import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/controllers/lecon_controller.dart';
import 'package:mobile/models/langues.dart';
import 'package:mobile/models/lecon_model.dart';
import 'package:mobile/models/module.dart';

class LeconLangage extends StatefulWidget {
  final Module module;
  final Langue langue;
  final List<Lecon>? lecons;
  const LeconLangage(
      {super.key, required this.module, required this.langue, this.lecons});

  @override
  State<LeconLangage> createState() => _LeconLangageState();
}

class _LeconLangageState extends State<LeconLangage> {
  List<Lecon>? lecons;
  String? error;
  bool loadinLecon = true;
  late Module module;
  late Langue langue;
  iniLecons() async {
    setState(() {
      loadinLecon = true;
    });
    await LeconController()
        .getAllLecons(context, module.module_id)
        .then((value) {
      loadinLecon = false;
      if (value != null) {
        lecons = value;
      } else {
        error = 'Error de récupération des lecons';
      }
      setState(() {});
    });
  }

  initialiezLecons() async {
    if (widget.lecons != null) {
      lecons = widget.lecons!;
      loadinLecon = false;
      setState(() {});
    } else {
      await iniLecons();
    }
  }

  @override
  void initState() {
    module = widget.module;
    langue = widget.langue;
    initialiezLecons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   color: const Color.fromARGB(31, 168, 166, 166),
      //   child: SingleChildScrollView(
      //     child: Column(children: [
      //       Stack(
      //         children: [
      //           Container(
      //             height: MediaQuery.of(context).size.height * 0.1,
      //             // color: Colors.blueAccent,
      //           ),
      //           Container(
      //             margin:
      //                 const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 IconButton(
      //                   onPressed: () {
      //                     Navigator.pop(
      //                       context,
      //                     );
      //                   },
      //                   icon: const Icon(
      //                     Icons.arrow_back_ios,
      //                     size: 25,
      //                   ),
      //                 ),
      //                 const Text(
      //                   'B U L U',
      //                   style: TextStyle(
      //                       fontSize: 17, fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //       Container(
      //         height: MediaQuery.of(context).size.height,
      //         padding: const EdgeInsets.all(8),
      //         decoration: const BoxDecoration(
      //             color: Colors.white,
      //             borderRadius:
      //                 BorderRadius.vertical(top: Radius.circular(50))),
      //         child: Column(
      //           children: [
      //             leconModelReading(Colors.indigo, 'BL1', 'Leçon 1',
      //                 'Description de la leçon associé', 0.25),
      //             spacerheight(10),
      //             leconModelReading(Colors.red, 'BL1', 'Leçon 1',
      //                 'Description de la leçon associé', 0.95),
      //             spacerheight(10),
      //             leconModelReading(Colors.yellow, 'BL1', 'Leçon 1',
      //                 'Description de la leçon associé', 0.58),
      //             spacerheight(10),
      //             leconModelReading(Colors.amber, 'BL1', 'Leçon 1',
      //                 'Description de la leçon associé', 0.65),
      //             spacerheight(10),
      //             leconModelReading(Colors.deepOrange, 'BL1', 'Leçon 1',
      //                 'Description de la leçon associé', 0.83),
      //             spacerheight(10),
      //             leconModelReading(Colors.orange, 'BL1', 'Leçon 1',
      //                 'Description de la leçon associé', 0.75),
      //             spacerheight(10),
      //           ],
      //         ),
      //       )
      //     ]),
      //   ),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, data) {
          return [
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              title: Row(
                children: [
                  SizedBox(
                    width: taille(context).width * 0.38,
                    child: Text(
                      langue.langue_name,
                      overflow: TextOverflow.ellipsis,
                      style: primarystyle.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    weight: 20,
                    color: Colors.white,
                  )),
              excludeHeaderSemantics: true,
              pinned: true,
              expandedHeight: taille(context).height / 5,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: AssetImage("assets/langs/5332505.png"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  height: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              module.module_name,
                              style: primarystyle.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                loadinLecon
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : lecons == null
                        ? Text(
                            error ?? 'Erreur de connexion internet',
                            style: primarystyle17.copyWith(
                              color: Colors.red,
                            ),
                          )
                        : Column(
                            children: [
                              ...lecons!.map(
                                (lecon) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 8.0),
                                  child: leconModelReading(
                                    context,
                                    lecon,
                                    langue,
                                  ),
                                ),
                              ),
                            ],
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
