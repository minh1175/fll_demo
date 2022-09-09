import 'dart:async';
import 'dart:convert';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/socket/receive_socket_handle.dart';
import 'package:connectivity/connectivity.dart';
import 'package:web_socket_channel/io.dart';

class SocketManager {
  static final SocketManager _instance = new SocketManager._internal();
  UserSharePref _userSharePref = getIt<UserSharePref>();
  IOWebSocketChannel? channel = null;
  bool _isConnect = false;
  StreamSubscription<ConnectivityResult>? subscription;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal() {
    connect();
  }

  connect() {
    var token = _userSharePref.getAppToken();
    if (token.isNotEmpty) {
      print("_____________________SOCKET_V2: Conecting...");
      try {
        channel = IOWebSocketChannel.connect(
          Uri.parse(SOCKET_SERVER_URL),
          headers: {"X-APP-TOKEN": _userSharePref.getAppToken(),},
          pingInterval: Duration(milliseconds: 5000),
        );
        _isConnect = true;
        channel!.stream.listen((message) {
          print("_____________________SOCKET_V2: receive");
          print("Receive message from Websocket: " + message);
          _isConnect = true;
          ReceiveSocketHandle(data: message).handleData();
        }, onDone: () {
          print('_____________________SOCKET_V2: Closed');
          channel == null;
          _isConnect = false;
        }, onError: (dynamic error) {
          print(error);
        });
        subscription = Connectivity()
            .onConnectivityChanged
            .listen((ConnectivityResult result) {
          if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
            print ("RESET_BY: mobile:mobile&wifi");
            initSocket();
          }
        });
        print("_____________________SOCKET_V2: Socket has been opened successfully.____________________");
        return channel;
      } catch (error) {
        print("_____________________SOCKET_V2: Error! Socket connection fail, try to reconnect. " + error.toString());
        _isConnect = false;
        channel = null;
        return null;
      }
    } else {
      return null;
    }
  }

  reconnect() {
    print ("_____________________SOCKET_V2: reconnect");
    disconnect();
    connect();
  }

  disconnect() {
    print ("_____________________SOCKET_V2: disconnect");
    _isConnect = false;
    subscription?.cancel();
    if (channel != null) {
      channel!.sink.close();
      channel = null;
    }
  }

  send(String event, dynamic data) async {
    print ("_____________________SOCKET_V2: send");
    final map = Map<String, dynamic>();
    map.putIfAbsent(KEY_ACTION_SOCKET, () => event);
    map.putIfAbsent(KEY_DATA_SOCKET, () => data ?? "");
    print("Send:  ${json.encode(map)}");
    if (channel != null) {
      channel!.sink.add(json.encode(map).toString());
    }
  }

  initSocket() {
    if (channel == null || !isConnectSocket()) {
      print ("init reconnect socketManager");
      reconnect();
    }
  }

  bool isConnectSocket() {
    return _isConnect;
  }
 }
