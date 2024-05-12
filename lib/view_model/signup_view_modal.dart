import 'package:budget_tracking_app/view/base_viewmodel.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  bool _autoValidate = false;

  GlobalKey<FormState> _signUpKey = GlobalKey();

  clearData(BuildContext context) {
    // resetFocus(context);
    setAutoValidate(false);
    setForgotKey(GlobalKey());
  }

  setForgotKey(GlobalKey<FormState> value) {
    _signUpKey = value;
    notifyListeners();
  }

  void resetFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  bool get autoValidate => _autoValidate;

  setAutoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  GlobalKey<FormState> get signUpKey => _signUpKey;
}
