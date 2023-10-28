import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/constants/images.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/screens/login_screen.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';
import 'package:smithackathon/widgets/textwidget.dart';

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                            Column(
                children: [
                    const SizedBox(
                height: 50,
              ),
                  Image.asset(Myimages.loginOrSignUpImage),
                  const SizedBox(
                height: 20,
              ),
              const TextWidget(
                  textMessage: "Registration",
                  textColor: MyColors.blackColor,
                  textSize: 29),
             
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const TextWidget(
                      textMessage: "Enter Username:",
                      textColor: MyColors.greyColor,
                      textSize: 15),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(textFieldController: emailController ,hintText: "Username",),
                   const TextWidget(
                      textMessage: "Enter Email Address:",
                      textColor: MyColors.greyColor,
                      textSize: 15),
                  const SizedBox(
                    height: 5,
                  ),
                   CustomTextField(textFieldController: emailController ,hintText: "Enter Email",),
                   const TextWidget(
                      textMessage: "Enter Password:",
                      textColor: MyColors.greyColor,
                      textSize: 15),
                  const SizedBox(
                    height: 5,
                  ),
                CustomTextField(textFieldController: passwordController ,isPass: true,hintText: "Password",),
                 
                ],
              ),
                
                InkWell(
                  onTap: (){
                      // loginWithEmailAndPassword();
                  func.signUpWithEmailAndPassword(context, emailController, passwordController, confirmpasswordController);
                  // emailController.clear();
                  // passwordController.clear();
                  // confirmpasswordController.clear();
                  },
                  child: const CustomButtonWidget(bgColor: MyColors.blackColor, textMessage: "Sign Up", textColor: MyColors.whiteColor, textSize: 30, buttonWidth: 150))
          
           ,InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(
                          textMessage: "Already Have an Acccount? ",
                          textColor: MyColors.textFieldBorderColor,
                          textSize: 12),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: const TextWidget(
                              textMessage: " Login",
                              textColor: MyColors.blackColor,
                              textSize: 12)),
                    ],
                  ))
            
            ],
          ),
        ),
      ),
    );
  }
}