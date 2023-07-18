// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';
import 'package:page_transition/page_transition.dart';

import 'langue_niveau.dart';

class LangagesScreen extends StatefulWidget {
  const LangagesScreen({super.key});

  @override
  State<LangagesScreen> createState() => _LangagesScreenState();
}

class _LangagesScreenState extends State<LangagesScreen> {
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
          child: Wrap(
            runSpacing: 10,
            children: [
              langeContainer(context, lang_name: 'Bulu', lang_nom: 15),
              spacerwidth(15),
              langeContainer(context,
                  lang_name: 'Ewondo', lang_nom: 20, colors: Colors.indigo),
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
      ),
    );
  }
}

Widget langeContainer(BuildContext context,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(
              lang_name,
              style: primarystyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(
              'Description de la langue concernée et indications diverses.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: primarystyle.copyWith(fontSize: 12),
            ),
          )
        ],
      ),
    ),
  );
}
