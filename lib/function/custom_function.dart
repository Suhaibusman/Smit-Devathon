import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/screens/home_screen.dart';
import 'package:smithackathon/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';
import 'package:smithackathon/widgets/textwidget.dart';

class CustomFunction {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController passController = TextEditingController();
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
      userNameController) async {
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String userName = userNameController.text.toString().trim();

    if (emailAddress == "" || password == "" || userName == "") {
      customDialogBox(context, "Sign up Error", "Please Fill All The Values");
    }  else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        await firestore.collection("users").doc(credential.user!.uid).set({"username":userName,"emailAddress" :emailAddress , "Password": password});
        if (credential.user != null) {
          customDialogBox(context, "Sign Up Successfully",
              "The User With This Email: $emailAddress is Registered Successfully");
          emailController.clear();
          passwordController.clear();
          userNameController.clear();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          customDialogBox(context, "Sign Up Error", "The Password is To Weak");
        } else if (e.code == 'email-already-in-use') {
          customDialogBox(context, "Sign Up Error",
              "The account already exists for that email");
        }
      } catch (e) {
        customDialogBox(context, "Error", e.toString());
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
      
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>   HomeScreen(uid: credential.user!.uid),
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
     log(doc.toString());
   }
  }
Future<Widget> fetchWholeData() async {
    //querysnaphot me pora data ayegaa
   
   return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection("users").snapshots(),
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasData && snapshot.data != null) {
          return Expanded(child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Map <String,dynamic> userMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
           DocumentSnapshot doc = snapshot.data!.docs[index];
            return  ListTile(
              title: TextWidget(textMessage: doc["emailAddress"], textColor: MyColors.blackColor, textSize: 15),
              subtitle: TextWidget(textMessage: doc["Password"], textColor: MyColors.blackColor, textSize: 15),
            
            trailing:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){
                     emailController.text=doc["emailAddress"];
                               passController.text=doc["Password"];
                   updateData(context, doc);
                }, icon: const Icon(Icons.edit)),
                 IconButton(onPressed: (){
                deleteData(context, doc);
                 }, icon: const Icon(Icons.delete))
              ],
            ),
            );
          },));
        } else {
          const Center(child: Text("No Data Found"),);
        }
      }
      return const Center(child: CircularProgressIndicator(),);
    },);
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
              textFieldController: passController,
              hintText: "Password",
              isPass: true,
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
               firestore.collection("users").add({"Password": passController.text ,"emailAddress": emailController.text});
            passController.clear();
            emailController.clear();
            Navigator.pop(context);
            },
            child: const Center(child: CustomButtonWidget(bgColor: MyColors.blackColor, textMessage: "Add", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: 100)))
        ],
      ),
    );
  }

updateData(context,doc){
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              textFieldController: passController,
              hintText: "Password",
              isPass: true,
            ),
            CustomTextField(
              textFieldController: emailController,
              hintText: "Email Address",
            ),
          ],
        ),
        actions:  [
           InkWell(
            onTap: ()async{
              //is method me doc id khud set horahi
              await  FirebaseFirestore.instance.collection('users').doc(doc.id).update({
                'name': passController.text,
                'emailAddress': emailController.text,
                // Update other fields as well
              }).then((value) {
                customDialogBox(context, "Value Updated", "Document updated");
                Navigator.pop(context); // Close the dialog
              }).catchError((error) {
                customDialogBox(context, "Error", "Error updating document: $error");
              });
            passController.clear();
            emailController.clear();
            Navigator.pop(context);
            },
            child: const Center(child: CustomButtonWidget(bgColor: MyColors.blackColor, textMessage: "Add", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: 100)))
        ],
      ),
    );
     
}
deleteData(context, doc) async {
  try {
    await firestore.collection('users').doc(doc.id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${doc['name']} deleted Successfully"),
        duration: const Duration(seconds: 2),
      ),
    );
  } catch (e) {
    // Handle any errors that occur during the delete operation
    print(e);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text("An error occurred while deleting the document."),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }
}


doctorSignUpWithEmailAndPassword(context, emailController, passwordController,
      userNameController) async {
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String userName = userNameController.text.toString().trim();

    if (emailAddress == "" || password == "" || userName == "") {
      customDialogBox(context, "Sign up Error", "Please Fill All The Values");
    }  else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        await firestore.collection("doctor").doc(credential.user!.uid).set({"username":userName,"emailAddress" :emailAddress , "Password": password});
        if (credential.user != null) {
          customDialogBox(context, "Sign Up Successfully",
              "The User With This Email: $emailAddress is Registered Successfully");
          emailController.clear();
          passwordController.clear();
          userNameController.clear();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          customDialogBox(context, "Sign Up Error", "The Password is To Weak");
        } else if (e.code == 'email-already-in-use') {
          customDialogBox(context, "Sign Up Error",
              "The account already exists for that email");
        }
      } catch (e) {
        customDialogBox(context, "Error", e.toString());
      }
    }
  }

 


}
