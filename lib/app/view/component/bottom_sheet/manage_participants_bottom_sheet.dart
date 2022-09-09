import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/participant_list_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/participant_player_list.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/participant_team_list.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void manageParticipantsBottomSheet({int? tournamentId}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;

  VoidCallback? defaultAction;

  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.pop(context),
    child: GestureDetector(
      onTap: () {},
      child: child,
    ),
  );

  showModalBottomSheet(
    backgroundColor: transparent,
    context: context,
    enableDrag: true,
    isDismissible: false,
    isScrollControlled: true,
    builder: (BuildContext builderContext) {
      // TODO : pauseの時に毎回ここが呼ばれるのでボトムシートを閉じることで暫定対応にした。やり方変更したい。
      return makeDismissible(
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (BuildContext context, ScrollController scrollController) {
            return ManageParticipants(
              defaultAction: defaultAction,
              tournamentId: tournamentId,
            );
          },
        ),
      );
    },
  );
}


class ManageParticipants extends PageProvideNode<ParticipantListViewModel> {
  final VoidCallback? defaultAction;
  final int? tournamentId;

  ManageParticipants({
    Key? key,
    required this.defaultAction,
    required this.tournamentId,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _ManageParticipants(
      viewModel,
      defaultAction: this.defaultAction,
      tournamentId: this.tournamentId,
    );
  }
}

class _ManageParticipants extends StatefulWidget {
  final ParticipantListViewModel _participantListViewModel;
  final VoidCallback? defaultAction;
  final int? tournamentId;

  const _ManageParticipants(this._participantListViewModel, {
    Key? key,
    required this.defaultAction,
    required this.tournamentId,
  }) : super(key: key);

  @override
  __ManageParticipantsState createState() => __ManageParticipantsState();
}

class __ManageParticipantsState extends State<_ManageParticipants>
    with WidgetsBindingObserver {
  ParticipantListViewModel get participantListViewModel => widget._participantListViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    participantListViewModel.participantsApi(widget.tournamentId,);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print ("************** participantListViewModel.dispose ******************");
    participantListViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParticipantListViewModel>(builder: (context, value, child) {
      return BottomSheetContainer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: size_20_w,
                right: size_20_w,
                bottom: size_20_h,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: size_30_h,
                        width: size_30_h,
                        child: SvgPicture.asset(
                          'asset/icons/ic_attendees.svg',
                        ),
                      ),
                      SizedBox(
                        width: size_10_w,
                      ),
                      Text(
                        txt_manager_member,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: text_14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Visibility(
                        visible: value.participantResponse?.is_make_teamcode == true,
                        child: SizedBox(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'asset/icons/ic_issue_team_code.svg',
                                color: Colors.grey,
                              ),
                              Text(
                                txt_issue_team_code,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 3,
              color: Colors.black,
            ),
            Visibility(
              visible: value.participantResponse?.match_type == 2,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size_20_w,
                      vertical: size_20_h,
                    ),
                    decoration: BoxDecoration(
                      color: kColor202330,
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          txt_member_invitation,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: text_12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        value.participantResponse?.invitation_url != ''
                            ? GestureDetector(
                          onTap: () async {
                            final dataUrl = ClipboardData(
                              text: value.participantResponse?.invitation_url,
                            );
                            await Clipboard.setData(dataUrl);
                            showAlertGTDialog(
                              message: txt_copy_url_invitation_complete,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: size_5_h,
                              horizontal: size_15_w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size_20_r),
                              color: Colors.blueAccent,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: size_20_h,
                                  width: size_20_h,
                                  child: SvgPicture.asset(
                                    'asset/icons/ic_copy_chat_team.svg',
                                  ),
                                ),
                                SizedBox(
                                  width: size_6_w,
                                ),
                                Text(
                                  txt_copy_url_invitation,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: text_10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    height: 3,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: value.participantResponse?.match_type == 1,
              child: ParticipantPlayerList(),
            ),
            Visibility(
              visible: value.participantResponse?.match_type == 2,
              child: ParticipantTeamList(),
            ),
          ],
        ),
      );
    });
  }
}
