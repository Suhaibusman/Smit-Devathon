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
      TextEditingController userNameController = TextEditingController();
  CustomFunction func = CustomFunction();
  bool isSelected= false;
    bool isDocSelected= false;
        bool isPatientSelected= true;
      String? checkValue;

      
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  CustomTextField(textFieldController: userNameController ,hintText: "Username",),
                   const SizedBox(
                height: 20,
              ),
                   const TextWidget(
                      textMessage: "Enter Email Address:",
                      textColor: MyColors.greyColor,
                      textSize: 15),
                  const SizedBox(
                    height: 5,
                  ),
                   CustomTextField(textFieldController: emailController ,hintText: "Enter Email",),
                   const SizedBox(
                height: 20,
              ),
                   const TextWidget(
                      textMessage: "Enter Password:",
                      textColor: MyColors.greyColor,
                      textSize: 15),
                  const SizedBox(
                    height: 5,
                  ),
                CustomTextField(textFieldController: passwordController ,isPass: true,hintText: "Password",),
                 
          
     Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Radio(
      value: false, // Assign true to one radio button and false to the other
      groupValue: isSelected,
      onChanged: (value) {
        setState(() {
          isSelected = value!;
          print("No dOCTOR value $value");
          checkValue ="patient";
          // print(value);
        });
      },
    ),
    const Text("Patient"),
    Radio(
      value: true, // Assign the opposite value for the other radio button
      groupValue: isSelected,
      onChanged: (value) {
        setState(() {
          isSelected = value!;
           checkValue ="doctor";
          print("No Patient value $value");
        });
      },
    ),
    const Text("Doctor"),
  ],
),       const SizedBox(
                height: 20,
              ),
                   Image.asset(Myimages.orLine),
                 
                ],
              ),
                
                InkWell(
                  onTap: (){
                      // loginWithEmailAndPassword();
                if (checkValue =="doctor") {
                func.customDialogBox(context, "Alert", "Do You Want to Signup as A Doctor");
                func.doctorSignUpWithEmailAndPassword(context, emailController, passwordController, userNameController);
                } else {
                  func.signUpWithEmailAndPassword(context, emailController, passwordController, userNameController);
                }
                
                  
              
                  },
                  child:  CustomButtonWidget(bgColor: MyColors.purpleColor, textMessage: "Create an Account", textColor: MyColors.whiteColor, textSize: 15, buttonWidth: MediaQuery.of(context).size.width))
          
           ,Row(
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
           )
            
            ],
          ),
        ),
      ),
    );
  }
}