// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smithackathon/data.dart';
import 'package:smithackathon/firebase_options.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/screens/home_screen.dart';
import 'package:smithackathon/screens/login_screen.dart';
import 'package:smithackathon/provider/theme/theme_provider.dart';




void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
 CustomFunction func = CustomFunction();
  @override
  Widget build(BuildContext context) {

   
        return ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, child) {
            final provider =Provider.of<ThemeProvider>(context);
            return MaterialApp(
          
            theme: provider.themeMode,
       
          
            debugShowCheckedModeBanner: false,
          home:(FirebaseAuth.instance.currentUser !=null )? HomeScreen( loginedUsername: currentname ?? "back",): const LoginScreen(),
          );
          },
        );
      
  
  
  }
}
