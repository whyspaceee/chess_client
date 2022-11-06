// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:chess_socket/models/socket.dart';
import 'package:chess_socket/views/create_join.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';

void main() async {
  final clientSocket = await Socket.connect(
    '192.168.2.3',
    57998,
  );
  print(clientSocket.remotePort);
  print('connected to ${clientSocket.address}');
  runApp(MyApp(clientSocket));
}

class MyApp extends StatelessWidget {
  final Socket socket;
  const MyApp(this.socket);
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ClientSocket(socket, ChessBoardController()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CreateJoin(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isWhite;
  const MyHomePage({super.key, required this.title, required this.isWhite});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: context.watch<ClientSocket>().enableBoardStream,
                builder: ((context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return ChessBoard(
                        controller: context.read<ClientSocket>().controller,
                        enableUserMoves: snapshot.data!, // enable user moves
                        size: 500,
                        boardOrientation: widget.isWhite
                            ? PlayerColor.white
                            : PlayerColor.black,
                        onMove: () => {
                              context.read<ClientSocket>().makeMove(
                                  context
                                      .read<ClientSocket>()
                                      .controller
                                      .getFen(),
                                  69,
                                  true),
                              print(snapshot)
                            });
                  } else {
                    return Container();
                  }
                }))
          ],
        ),
      ),
    );
  }
}
