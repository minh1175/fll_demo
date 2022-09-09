import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class MatchBoardRequest {
  MatchBoardRequest();

  Stream bulkScoreInfoList(params, tournament_id) => get(API_BULK_SCORE_INPUT_LIST + tournament_id.toString(), params: params);

  Stream bulkOrganizerLeaguePost(params) => post(API_BULK_ORIGANIZER_LEANGUE_SCORE, params: params);

  Stream matchBoardList(params) => get(API_MATCHBOARD_LIST, params: params);

  Stream score(params, tournament_round_id) => get(API_SCORE_INFO + tournament_round_id.toString(), params: params);

  Stream scorePost(params) => post(API_SCORE_POST_LEAGUE, params: params);

  Stream scorePostLeagueOrganizer(params) => post(API_SCORE_POST_LEAGUE_ORGANIZER, params: params);

  Stream postResult(params) => post(API_MATCH_RESULT_POST, params: params);
}
