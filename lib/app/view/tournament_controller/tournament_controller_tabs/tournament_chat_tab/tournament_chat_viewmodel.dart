import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/chat_list_response.dart';
import 'package:Gametector/app/module/network/response/push_notification_response.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/network/response/upload_image_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/module/socket/post/already_read_msg_chat_post.dart';
import 'package:Gametector/app/module/socket/post/chat_post_data.dart';
import 'package:Gametector/app/module/socket/post/typing_msg_post_data.dart';
import 'package:Gametector/app/module/socket/receive/already_read_msg_socket_response.dart';
import 'package:Gametector/app/module/socket/socket_manager.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../module/common/res/string.dart';
import '../../../../module/utils/image_util.dart';

class TournamentChatViewModel extends BaseViewModel {
  final UserSharePref _userSharePref = getIt<UserSharePref>();
  final NavigationService _navigationService = getIt<NavigationService>();
  late SocketManager socketManager = getIt<SocketManager>();
  int myUserId = getIt<UserSharePref>().getUser()?.user_id ?? -1;
  final DataRepository _dataRepo;
  ChatListResponse? _responseChatList;
  UploadImageResponse? _uploadResponse;
  late int tournamentId;
  TournamentInfo? _tournamentInfo;
  LoadingState loadingState = LoadingState.LOADING;

  int lastChatId =  -1;
  int flgLastPage = 0;

  ScrollController chatScrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  ScrollController scrollController = ScrollController();

  RefreshController refreshController = RefreshController(initialRefresh: false);

  // For chatList
  List<Item> lsChat = [];

  // For chatPost
  bool isAnnounce = false;
  File? image = null;

  // For typing
  List<String> typingPlayerThumb = [];
  int typingDuration = 10;
  bool canTypingPost = true;

  static Map<String, TournamentChatViewModel?>? _cache;

  // TODO : confirm whether this code is ok or ng.
  factory TournamentChatViewModel(dataRepo, {tournamentId}) {
    var key = tournamentId.toString();
    // reset
    if (tournamentId == 0) _cache = null;
    if (_cache == null) _cache = {};
    if (_cache!.containsKey(key) == false) {
      _cache![key] = new TournamentChatViewModel._(dataRepo, tournamentId: tournamentId);
    }
    return _cache![key]!;
  }

  TournamentChatViewModel._(this._dataRepo, {this.tournamentId = 0});

  set responseChatList(ChatListResponse? response) {
    _responseChatList = response;
    notifyListeners();
  }

  set tournamentInfo(TournamentInfo? info) {
    _tournamentInfo = info;
  }

  set uploadResponse(UploadImageResponse? response) {
    _uploadResponse = response;
    notifyListeners();
  }

  ChatListResponse? get responseChatList => _responseChatList;

  TournamentInfo? get tournamentInfo => _tournamentInfo;

  UploadImageResponse? get uploadResponse => _uploadResponse;

  Future<void> chatListApi() async {
    if (flgLastPage == 1) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      return;
    }

    var params = <String, dynamic>{};
    params.putIfAbsent('tournament_id', () => tournamentId);
    params.putIfAbsent('is_paging', () => 1);
    if (lastChatId != -1) {
      params.putIfAbsent('last_chat_id', () => lastChatId);
    }

