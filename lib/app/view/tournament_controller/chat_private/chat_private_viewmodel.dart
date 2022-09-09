import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/chat_list_response.dart';
import 'package:Gametector/app/module/network/response/chat_private_list_response.dart';
import 'package:Gametector/app/module/network/response/notice_read_response.dart';
import 'package:Gametector/app/module/network/response/push_notification_private_response.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/network/response/upload_image_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/module/socket/post/already_read_msg_chat_post.dart';
import 'package:Gametector/app/module/socket/post/chat_private_post_data.dart';
import 'package:Gametector/app/module/socket/post/typing_msg_post_data.dart';
import 'package:Gametector/app/module/socket/receive/already_read_msg_socket_response.dart';
import 'package:Gametector/app/module/socket/socket_manager.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../module/common/res/string.dart';
import '../../../module/utils/image_util.dart';

class ChatPrivateViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  UserSharePref _userSharePref = getIt<UserSharePref>();
  final NavigationService _navigationService = getIt<NavigationService>();
  late SocketManager socketManager = getIt<SocketManager>();
  int myUserId = getIt<UserSharePref>().getUser()?.user_id ?? -1;

  int lastChatId =  -1;
  int flgLastPage = 0;

  final ScrollController chatPrivateScrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  final bool isExpanded = false;
  bool isKeyboardFocus = false;

  int flexChatListVal = 4;
  int flexInPutAreaVal = 1;

  RefreshController refreshController = RefreshController(initialRefresh: false);
  KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  TextEditingController privateChatController = TextEditingController();
  ExpandableController expandableController = ExpandableController();

  LoadingState loadingState = LoadingState.LOADING;

  late int tournamentId;
  late int tournamentRoundId;
  late TournamentInfo _tournamentInfo;
  ChatPrivateListResponse? _responseChatPrivateList;
  UploadImageResponse? _uploadResponse;
  NoticeReadResponse? _readResponse;

  // PrivateChatList
  List<ChatPrivateItem> lsChatPrivate = [];

  // PrivateChatPost
  var image;
  bool isOrganizerCall = false;

  // For typing
  List<String> typingPlayerThumb = [];
  int typingDuration = 10;
  bool canTypingPost = true;

  void setInitialExpand(bool visible) {
    expandableController.expanded = visible;
    notifyListeners();
  }

  void onExpandableChanged() {
    if (expandableController.expanded) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void onKeyboardChange(bool visible) {
    isKeyboardFocus = visible;
    if (visible) expandableController.expanded = false;
    if (image == null && isKeyboardFocus) {
      flexChatListVal = 1;
      flexInPutAreaVal = 3;
      // 画像アップロードなし、キーボード未起動
    } else if (image == null && !isKeyboardFocus) {
      flexChatListVal = 4;
      flexInPutAreaVal = 1;
      // 画像アップロードあり、キーボード起動
    } else if (image != null && isKeyboardFocus) {
      flexChatListVal = 1;
      flexInPutAreaVal = 4;
      // 画像アップロードあり、キーボード未起動
    } else if (image != null && !isKeyboardFocus) {
      flexChatListVal = 3;
      flexInPutAreaVal = 2;
    }
    notifyListeners();
  }

  ChatPrivateViewModel(this._dataRepo,) {
    addSubscription(
        keyboardVisibilityController.onChange.listen((bool visible) => onKeyboardChange(visible))
    );

    addSubscription(
        eventBus.on<PushNotificationPrivateEvent>().listen((event) {
          handlePrivateChatData(event.pushNotificationPrivateResponse);
          print("Listener: ${event.pushNotificationPrivateResponse.toJson()}");
        })
    );

    addSubscription(
        eventBus.on<TypingMessageEvent>().listen((event) {
          handleTypingChat(event.typingMessageResponse);
          print('Listener: ${event.typingMessageResponse.toJson()}');
        })
    );

    addSubscription(
        eventBus.on<AlreadyReadMessageSocketEvent>().listen((event) {
          handleAlreadyReadMessage(event.alreadyReadMessageSocketResponse);
          print('Listener: ${event.alreadyReadMessageSocketResponse.toJson()}');
        })
    );
  }

  set responseChatPrivateList(ChatPrivateListResponse? response) {
    _responseChatPrivateList = response;
    notifyListeners();
  }

  set tournamentInfo(TournamentInfo info) {
    _tournamentInfo = info;
  }

  set uploadResponse(UploadImageResponse? response) {
    _uploadResponse = response;
    notifyListeners();
  }

  set readResponse(NoticeReadResponse? response) {
    _readResponse = response;
    notifyListeners();
  }

  ChatPrivateListResponse? get responseChatPrivateList => _responseChatPrivateList;

  TournamentInfo get tournamentInfo => _tournamentInfo;

  UploadImageResponse? get uploadImageResponse => _uploadResponse;

  NoticeReadResponse? get readResponse => this._readResponse;

  Stream chatPrivateList(Map<String, dynamic> params) => _dataRepo
      .chatPrivateList(params)
      .doOnData((r) =>
  responseChatPrivateList = ChatPrivateListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      responseChatPrivateList =
          ChatPrivateListResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    ;
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> tournamentChatPrivateListApi(tournament_id, tournament_round_id) async {
    if (flgLastPage == 1) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      return;
    }

    tournamentId = tournament_id;
    tournamentRoundId = tournament_round_id;
    var params = <String, dynamic>{};
    params.putIfAbsent('tournament_id', () => tournament_id);
    params.putIfAbsent('tournament_round_id', () => tournament_round_id);
    params.putIfAbsent('is_paging', () => 1);
    if (lastChatId != -1) {
      params.putIfAbsent('last_chat_id', () => lastChatId);
    }

    final subscript = chatPrivateList(params).listen((_) {
      if (responseChatPrivateList!.success) {
        if (loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        if (lastChatId == -1) {
          lsChatPrivate = responseChatPrivateList!.chat_list!;
          sendAlreadyReadMessage(tournament_round_id, lsChatPrivate.last.tournament_private_chat_id!);
          noticeReadApi();
        } else {
          lsChatPrivate.insertAll(0, responseChatPrivateList?.chat_list ?? []);
        }
        if (responseChatPrivateList!.flg_last_page == 1) flgLastPage = 1;
        if (lsChatPrivate.length != 0) lastChatId = lsChatPrivate.first.tournament_private_chat_id!;
      } else {
        _navigationService.gotoErrorPage(
            message: responseChatPrivateList!.error_message);
      }
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      notifyListeners();
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

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

  Future<void> privateChatPostSocket(String message, tournamentRoundId, tournamentId) async {
    if (tournamentId <= 0) return;
    if (message.isEmpty && image == null) return;

    if (!socketManager.isConnectSocket()) {
      showAlertGTDialog(message: txt_error_send_chat);
      return;
    }
    var chatPrivatePostData = ChatPrivatePostData();
    chatPrivatePostData.message = message.toString();
    chatPrivatePostData.flg_organizer_call = isOrganizerCall ? 1 : 0;
    chatPrivatePostData.tournament_round_id = tournamentRoundId.toString();
    chatPrivatePostData.message_image = '';
    chatPrivatePostData.image_size_rate = null;
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
      uploadParams.putIfAbsent('is_private', () => 1);
      uploadParams.putIfAbsent('image', () =>
          MultipartFile.fromFileSync(imageCompressed.path, filename: imageCompressed.path.split('/').last,),
      );
      final subscript = uploadImage(uploadParams).listen((_) async {
        if (uploadImageResponse!.success && uploadImageResponse!.thumb_file_name!.isNotEmpty) {
          chatPrivatePostData.message_image = uploadImageResponse?.thumb_file_name;
          chatPrivatePostData.image_size_rate = uploadImageResponse?.image_size_rate;
          socketManager.send(ACTION_SEND_CHAT_PRIVATE, chatPrivatePostData);
          setImage(null);
          isOrganizerCall = false;
        } else {
          showAlertGTDialog(message: uploadImageResponse?.error_message);
        }
        await EasyLoading.dismiss();
        notifyListeners();
      }, onError: (e) {
        notifyListeners();
        _navigationService.gotoErrorPage();
      });
      addSubscription(subscript);
    } else {
      socketManager.send(ACTION_SEND_CHAT_PRIVATE, chatPrivatePostData);
      isOrganizerCall = false;
      notifyListeners();
    }
  }

  handlePrivateChatData(PushNotificationPrivateResponse data) {
    if (_userSharePref.getUser() == null) return;
    if (data.tournament_round_id != tournamentRoundId) return;
    var dataToItem = ChatPrivateItem.fromJson(jsonDecode(json.encode(data)));
    bool existPrivateChatId = false;
    if (lsChatPrivate.length > 0) {
      existPrivateChatId = (lsChatPrivate.last.tournament_private_chat_id == dataToItem.tournament_private_chat_id);
    }

    if (!existPrivateChatId) {
      lsChatPrivate.add(dataToItem);
      sendAlreadyReadMessage(tournamentRoundId, dataToItem.tournament_private_chat_id!);
      if (dataToItem.user_id == myUserId){
        scrollToBottom();
      }
      notifyListeners();
      noticeReadApi();
    }

  }

  Future<void> sendAlreadyReadMessage(int tournamentRoundId, int tournamentPrivateChatId) async {
    if (responseChatPrivateList!.is_authorized == false) return;
    if (isAlreadyReadLatestChat()) return;
    var alreadyReadData = AlreadyReadMessagePrivateChatPost();
    alreadyReadData.tournament_round_id = tournamentRoundId;
    alreadyReadData.tournament_private_chat_id = tournamentPrivateChatId;
    socketManager.send(ACTION_ALREADY_READ_MESSAGE, alreadyReadData);
  }

  bool isAlreadyReadLatestChat() {
    if (lsChatPrivate.length == 0) return true;
    var alreadyReadList = lsChatPrivate.last.alrady_read_list;
    for (int i=0; i < alreadyReadList!.length; i++){
      if (alreadyReadList[i].user_id == myUserId) return true;
    }
    return false;
  }

  handleAlreadyReadMessage(AlreadyReadMessageSocketResponse alreadyReadData) {
    if (alreadyReadData.tournament_round_id != tournamentRoundId) return;
    int readChatId = alreadyReadData.already_read_private_chat_id!;
    int readUserId = alreadyReadData.user_id!;

    for (int i=0; i < lsChatPrivate.length; i++) {
      // Remove alreadyReadMessageData
      var isRemove = -1;
      for (int j=0; j < lsChatPrivate[i].alrady_read_list!.length; j++) {
        if (lsChatPrivate[i].alrady_read_list![j].user_id == readUserId) {
          isRemove = j;
        }
      }
      if (isRemove != -1) {
        lsChatPrivate[i].alrady_read_list!.removeAt(isRemove);
      }

      // Add alreadyReadMessageData
      if (lsChatPrivate[i].tournament_private_chat_id == readChatId) {
        var alreadyReadMessageData = AlreadyReadMessagePrivateData.fromJson(jsonDecode(json.encode(alreadyReadData)));
        lsChatPrivate[i].alrady_read_list!.add(alreadyReadMessageData);
      }
    }
    notifyListeners();
  }

  Future<void> postDataTyping(tournamentRoundId) async {
    if (canTypingPost == false) return;
    canTypingPost = false;
    var typingData = TypingPrivateMessagePostData();
    typingData.tournament_round_id = tournamentRoundId.toString();
    socketManager.send(ACTION_TYPING_MESSAGE, typingData);
    Timer(Duration(seconds: typingDuration), () {
      canTypingPost = true;
    });
  }

  handleTypingChat(TypingMessageResponse event) {
    if (event.tournament_round_id != tournamentRoundId) return;
    if (typingPlayerThumb.contains(event.display_thumbnail!)) return;
    typingPlayerThumb.add(event.display_thumbnail!);
    notifyListeners();

    Timer(Duration(seconds: typingDuration), () {
      typingPlayerThumb.remove(event.display_thumbnail!);
      notifyListeners();
    });
  }

  Future<void> noticeReadApi() async {
    if (responseChatPrivateList!.is_authorized == false) return;
    // TODO : 毎回送らないための制御を入れる？

    var params = <String, dynamic>{};
    params.putIfAbsent('tournament_id', () => tournamentId);
    params.putIfAbsent('notice_type', () => 3);
    params.putIfAbsent('tournament_round_id', () => tournamentRoundId);
    final subscript = noticeRead(params).listen((_) {
      if (readResponse != null && readResponse!.success) {
        notifyListeners();
        eventBus.fire(UpdateAllNotificationTabBadgeEvent(2, readResponse!.flg_badge_on?? 0));
      }
    });
    addSubscription(subscript);
  }

  Stream noticeRead(Map<String, dynamic> params) => _dataRepo
      .readNotify(params)
      .doOnData((r) => readResponse = NoticeReadResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      readResponse =
          NoticeReadResponse.fromJson(e.response?.data.trim() ?? '');
    }
  })
      .doOnListen(() {})
      .doOnDone(() {
    EasyLoading.dismiss();
  });

  changeIsOrganizerCall() {
    isOrganizerCall = !isOrganizerCall;
    notifyListeners();
  }

  setImage(File? img) {
    image = img;
    notifyListeners();
  }

  scrollToBottom() async {
    await chatPrivateScrollController.animateTo(
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

  void updateUIChat() {
    FocusManager.instance.primaryFocus?.unfocus();
    privateChatController.clear();
  }

  void setText(String text) {
    privateChatController.text = privateChatController.text + text;
    privateChatController.selection = TextSelection.fromPosition(TextPosition(offset: privateChatController.text.length));
  }

  refreshPrivateChat(tournament_id, tournament_round_id) {
    lastChatId = -1;
    flgLastPage = 0;
    tournamentChatPrivateListApi(tournament_id, tournament_round_id);
  }
}
