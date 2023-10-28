import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/constants/images.dart';
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
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                const SizedBox(height: 50,),
              Image.asset(Myimages.loginOrSignUpImage),
              const SizedBox(height: 20,),
              
              const TextWidget(textMessage: "Login", textColor: MyColors.blackColor, textSize: 29),
              const SizedBox(height: 20,),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const TextWidget(textMessage: "Username:", textColor: MyColors.greyColor, textSize: 15),
                   CustomTextField(textFieldController: emailController ,hintText: "Email Address",),
                 ],
               ),
             
              const SizedBox(height: 20,),
                CustomTextField(textFieldController: passwordController ,isPass: true,hintText: "Password",),
              const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                      func.loginWithEmailAndPassword(context,emailController,passwordController);
                  },
                  child:  CustomButtonWidget(bgColor: MyColors.purpleColor, textMessage: "Login", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: MediaQuery.of(context).size.width)),
            
           InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
            },
            child: const TextWidget(textMessage: "Do You Want To Create an account? Sign up", textColor: MyColors.textFieldBorderColor, textSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}