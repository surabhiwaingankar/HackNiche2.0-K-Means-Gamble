import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:hackniche/utils/gradient_button.dart';
import 'package:hackniche/utils/onhover.dart';
import 'package:hackniche/widgets/nav_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: ((context, constraints) {
        return Container(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/CosmicHero.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Title',
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                      Row(
                        children: [
                          NavButton(
                            child: 'Home',
                            height: 42,
                            width: 80,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          NavButton(
                            child: 'Generate',
                            height: 42,
                            width: 120,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          NavButton(
                            child: 'Version Control',
                            height: 42,
                            width: 200,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          NavButton(
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
                        child: const Column(
                          children: [
                            Text(
                              GlobalVariables.tagline,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
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
                            SizedBox(
                              height: 60,
                            ),
                            NavButtonInverted(
                                child: 'Get Started', height: 50, width: 200)
                          ],
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        );
      })),
    );
  }
}
