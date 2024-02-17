import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser myself = ChatUser(id: '1', firstName: "Srinath");
  ChatUser bot = ChatUser(id: '2', firstName: "Gemini");
  getData(ChatMessage m) async {
    typing.add(bot);
    messages.insert(0, m);
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    ChatMessage data = ChatMessage(
        user: bot,
        createdAt: DateTime.now(),
        text: 'I am better than other chatbots');
    messages.insert(0, data);
    typing.remove(bot);
    setState(() {});
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
                // You can add your sidebar content here
              ),
            ),
            // Right Container (Main Chat Area)
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Color.fromRGBO(26, 26, 26, 1),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 1,
                      color: Color.fromRGBO(26, 26, 26, 1),
                      child: DashChat(
                        typingUsers: typing,
                        currentUser: myself,
                        onSend: (ChatMessage message) {
                          getData(message);
                        },
                        messages: messages,
                        inputOptions: InputOptions(),
                        messageOptions: MessageOptions(),
                      ),
                    ),
                  ],
                )
                // You can add your chat area content here
                ),
          ],
        ),
      ),
    );
  }
}
