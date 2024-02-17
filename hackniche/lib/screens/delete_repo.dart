import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:hackniche/widgets/nav_button.dart';
import'package:http/http.dart'as http;

class DeleteRepositoryScreen extends StatefulWidget {
  final String username;
  final String apiKey;
  const DeleteRepositoryScreen({super.key, required this.username, required this.apiKey});

  @override
  State<DeleteRepositoryScreen> createState() => _CreateRepositoryScreenState();
}

class _DeleteRepositoryScreenState extends State<DeleteRepositoryScreen> {
  String? _selectedoption;

  TextEditingController _repoNameController = TextEditingController();

  void deleteRepo() async{
   const url = '${GlobalVariables.url}/delete/repo';

  Map<String, dynamic> data = {"username":widget.username,"repo_name": _repoNameController.text, "token":widget.apiKey};
  var encodedData = jsonEncode(data);

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: encodedData,
  );

  print('Status code: ${response.statusCode}');

  if (response.statusCode == 200){
    var decodedData = jsonDecode(response.body);
    print('Response data: $decodedData');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(decodedData['message'],),),);


  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to get response. Status code: ${response.statusCode}',),),);

    print('Failed to get response. Status code: ${response.statusCode}');
  }
  }


  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromRGBO(26, 26, 26, 1),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [TextField(
              style: TextStyle(color: Colors.white),
              controller: _repoNameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(6)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.white)),
              filled: true,
              fillColor: Colors.black45,
              hintText: "Enter repository name",hintStyle: TextStyle(
              color: Color.fromARGB(255, 158, 158, 158),
              
            ),),
          ),
         
           const SizedBox(height: 50,),
           NavButtonInverted(child: 'Delete repository', height: 70, width: 200, onPressed: (){
            deleteRepo();
           })
          ]),
        ),
      ),
    );
  }
}