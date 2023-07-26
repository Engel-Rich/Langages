import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/providers/tokenprovider.dart';
import 'package:mobile/views/sreens/homepage.dart';
import 'package:mobile/views/sreens/initialpage.dart';

void main() {
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
      initState: (context) => UserProvider.user.getToken(),
      builder: (context) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: UserProvider.user.tokenuser == null
              ? const InitialScreen()
              : const HomePage(),
        );
      },
    );
  }
}
