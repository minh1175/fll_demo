enum LoadingState { LOADING, DONE, ERROR, EMPTY }

//Network Config
const int CONNECT_TIMEOUT = 15000;
const int WRITE_TIMEOUT = 15000;
const int READ_TIMEOUT = 15000;

//time navigate to login page
const int DELAY_SPLASH_PAGE = 300;

//API
const String DOMAIN = 'develop.gametector.com';
const String API_BASE = 'https://' + DOMAIN + '/api';

//Twitter
const String TWITTER_URL_APP = 'twitter://user?id={id}';
const String TWITTER_URL_WEB = 'https://twitter.com/intent/user?user_id={id}';
const String TWITTER_API_KEY = 'dqqp1CRkJWqAUBlVfz9VSL1h8';
const String TWITTER_API_SECRET = 'jkYenSqmXgXYQg3t6JP6hzEKs037eQZ1512ILT8ztrEghFWTTC';
const String TWITTER_URL_CALLBACK = 'https://gametector-29ef5.firebaseapp.com/__/auth/handler';
const String TWITTER_URL_SCHEME = 'gametector://';

// API
const String API_APP_START = '/start'; // アプリ起動（app start）
const String API_APP_LOGIN = '/login'; // ログイン（login）
const String API_APP_LOGOUT = '/logout'; // ログアウト（logout）
const String API_APP_SIGNUP_COMPLETE = '/signUpComplete'; // サインアップ完成（sign up complete）
const String API_APP_ACCOUNT_LIST = '/accounts'; // アカウントリスト（get account list）
const String API_MATCHBOARD_LIST = '/matches'; // マッチボード一覧取得（get match board list）
const String API_MATCH_RESULT_POST = '/matches'; // 対戦結果ポスト（post match result）
const String API_UPLOAD_WINCERTIFICATION = '/matches/wincertification'; // 勝利証明ポスト（upload win certification）
const String API_CHAT_LIST = '/chats'; // チャット一覧取得（get chat list）
const String API_CHAT_POST = '/chats'; // チャットポスト（post chat）
const String API_CHAT_PRIVATE_LIST = '/chats/private'; // 個別チャット一覧取得（get private chat list）
const String API_CHAT_PRIVATE_POST = '/chats/private'; // 個別チャットポスト（post private chat）
const String API_TOURNAMENT_LIST = '/tournaments'; // 参加した大会一覧取得（get tournament list）
const String API_NOTICE_LIST = '/notices'; //通知一覧（get notification list）
const String API_NOTICE_READ = '/notices/read'; //既読にする（set notification read）
const String API_ANNOUNCE_LIST = '/notices/announce'; //全体アナウンス（get announce list）
const String API_SCORE_INFO = '/matches/score/'; //情報スコアを取得（get info score）
const String API_SCORE_POST_LEAGUE = '/matches'; //スコアを登録（post score）
const String API_SCORE_POST_LEAGUE_ORGANIZER = '/matches/league/organizer';
const String API_ORGANIZER_LEAGUE_SCORE_POST = '/matches/league/organizer';
const String API_TOURNAMENT_LIST_RANKING = '/tournaments/ranking'; //情報スコアを取得（get info score）
const String API_TOURNAMENT_FINISH = '/tournaments/finish';
const String API_TOURNAMENT_LIST_PLAYER_LIST = '/tournaments/player';
const String API_BULK_SCORE_INPUT_LIST = '/matches/score/bulk/';
const String API_BULK_ORIGANIZER_LEANGUE_SCORE = '/matches/league/organizer/bulk';
const String API_NOTIFY_ALL = '/notices/all';
const String API_TOURNAMENT_INFO = '/tournaments/info';
const String API_BADGE_COUNT = '/notices/badge';
const String API_SETTING = '/settings';
const String API_TOURNAMENT_FILTER_LIST = '/tournaments/menu';
const String API_UPLOAD_IMAGE_CHAT = '/chats/upload'; //upload image
const String API_TOURNAMENT_MANAGE_PLAYER = '/tournaments/manageplayerlist';
const String API_GET_TEAM_CODE = '/tournaments/getteamcode';
const String API_EXCLUDE_PLAYER = '/tournaments/excludeplayer';
const String API_DELETE_PLAYER = '/tournaments/deleteplayer';
const String API_APP_MY_PAGE = '/mypage';
const String API_APP_MY_PAGE_GAME = '/mypage/game';
const String API_APP_MY_PAGE_INTRODUCTION = '/mypage/introduction';
const String API_APP_MY_PAGE_TWITTER_UPDATE = '/mypage/twitter/update';
const String API_RETIRE_PLAYER = '/tournaments/player/retire';
const String API_PARTICIPANTS = '/tournaments/participants';
const String API_FINISH_HALFWAY = '/tournaments/finish/halfway';
const String API_HOME = '/home';
const String API_PROFILE_INFO = '/mypage/profile';
const String API_INTRODUCTION_POST = '/mypage/introduction';

