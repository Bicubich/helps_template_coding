import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helps_flutter/api/constants.dart';
import 'package:helps_flutter/model/mark_stream_model.dart';
import 'package:helps_flutter/model/sos_stream_model.dart';
import 'package:helps_flutter/model/user_stream_model.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static IO.Socket? _serverSocket;
  static late int _reconnectAttemptsSocket;

  static Stream<SosStreamModel?> get sosStream => _sosStreamController.stream;

  static Stream<UserStreamModel?> get userStream =>
      _userStreamController.stream;

  static Stream<MarkStreamModel?> get markStream =>
      _markStreamController.stream;

  static Stream<String?> get userDisconnectStream =>
      _userDisconnectStreamController.stream;

  static StreamController<SosStreamModel> _sosStreamController =
      StreamController.broadcast();

  static StreamController<UserStreamModel> _userStreamController =
      StreamController.broadcast();

  static StreamController<MarkStreamModel> _markStreamController =
      StreamController.broadcast();

  static StreamController<String> _userDisconnectStreamController =
      StreamController.broadcast();

  static void initSocket(BuildContext context) async {
    try {
      _reconnectAttemptsSocket = 0;

      String? serverToken = await SharedPreferencesHelper.getString(
          SharedPreferencesKeys.serverToken);

      if (serverToken != null) {
        _serverSocket = IO.io(
            ApiConstants.apiUrl,
            IO.OptionBuilder().setTransports(
                    ['websocket', 'polling']) // for Flutter or Dart VM
                .setExtraHeaders(
                    {'Authorization': 'Bearer $serverToken'}) // optional
                .build());
        _serverSocket?.connect();

        //_serverSocket = IO.io(ApiConstants.apiUrl, <String, dynamic>{
        //  //'transports': ['websocket', 'polling'],
        //  'extraHeaders': {'Authorization': 'Bearer YOUR_TOKEN'},
        //});

        _serverSocket?.onConnect((data) {
          print('Socket: Соединение установлено успешно');
          _reconnectAttemptsSocket = 0;
        });

        _serverSocket?.onError((data) {
          print('Socket: Ошибка присоединения');
          if (_reconnectAttemptsSocket < 5) {
            _reconnectAttemptsSocket++;
            Future.delayed(Duration(seconds: 5), () {
              _serverSocket?.connect();
            });
          } else {
            print(
                'Socket: Достигнуто максимальное количество попыток подключения');
          }
        });

        _serverSocket?.onDisconnect((data) {
          print('Socket: Отключено');
          if (_reconnectAttemptsSocket < 5) {
            _reconnectAttemptsSocket++;
            Future.delayed(Duration(seconds: 5), () {
              _serverSocket?.connect();
            });
          } else {
            print(
                'Socket: Достигнуто максимальное количество попыток подключения');
          }
        });

        _serverSocket?.on('userStream', (data) {
          try {
            UserStreamModel userStreamModel = UserStreamModel.fromJson(data);
            _userStreamController.add(userStreamModel);
          } catch (_) {}
        });

        _serverSocket?.on('sosStream', (data) {
          try {
            SosStreamModel sosStreamModel = SosStreamModel.fromJson(data);
            _sosStreamController.add(sosStreamModel);
          } catch (_) {}
        });

        _serverSocket?.on('markStream', (data) {
          try {
            MarkStreamModel markStreamModel = MarkStreamModel.fromJson(data);
            _markStreamController.add(markStreamModel);
          } catch (_) {}
        });

        // TODO: Убрать чела из листа, если он отсоединился, чтобы не рисовать его на карте
        _serverSocket?.on('onUserDisconnect', (data) {
          try {
            if (data is String) {
              _userDisconnectStreamController.add(data);
            }
          } catch (_) {}
        });

        _serverSocket?.on('error', (data) {
          print('Socket: $data');
        });

        _serverSocket?.on('reconnect', (_) {
          print('Socket: Соединение восстановлено успешно');
          _reconnectAttemptsSocket = 0;
        });
      }
    } catch (ex) {
      print('Socket: Ошибка при создании сокета: $ex');
      print(ex);
    }
  }

  static emitData(Map<String, dynamic> jsonData) {
    if (_serverSocket != null && _serverSocket!.connected) {
      _serverSocket?.emit("newMark", jsonData);
    }
  }

  static void disposeSocket() {
    _serverSocket?.dispose();
  }
}
