import 'package:flutter/material.dart';
import 'package:qr_scanner_v3/login/components/collection_not_found_dialog.dart';
import 'package:qr_scanner_v3/login/components/db_connect_error_dialog.dart';
import 'package:qr_scanner_v3/login/components/id_pass_error_dialog.dart';
import 'package:qr_scanner_v3/secrets/secrets.dart';

import '../database/database.dart';
import '../home.dart';
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

  bool _isCorrectIdPass({required idController, required passController}) {
    var id = idController.text.trim();
    var pass = passController.text.trim();
    if (id == '' || pass == '' || pass != univPass || id != univId) {
      return false;
    }
    return true;
  }

  Future<void> _dbValidator(BuildContext context) async {
    var collec = collecController.text.trim();
    var database = dbController.text.trim();
    await MongoDatabase.connect(collecName: collec, dbName: database).then(
      (db) async {
        await db.open();
        db.getCollectionNames().then((collecList) {
          if (collecList.contains(collec)) {
            MongoDatabase.userCollection = db.collection(collec);
            Navigator.of(context).pop(); //For Loading
            Navigator.of(context).pop(); //For Login Screen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else {
            Navigator.of(context).pop(); //For Loading Screen
            showDialog(
              context: context,
              builder: (context) => CollectionNotFound(),
            );
          }
        });
      },
    ).onError(
      (error, stackTrace) {
        Navigator.of(context).pop(); //For loading
        showDialog(
          context: context,
          builder: (context) => DatabaseConnectError(),
        );
      },
    );
  }

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
                          if (_isCorrectIdPass(
                                  idController: idController,
                                  passController: passController) ==
                              true) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => CircularLoadDialog(),
                            );
                            
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => IdPassError(),
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
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
