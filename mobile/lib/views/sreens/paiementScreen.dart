import 'package:flutter/material.dart';
import 'package:mobile/views/components/button.dart';

class PaiementScreen extends StatefulWidget {
  const PaiementScreen({super.key});

  @override
  State<PaiementScreen> createState() => _PaiementScreenState();
}

class _PaiementScreenState extends State<PaiementScreen> {
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      )),
                  Text(
                    "Paiement",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              color: const Color.fromARGB(131, 190, 219, 243),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
            ),

            Container(), // Required some widget in between to float AppBar

            Positioned(
              // To take AppBar Size only
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: const Icon(
                  Icons.menu,
                  color: Colors.amber,
                ),
                primary: false,
              ),
            )
          ],
        ),
      );
  TextEditingController controllerNumero = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiements'),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
      ),
      body: Column(
        children: [
          Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Information sur la commande',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              Container(
                child: Material(
                  elevation: 3,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black12,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nom",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "User@gmail.com",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "User@gmail.com",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Niveau",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Debutant",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Langue",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Fufulbé",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Numero de paiement",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Numero',
                                  fillColor:
                                      const Color.fromARGB(31, 52, 74, 219),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          //bouton
          button2('Commander', () {})
        ],
      ),
    );
  }
}
