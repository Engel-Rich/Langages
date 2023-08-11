import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mobile/models/users.dart';
import 'package:mobile/views/sreens/homepage.dart';
import 'package:page_transition/page_transition.dart';

import '../../commons/fonctions.dart';
import '../../commons/style.dart';
import '../../controllers/usercontroller.dart';
import '../../providers/data_providers.dart';
import '../components/button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerVille = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool conditionsread = false;
  bool showpass = false;
  bool loading = false;

  PhoneNumber? numero;

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
                Text('Nom d\'utilisateur',
                    style: primarystyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600)),
                spacerheight(10),
                TextFormField(
                  controller: controllerName,
                  style: primarystyle,
                  validator: (val) {
                    return val == null || val.trim().isEmpty
                        ? 'Le nom est obligatoire '
                        : null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'entrer le nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                spacerheight(20),
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
                Text('Telephone',
                    style: primarystyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600)),
                spacerheight(10),
                IntlPhoneField(
                  initialCountryCode: "CM",
                  onChanged: (val) {
                    numero = val;
                  },
                  style: primarystyle,
                  validator: (val) {
                    return val == null
                        ? 'Le numéro de téléphone est obligatoire'
                        : !val.isValidNumber()
                            ? 'Entrer un numéro de téléphone correcte'
                            : null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'Entrer votre numéro de téléphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                spacerheight(20),
                Text('Ville de résidence',
                    style: primarystyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600)),
                spacerheight(10),
                TextFormField(
                  controller: controllerVille,
                  style: primarystyle,
                  validator: (val) {
                    return val == null ||
                            val.trim().isEmpty ||
                            val.trim().length < 3
                        ? 'La ville est obligatoire '
                        : null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'entrer votre ville de résidence',
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
                    value: conditionsread,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      "J'accepte la politique d'utilisation",
                      style: primarystyle.copyWith(color: Colors.grey.shade400),
                    ),
                    onChanged: (val) {
                      setState(() {
                        conditionsread = val!;
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
                            if (formKey.currentState!.validate() &&
                                conditionsread) {
                              setState(() {
                                loading = true;
                              });
                              final UserApp userApp = UserApp(
                                userEmail: controllerEmail.text,
                                userId: 0,
                                userName: controllerName.text,
                                ville: controllerVille.text,
                                password: controllerPass.text,
                                phone: numero!.completeNumber,
                              );
                              await UserController()
                                  .registerUser(userApp)
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
                                          .then((value) {
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
