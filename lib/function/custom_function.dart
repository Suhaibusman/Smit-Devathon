import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomFunction {
       
   Future customDialogBox(
         context ,String title,String message) async{
 return  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text(title),
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
  

//   fireBaseSignUp(context ,emailAddress, password,) async {
// try {
  
//   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: emailAddress,
//     password: password,
//   );
// if (credential.user != null) {
//   customDialogBox(context, "Sign Up Successfully", "The User With This $emailAddress is Registered Successfully");
// }

// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//    customDialogBox(context, "Sign Up Error", "The Password is To Weak");
//   } else if (e.code == 'email-already-in-use') {
//        customDialogBox(context, "Sign Up Error", "The account already exists for that email");
   
//   }
// } catch (e) {
//   print(e);

// }


 signUpWithEmailAndPassword(context,emailController,passwordController ,confirmpasswordController) async {
      String emailAddress = emailController.text.toString().trim();
       String password = passwordController.text.toString().trim();
        String confirmPassword = confirmpasswordController.text.toString().trim();

    if (emailAddress =="" || password =="" || confirmPassword =="") {

      customDialogBox(context, "Sign up Error", "Please Fill All The Values");
    } else if (password != confirmPassword ) {

      customDialogBox(context, "Sign up Error", "Passwords do Not Matched");
    }else{
      try {
  
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
if (credential.user != null) {
  customDialogBox(context, "Sign Up Successfully", "The User With This $emailAddress is Registered Successfully");
 emailController.clear();
              passwordController.clear();
              confirmpasswordController.clear();

}

} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
   customDialogBox(context, "Sign Up Error", "The Password is To Weak");
  } else if (e.code == 'email-already-in-use') {
       customDialogBox(context, "Sign Up Error", "The account already exists for that email");
   
  }
} catch (e) {
  print(e);

}
    }

  }
  }

