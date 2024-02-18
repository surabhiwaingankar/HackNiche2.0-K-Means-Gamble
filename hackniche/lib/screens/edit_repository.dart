import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackniche/widgets/nav_button.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:http/http.dart' as http;

class EditRepository extends StatefulWidget {
  final String username;
  final String apiKey;
  const EditRepository({super.key,required this.username,required this.apiKey});

  @override
  State<EditRepository> createState() => _EditRepositoryState();
}

class _EditRepositoryState extends State<EditRepository> {
  TextEditingController _nameController = TextEditingController(); 
  TextEditingController _fileController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    createFile() async {
      const url = '${GlobalVariables.url}/upload/file';

  Map<String, dynamic> data = {"username":widget.username,"token":widget.apiKey,"repo_name":_nameController.text,"file_name":base64Encode(utf8.encode(_fileController.text) )};
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

    return Scaffold(
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
              controller: _fileController,
              maxLines: 8,
              
              decoration: InputDecoration(
                
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(6)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.white)),
              filled: true,
              fillColor: Colors.black45,
                hintText: "Enter code",hintStyle: TextStyle(
                color: Color.fromARGB(255, 158, 158, 158),
                
              ),),
            ),
          ),
           SizedBox(height: 50,),
           
           const SizedBox(height: 50,),
           NavButtonInverted(child: 'Create file', height: 70, width: 200, onPressed: (){
            createFile();
           })
          ]),
        ),
      ),
    ) ;
  }
}