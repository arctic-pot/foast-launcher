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

void navigateWidget(BuildContext context, builder) {
  Navigator.of(context).push(MaterialPageRoute(builder: builder));
}
