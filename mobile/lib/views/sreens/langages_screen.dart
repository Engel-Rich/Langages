// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/controllers/langue_controller.dart';
import 'package:mobile/models/langues.dart';
import 'package:page_transition/page_transition.dart';

import 'langue_niveau.dart';

class LangagesScreen extends StatefulWidget {
  const LangagesScreen({super.key});

  @override
  State<LangagesScreen> createState() => _LangagesScreenState();
}

class _LangagesScreenState extends State<LangagesScreen> {
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
        leadingWidth: 70,
        title: Text(
          "Langages",
          style: primarystyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
                      ? Center(child: Lottie.asset('assets/icon/empty3.json'))
                      : Center(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ...allLangages!
                                  .map(
                                    (lang) => langeContainer(
                                      context,
                                      langue: lang,
                                      colors: selColor(),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
        ),
      ),
    );
  }
}

Widget langeContainer(BuildContext context,
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
      padding: const EdgeInsets.all(5),
      height: 200,
      width: MediaQuery.sizeOf(context).width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colors, width: 2.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(3),
            horizontalTitleGap: 8,
            title: Text(
              'Leçons',
              style: primarystyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Audios',
              style: primarystyle.copyWith(
                color: Colors.grey[500],
              ),
            ),
            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: colors),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(
              langue.langue_name,
              style: primarystyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(
              "Région d'origine : ${(langue.langue_origine == null || langue.langue_origine!.trim().isEmpty) ? 'Pas d\'origine précisé' : langue.langue_origine}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: primarystyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    ),
  );
}
