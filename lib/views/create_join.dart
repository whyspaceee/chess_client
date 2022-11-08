// ignore_for_file: prefer_const_constructors

import 'package:chess_socket/main.dart';
import 'package:chess_socket/models/socket.dart';
import 'package:chess_socket/views/chess_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';

class CreateJoin extends StatefulWidget {
  const CreateJoin({super.key});

  @override
  State<CreateJoin> createState() => _CreateJoinState();
}

class _CreateJoinState extends State<CreateJoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () => {
                      context.read<ClientSocket>().createGame(
                          'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1',
                          69,
                          true),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChessPage(title: "Chess", isWhite: true),
                          ))
                    },
                child: const Text('Create')),
            TextButton(
                onPressed: () => {
                      context.read<ClientSocket>().joinGame(
                          'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1',
                          69,
                          false),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ChessPage(title: "Chess", isWhite: false),
                          ))
                    },
                child: Text("Join"))
          ],
        ),
      ),
    );
  }
}
