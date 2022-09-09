import 'package:Gametector/app/module/network/request/account_request.dart';
import 'package:Gametector/app/module/network/request/auth_request.dart';
import 'package:Gametector/app/module/network/request/chat_request.dart';
import 'package:Gametector/app/module/network/request/common_request.dart';
import 'package:Gametector/app/module/network/request/home_request.dart';
import 'package:Gametector/app/module/network/request/matchboard_request.dart';
import 'package:Gametector/app/module/network/request/notice_request.dart';
import 'package:Gametector/app/module/network/request/setting_request.dart';
import 'package:Gametector/app/module/network/request/tournament_request.dart';

class DataRepository {
  final CommonRequest? _commonRequest;
  final AuthRequest? _authRequest;
  final AccountRequest? _accountRequest;
  final TournamentRequest? _tournamentRequest;
  final MatchBoardRequest? _matchBoardRequest;
  final HomeRequest? _homeRequest;
  final NoticeRequest? _noticeRequest;
  final ChatRequest? _chatRequest;
  final SettingRequest? _settingRequest;

  DataRepository(
      this._authRequest,
      this._commonRequest,
      this._accountRequest,
      this._tournamentRequest,
      this._matchBoardRequest,
      this._homeRequest,
      this._noticeRequest,
      this._chatRequest,
      this._settingRequest,);

  Stream start() {
    return _commonRequest!.start();
  }

  Stream login(Map<String, dynamic> params) {
    return _authRequest!.login(params);
  }

  Stream logout() {
    return _authRequest!.logout();
  }

  Stream loginComplete(Map<String, dynamic> params) {
    return _authRequest!.loginComplete(params);
  }

  Stream twitterInfoUpdate() {
    return _accountRequest!.twitterInfoUpdate();
  }

  Stream list(Map<String, dynamic> params) {
    return _tournamentRequest!.list(params);
  }

  Stream playerList(Map<String, dynamic> params) {
    return _tournamentRequest!.playerList(params);
  }

  Stream filterMenuList(Map<String, dynamic> params) {
    return _tournamentRequest!.filterMenuList(params);
  }

  Stream tournamentInfo(Map<String, dynamic> params) {
    return _tournamentRequest!.tournamentInfo(params);
  }

  Stream participants(Map<String, dynamic> params) {
    return _tournamentRequest!.participants(params);
  }

  Stream athletes(Map<String, dynamic> params) {
    return _tournamentRequest!.athletes(params);
  }

  Stream retirePlayer(Map<String, dynamic> params) {
    return _tournamentRequest!.retirePlayer(params);
  }

  Stream excludePlayer(Map<String, dynamic> params) {
    return _tournamentRequest!.excludePlayer(params);
  }

  Stream deletePlayer(Map<String, dynamic> params) {
    return _tournamentRequest!.deletePlayer(params);
  }

  Stream rankList(Map<String, dynamic> params) {
    return _tournamentRequest!.rankList(params);
  }

  Stream tournamentFinish(Map<String, dynamic> params) {
    return _tournamentRequest!.tournamentFinish(params);
  }

  Stream bulkScoreInfoList(Map<String, dynamic> params, tournament_id) {
    return _matchBoardRequest!.bulkScoreInfoList(params, tournament_id);
  }

  Stream bulkOrganizerLeaguePost(Map<String, dynamic> params) {
    return _matchBoardRequest!.bulkOrganizerLeaguePost(params);
  }

  Stream scoreInfo(Map<String, dynamic> params, tournament_round_id) {
    return _matchBoardRequest!.score(params, tournament_round_id);
  }

  Stream scorePost(Map<String, dynamic> params) {
    return _matchBoardRequest!.scorePost(params);
  }

  Stream scorePostLeagueOrganizer(Map<String, dynamic> params) {
    return _matchBoardRequest!.scorePostLeagueOrganizer(params);
  }

  Stream matchBoardList(Map<String, dynamic> params) {
    return _matchBoardRequest!.matchBoardList(params);
  }

  Stream home() {
    return _homeRequest!.home();
  }

  Stream all(Map<String, dynamic> params) {
    return _noticeRequest!.all(params);
  }

  Stream listNotify(Map<String, dynamic> params) {
    return _noticeRequest!.list(params);
  }

  Stream readNotify(Map<String, dynamic> params) {
    return _noticeRequest!.read(params);
  }

  Stream announceList(Map<String, dynamic> params) {
    return _noticeRequest!.announce(params);
  }

  Stream badgeCount() {
    return _noticeRequest!.badgeCount();
  }

  Stream mypage() {
    return _accountRequest!.mypage();
  }

  Stream chatList(Map<String, dynamic> params) {
    return _chatRequest!.list(params);
  }

  Stream chatPrivateList(Map<String, dynamic> params) {
    return _chatRequest!.privateList(params);
  }

  Stream mypageGame(Map<String, dynamic> params) {
    return _accountRequest!.mypageGame(params);
  }

  Stream profile(Map<String, dynamic> params) {
    return _accountRequest!.profile(params);
  }

  Stream introductionPost(Map<String, dynamic> params) {
    return _accountRequest!.introductionPost(params);
  }

  Stream setting() {
    return _settingRequest!.getSetting();
  }

  Stream postSetting(Map<String, dynamic> params) {
    return _settingRequest!.postSetting(params);
  }

  Stream finishHalfway(Map<String, dynamic> params) {
    return _tournamentRequest!.finishHalfway(params);
  }

  Stream postResult(Map<String, dynamic> params) {
    return _matchBoardRequest!.postResult(params);
  }

  Stream uploadImage(Map<String, dynamic> params) {
    return _chatRequest!.uploadImage(params);
  }

  Stream noticeRead(Map<String, dynamic> params) {
    return _noticeRequest!.read(params);
  }
}
