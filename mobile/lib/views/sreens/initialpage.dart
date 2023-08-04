import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/views/components/button.dart';
import 'package:mobile/views/sreens/loginsreen.dart';
import 'package:mobile/views/sreens/register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

List imageList = [
  {"id": 1, "image_path": 'assets/image1.png'},
  {"id": 2, "image_path": 'assets/image2.jpg'},
  {"id": 3, "image_path": 'assets/image3.png'},
  {"id": 4, "image_path": 'assets/image4.png'},
];
final CarouselController carouselController = CarouselController();
int currentindex = 0;

class _InitialScreenState extends State<InitialScreen> {
  // late Material materialButton;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(10),
                    height: 600,
                    color: const Color.fromARGB(255, 234, 233, 233),
                    child: CarouselSlider(
                      items: imageList
                          .map((data) => Image.asset(
                                data['image_path'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 500,
                              ))
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentindex = index;
                            });
                          }),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Container(
                      height: 25,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imageList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: null,
                              child: Container(
                                width: currentindex == entry.key ? 17 : 7,
                                height: 7.0,
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: currentindex == entry.key
                                        ? Colors.blue
                                        : Color.fromARGB(255, 32, 32, 32)),
                              ),
                            );
                          }).toList()),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
                flex: 1,
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
    );
  }
}
