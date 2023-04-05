import 'package:flutter/material.dart';

///
///keyboard dismissal
///
void dissmissKeyboard(BuildContext context) {
  FocusScopeNode currentfocus =
      FocusScope.of(context); //get the currnet focus node
  if (!currentfocus.hasPrimaryFocus) {
    //prevent Flutter from throwing an exception
    currentfocus
        .unfocus(); //unfocust from current focust, so that keyboard will dismiss
  }
}
