import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chess_socket/enums.dart';
import 'package:chess_socket/models/message.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class ClientSocket {
  Socket? _socket;
  ChessBoardController controller;
  StreamController<bool> streamController;
  Stream<bool> get enableBoardStream =>
      streamController.stream.asBroadcastStream();

  ClientSocket(
    this.controller,
  ) : streamController = StreamController();

  void createGame(String fen, int gameNumber, bool isWhite) {
    _socket?.write(
        Message(fen, MessageType.create, gameNumber, isWhite).toString());
  }

  void joinGame(String fen, int gameNumber, bool isWhite) {
    _socket
        ?.write(Message(fen, MessageType.join, gameNumber, isWhite).toString());
  }

  void makeMove(String fen, int gameNumber, bool isWhite) {
    print('make move $fen');
    streamController.add(false);
    _socket
        ?.write(Message(fen, MessageType.move, gameNumber, isWhite).toString());
  }

  void quitGame(int gameNumber, bool isWhite) {
    _socket
        ?.write(Message('', MessageType.quit, gameNumber, isWhite).toString());
    _socket?.close();
  }

  void jsonParser(Uint8List data) {
    String rawMessage = String.fromCharCodes(data).trim();
    Map<String, dynamic> json = jsonDecode(rawMessage);
    Message message = Message.fromJSON(json);
    handleMessage(message);
  }

  void handleMessage(Message message) {
    switch (message.type) {
      case MessageType.create:
        break;
      case MessageType.join:
        print(message.message);
        streamController.add(true);
        break;
      case MessageType.move:
        print('move ${message.message}');
        controller.loadFen(message.message);
        streamController.add(true);
        break;
      case MessageType.quit:
        break;
    }
  }

  void errorHandler(error) {
    print(error);
    _socket?.close();
  }

  void finishedHandler() {
    print('Disconnected');
    _socket?.close();
  }

  void setSocket(Socket socket) {
    this._socket = socket;
    _socket!.listen(jsonParser, onDone: finishedHandler, onError: errorHandler);
    streamController.add(false);
  }
}
