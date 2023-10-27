// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/provider/theme/theme_provider.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomFunction func = CustomFunction();
  File? profilePic;

  
  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<ThemeProvider>(context);
    return  Scaffold(

      appBar: AppBar(
      
        title:  const Text("HomeScreen"),
      actions: [
        IconButton(onPressed: (){
          func.signout(context);
          
        }, icon: const Icon(Icons.exit_to_app)),
      Consumer<ThemeProvider>(
  builder: (context, provider, child) => Switch(
    value: provider.themeMode == ThemeData.dark(),
    onChanged: (newValue) {
      provider.toogleTheme();
    },
  ),
)

      ],
      ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            func.fecthData();
          }, child: const Text("Fetch")),
             ElevatedButton(onPressed: (){
              func.addUsertoFireBase(context);
             
          }, child: const Text("Add User")),

           ElevatedButton(onPressed: (){
            provider.toogleTheme();
             
          }, child: const Text("Toogle")),
        FutureBuilder<Widget>(
            future: func.fetchWholeData(),
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
    );
  }
}