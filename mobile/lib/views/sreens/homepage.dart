// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/controllers/langue_controller.dart';
import 'package:mobile/models/langues.dart';
import 'package:mobile/providers/data_providers.dart';
import 'package:mobile/views/sreens/langages_screen.dart';
import 'package:mobile/views/sreens/langue_niveau.dart';
import 'package:mobile/views/sreens/lecons_langues.dart';
import 'package:mobile/views/sreens/user_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'lecture.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Langue>? allLangages;
  bool loading = true;
  String? error;

  initLangages() async {
    await LangueController().getAllLangages(context).then((value) {
      loading = false;
      if (value == null) {
        error = "Impossible de récupérer les utilisateurs";
      } else {
        allLangages = value;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    initLangages();
    super.initState();
  }

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
                      child: const UserScreen(),
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
                //
                'Bonjour ${UserProvider.user.currenUser?.userName ?? ""}',
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
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : allLangages == null
                        ? Center(
                            child: Text(error ?? 'Something when wrongs',
                                style: primarystyle17.copyWith(
                                  color: Colors.red,
                                )),
                          )
                        : Row(
                            children: [
                              ...allLangages!
                                  .map(
                                    (lang) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: langeContainer(
                                        context,
                                        langue: lang,
                                        colors: selColor(),
                                      ),
                                    ),
                                  )
                                  .toList(),
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
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         child: const LeconLangage(),
                      //         type: PageTransitionType.leftToRight));
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
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : allLangages == null
                        ? Center(
                            child: Text(error ?? 'Something when wrongs',
                                style: primarystyle17.copyWith(
                                  color: Colors.red,
                                )),
                          )
                        : allLangages!.isEmpty
                            ? Lottie.asset('assets/icon/empty3.json')
                            : Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    minilangeContainer(
                                      context,
                                      (allLangages!..shuffle())[0],
                                      selColor(),
                                    ),

                                    minilangeContainer(
                                      context,
                                      (allLangages!..shuffle())[0],
                                      selColor(),
                                    ),

                                    minilangeContainer(
                                      context,
                                      (allLangages!..shuffle())[0],
                                      selColor(),
                                    ),

                                    // minilangeContainer(context, "M", Colors.amber),
                                    spacerwidth(10),
                                    Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                            child: Icon(Icons.more_vert,
                                                size: 30))),
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
              Center(child: Lottie.asset('assets/icon/empty_b.json')),
              const Center(
                  child: Text("Vous n'avez pas encore commencé de cours"))
            ],
          ),
        ),
      ),
    );
  }

  Widget minilangeContainer(
      BuildContext context, Langue langage, Color colors) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: LangageNiveau(langue: langage),
                type: PageTransitionType.leftToRight));
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            langage.langue_name.trim()[0],
            style: primarystyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget langeContainer(BuildContext contextc,
      {required Langue langue, Color colors = Colors.green}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: LangageNiveau(langue: langue),
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
                    "10",
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
                langue.langue_name,
                style: primarystyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: Text(
                "Région d'origine : ${(langue.langue_origine == null || langue.langue_origine!.trim().isEmpty) ? 'Pas d\'origine précisé' : langue.langue_origine}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: primarystyle.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
