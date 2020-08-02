import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration inputDecoration;
  final TextInputType keyboardType;
  final Function(String) onSubmitted;

  AdaptativeTextField({
    this.controller,
    this.inputDecoration,
    this.keyboardType,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 12,
                ),
                controller: controller,
                placeholder: inputDecoration.labelText,
                keyboardType: keyboardType,
                onSubmitted: onSubmitted),
          )
        : TextField(
            controller: controller,
            decoration: inputDecoration,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted);
  }
}
