import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateJoinCard extends StatelessWidget {
  final String title;
  final Function handlePressed;
  const CreateJoinCard(
      {super.key, required this.handlePressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                          width: 1,
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer)))),
          onPressed: () => {
            handlePressed(context),
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/piece.svg',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
