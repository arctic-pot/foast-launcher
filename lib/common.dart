import 'package:flutter/material.dart';

class SingleValueChangeNotifier<T> with ChangeNotifier {
  late T _value;
  SingleValueChangeNotifier(initValue) {
    _value = initValue;
  }
  get value => _value;
  set value(newValue) {
    _value = newValue;
    notifyListeners();
  }
}

ThemeData navigationDrawerStyle(BuildContext context) => ThemeData(
      listTileTheme: ListTileThemeData(
        selectedTileColor: Theme.of(context).primaryColorLight.withOpacity(0.4),
      ),
    );

class GameRunning extends SingleValueChangeNotifier {
  GameRunning(bool initValue) : super(initValue);
}

void navigateToWidget(BuildContext context, Widget widget) {
  Navigator.of(context).push(PageRouteBuilder(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slideTween = Tween(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.fastOutSlowIn));
      final fadeTween = Tween(
        begin: 0.0,
        end: 1.0,
      );
      return SlideTransition(
        position: animation.drive(slideTween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        ),
      );
    },
    pageBuilder: (context, _, __) => widget,
  ));
}
