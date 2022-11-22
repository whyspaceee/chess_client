import 'package:flutter/material.dart';

class IPTextField extends StatelessWidget {
  final TextEditingController controller;
  const IPTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            label: Text('Host IP'),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
        controller: controller,
      ),
    );
  }
}
