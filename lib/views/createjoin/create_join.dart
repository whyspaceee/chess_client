// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chess_socket/models/socket.dart';
import 'package:chess_socket/views/chess_page.dart';
import 'package:chess_socket/views/createjoin/components/createjoincard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreateJoin extends StatefulWidget {
  const CreateJoin({super.key});

  @override
  State<CreateJoin> createState() => _CreateJoinState();
}

createGame(BuildContext context) => {
      context.read<ClientSocket>().createGame(
          'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', 69, true),
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChessPage(title: "Chess", isWhite: true),
          ))
    };

joinGame(BuildContext context) => {
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
    };

class _CreateJoinState extends State<CreateJoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
              flex: 1,
              child: SvgPicture.asset(
                'assets/king.svg',
              )),
          CreateJoinCard(
            title: "Create Game",
            handlePressed: createGame,
          ),
          CreateJoinCard(title: "Join Game", handlePressed: joinGame),
          SizedBox(height: 32)
         
        ]),
      ),
    );
  }
}

