import 'dart:io';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isStartPage;
  const CustomAppBar({Key? key, this.title, this.isStartPage = false})
      : super(key: key);
  static const double height = 50;

  Widget _buildButton(
      {required Widget child,
      required void Function() onClick,
      required BuildContext context}) {
    return SizedBox(
      height: height,
      child: TextButton(
          onPressed: onClick,
          child: child,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColorDark),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              splashFactory: NoSplash.splashFactory)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: height,
      child: WindowTitleBarBox(
        child: Row(
          children: [
            if (!isStartPage)
              _buildButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: const [
                  Icon(FluentIcons.arrow_left_24_regular, size: 22,),
                  Text(
                    'ESC',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)
                  )
                ]),
                context: context,
              ),
            Expanded(
              flex: 1,
              child: MoveWindow(
                child: Row(
                  children: [
                    // Padding
                    const SizedBox(width: 10),
                    // Add an extra width on start-page
                    if (isStartPage) const SizedBox(width: 5),
                    // Title
                    Text(
                      title ?? 'Foast Launcher',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            if (isStartPage) _buildButton(
              child: const Icon(FluentIcons.dismiss_24_regular),
              onClick: () {
                exit(0);
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
