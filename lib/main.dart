import 'package:flutter/material.dart';
import 'package:learnify/home/home_screen.dart';
import 'package:learnify/screens/auth/login_screen.dart';
import 'package:learnify/screens/auth/register_screen.dart';
import 'package:learnify/screens/auth/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:learnify/services/firestore_seeder.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Ejecutar solo una vez
  await FirestoreSeeder.subirUnidades();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learnify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WelcomeScreen(),
      
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
