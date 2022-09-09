import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class ChatRequest {
  ChatRequest();

  Stream list(params) => get(API_CHAT_LIST, params: params);

  Stream privateList(params) => get(API_CHAT_PRIVATE_LIST, params: params);

  Stream chatPost(params) => post(API_CHAT_POST, params: params);

  Stream chatPrivatePost(params) => post(API_CHAT_PRIVATE_POST, params: params);

  Stream uploadImage(params) => post(API_UPLOAD_IMAGE_CHAT, params: params);
}
