// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chess_socket/views/connect/components/button.dart';
import 'package:chess_socket/views/connect/components/textfield.dart';
import 'package:chess_socket/views/createjoin/create_join.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../../models/socket.dart';

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

  final Logo = Expanded(
      flex: 5,
      child: SvgPicture.asset(
        'assets/king.svg',
      ));

  @override
  Widget build(BuildContext context) {
    if (connected) {
      context.read<ClientSocket>().setSocket(_socket);
      return CreateJoin();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Logo,
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  IPTextField(controller: controller),
                  SizedBox(height: 16),
                  ConnectButton(
                      controller: controller, connectToIP: connectToIP),
                ],
              )),
        ]),
      ),
    );
  }
}
