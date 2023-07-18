import 'package:flutter/material.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/views/components/button.dart';

class LangageNiveau extends StatefulWidget {
  final String langue;
  const LangageNiveau({super.key, required this.langue});

  @override
  State<LangageNiveau> createState() => _LangageNiveauState();
}

class _LangageNiveauState extends State<LangageNiveau> {
  int selectedLevel = 0;

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
          widget.langue,
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
            const Spacer(),
            InkWell(
              onTap: () {
                setState(() => selectedLevel = 1);
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedLevel == 1
                          ? Colors.blueAccent
                          : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.book_rounded,
                      size: 50,
                    ),
                    // leading: Image.asset(
                    //   'assets/bgl.png',
                    //   height: 60,
                    //   width: 60,
                    // ),
                    title: Text(
                      'Débutant',
                      style: primarystyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: selectedLevel == 1
                              ? Colors.blueAccent
                              : Colors.grey.shade500),
                    ),
                    subtitle: Text(
                      'Ici vous apprenez les bases de la langue',
                      style: primarystyle,
                    ),
                  ),
                ),
              ),
            ),
            spacerheight(15),
            InkWell(
              onTap: () {
                setState(() => selectedLevel = 2);
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedLevel == 2
                          ? Colors.blueAccent
                          : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.book_rounded,
                      size: 50,
                    ),
                    // leading: Image.asset(
                    //   'assets/bgl.png',
                    //   height: 60,
                    //   width: 60,
                    // ),
                    title: Text(
                      'Intermédiaire',
                      style: primarystyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: selectedLevel == 2
                              ? Colors.blueAccent
                              : Colors.grey.shade500),
                    ),
                    subtitle: Text(
                      'Ici vous apprenez les contoures de la langue',
                      style: primarystyle,
                    ),
                  ),
                ),
              ),
            ),
            spacerheight(15),
            InkWell(
              onTap: () {
                setState(() => selectedLevel = 3);
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedLevel == 3
                          ? Colors.blueAccent
                          : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.book_rounded,
                      size: 50,
                    ),
                    // leading: Image.asset(
                    //   'assets/bgl.png',
                    //   height: 60,
                    //   width: 60,
                    // ),
                    title: Text(
                      'Avancé',
                      style: primarystyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: selectedLevel == 3
                              ? Colors.blueAccent
                              : Colors.grey.shade500),
                    ),
                    subtitle: Text(
                      'Ici vous apprenez les expression particulières de la langue',
                      style: primarystyle,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: bouttonCommun(
                  tittle: 'Commencer',
                  onPressed: () {
                    if (selectedLevel == 0) {
                    } else {}
                  }),
            ),
            spacerheight(50),
          ],
        ),
      ),
    );
  }
}
