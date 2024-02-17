import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:hackniche/widgets/nav_button.dart';
import'package:http/http.dart'as http;

class CreateRepositoryScreen extends StatefulWidget {
  final String username;
  final String apiKey;
  const CreateRepositoryScreen({super.key, required this.username, required this.apiKey});

  @override
  State<CreateRepositoryScreen> createState() => _CreateRepositoryScreenState();
}

class _CreateRepositoryScreenState extends State<CreateRepositoryScreen> {
  String? _selectedoption;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  void createRepo() async{
    bool isPrivate = true;
    if(_selectedoption=="Public"){
      isPrivate = false;
    }
   const url = '${GlobalVariables.url}/create/repo';

  Map<String, dynamic> data = {"name":_nameController.text,"token":widget.apiKey,"description":_descController.text,"private":isPrivate};
  var encodedData = jsonEncode(data);

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: encodedData,
  );

  print('Status code: ${response.statusCode}');

  if (response.statusCode == 200) {
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
              controller: _nameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(6)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.white)),
              filled: true,
              fillColor: Colors.black45,
              hintText: "Enter repository name",hintStyle: TextStyle(
              color: Color.fromARGB(255, 158, 158, 158),
              
            ),),
          ),
          SizedBox(height: 50,),
          SizedBox(
            height: 60,
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: _descController,
              maxLines: 8,
              
              decoration: InputDecoration(
                
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(6)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.white)),
              filled: true,
              fillColor: Colors.black45,
                hintText: "Enter repository description",hintStyle: TextStyle(
                color: Color.fromARGB(255, 158, 158, 158),
                
              ),),
            ),
          ),
           SizedBox(height: 50,),
           DropdownButton(
            
            focusColor:  Colors.black45
            ,
            borderRadius:  BorderRadius.circular(6),
            padding: EdgeInsets.all(15),
            style: TextStyle(color: Colors.white),
            value: _selectedoption,
            items: const [DropdownMenuItem(child: Text('Private'),value: "Private",),DropdownMenuItem(child: Text('Public'),value: 'Public',)], onChanged: (newValue){
            setState(() {
              _selectedoption = newValue;
            });
           }),
           const SizedBox(height: 50,),
           NavButtonInverted(child: 'Create repository', height: 70, width: 200, onPressed: (){
            createRepo();
           })
          ]),
        ),
      ),
    );
  }
}