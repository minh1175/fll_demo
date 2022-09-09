import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/module/network/response/chat_private_list_response.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/view/component/bottom_sheet/player_listteam_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/show_chat_image_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/grayed_out.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/component/common/twitter_elipse.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_footer.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/private_chat_expand.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_page.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';
import '../tournament_controller_tabs/tournament_chat_tab/chat_preview_widget.dart';

class ChatPrivatePage extends PageProvideNode<ChatPrivateViewModel> {
  final int tournamentId;
  final int tournamentRoundId;
  final bool isDiplayTournamentButton;

  ChatPrivatePage({
    Key? key,
    required this.tournamentId,
    required this.tournamentRoundId,
    required this.isDiplayTournamentButton,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _chatPrivatePage(
      viewModel,
      tournamentId: this.tournamentId,
      tournamentRoundId: this.tournamentRoundId,
      isDiplayTournamentButton: this.isDiplayTournamentButton,
      key: key,
    );
  }
}

class _chatPrivatePage extends StatefulWidget {
  final int tournamentId;
  final int tournamentRoundId;
  final bool isDiplayTournamentButton;
  final ChatPrivateViewModel _chatPrivateViewModel;

  const _chatPrivatePage(
    this._chatPrivateViewModel, {
    Key? key,
    required this.tournamentId,
    required this.tournamentRoundId,
    required this.isDiplayTournamentButton,
  }) : super(key: key);

  @override
  __chatPrivatePageState createState() => __chatPrivatePageState();
}

class __chatPrivatePageState extends State<_chatPrivatePage> {
  ChatPrivateViewModel get chatPrivateViewModel => widget._chatPrivateViewModel;

