import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/screens/home_screen.dart';
import 'package:smithackathon/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';

class CustomFunction {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future customDialogBox(
    context,
    String title,
    String message,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  signUpWithEmailAndPassword(context, emailController, passwordController,
      confirmpasswordController) async {
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String confirmPassword = confirmpasswordController.text.toString().trim();

    if (emailAddress == "" || password == "" || confirmPassword == "") {
      customDialogBox(context, "Sign up Error", "Please Fill All The Values");
    } else if (password != confirmPassword) {
      customDialogBox(context, "Sign up Error", "Passwords do Not Matched");
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        await firestore.collection("users").doc(credential.user!.uid).set({"emailAddress" :emailAddress , "Password": password});
        if (credential.user != null) {
          customDialogBox(context, "Sign Up Successfully",
              "The User With This Email: $emailAddress is Registered Successfully");
          emailController.clear();
          passwordController.clear();
          confirmpasswordController.clear();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          customDialogBox(context, "Sign Up Error", "The Password is To Weak");
        } else if (e.code == 'email-already-in-use') {
          customDialogBox(context, "Sign Up Error",
              "The account already exists for that email");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  loginWithEmailAndPassword(
      context, emailController, passwordController) async {
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (emailAddress == "" || password == "") {
      customDialogBox(context, "Error", "Please Fill All The Values");
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
        emailController.clear();
        passwordController.clear();
        if (credential.user != null) {
          // customDialogBox(context, "Login Successfully", "Login Succesfull with $emailAddress");

          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        }
      } on FirebaseAuthException catch (e) {
        customDialogBox(context, "Error", e.code.toString());
      }
    }
  }

  signout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  //for fetching whole data
  fecthData() async {
    //querysnaphot me pora data ayegaa
    QuerySnapshot snapshot = await firestore.collection("users").get();
    for (var doc in snapshot.docs) {
      log(doc.data().toString());
    }
  }

  //for fetching specific data
  fecthSpecificData() async {
    //agr specific document pr run krenge to document snapshot me aayega sirf ek user ka data aayega
    DocumentSnapshot snapshot =
        await firestore.collection("users").doc("05NHGEjt1Jklkbd1Yl4h").get();

    log(snapshot.toString());
  }

  addUsertoFireBase(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              textFieldController: nameController,
              hintText: "Name",
            ),
            CustomTextField(
              textFieldController: emailController,
              hintText: "Email Address",
            ),
          ],
        ),
        actions:  [
           InkWell(
            onTap: (){
              //is method me doc id khud set horahi
               firestore.collection("users").add({"name": nameController.text ,"email": emailController.text});
            nameController.clear();
            emailController.clear();
            Navigator.pop(context);
            },
            child: const Center(child: CustomButtonWidget(bgColor: MyColors.blackColor, textMessage: "Add", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: 100)))
        ],
      ),
    );
  }
}
