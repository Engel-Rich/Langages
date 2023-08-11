import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/providers/data_providers.dart';
// import 'package:mobile/views/sreens/activation.dart';
import 'package:mobile/views/sreens/homepage.dart';
import 'package:mobile/views/sreens/initialpage.dart';
// import 'package:mobile/views/sreens/lecture.dart';
// import 'package:mobile/views/sreens/paiementScreen.dart';

void main() async {
  // await Get.put(UserProvider()).logOut();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final token = Get.put(UserProvider());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: token,
      initState: (context) => UserProvider.user.getDatas(),
      builder: (context) {
        return GetMaterialApp(
            title: 'Langue',
            debugShowCheckedModeBanner: false,
            themeMode: UserProvider.user.currentTheme,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            home: UserProvider.user.tokenuser != null
                ? const HomePage()
                : const InitialScreen());
      },
    );
  }
}