// terms of service URL
const String URL_TERMS_OF_SERVICE =
    'https://docs.google.com/document/d/1rBVXIJD26e_YLSDU4gV_y1HAxVjpT3yD67GaQzrHbBM/edit?usp=sharing';

// privacy policy URL
const String URL_PRIVACY_POLICY =
    'https://docs.google.com/document/d/1L-scSpxvizttDtdEFbtL0r-DB95lpHShgLCR_gCMD48/edit';

// organizer post score URL
const String URL_ORGANIZER_POST_SCORE = 'https://' + DOMAIN + '/appscore/{tournamentId}';

// users page URL
const String URL_USERS = 'https://' + DOMAIN + '/users';

// WebView URL
const String URL_MATCH_STATS = 'https://' + DOMAIN + '/appweb/player/{tournamentRoundId}/result';
const String URL_TOURNAMENT_BRACKET = 'https://' + DOMAIN + '/tournaments/{uniqueId}/brackets?is_app=1&player_id={playerId}';
const String URL_LEAGUE_TABLE = 'https://' + DOMAIN + '/leagues/{uniqueId}/table?is_app=1';
const String URL_HOME = 'https://' + DOMAIN + '/appweb/home?game_title_id={gameTitleId}';
const String URL_ENTRY = 'https://' + DOMAIN + '/appweb/tournament/{tournamentId}/entry/device/{deviceType}';
const String URL_CHECKIN = 'https://' + DOMAIN + '/appweb/checkin/{tournamentId}/device/{deviceType}';
const String URL_DELETE_USER = 'https://' + DOMAIN + '/appweb/delete_user';

// Push Type
const String PUSH_TYPE_SOCKET_ERROR = "0"; // receive socket error
const String PUSH_TYPE_CHAT_MESSAGE = "1"; // receive chat message
const String PUSH_TYPE_PRIVATE_CHAT_MESSAGE = "2"; // receive private chat message
const String PUSH_TYPE_REFLECT_MATCH_RESULT = "3"; // reflect match result
const String PUSH_TYPE_UPDATE_MATCH_BOARD = "4"; // update match board
const String PUSH_TYPE_UPDATE_NOTIFICATION = "5"; // update notification
const String PUSH_TYPE_REFLECT_MATCH_RESULT_BULK = "6"; // reflect match result for bulk
const String PUSH_TYPE_UPDATE_ALL_NOTIFICATION = "7"; // update all notification
const String PUSH_TYPE_ALREADY_READ_MESSAGE = "8";
const String PUSH_TYPE_TYPING_MESSAGE = "9";

//Chat socket
const String SOCKET_SERVER_URL = "wss://socket." + DOMAIN + ":443";
const String KEY_ACTION_SOCKET = "action";
const String KEY_DATA_SOCKET = "data";
//send chat
const String ACTION_SEND_CHAT = "sendchat";
const String ACTION_SEND_CHAT_PRIVATE = "sendprivatechat";
//typing message
const String ACTION_TYPING_MESSAGE = "typingmessage";
//already read message
const String ACTION_ALREADY_READ_MESSAGE = "alreadyreadmessage";

const int IMAGE_COMPRESS_SIZE = 1024*1024;
