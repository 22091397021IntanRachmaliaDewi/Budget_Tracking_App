import 'package:budget_tracking_app/view/view_state.dart';
import 'package:flutter/material.dart';

class BaseViewModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  set state(ViewState viewState) {
    print('State:$viewState');
    _state = viewState;
    notifyListeners();
  }

  set stateWithoutUpdate(ViewState viewState) {
    print('State:$viewState');
    _state = viewState;
  }

  void update() {
    notifyListeners();
  }
}
