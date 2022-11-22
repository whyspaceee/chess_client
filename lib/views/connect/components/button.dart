import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

class ConnectButton extends StatelessWidget {
  final TextEditingController controller;
  final Function connectToIP;
  const ConnectButton(
      {super.key, required this.controller, required this.connectToIP});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
            foregroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onPrimary)),
        onPressed: () => {
          if (validator.ip(controller.text.trim()))
            {
              connectToIP(controller.text.trim()),
            },
          print("world"),
        },
        child: Text('Connect'),
      ),
    );
  }
}
