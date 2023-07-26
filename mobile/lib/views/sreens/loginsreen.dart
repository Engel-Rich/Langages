// import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mobile/commons/fonctions.dart';
import 'package:mobile/commons/style.dart';
import 'package:mobile/controllers/usercontroller.dart';
import 'package:mobile/views/sreens/homepage.dart';
import 'package:page_transition/page_transition.dart';

import '../../providers/tokenprovider.dart';
import '../components/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSessionsave = false;
  bool showpass = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenu Connectez vous',
                  style: primarystyle.copyWith(
                      fontSize: 25,
                      wordSpacing: 5,
                      fontWeight: FontWeight.bold),
                ),
                spacerheight(20),
                Text(
                  "remplir les champs pour continuer",
                  style: primarystyle.copyWith(color: Colors.grey.shade400),
                ),
                spacerheight(40),
                Text('E-mail',
                    style: primarystyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600)),
                spacerheight(10),
                TextFormField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: primarystyle,
                  validator: (val) {
                    return val == null || val.trim().isEmpty
                        ? 'L\'email est obligatoire '
                        : !EmailValidator.validate(val)
                            ? 'Email incorrecte'
                            : null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'multriix@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                spacerheight(20),
                Text('Mot de passe',
                    style: primarystyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600)),
                spacerheight(10),
                TextFormField(
                  controller: controllerPass,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty || val.length < 6) {
                      return 'entrer un mot de passe correcte';
                    } else {
                      return null;
                    }
                  },
                  style: primarystyle,
                  obscureText: showpass,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'entrer un mot de passe',
                    suffixIcon: IconButton(
                        onPressed: () => setState(() {
                              showpass = !showpass;
                            }),
                        icon: Icon(showpass
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                spacerheight(20),
                CheckboxListTile(
                    value: isSessionsave,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      "Garder ma session",
                      style: primarystyle.copyWith(color: Colors.grey.shade400),
                    ),
                    onChanged: (val) {
                      setState(() {
                        isSessionsave = val!;
                      });
                    }),
                spacerheight(40),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: loading
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loading = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ))
                      : bouttonCommun(
                          tittle: "Se connecter",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              await UserController()
                                  .loginUser(
                                controllerEmail.text,
                                controllerPass.text,
                              )
                                  .then((value) async {
                                if (value['statu'] == true) {
                                  await UserController()
                                      .getUser(context)
                                      .then((value) async {
                                    printer(value);
                                    if (value != null) {
                                      final userProvider = UserProvider.user;
                                      userProvider.setCurrentUser(value);
                                      await userProvider
                                          .saveCurrentUser(value)
                                          .then((val) {
                                        setState(() {
                                          loading = false;
                                        });
                                        Navigator.of(context).push(
                                          PageTransition(
                                            child: const HomePage(),
                                            type:
                                                PageTransitionType.leftToRight,
                                          ),
                                        );
                                      });
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      toasterError(context,
                                          "Impossible de récuperer les données dns le serveur");
                                    }
                                  });
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  toasterError(context, value['message']);
                                }
                              });
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
