import 'package:flutter/material.dart';
import 'package:lab12_covid_tracker/Screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/FruitsModelRunner.dart';
import 'Screens/home.dart';
import 'Screens/models_list.dart';
import 'Screens/register.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Tracker',
      home: LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/models': (context) => ModelsList(),
        '/fruits': (context) => FruitsModelRunner(),
      },

    );
  }
}
