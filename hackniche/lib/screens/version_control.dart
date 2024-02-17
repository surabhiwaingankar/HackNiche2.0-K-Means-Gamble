import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackniche/global/globalvariables.dart';
import 'package:hackniche/utils/onhover.dart';

class VersionControlScreen extends StatefulWidget {
  const VersionControlScreen({super.key});

  @override
  State<VersionControlScreen> createState() => _VersionControlScreenState();
}

class _VersionControlScreenState extends State<VersionControlScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String username; // Declare username as late

  @override
  void initState() {
    super.initState();
    // Access displayName after Firebase is initialized
    if (_auth.currentUser != null) {
      username = _auth.currentUser!.displayName ?? "No Username"; // Null check
    } else {
      username = "No User"; // Set default value if currentUser is null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.white,
        child: const Drawer(
          surfaceTintColor: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(4, 14, 10, 1),
        title: Text(
          'Hey There , $username',
          style:
              const TextStyle(fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
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
                              GlobalVariables.versionControlTitle,
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
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(26, 26, 26, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OnHover(
                                          builder: (isHovered) {
                                            return PhysicalModel(
                                              elevation: 20,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              color: const Color.fromRGBO(
                                                  0, 133, 29, 1),
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                height: 150,
                                                width: 300,
                                                child: const Center(
                                                  child: Text(
                                                    'Create Repository',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        OnHover(
                                          builder: (isHovered) {
                                            return PhysicalModel(
                                              elevation: 20,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              color: const Color.fromRGBO(
                                                  0, 29, 133, 1),
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                height: 150,
                                                width: 300,
                                                child: const Center(
                                                  child: Text(
                                                    'Edit Repository',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        OnHover(
                                          builder: (isHovered) {
                                            return PhysicalModel(
                                              elevation: 20,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              color: const Color.fromRGBO(
                                                  133, 7, 0, 1),
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                height: 150,
                                                width: 300,
                                                child: const Center(
                                                  child: Text(
                                                    'Delete Repository',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ]),
                                ),
                              ),
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
