import 'dart:async';

import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/network/response/chat_list_response.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/checkin_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/show_chat_image_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/chat_preview_widget.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_result.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_result_event.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_guid_image.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'tournament_chat_footer.dart';

class TournamentChatTab extends PageProvideNode<TournamentChatViewModel> {
  final int tournamentId;
  final TournamentInfo? tournamentInfo;

  TournamentChatTab({
    Key? key,
    required this.tournamentId,
    required this.tournamentInfo,
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return _TournamentChatTab(
      viewModel,
      tournamentInfo: tournamentInfo,
    );
  }
}

class _TournamentChatTab extends StatefulWidget {
  final TournamentChatViewModel _tournamentChatViewModel;
  final TournamentInfo? tournamentInfo;

  const _TournamentChatTab(
    this._tournamentChatViewModel, {
    Key? key,
    required this.tournamentInfo,
  }) : super(key: key);

  @override
  __TournamentChatTabState createState() => __TournamentChatTabState();
}

class __TournamentChatTabState extends State<_TournamentChatTab>
    with SingleTickerProviderStateMixin {
  TournamentChatViewModel get tournamentChatViewModel => widget._tournamentChatViewModel;
  late StreamSubscription pushNotificationEventSubscription;
  late StreamSubscription typingMessageEventSubscription;
  late StreamSubscription alreadyReadMessageSocketEventSubscription;
  late StreamSubscription refreshSubscription;

  // Detect keyboard
  bool isDisplayCheckin = true;
  KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    tournamentChatViewModel.setTournamentInfo(widget.tournamentInfo);
    tournamentChatViewModel.chatListApi();

    keyboardSubscription = keyboardVisibilityController.onChange
        .listen((bool visible) => onKeyboardVisibilityChanged(visible));
    super.initState();

    pushNotificationEventSubscription = eventBus.on<PushNotificationEvent>().listen((event) {
      tournamentChatViewModel.handleChatData(event.pushNotificationResponse);
      print("Listener: ${event.pushNotificationResponse.toJson()}");
    });

    typingMessageEventSubscription = eventBus.on<TypingMessageEvent>().listen((event) {
      tournamentChatViewModel.handleTypingChat(event.typingMessageResponse);
      print('Listener: ${event.typingMessageResponse.toJson()}');
    });

    alreadyReadMessageSocketEventSubscription = eventBus.on<AlreadyReadMessageSocketEvent>().listen((event) {
      tournamentChatViewModel.handleAlreadyReadMessage(event.alreadyReadMessageSocketResponse);
      print('Listener: ${event.alreadyReadMessageSocketResponse.toJson()}');
    });

    refreshSubscription = eventBus.on<RefreshTournamentChatEvent>().listen((event) {
      if (event.tournamentId != tournamentChatViewModel.tournamentId) return;
      tournamentChatViewModel.refreshData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    keyboardSubscription.cancel();
    pushNotificationEventSubscription.cancel();
    typingMessageEventSubscription.cancel();
    alreadyReadMessageSocketEventSubscription.cancel();
    refreshSubscription.cancel();
  }

  void onKeyboardVisibilityChanged(bool visible) {
    setState(() {
      if (visible) {
        isDisplayCheckin = false;
      } else {
        isDisplayCheckin = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<TournamentChatViewModel>(builder: (context, value, child) {
      switch (value.loadingState) {
        case LoadingState.LOADING:
          return BuildProgressLoading();
        case LoadingState.DONE:
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // Chat
                    SmartRefresher(
                      primary: false,
                      physics: AlwaysScrollableScrollPhysics(),
                      reverse: true,
                      enablePullUp: (value.flgLastPage == 0),
                      enablePullDown: true,
                      footer: SmartRefresherCustomFooter(),
                      header: SmartRefresherCustomHeader(),
                      scrollDirection: Axis.vertical,
                      controller: value.refreshController,
                      scrollController: value.chatScrollController,
                      onLoading: () {
                        value.chatListApi();
                      },
                      onRefresh: () {
                        value.refreshData();
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: size.height - (kToolbarHeight + size_140_h), // TODO: CHECK size_120_h is suitable?
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                child: Visibility(
                                  visible: value.tournamentInfo!.competition_type != 99 && value.flgLastPage == 1,
                                  child: GuidImage(),
                                ),
                                alignment: Alignment.topCenter,
                              ),
                              TournamentChatList(
                                chatList: value.lsChat,
                                myUserId: value.myUserId,
                                tournamentInfo: value.tournamentInfo!,
                                guidImg: value.tournamentInfo!.competition_type,
                              ),
                              Visibility(
                                visible: value.typingPlayerThumb.length > 0,
                                child: SizedBox(
                                  height: size_15_h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // CheckIn
                    Visibility(
                      visible: isDisplayCheckin,
                      child: Align(
                        alignment: const Alignment(0.0, 1.0),
                        child: CheckinButton(
                          checkinStatus: value.tournamentInfo!.checkin_status,
                          checkinStartTime: value.tournamentInfo!.checkin_start_time,
                          tournamentId: value.tournamentId,
                        ),
                      ),
                    ),
                    // Typing message
                    Visibility(
                      visible: value.typingPlayerThumb.length > 0,
                      child: Align(
                        alignment: const Alignment(1.0, 1.0),
                        child: Container(
                          padding: EdgeInsets.only(
                            right: size_10_w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ...value.typingPlayerThumb.map((thumb) {
                                return Padding(
                                  padding: EdgeInsets.only(right: size_2_w),
                                  child: PlayerThumb(
                                    playerThumbUrl: thumb,
                                    size: size_12_w,
                                    placeholderImage:
                                        'asset/images/ic_default_avatar.png',
                                  ),
                                );
                              }).toList(),
                              Text(
                                txt_is_typing,
                                style: TextStyle(
                                    color: Colors.white, fontSize: text_12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TournamentChatFooter(
                tournamentChatViewModel: tournamentChatViewModel,
                fixedMessages: value.responseChatList!.fixed_messages,
                tournamentId: value.tournamentId,
                isEvent: (value.tournamentInfo!.competition_type == 99 &&
                        ((value.tournamentInfo!.role_type == 'both' ||
                            value.tournamentInfo!.role_type == 'organizer')))
                    ? true
                    : false,
              ),
            ],
          );
        default:
          return Container();
      }
    });
  }
}

class CheckinButton extends StatelessWidget {
  final int? tournamentId;
  final int? checkinStatus;
  final String? checkinStartTime;

  const CheckinButton({
    Key? key,
    required this.tournamentId,
    required this.checkinStatus,
    required this.checkinStartTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (checkinStatus == 3) {
      return Container(
        height: size_60_h,
        child: Image.asset(
          'asset/images/btn_checkin_after.png',
          fit: BoxFit.fitWidth,
        ),
      );
    } else if (checkinStatus == 2 || checkinStatus == 1) {
      return Container(
        height: size_60_h,
        child: GestureDetector(
          onTap: () {
            CheckinBottomSheet(tournamentId: tournamentId);
          },
          child: Stack(
            children: [
              Align(
                child: Image.asset(
                  'asset/images/btn_checkin_before.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              checkinStatus == 1
                  ? Align(
                      alignment: const Alignment(0.15, 0.45),
                      child: Text(
                        checkinStartTime! + ' 受付開始',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: text_12,
                        ),
                      ),
                    )
                  : Align(
                      alignment: const Alignment(0.05, 0.45),
                      child: Text(
                        '受付中',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: text_14,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class TournamentChatList extends StatelessWidget {
  final int myUserId;
  final List<Item> chatList;
  final TournamentInfo tournamentInfo;
  final int? guidImg;

  TournamentChatList({
    Key? key,
    required this.myUserId,
    required this.chatList,
    required this.tournamentInfo,
    required this.guidImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size_20_w, vertical: size_10_h),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: chatList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return tournamentChat(
              item: this.chatList[index],
              myUserId: this.myUserId,
              tournamentInfo: this.tournamentInfo,
              index: index,
            );
          }),
    );
  }
}

class tournamentChat extends StatelessWidget {
  final Item item;
  final int myUserId;
  final TournamentInfo tournamentInfo;
  final int index;

  const tournamentChat(
      {Key? key,
      required this.item,
      required this.index,
      required this.myUserId,
      required this.tournamentInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _linkTextStyle = TextStyle(
      color: Colors.white,
      fontSize: text_12,
      overflow: TextOverflow.ellipsis,
    );

    bool isOrganizer =
        (item.type == 1 || item.type == 3 || item.type == 6) ? true : false;
    bool isImage = (item.type == 3 || item.type == 4) ? true : false;
    bool isMine = (myUserId == item.user_id) ? true : false;

    if (item.type == 8) {
      return tournamentInfo.competition_type == 99
          ? TournamentChatResultEvent(
              item: this.item,
              tournamentInfo: this.tournamentInfo,
            )
          : TournamentChatResult(
              item: this.item,
              tournamentInfo: this.tournamentInfo,
            );
    } else {
      return Consumer<TournamentChatViewModel>(
          builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: size_10_h,
          ),
          child: Column(
            crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: !isMine,
                    child: Container(
                      padding: EdgeInsets.only(
                        right: size_10_w,
                      ),
                      child: PlayerThumb(
                        playerThumbUrl: isOrganizer
                            ? this.item.organizer_thumb_url
                            : this.item.player_thumb_url,
                        placeholderImage: 'asset/images/ic_default_avatar.png',
                        size: size_32_w,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: isMine
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: size_5_h,
                          ),
                          child: Row(
                            mainAxisAlignment: isMine
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: !isMine,
                                child: Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: size_10_w),
                                    child: Text(
                                      isOrganizer
                                          ? this.item.organizer_name!
                                          : this.item.player_name!,
                                      style: TextStyle(
                                        overflow: TextOverflow.clip,
                                        color: Colors.grey,
                                        fontSize: text_9,
                                      ),
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: !isMine ? size_10_w : 0),
                              Visibility(
                                visible: isOrganizer,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: size_2_h,
                                    horizontal: size_4_w,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      size_2_r,
                                    ),
                                    color: kColor2947C3,
                                  ),
                                  child: Text(
                                    txt_tournament_list_organizer,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: text_6,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: isOrganizer ? size_10_w : 0),
                              Text(
                                this.item.post_time!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: text_9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isImage,
                          child: GestureDetector(
                            onTap: () {
                              showImageChatBottomSheet(item.image_url!);
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  size_5_r,
                                ),
                                child: FadeInImage(
                                  fit: BoxFit.fitWidth,
                                  height: size_180_w,
                                  image: NetworkImage(
                                    this.item.image_url!,
                                  ),
                                  placeholder: AssetImage(
                                    'asset/images/gray04.png',
                                  ),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      'asset/images/gray04.png',
                                      fit: BoxFit.fill,
                                      height: size_100_h,
                                      width: size_100_w,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: item.flg_announce == 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: size_2_h,
                              horizontal: size_8_w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                size_50_r,
                              ),
                              color: kColorF0485D,
                            ),
                            child: Text(
                              txt_announce,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: text_9,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: this.item.message != "",
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: isMine
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: size_10_w,
                                    top: size_10_h,
                                    right: size_10_w,
                                    bottom: size_10_h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    size_10_r,
                                  ),
                                  color: kColor2b2e3c,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6,
                                ),
                                child: SelectableLinkify(
                                  onOpen: (link) => launchURL(link.url),
                                  text: this.item.message ?? '',
                                  style: _linkTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isMine,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: size_10_w,
                      ),
                      child: PlayerThumb(
                        playerThumbUrl: isOrganizer
                            ? this.item.organizer_thumb_url
                            : this.item.player_thumb_url,
                        placeholderImage: 'asset/images/ic_default_avatar.png',
                        size: size_32_w,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size_5_h,),
              Visibility(
                  visible: value.extractLink(this.item.message!) != '',
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size_42_w),
                    child: ChatPreviewWidget(
                      url: value.extractLink(this.item.message!),
                      chatTextStyle: _linkTextStyle,
                    ),
                  )),
              Visibility(
                visible: (this.item.alrady_read_list!.length > 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: (this.item.alrady_read_list!.length > 7),
                      child: Text(
                        "...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: text_13,
                        ),
                      ),
                    ),
                    ...this
                        .item
                        .alrady_read_list!
                        .sublist(
                            0,
                            (this.item.alrady_read_list!.length > 8)
                                ? 8
                                : this.item.alrady_read_list!.length)
                        .map((itemList) {
                      return Visibility(
                        visible: myUserId != itemList.user_id,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size_4_h, horizontal: size_2_w),
                          child: PlayerThumb(
                            playerThumbUrl: itemList.thumbnail,
                            placeholderImage:
                                'asset/images/ic_default_avatar.png',
                            size: size_15_w,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    }
  }
}
