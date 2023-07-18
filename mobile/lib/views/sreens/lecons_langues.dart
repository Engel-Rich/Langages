import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';

class LeconLangage extends StatefulWidget {
  const LeconLangage({super.key});

  @override
  State<LeconLangage> createState() => _LeconLangageState();
}

class _LeconLangageState extends State<LeconLangage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Bulu ",
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
                      image: AssetImage("assets/langs/2399739.png"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
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
                              "Debutant",
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
          child: Column(
            children: [
              leconModelReading(Colors.indigo, 'BL1', 'Leçon 1',
                  'Description de la leçon associé', 0.25),
              spacerheight(10),
              leconModelReading(Colors.red, 'BL1', 'Leçon 1',
                  'Description de la leçon associé', 0.95),
              spacerheight(10),
              leconModelReading(Colors.yellow, 'BL1', 'Leçon 1',
                  'Description de la leçon associé', 0.58),
              spacerheight(10),
              leconModelReading(Colors.amber, 'BL1', 'Leçon 1',
                  'Description de la leçon associé', 0.65),
              spacerheight(10),
              leconModelReading(Colors.deepOrange, 'BL1', 'Leçon 1',
                  'Description de la leçon associé', 0.83),
              spacerheight(10),
              leconModelReading(Colors.orange, 'BL1', 'Leçon 1',
                  'Description de la leçon associé', 0.75),
              spacerheight(10),
            ],
          ),
        ),
      ),
    );
  }
}
