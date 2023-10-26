import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  CustomFunction func = CustomFunction();
    
  
    loginWithEmailAndPassword(){
      String emailAddress = emailController.text.toString().trim();
       String password = passwordController.text.toString().trim();

    if (emailAddress =="" || password =="") {

      func.customDialogBox(context, "title", "message");
    } else {
      
    }
  }
  @override


  
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(textFieldController: emailController ,hintText: "Email Address",),
            CustomTextField(textFieldController: passwordController ,isPass: true,hintText: "Password",),
            InkWell(
              onTap: (){
                  loginWithEmailAndPassword();
              },
              child: const CustomButtonWidget(bgColor: MyColors.blackColor, textMessage: "Login", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: 100))
        ],
      ),
    );
  }
}