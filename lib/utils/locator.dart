import 'package:budget_tracking_app/view_model/login_view_model.dart';
import 'package:budget_tracking_app/view_model/signup_view_modal.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LogInViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());
}