  @override
  void initState() {
    chatPrivateViewModel.tournamentChatPrivateListApi(
      widget.tournamentId,
      widget.tournamentRoundId,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print ("************** chatPrivateViewModel.dispose ******************");
    chatPrivateViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ChatPrivateViewModel>(builder: (context, value, child) {
      switch (value.loadingState) {
        case LoadingState.LOADING:
          return Container(
            color: kColor202330,
            child: SafeArea(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: Scaffold(
                  backgroundColor: kColor212430,
                  body: BuildProgressLoading(),
                ),
              ),
            ),
          );
        case LoadingState.DONE:
          return Container(
            color: kColor202330,
            child: SafeArea(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: Scaffold(
                  backgroundColor: kColor212430,
                  body: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ChatPrivateHead(
                        tournamentId: widget.tournamentId,
                        tournamentName:
                            value.responseChatPrivateList?.tournament_name ??
                                '',
                        roundBoxStr:
                            value.responseChatPrivateList?.round_box_str ?? '',
                        isDisplayButton: widget.isDiplayTournamentButton,
                      ),
                      value.responseChatPrivateList?.is_team ?? false
                          ? ChatTeams(
                              isAuthorized:
                                  value.responseChatPrivateList?.is_authorized,
                              chatTeam:
                                  value.responseChatPrivateList?.chat_team,
                            )
                          : ChatPlayers(
                              chatUser:
                                  value.responseChatPrivateList?.chat_user,
                            ),
                      Expanded(
                        flex: value.flexChatListVal,
                        child: Stack(
                          children: [
                            SmartRefresher(
                              physics: AlwaysScrollableScrollPhysics(),
                              reverse: true,
                              enablePullUp: (value.flgLastPage == 0),
                              enablePullDown: true,
                              footer: SmartRefresherCustomFooter(),
                              header: SmartRefresherCustomHeader(),
                              scrollDirection: Axis.vertical,
                              controller: value.refreshController,
                              scrollController: value.chatPrivateScrollController,
                              primary: false,
                              onLoading: () {
                                value.tournamentChatPrivateListApi(widget.tournamentId,
                                    widget.tournamentRoundId);
                              },
                              onRefresh: () {
                                value.refreshPrivateChat(widget.tournamentId,
                                    widget.tournamentRoundId);
                              },
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  padding: EdgeInsets.only(top: size_30_h),
                                  constraints: BoxConstraints(
                                    minHeight: size.height -
                                        (kToolbarHeight + size_260_h),
                                  ),
                                  child: TournamentChatPrivateList(
                                    myUserId: value.myUserId,
                                    chatPrivateList: value.lsChatPrivate,
                                  ),
                                ),
                              ),
                            ),
                            //Header
                            Visibility(
                              visible: value.responseChatPrivateList
                                      ?.is_authorized! ==
                                  true,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    PrivateChatExpandable(
                                      isDefaultShow: value.responseChatPrivateList
                                          ?.game_info.is_default_show,
                                      organizerThumbUrl: value
                                          .responseChatPrivateList
                                          ?.organizer_thumb_url,
                                      gameInfo: value
                                          .responseChatPrivateList?.game_info,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: value.typingPlayerThumb.length > 0,
                        child: Container(
                          width: double.infinity,
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
                      Expanded(
                        flex: value.flexInPutAreaVal,
                        child: SingleChildScrollView(
                          reverse: true,
                          child: IgnorePointer(
                            ignoring:
                                value.responseChatPrivateList?.is_authorized! ==
                                    false,
                            child: GrayedOut(
                              grayedOut: value.responseChatPrivateList
                                      ?.is_authorized! ==
                                  false,
                              child: ChatPrivateFooter(
                                tournamentId: widget.tournamentId,
                                tournamentRoundId: widget.tournamentRoundId,
                                roundBoxStr: value
                                    .responseChatPrivateList?.round_box_str,
                                myUserId: value.myUserId,
                                organizerUserId: value
                                    .responseChatPrivateList?.organizer_user_id,
                                isScorePostBtnAvailable: value
                                    .responseChatPrivateList
                                    ?.is_score_post_btn_available,
                                organizerThumbUrl: value.responseChatPrivateList
                                    ?.organizer_thumb_url,
                                // scroll: value.chatPrivateScrollController,
                                messages: value
                                    .responseChatPrivateList?.fixed_messages,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        default:
          return Container(
            color: kColor202330,
            child: SafeArea(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: Scaffold(
                  backgroundColor: kColor212430,
                  body: Container(),
                ),
              ),
            ),
          );
      }
    });
  }
}

class ChatPrivateHead extends StatelessWidget {
  final int tournamentId;
  final String? tournamentName;
  final String? roundBoxStr;
  final bool? isDisplayButton;

  const ChatPrivateHead({
    Key? key,
    required this.tournamentId,
    required this.tournamentName,
    required this.roundBoxStr,
    required this.isDisplayButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: size_5_h,
        bottom: size_5_h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(size_10_w),
              child: SvgPicture.asset(
                'asset/icons/ic_back_arrow.svg',
                height: size_24_w,
                width: size_24_w,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          SizedBox(
            width: size_10_w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.tournamentName!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text_12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  this.roundBoxStr!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text_15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            width: size_10_w,
          ),
          this.isDisplayButton!
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TournamentControllerPage(
                          tournamentId: this.tournamentId,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size_7_h,
                      horizontal: size_12_w,
                    ),
                    decoration: BoxDecoration(
                      color: kColor3E455C,
                      borderRadius: BorderRadius.circular(size_20_r),
                    ),
                    child: Text(
                      txt_view_tournament,
                      style: TextStyle(color: Colors.white, fontSize: text_9),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class ChatTeams extends StatelessWidget {
  final bool? isAuthorized;
  final ChatTeam? chatTeam;

  const ChatTeams({
    Key? key,
    required this.isAuthorized,
    required this.chatTeam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size_16_w,
        vertical: size_10_h,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PlayerThumb(
                        playerThumbUrl:
                            chatTeam?.your_team!.team_thumb_url ?? null,
                        size: size_32_w,
                        placeholderImage: 'asset/images/ic_default_avatar.png',
                      ),
                      SizedBox(
                        width: size_18_w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chatTeam?.your_team!.team_name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: text_12),
                            ),
                            Text(
                              sprintf(txt_people_participanting,
                                  [chatTeam?.your_team!.team_member_num]),
                              style: TextStyle(
                                  color: kColoraaaaaa, fontSize: text_9),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size_10_h,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PlayerThumb(
                        playerThumbUrl:
                            chatTeam?.opponent_team!.team_thumb_url ?? null,
                        size: size_32_w,
                        placeholderImage: 'asset/images/ic_default_avatar.png',
                      ),
                      SizedBox(
                        width: size_18_w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chatTeam?.opponent_team!.team_name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: text_12),
                            ),
                            Text(
                              sprintf(txt_people_participanting,
                                  [chatTeam?.opponent_team!.team_member_num]),
                              style: TextStyle(
                                  color: kColoraaaaaa, fontSize: text_9),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              playerListTeamBottomSheet(
                isAuthorized: this.isAuthorized,
                chatTeam: chatTeam,
              );
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  'asset/icons/ic_group_member.svg',
                  height: size_28_h,
                  width: size_28_h,
                ),
                Text(
                  txt_member_confirmation,
                  style: TextStyle(color: Colors.white, fontSize: text_11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatPlayers extends StatelessWidget {
  final ChatUser? chatUser;

  const ChatPlayers({Key? key, required this.chatUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size_16_w,
        vertical: size_10_h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayerThumb(
                  playerThumbUrl: chatUser?.you!.thumb_url ?? null,
                  size: size_32_w,
                  placeholderImage: 'asset/images/ic_default_avatar.png',
                ),
                SizedBox(
                  width: size_18_w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatUser?.you!.disp_name ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            TextStyle(color: Colors.white, fontSize: text_12),
                      ),
                      Text(
                        chatUser?.you!.last_access ?? '',
                        style: TextStyle(
                          color: chatUser?.you!.flg_non_access == 1
                              ? Colors.red
                              : kColoraaaaaa,
                          fontSize: text_9,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size_10_w),
                TwitterElipse(
                  width: size_30_w,
                  height: size_20_h,
                  callback: () {
                    var scheme = TWITTER_URL_APP.replaceAll(
                        "{id}", chatUser?.you!.twitter_id ?? "");
                    var url = TWITTER_URL_WEB.replaceAll(
                        "{id}", chatUser?.you!.twitter_id ?? "");
                    launchScheme(scheme, url);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: size_10_h,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayerThumb(
                  playerThumbUrl: chatUser?.opponent!.thumb_url ?? null,
                  size: size_32_w,
                  placeholderImage: 'asset/images/ic_default_avatar.png',
                ),
                SizedBox(
                  width: size_18_w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatUser?.opponent!.disp_name ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            TextStyle(color: Colors.white, fontSize: text_12),
                      ),
                      Text(
                        chatUser?.opponent!.last_access ?? '',
                        style: TextStyle(
                          color: chatUser?.opponent!.flg_non_access == 1
                              ? Colors.red
                              : kColoraaaaaa,
                          fontSize: text_9,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size_10_w),
                TwitterElipse(
                  width: size_30_w,
                  height: size_20_h,
                  callback: () {
                    var scheme = TWITTER_URL_APP.replaceAll(
                        "{id}", chatUser?.opponent!.twitter_id ?? "");
                    var url = TWITTER_URL_WEB.replaceAll(
                        "{id}", chatUser?.opponent!.twitter_id ?? "");
                    launchScheme(scheme, url);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TournamentChatPrivateList extends StatelessWidget {
  final int myUserId;
  final List<ChatPrivateItem> chatPrivateList;

  TournamentChatPrivateList(
      {Key? key, required this.myUserId, required this.chatPrivateList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size_20_w, vertical: size_10_h),
      child: ListView.builder(
        itemCount: this.chatPrivateList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => tournamentChatPrivate(
          item: this.chatPrivateList[index],
          myUserId: this.myUserId,
          index: index,
        ),
      ),
    );
  }
}

class tournamentChatPrivate extends StatelessWidget {
  final ChatPrivateItem item;
  final int myUserId;
  final int index;

  const tournamentChatPrivate(
      {Key? key,
      required this.item,
      required this.myUserId,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _linkTextStyle = TextStyle(
      color: Colors.white,
      fontSize: text_13,
      overflow: TextOverflow.ellipsis,
    );
    bool isImage = (item.type == 2) ? true : false;
    bool isMine = (myUserId == item.user_id) ? true : false;
    return Consumer<ChatPrivateViewModel>(builder: (context, value, child) {
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
                      playerThumbUrl: this.item.player_thumb_url,
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
                          children: [
                            Visibility(
                              visible: !isMine,
                              child: Flexible(
                                child: Text(
                                  this.item.player_name!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: text_9,
                                  ),
                                  maxLines: 1,
                                  softWrap: true,
                                ),
                              ),
                            ),
                            SizedBox(width: !isMine ? size_10_w : 0),
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
                            showImageChatBottomSheet(this.item.image_url!);
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
                        visible: (item.flg_organizer_call == 1),
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
                            txt_call,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_9,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (this.item.message != ""),
                        child: Container(
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
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: SelectableLinkify(
                            onOpen: (link) => launchURL(link.url),
                            text: this.item.message ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Player Icon
                Visibility(
                  visible: isMine,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: size_10_w,
                    ),
                    child: PlayerThumb(
                      playerThumbUrl: this.item.player_thumb_url,
                      placeholderImage: 'asset/images/ic_default_avatar.png',
                      size: size_32_w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size_5_h,
            ),
            Visibility(
              visible: value.extractLink(this.item.message!) != '',
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size_42_w),
                child: ChatPreviewWidget(
                  url: value.extractLink(this.item.message!),
                  chatTextStyle: _linkTextStyle,
                ),
              ),
            ),
            Visibility(
              visible: (this.item.alrady_read_list!.length > 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...this.item.alrady_read_list!.map((itemList) {
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
