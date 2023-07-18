import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/views/components/button.dart';
import 'package:mobile/views/sreens/loginsreen.dart';
import 'package:mobile/views/sreens/register.dart';
import 'package:page_transition/page_transition.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late Material materialButton;
  late int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Flexible(flex: 7, child: Container()),
              Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: bouttonCommun(
                              tittle: "S'inscrire",
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                  child: const RegisterPage(),
                                  type: PageTransitionType.rightToLeft,
                                ));
                              },
                            ),
                          ),
                          spacerheight(30),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: bouttonCommun(
                              tittle: "Se connecter",
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                  child: const LoginScreen(),
                                  type: PageTransitionType.rightToLeft,
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
