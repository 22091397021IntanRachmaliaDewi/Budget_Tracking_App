import 'package:budget_tracking_app/firebase_options.dart';
import 'package:budget_tracking_app/routing/router.dart';
import 'package:budget_tracking_app/routing/routes.dart';
import 'package:budget_tracking_app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir', useMaterial3: false),
      onGenerateRoute: PageRouter.generateRoute,
      initialRoute: Routes.SplashRoute,
    );
  }
}
