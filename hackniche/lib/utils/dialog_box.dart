import 'package:flutter/material.dart';
import 'package:hackniche/screens/create_repository.dart';
import 'package:hackniche/widgets/nav_button.dart';

class DialogBox{
  static String? username;
  static String? apiKey;
  static showdialogbox(BuildContext context){
    TextEditingController usernameController = TextEditingController();
    TextEditingController apiKeyController = TextEditingController();
    return showDialog(context: context, builder: (context){
      return  SizedBox(
        height: 700,
        width: 300,
        child: SimpleDialog(
          backgroundColor:  const Color.fromRGBO(26, 26, 26, 1),
          contentPadding: const EdgeInsets.all(12),
          title: const Text("Enter GitHub details",style: TextStyle(color: Colors.white),),
          children: [
            SimpleDialogOption(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: usernameController,
                decoration: const InputDecoration(hintText: 'Enter your GitHub Username', hintStyle:TextStyle(color:Color.fromARGB(255, 158, 158, 158)), ) ),
            ),
            SimpleDialogOption(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: apiKeyController,
                decoration: const InputDecoration(hintText: 'Enter your GitHub Apikey', hintStyle:TextStyle(color:Color.fromARGB(255, 158, 158, 158)), ),),
            ),
            SimpleDialogOption(child: NavButton(child: 'Submit', height: 30, width: 60, onPressed:(){
              if(usernameController.text!=""&&apiKeyController.text!=""){
               username = usernameController.text;
               apiKey = apiKeyController.text;
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields")));
              }

            }),)
          ],
        
        ),
      );
    });
  }
}