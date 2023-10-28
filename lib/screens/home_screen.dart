// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/constants/images.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/provider/theme/theme_provider.dart';
import 'package:smithackathon/screens/all_doctors.dart';
import 'package:smithackathon/screens/cardiology_screen.dart';
import 'package:smithackathon/screens/dentist.dart';
import 'package:smithackathon/widgets/textwidget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? uid;
  HomeScreen({
    Key? key,
    this.uid,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CustomFunction func = CustomFunction();
  File? profilePic;
  
  var snapshot;

  
  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<ThemeProvider>(context);
    return  SafeArea(
      child: Scaffold(
    
    //       appBar: AppBar(
        
    //         title:  const Text("HomeScreen"),
    //       actions: [
            // IconButton(onPressed: (){
            //   func.signout(context);
            
            // }, icon: const Icon(Icons.exit_to_app)),
    //       Consumer<ThemeProvider>(
    //   builder: (context, provider, child) => Switch(
    //     value: provider.themeMode == ThemeData.dark(),
    //     onChanged: (newValue) {
    //       provider.toogleTheme();
    //     },
    //   ),
    // )
    
    //       ],
    //       ),
        drawer: Drawer(
          child: Column(
            children: [
              InkWell(
                onTap: ()async{
                    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
               print("Image Selected");
    
               if (selectedImage != null) {
                 File convertedFile =File(selectedImage.path);
    
                //  await FirebaseStorage.instance.ref().child("profilepictures").child(const Uuid().v1()).putFile(profilePic!);
                 setState(() {
                   profilePic=convertedFile;
                 });
                  print("Image Selected!");
               } else {
                 print("No Image Selected!");
               }
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: (profilePic != null) ?FileImage(profilePic!):null,
                ),
              )
            ],
          ),
        ),
        body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              decoration:  const BoxDecoration(
                  
                color: MyColors.purpleColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:30 ,right: 30 ,top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         InkWell(
                          onTap: (){
                            func.signout(context);
                          },
                          child: Image.asset(Myimages.drawerIcon)),
                          InkWell(
                  onTap: ()async{
                      XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                 print("Image Selected");
                  
                 if (selectedImage != null) {
                   File convertedFile =File(selectedImage.path);
                  
                  //  await FirebaseStorage.instance.ref().child("profilepictures").child(const Uuid().v1()).putFile(profilePic!);
                   setState(() {
                     profilePic=convertedFile;
                   });
                    print("Image Selected!");
                 } else {
                   print("No Image Selected!");
                 }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    backgroundImage: (profilePic != null) ?FileImage(profilePic!):null,
                  ),
                )
                      ],
                    ),

                    const TextWidget(textMessage: "Welcome Back", textColor: MyColors.whiteColor, textSize: 15),
                      SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: const TextWidget(textMessage: "Lets find your Top Doctor", textColor: MyColors.whiteColor, textSize: 36)),
                 const SizedBox(
                height: 20,
              ),
                  const TextWidget(textMessage: "Doctor's Inn", textColor: MyColors.whiteColor, textSize: 36)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(textMessage: "Categories", textColor: MyColors.blackColor, textSize: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllDoctors(),));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              height: 60,
                               width: 60,
                              child: Image.asset(Myimages.allIcon),
                            ),
                          ),
                          const Text("all", style: TextStyle(color: MyColors.greyColor),)
                        ],
                      ),
                        Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CardiologyScreen(),));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              height: 60,
                               width: 60,
                              child: Image.asset(Myimages.cardiologyIcon),
                            ),
                          ),
                          const Text("Cardiology", style: TextStyle(color: MyColors.greyColor),)
                        ],
                      ),
                        Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DentistScreen(),));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              height: 60,
                               width: 60,
                              child: Image.asset(Myimages.medicineIcon),
                            ),
                          ),
                          const Text("Dentist", style: TextStyle(color: MyColors.greyColor),)
                        ],
                      ),
                        Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            height: 60,
                             width: 60,
                            child: Image.asset(Myimages.generalIcon),
                          ),
                          const Text("General", style: TextStyle(color: MyColors.greyColor),)
                        ],
                      )
                    ],
                  )
                
                ],
              ),
            ),
            
          //   ElevatedButton(onPressed: (){
          //     func.fecthData();
          //   }, child: const Text("Fetch")),
          //      ElevatedButton(onPressed: (){
          //       func.addUsertoFireBase(context);
               
          //   }, child: const Text("Add User")),
    
          //    ElevatedButton(onPressed: (){
          //     provider.toogleTheme();
               
          //   }, child: const Text("Toogle")),
          FutureBuilder<Widget>(
              future: func.fetchWholeData(setState, profilePic,),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return const Center(child: Text("No Data Found"));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}