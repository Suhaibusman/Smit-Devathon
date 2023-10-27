import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/provider/theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomFunction func = CustomFunction();


  
  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<ThemeProvider>(context);
    return  Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  const Text("HomeScreen"),
      actions: [
        IconButton(onPressed: (){
          func.signout(context);
          
        }, icon: const Icon(Icons.exit_to_app)),
       Consumer<ThemeProvider>(builder: (context, value, child) => Switch(value: provider.themeMode ==ThemeMode.dark, onChanged: (newValue){
          provider.toogleTheme();
        
        }) ,)
      ],
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