import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:inventura_app/common/color_palette.dart';
import 'package:inventura_app/routes.dart';
import 'package:inventura_app/screens/auth/login.dart';
import 'package:inventura_app/screens/dashboard.dart';
import 'package:inventura_app/services/auth_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true // optional: set false to disable printing logs to console
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final authService = AuthService.fromAuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('hr', ''),
      ],
      title: 'Inventura',
      theme: ThemeData(
          primarySwatch: ColorPalette.primary,
          primaryColor: ColorPalette.primary,
          // fontFamily: 'Roboto',
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 96.0,
                fontWeight: FontWeight.w300,
                letterSpacing: -1.5),
            headline2: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.w300,
                letterSpacing: -0.5),
            headline3: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0),
            headline4: TextStyle(
                fontSize: 34.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.25),
            headline5: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0),
            headline6: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15),
            subtitle1: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.15),
            subtitle2: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1),
            bodyText1: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5),
            bodyText2: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.25),
            button: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.25),
            caption: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.4),
            overline: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 1.5),
          )),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: authService.isUserLoggedIn(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data == true) {
              return const DashboardScreen(title: '');
            } else {
              return const LoginScreen();
            }
          }),
      routes: routes,
    );
  }
}
