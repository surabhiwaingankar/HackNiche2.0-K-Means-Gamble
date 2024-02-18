import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackniche/screens/chat_screen.dart';
import 'package:hackniche/screens/code_analysis.dart';
import 'package:hackniche/screens/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCKg5WOf-9akQ3Rd3bZz9c25MmvPpbrXX0",
          appId: "1:445477704816:web:98a8f204bf714d930f50b5",
          messagingSenderId: "445477704816",
          projectId: "fir-app-5e336"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Figtree'),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return ChatScreen();
          } else if (snapshot.hasError) {
            return Text('Something went wrong!');
          } else {
            return CodeAnalysisDashboard();
          }
        },
      ),
    );
  }
}
