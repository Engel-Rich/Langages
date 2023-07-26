import 'package:flutter/material.dart';
import 'package:mobile/commons/fonctions.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/models/langues.dart';
import 'package:mobile/models/module.dart';
import 'package:mobile/views/components/button.dart';
import 'package:mobile/views/sreens/lecons_langues.dart';
import 'package:page_transition/page_transition.dart';

import '../../controllers/module_controller.dart';

class LangageNiveau extends StatefulWidget {
  final Langue langue;
  const LangageNiveau({super.key, required this.langue});

  @override
  State<LangageNiveau> createState() => _LangageNiveauState();
}

class _LangageNiveauState extends State<LangageNiveau> {
  int selectedLevel = 0;

  String? selectedlevel;
  late Langue langue;
  String? error;

  @override
  void initState() {
    langue = widget.langue;
    loadModuleList();
    super.initState();
  }

  loadModuleList() async {
    await ModuleController().getAllModules(context, langue).then((value) {
      loadin = false;
      if (value != null) {
        modules = value;
      }
      setState(() {});
    });
  }

  int? seletedmodule;
  List<Module>? modules;
  Module? moduleselectted;
  // List<Lecon> lecons = [];
  bool loadin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 25),
        ),
        title: Text(
          widget.langue.langue_name,
          style: primarystyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choisissez le niveau d'apprentissage",
              style: primarystyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            spacerheight(30),
            loadin
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : modules == null
                    ? Center(
                        child: Text(error ?? 'Something when wrongs',
                            style: primarystyle17.copyWith(
                              color: Colors.red,
                            )),
                      )
                    : Column(
                        children: [
                          ...modules!
                              .map((module) => Column(
                                    children: [
                                      moduleWidget(module),
                                      spacerheight(15),
                                    ],
                                  ))
                              .toList()
                        ],
                      ),
            spacerheight(30),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: bouttonCommun(
                  tittle: 'Commencer',
                  onPressed: () {
                    if (moduleselectted == null) {
                      toasterError(context,
                          "Veille selectionner un module d'apprentissage");
                    } else {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: LeconLangage(
                              langue: langue,
                              module: moduleselectted!,
                            ),
                            type: PageTransitionType.leftToRight),
                      );
                    }
                  }),
            ),
            spacerheight(50),
          ],
        ),
      ),
    );
  }

  InkWell moduleWidget(Module module) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedLevel = module.module_id!;
          moduleselectted = module;
        });
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color: selectedLevel == module.module_id
                  ? Colors.orange
                  : Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: ListTile(
            leading: Image.asset(
              'assets/bgl.png',
              height: 60,
              width: 60,
            ),
            title: Text(
              module.module_name,
              style: primarystyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: selectedLevel == module.module_id
                      ? Colors.blueAccent
                      : Colors.grey.shade500),
            ),
            subtitle: Text(
              '${module.module_price} FCFA',
              style: primarystyle17.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
