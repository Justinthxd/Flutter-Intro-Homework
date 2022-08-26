import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_intro_software/pages/Login.dart';
import 'package:flutter_app_intro_software/pages/edit.dart';
import 'package:flutter_app_intro_software/pages/sub.dart';

import 'pages/create_employee.dart';
import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'App',
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => const Home(),
        '/create': (context) => const Crear(),
        '/sub': (context) => Sub(),
        '/edit': (context) => Edit(),
      },
    );
  }
}
