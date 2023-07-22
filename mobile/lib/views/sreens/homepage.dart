// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/providers/tokenprovider.dart';
import 'package:mobile/views/sreens/langages_screen.dart';
import 'package:mobile/views/sreens/langue_niveau.dart';
import 'package:mobile/views/sreens/lecons_langues.dart';
import 'package:mobile/views/sreens/user_screen.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          spacerwidth(30),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UserScreen(),
                      type: PageTransitionType.leftToRight));
            },
            child: const CircleAvatar(
              child: Center(
                child: Icon(Icons.person),
              ),
            ),
          ),
          spacerwidth(30),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacerheight(15),
              Text(
                'Bonjour IVAN'
                //  ${UserProvider.user.currenUser!.userName}'
                ,
                style: primarystyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacerheight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Langues',
                      style:
                          primarystyle.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const LangagesScreen(),
                              type: PageTransitionType.leftToRight));
                    },
                    icon: const Icon(Icons.arrow_forward_ios, size: 20),
                  )
                ],
              ),
              spacerheight(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    langeContainer(context, lang_name: 'Bulu', lang_nom: 15),
                    spacerwidth(15),
                    langeContainer(context,
                        lang_name: 'Ewondo',
                        lang_nom: 20,
                        colors: Colors.indigo),
                    spacerwidth(15),
                    langeContainer(
                      context,
                      lang_name: 'Bamiléké',
                      lang_nom: 10,
                      colors: Colors.orangeAccent,
                    ),
                    spacerwidth(15),
                    langeContainer(
                      context,
                      lang_name: 'Fufuldé',
                      lang_nom: 15,
                      colors: Colors.amber,
                    ),
                    spacerwidth(15),
                  ],
                ),
              ),
              spacerheight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Vos langues',
                      style:
                          primarystyle.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const LeconLangage(),
                              type: PageTransitionType.leftToRight));
                    },
                    child: Text('plus', style: primarystyle),
                  )
                ],
              ),
              spacerheight(10),
              Container(
                height: 100,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      minilangeContainer(context, "B", Colors.green),

                      minilangeContainer(context, "E", Colors.indigo),

                      minilangeContainer(context, "F", Colors.blueAccent),

                      // minilangeContainer(context, "M", Colors.amber),
                      spacerwidth(10),
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Icon(Icons.more_vert, size: 30))),
                      spacerwidth(10),
                    ],
                  ),
                ),
              ),
              spacerheight(20),
              Text(
                "Continuez vos leçons",
                style: primarystyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              spacerheight(15),
              leconModel(Colors.indigo, 'BL1', 'Leçon 1',
                  'Description de la leçon associé'),
              spacerheight(10),
              leconModel(Colors.red, 'BL1', 'Leçon 1',
                  'Description de la leçon associé'),
              spacerheight(10),
              leconModel(Colors.yellow, 'BL1', 'Leçon 1',
                  'Description de la leçon associé'),
              spacerheight(10),
              leconModel(Colors.amber, 'BL1', 'Leçon 1',
                  'Description de la leçon associé'),
              spacerheight(10),
              leconModel(Colors.deepOrange, 'BL1', 'Leçon 1',
                  'Description de la leçon associé'),
              spacerheight(10),
              leconModel(Colors.orange, 'BL1', 'Leçon 1',
                  'Description de la leçon associé'),
              spacerheight(10),
            ],
          ),
        ),
      ),
    );
  }

  Container minilangeContainer(
      BuildContext context, String langName, Color colors) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          langName,
          style: primarystyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget langeContainer(BuildContext contextc,
      {required String lang_name,
      required int lang_nom,
      Color colors = Colors.green}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: LangageNiveau(langue: lang_name),
                type: PageTransitionType.leftToRight));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 200,
        width: MediaQuery.sizeOf(context).width * 0.7,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Leçons',
                style: primarystyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Text('Audios',
                  style: primarystyle.copyWith(
                    color: Colors.grey[200],
                  )),
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    "$lang_nom",
                    style: primarystyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: Text(
                lang_name,
                style: primarystyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: Text(
                'Description de la langue concernée et indications diverses.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: primarystyle.copyWith(color: Colors.white, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
