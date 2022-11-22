// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:chess_socket/models/socket.dart';
import 'package:chess_socket/scheme/color_schemes.g.dart';
import 'package:chess_socket/views/connect/connect.dart';
import 'package:chess_socket/views/createjoin/create_join.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart' as chess;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ClientSocket(chess.ChessBoardController()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: GoogleFonts.robotoCondensedTextTheme()),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        home: const ConnectToIP(),
      ),
    );
  }
}
