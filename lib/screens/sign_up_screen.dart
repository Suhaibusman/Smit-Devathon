import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/constants/images.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/screens/login_screen.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';
import 'package:smithackathon/widgets/textwidget.dart';

// ... (imports and constants)

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
    TextEditingController specialityController = TextEditingController();
  CustomFunction func = CustomFunction();
  bool isSelected = false;
  bool isDocSelected = false;
  bool isPatientSelected = true;
  String? checkValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
         
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
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
                    CustomTextField(textFieldController: userNameController, hintText: "Username",),
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
                    CustomTextField(textFieldController: emailController, hintText: "Enter Email",),
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
                    CustomTextField(textFieldController: passwordController, isPass: true, hintText: "Password",),
      
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: false,
                          groupValue: isSelected,
                          onChanged: (value) {
                            setState(() {
                              isSelected = value!;
                              checkValue = "patient";
                            });
                          },
                        ),
                        const Text("Patient"),
                        Radio(
                          value: true,
                          groupValue: isSelected,
                          onChanged: (value) {
                            setState(() {
                              isSelected = value!;
                              checkValue = "doctor";
                            });
                          },
                        ),
                        const Text("Doctor"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(Myimages.orLine),
      
                    // Conditionally show extra fields when "Patient" is selected
                    Visibility(
                      visible: isSelected == true, // Show when "Patient" is selected
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                               const TextWidget(
                        textMessage: "Enter Speciality:",
                        textColor: MyColors.greyColor,
                        textSize: 15),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(textFieldController: specialityController, hintText: "Enter Speciality",),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                     
         crossAxisAlignment: CrossAxisAlignment.center,
                      children: [ 
                        const Align(
                          alignment: Alignment.topCenter,
                          child: TextWidget(
                          textMessage: "Upload image:",
                          textColor: MyColors.greyColor,
                          textSize: 15),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.image , size: 70,)),

                      ],
                    ),
                    const SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ],
                ),
                 const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    // Depending on checkValue, do different actions
                    if (checkValue == "doctor") {
                      func.customDialogBox(context, "Alert", "Do You Want to Signup as A Doctor");
                      func.doctorSignUpWithEmailAndPassword(context, emailController, passwordController, userNameController);
                    } else {
                      func.signUpWithEmailAndPassword(context, emailController, passwordController, userNameController);
                    }
                  },
                  child: CustomButtonWidget(bgColor: MyColors.purpleColor, textMessage: "Create an Account", textColor: MyColors.whiteColor, textSize: 15, buttonWidth: MediaQuery.of(context).size.width)),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                      textMessage: "Already Have an Acccount? ",
                      textColor: MyColors.textFieldBorderColor,
                      textSize: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const TextWidget(
                        textMessage: " Login",
                        textColor: MyColors.blackColor,
                        textSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
