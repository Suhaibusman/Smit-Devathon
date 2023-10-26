import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
    TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
      TextEditingController confirmpasswordController = TextEditingController();
  CustomFunction func = CustomFunction();
    

      
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(textFieldController: emailController ,hintText: "Email Address",),
            CustomTextField(textFieldController: passwordController ,isPass: true,hintText: "Password",),
              CustomTextField(textFieldController: confirmpasswordController ,isPass: true,hintText: "Confirm Password",),
            InkWell(
              onTap: (){
                  // loginWithEmailAndPassword();
              func.signUpWithEmailAndPassword(context, emailController, passwordController, confirmpasswordController);
              // emailController.clear();
              // passwordController.clear();
              // confirmpasswordController.clear();
              },
              child: const CustomButtonWidget(bgColor: MyColors.blackColor, textMessage: "Sign Up", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: 150))
        ],
      ),
    );
  }
}