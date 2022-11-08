import 'package:chess_socket/components/chessboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';

import '../models/socket.dart';

class ChessPage extends StatefulWidget {
  final bool isWhite;
  const ChessPage({super.key, required this.title, required this.isWhite});

  final String title;

  @override
  State<ChessPage> createState() => _ChessPageState();
}

class _ChessPageState extends State<ChessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CustomBoard(isWhite: widget.isWhite)],
        ),
      ),
    );
  }
}
