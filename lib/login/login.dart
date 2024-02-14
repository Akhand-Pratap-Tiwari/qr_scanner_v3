import 'package:flutter/material.dart';
// import 'package:qr_scanner_v3/login/components/db_connect_error_dialog.dart';
import 'package:qr_scanner_v3/login/components/id_pass_error_dialog.dart';
import 'package:qr_scanner_v3/secrets/secrets.dart';

import 'components/functions.dart';
import 'components/screen_load_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var idController = TextEditingController();
  var passController = TextEditingController();
  var collecController = TextEditingController()..text = defaultCollection;
  var dbController = TextEditingController()..text = defaultDb;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Login",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height / 1.5,
            child: Stack(
              children: [
                Container(
                  height: size.height / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(size.width / 2, 88),
                        bottomRight: Radius.elliptical(size.width / 2, 88)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: idController,
                        decoration: const InputDecoration(labelText: "Id"),
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextField(
                        controller: passController,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextField(
                        controller: dbController,
                        decoration:
                            const InputDecoration(labelText: "Database Name"),
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextField(
                        controller: collecController,
                        decoration:
                            const InputDecoration(labelText: "Collection Name"),
                        style: const TextStyle(color: Colors.white),
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          if (isCorrectIdPass(
                                  idController: idController,
                                  passController: passController) ==
                              true) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const CircularLoadDialog(),
                            );

                            String collec = collecController.text.trim();
                            String database = dbController.text.trim();
                            checkDbAndGotoHome(context, collec, database);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const IdPassError(),
                            );
                          }
                        },
                        icon: const Icon(Icons.login_rounded),
                        label: const Text("Login"),
                        backgroundColor: Colors.amber,
                      ),
                    ],
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
