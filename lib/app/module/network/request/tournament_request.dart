import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class TournamentRequest {
  TournamentRequest();

  Stream filterMenuList(params) => get(API_TOURNAMENT_FILTER_LIST, params: params);

  Stream list(params) => get(API_TOURNAMENT_LIST, params: params);

  Stream playerList(params) => get(API_TOURNAMENT_LIST_PLAYER_LIST, params: params);

  Stream tournamentInfo(params) => get(API_TOURNAMENT_INFO, params: params);

  Stream participants(params) => get(API_TOURNAMENT_MANAGE_PLAYER, params: params);

  Stream athletes(params) => get(API_PARTICIPANTS, params: params);

  Stream retirePlayer(params) => post(API_RETIRE_PLAYER, params: params);

  Stream excludePlayer(params) => post(API_EXCLUDE_PLAYER, params: params);

  Stream deletePlayer(params) => post(API_DELETE_PLAYER, params: params);

  Stream finishHalfway(params) => post(API_FINISH_HALFWAY, params: params);

  Stream rankList(params) => get(API_TOURNAMENT_LIST_RANKING, params: params);

  Stream tournamentFinish(params) => post(API_TOURNAMENT_FINISH, params: params);
}
