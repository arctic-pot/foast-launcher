import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foast_launcher/pages/app_bar.dart';

class SubPageScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final focusNode = FocusNode();

  SubPageScaffold({Key? key, required this.child, this.title = 'Untitled'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      child: Scaffold(
        appBar: CustomAppBar(title: title),
        body: child,
      ),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  StatelessElement createElement() {
    focusNode.requestFocus();
    return super.createElement();
  }
}
