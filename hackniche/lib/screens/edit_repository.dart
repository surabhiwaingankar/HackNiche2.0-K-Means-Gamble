import 'package:flutter/material.dart';
import 'package:hackniche/widgets/nav_button.dart';

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

    createFile(){
      
      
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
            
           })
          ]),
        ),
      ),
    ) ;
  }
}