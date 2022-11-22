import 'package:chess_socket/models/socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';

class CustomBoard extends StatelessWidget {
  final bool isWhite;
  const CustomBoard({super.key, required this.isWhite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: context.read<ClientSocket>().enableBoardStream,
          builder: ((context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return ChessBoard(
                  controller: context.read<ClientSocket>().controller,
                  enableUserMoves: snapshot.data!, // enable user moves
                  size: 500,
                  boardOrientation:
                      isWhite ? PlayerColor.white : PlayerColor.black,
                  onMove: () => {
                        context.read<ClientSocket>().makeMove(
                            context.read<ClientSocket>().controller.getFen(),
                            69,
                            true),
                        print(snapshot)
                      });
            } else {
              return Container();
            }
          })),
    );
  }
}
