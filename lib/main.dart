import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/firebase_options.dart';
import 'package:smithackathon/screens/login_screen.dart';
import 'package:smithackathon/screens/sign_up_screen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     debugShowCheckedModeBanner: false,
    
      home:SignUpScreen(),
    );
  }
}
