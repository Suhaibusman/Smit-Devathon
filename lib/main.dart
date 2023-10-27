import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/firebase_options.dart';
import 'package:smithackathon/screens/home_screen.dart';
import 'package:smithackathon/screens/login_screen.dart';


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
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
    home: (FirebaseAuth.instance.currentUser != null)
    ? FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // Handle the error
              return Text("Error: ${snapshot.error}");
            }

            if (snapshot.hasData) {
              // Get the email address from the user's document
              String userEmail = snapshot.data!["email"] ?? "No Email Found";

              // Pass the email address to the HomeScreen
              return HomeScreen(emailAddress: userEmail);
            }
          }

          // Show a loading indicator while fetching the data
          return CircularProgressIndicator();
        },
      )
    : const LoginScreen(),

      // home:(FirebaseAuth.instance.currentUser !=null )?const HomeScreen(): const LoginScreen(),
    );
  }
}
