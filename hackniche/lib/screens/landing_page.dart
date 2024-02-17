import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:hackniche/screens/chat_screen.dart';
import 'package:hackniche/screens/version_control.dart';
import 'package:hackniche/services/auth_services.dart';
import 'package:hackniche/utils/dialog_box.dart';
import 'package:hackniche/utils/gradient_button.dart';
import 'package:hackniche/utils/onhover.dart';
import 'package:hackniche/widgets/nav_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthServices _authServices = AuthServices();
  UserCredential? userCredential;
  void signInWithGithub(context) async {
    try {
      // Sign in with GitHub
      userCredential = await _authServices.signInWithGitHub();

      // Navigate to the next page upon successful login
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const ChatScreen()), 
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
          print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/CosmicHero.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Title',
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                      Row(
                        children: [
                          NavButton(
                            onPressed: () {},
                            child: 'Home',
                            height: 42,
                            width: 80,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          NavButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ChatScreen()));
                            },
                            child: 'Generate',
                            height: 42,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          NavButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const VersionControlScreen()));
                              DialogBox.showdialogbox(context);
                              
                            },
                            child: 'Version Control',
                            height: 42,
                            width: 200,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          NavButton(
                            onPressed: () {},
                            child: 'About',
                            height: 42,
                            width: 100,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  child: Center(
                    child: Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Column(
                          children: [
                            const Text(
                              GlobalVariables.tagline,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                GlobalVariables.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            GestureDetector(
                              onTap: () async {
                                try {
                                  // signInWithGithub();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              },
                              child: NavButtonInverted(
                                  onPressed: () {
                                    signInWithGithub(context);
                                  },
                                  child: 'Get Started',
                                  height: 50,
                                  width: 200),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
