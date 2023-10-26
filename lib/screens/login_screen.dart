import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/screens/sign_up_screen.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';
import 'package:smithackathon/widgets/textwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  CustomFunction func = CustomFunction();
    
  
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
                  func.loginWithEmailAndPassword(context,emailController,passwordController);
              },
              child: const CustomButtonWidget(bgColor: MyColors.blackColor, textMessage: "Login", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: 100)),
        
       InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
        },
        child: const TextWidget(textMessage: "Do You Want To Create an account? Sign up", textColor: MyColors.blackColor, textSize: 20))
        ],
      ),
    );
  }
}