    final subscript = chatList(params).listen((_) {
      if (responseChatList!.success) {
        if (loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        if (lastChatId == -1) {
          lsChat = responseChatList!.chat_list!;
          sendAlreadyReadMessage(tournamentId, lsChat.last.tournament_chat_id!);
        } else {
          lsChat.insertAll(0, responseChatList?.chat_list ?? []);
        }
        if (responseChatList!.flg_last_page == 1) flgLastPage = 1;
        if (lsChat.length != 0) lastChatId = lsChat.first.tournament_chat_id!;
      } else {
        _navigationService.gotoErrorPage(
            message: responseChatList!.error_message);
      }
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      notifyListeners();
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream chatList(Map<String, dynamic> params) => _dataRepo
          .chatList(params)
          .doOnData((r) => responseChatList = ChatListResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          print('error');
          responseChatList =
              ChatListResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        ;
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Stream uploadImage(Map<String, dynamic> params) => _dataRepo
      .uploadImage(params)
      .doOnData((r) => uploadResponse = UploadImageResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          print('error');
          uploadResponse =
              UploadImageResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {});

  Future<void> chatPostSocket(String message, int tournamentId) async {
    if (tournamentId <= 0) return;
    if (message.isEmpty && image == null) return;
    if (!socketManager.isConnectSocket()) {
      showAlertGTDialog(message: txt_error_send_chat);
      return;
    }
    var chatPostData = ChatPostData();
    chatPostData.message = message;
    chatPostData.flg_announce = isAnnounce ? 1 : 0;
    chatPostData.tournament_id = tournamentId.toString();
    chatPostData.message_image = '';
    chatPostData.image_size_rate = null;
    if (image != null) {
      await EasyLoading.show();

      File? imageCompressed = await compressFile(image!);
      if (imageCompressed == null) {
        await EasyLoading.dismiss();
        _navigationService.gotoErrorPage();
        return;
      }

      var uploadParams = <String, dynamic>{};
      uploadParams.putIfAbsent('tournament_id', () => tournamentId);
      uploadParams.putIfAbsent('is_private', () => 0);

      uploadParams.putIfAbsent(
        'image',
        () => MultipartFile.fromFileSync(
          imageCompressed.path,
          filename: imageCompressed.path.split('/').last,
        ),
      );
      final subscript = uploadImage(uploadParams).listen((_) {
        if (uploadResponse!.success &&
            uploadResponse!.thumb_file_name!.isNotEmpty) {
          chatPostData.message_image = uploadResponse?.thumb_file_name;
          chatPostData.image_size_rate = uploadResponse?.image_size_rate;
          socketManager.send(ACTION_SEND_CHAT, chatPostData);
          setImage(null);
          isAnnounce = false;
        } else {
          showAlertGTDialog(message: uploadResponse?.error_message);
        }
        notifyListeners();
        EasyLoading.dismiss();
      }, onError: (e) async {
        await EasyLoading.dismiss();
        _navigationService.gotoErrorPage();
      });
      addSubscription(subscript);
    } else {
      socketManager.send(ACTION_SEND_CHAT, chatPostData);
      isAnnounce = false;
      notifyListeners();
    }
  }

  Future<void> sendAlreadyReadMessage(
      int tournamentId, int tournamentChatId) async {
    if (isAlreadyReadLatestChat()) return;
    var alreadyReadData = AlreadyReadMessageChatPost();
    alreadyReadData.tournament_id = tournamentId;
    alreadyReadData.tournament_chat_id = tournamentChatId;
    socketManager.send(ACTION_ALREADY_READ_MESSAGE, alreadyReadData);
  }

  bool isAlreadyReadLatestChat() {
    if (lsChat.length == 0) return true;
    var alreadyReadList = lsChat.last.alrady_read_list;
    for (int i = 0; i < alreadyReadList!.length; i++) {
      if (alreadyReadList[i].user_id == myUserId) return true;
    }
    return false;
  }

  Future<void> postDataTyping(tournamentId) async {
    if (canTypingPost == false) return;
    canTypingPost = false;
    var typingData = TypingMessagePostData();
    typingData.tournament_id = tournamentId.toString();
    socketManager.send(ACTION_TYPING_MESSAGE, typingData);
    Timer(Duration(seconds: typingDuration), () {
      canTypingPost = true;
    });
  }

  handleTypingChat(TypingMessageResponse event) {
    if (event.tournament_id != tournamentId) return;
    if (typingPlayerThumb.contains(event.display_thumbnail!)) return;
    typingPlayerThumb.add(event.display_thumbnail!);
    notifyListeners();

    Timer(Duration(seconds: typingDuration), () {
      typingPlayerThumb.remove(event.display_thumbnail!);
      notifyListeners();
    });
  }

  handleChatData(PushNotificationResponse data) {
    if (_userSharePref.getUser() == null) return;
    if (data.tournament_id != tournamentId) return;
    var dataToItem = Item.fromJson(jsonDecode(json.encode(data)));
    bool existChatId = false;
    if (lsChat.length > 0) {
      existChatId = (lsChat.last.tournament_chat_id == data.tournament_chat_id);
    }

    if (!existChatId) {
      lsChat.add(dataToItem);
      notifyListeners();
      sendAlreadyReadMessage(tournamentId, dataToItem.tournament_chat_id!);
      if (dataToItem.user_id == myUserId) {
        scrollToBottom();
      }
    }
  }

  handleAlreadyReadMessage(AlreadyReadMessageSocketResponse alreadyReadData) {
    if (alreadyReadData.tournament_id != tournamentId) return;
    int readChatId = alreadyReadData.already_read_chat_id!;
    int readUserId = alreadyReadData.user_id!;

    for (int i = 0; i < lsChat.length; i++) {
      // Remove alreadyReadMessageData
      var isRemove = -1;
      for (int j = 0; j < lsChat[i].alrady_read_list!.length; j++) {
        if (lsChat[i].alrady_read_list![j].user_id == readUserId) {
          isRemove = j;
        }
      }
      if (isRemove != -1) {
        lsChat[i].alrady_read_list!.removeAt(isRemove);
      }

      // Add alreadyReadMessageData
      if (lsChat[i].tournament_chat_id == readChatId) {
        var alreadyReadMessageData = AlreadyReadMessageData.fromJson(
            jsonDecode(json.encode(alreadyReadData)));
        lsChat[i].alrady_read_list!.add(alreadyReadMessageData);
      }
    }
    notifyListeners();
  }

  changeIsAnnounce() {
    isAnnounce = !isAnnounce;
    notifyListeners();
  }

  setImage(File? img) {
    image = img;
    notifyListeners();
  }

  scrollToBottom() async {
    await chatScrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  extractLink(String msg) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(msg);
    String getLink = '';
    matches.forEach((match) {
      getLink = msg.substring(match.start, match.end);
    });
    return getLink;
  }

  setTournamentInfo(TournamentInfo? info) {
    tournamentInfo = info;
    notifyListeners();
  }

  refreshData() {
    lastChatId = -1;
    flgLastPage = 0;
    chatListApi();
  }

  diposeSelf() {
    var key = tournamentId.toString();
    if (_cache!.containsKey(key)) {
      _cache![key]!.dispose();
      _cache!.remove(key);
    }
  }
}
