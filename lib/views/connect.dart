import 'dart:io';

import 'package:chess_socket/views/create_join.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../models/socket.dart';

class ConnectToIP extends StatefulWidget {
  const ConnectToIP({super.key});

  @override
  State<ConnectToIP> createState() => _ConnectToIPState();
}

class _ConnectToIPState extends State<ConnectToIP> {
  late Socket _socket;
  final TextEditingController controller = TextEditingController();
  bool connected = false;

  void connectToIP(String IP) async {
    _socket = await Socket.connect(IP, 57998);
    print(_socket.remotePort);
    print('connected to ${_socket.address}');
    setState(() {
      connected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (connected) {
      context.read<ClientSocket>().setSocket(_socket);
      return CreateJoin();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(flex: 4, child: SvgPicture.asset('assets/king.svg')),
          Expanded(
              flex: 6,
              child: Column(
                children: [
                  Text(
                    'Enter Host IP',
                    style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                      controller: controller,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
                      if (validator.ip(controller.text.trim()))
                        {
                          print("hello"),
                          connectToIP(controller.text.trim()),
                        },
                      print("world"),
                    },
                    child: Text('Connect'),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
