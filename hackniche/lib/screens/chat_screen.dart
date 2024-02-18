import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:hackniche/screens/code_analysis.dart';
import 'package:hackniche/screens/langchain_help.dart';
import 'package:http/http.dart ' as http;

import '../widgets/nav_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser myself = ChatUser(id: '1', firstName: "Srinath");
  ChatUser bot = ChatUser(id: '2', firstName: "Gemini");
  var url = '';
Future<void> getData(ChatMessage m) async {
  const url = '${GlobalVariables.url}/generate/code';
  typing.add(bot);
  messages.insert(0, m);
  setState(() {});

  Map<String, dynamic> data = {"input": m.text};
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

    ChatMessage chatData = ChatMessage(
      user: bot,
      createdAt: DateTime.now(),
      text: "Code : \n\n${decodedData['code']}\n\nExplanation : \n\n${decodedData['explaination']}" ?? '',
    );

    messages.insert(0, chatData);
    typing.remove(bot);
    setState(() {});
  } else {
    print('Failed to get response. Status code: ${response.statusCode}');
  }
}

  List<ChatUser> typing = [];
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(26, 26, 26, 1),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  // Left Container (Sidebar or List of Contacts)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Color.fromRGBO(13, 13, 13, 1),
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(13, 13, 13, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "New Chat",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(13, 13, 13, 1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(""),
                      ]),
                      // You can add your sidebar content here
                    ),
                  ),
                  // Right Container (Main Chat Area)
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      color: Color.fromRGBO(26, 26, 26, 1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                NavButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CodeAnalysisDashboard()));
                                  },
                                  child: 'Code analysis',
                                  height: 42,
                                  width: 250,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                NavButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LanchainHelp()));  
                                  },
                                  child: 'Langchain help',
                                  height: 42,
                                  width: 300,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            color: Color.fromRGBO(26, 26, 26, 1),
                            child: DashChat(
                              typingUsers: typing,
                              currentUser: myself,
                              onSend: (ChatMessage message) {
                                getData(message);
                              },
                              messages: messages,
                              inputOptions: InputOptions(
                                inputTextStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                inputDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //isDense: true,
                                  hintText: "Start conversation",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(26, 26, 26, 1),
                                  contentPadding: const EdgeInsets.only(
                                    left: 18,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      width: 5,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                              ),
                              messageOptions: MessageOptions(
                                // avatarBuilder:(ChatUser user,Function? onAvatarTap,Function? onAvatarLongPress){},
                                currentUserContainerColor:
                                    Color.fromRGBO(52, 103, 81, 1),
                                currentUserTextColor: Colors.white,
                                textColor: Colors.white,
                                containerColor: Color.fromRGBO(68, 68, 68, 1),
                              ),
                            ),
                          ),
                        ],
                      )
                      // You can add your chat area content here
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
