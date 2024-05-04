import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:td_app/firebase_options.dart';

import 'home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  // 테마 모드 light or dark
  ThemeMode _themeMode = ThemeMode.system; // system은 dark, light 둘다 사용

  _changeThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    setState(() {});
  }

  static const seedColor = Colors.deepPurple;


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 언어 설정
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // '언어', '지역이름'
        Locale('en', 'US'),
      ],
      title: 'Flutter Demo',
      themeMode: _themeMode,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: seedColor
      ),


      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: seedColor
      ),
      // function도 보낼 수 있다.
      
      home: const Home(),
    );
  }
}