import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/providers/data_providers.dart';
import 'package:mobile/views/sreens/initialpage.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:page_transition/page_transition.dart';

import '../../commons/style.dart';
import '../components/button.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

bool isSwitched = false;
bool istrue = false;

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 19),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                ),
              ),
              const Text(
                'Profile',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  maxRadius: 60,
                ),
                Positioned(
                    left: 90,
                    bottom: 10,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 170, 210, 242),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "${UserProvider.user.currenUser!.userEmail} ",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Mes Langues',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          spacerheight(10),
          Container(
            height: 100,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: !Get.isDarkMode
                    ? Colors.grey.shade200
                    : const Color.fromARGB(255, 39, 36, 36),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                minilangeContainer(context, "B", Colors.green),
                minilangeContainer(context, "E", Colors.indigo),
                minilangeContainer(context, "F", Colors.blueAccent),
                spacerwidth(10),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(Icons.more_vert, size: 30),
                  ),
                ),
                spacerwidth(10),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Paramètres Application',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          spacerheight(10),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: !Get.isDarkMode
                      ? const Color.fromARGB(255, 243, 241, 241)
                      : const Color.fromARGB(255, 39, 36, 36),
                ),
                child: ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Mode Sombre'),
                  subtitle: const Text('Activer'),
                  trailing: Switch(
                    value: isSwitched,
                    onChanged: (value) async {
                      isSwitched =
                          UserProvider.user.currentTheme == ThemeMode.dark;
                      UserProvider.user.setThemode(
                          isSwitched ? ThemeMode.light : ThemeMode.dark);
                      await UserProvider.user
                          .saveTheme(isSwitched ? theme[1]! : theme[-1]!);
                      setState(() {
                        isSwitched =
                            UserProvider.user.currentTheme == ThemeMode.dark;
                      });
                    },
                    // activeTrackColor: Colors.lightGreenAccent,
                    // activeColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              spacerheight(10),
              listProfil2(
                !Get.isDarkMode
                    ? const Color.fromARGB(255, 243, 241, 241)
                    : const Color.fromARGB(255, 39, 36, 36),
                'Langues',
                'changer de langue',
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          spacerheight(20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: bouttonCommun(
              tittle: "Se Déconnecté",
              onPressed: () async {
                await UserProvider().logOut().then((val) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: InitialScreen(),
                          type: PageTransitionType.leftToRight),
                      (route) => false);
                });
              },
            ),
          ),
        ]),
      ),
    ));
  }
}

Widget listProfil(Color col, String title, String subtitle, funct) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(8), color: col),
    child: ListTile(
      leading: const Icon(Icons.book),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: isSwitched,
        onChanged: funct,
        activeTrackColor: Colors.lightGreenAccent,
        activeColor: Colors.green,
      ),
    ),
  );
}

Widget listProfil2(
  Color col,
  String title,
  String subtitle,
) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(8), color: col),
    child: ListTile(
      leading: const Icon(Icons.drag_handle),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.translate_outlined),
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: 'F R A N C A I S',
              child: Text('F R A N C A I S'),
            ),
            const PopupMenuItem(
              value: 'E N G L I S H',
              child: Text('E N G L I S H'),
            )
          ];
        },
        onSelected: null,
      ),
    ),
  );
}

funct(bool istrue) {
  if (istrue != istrue) {
    return true;
  } else
    false;
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
