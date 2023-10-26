import 'package:flutter/material.dart';
import 'package:smithackathon/function/custom_function.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomFunction func = CustomFunction();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
      actions: [
        IconButton(onPressed: (){
          func.signout(context);
          
        }, icon: const Icon(Icons.exit_to_app))
      ],
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            func.fecthData();
          }, child: Text("Fetch"))
        ],
      ),
    );
  }
}