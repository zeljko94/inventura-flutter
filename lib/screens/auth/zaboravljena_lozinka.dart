import 'package:flutter/material.dart';
import 'package:inventura_app/screens/auth/promjena_lozinke.dart';
import 'package:inventura_app/services/auth_service.dart';

import '../../common/color_palette.dart';

class ZaboravljenaLozinka extends StatefulWidget {
  const ZaboravljenaLozinka({Key? key}) : super(key: key);

  @override
  _ZaboravljenaLozinkaState createState() => _ZaboravljenaLozinkaState();
}

class _ZaboravljenaLozinkaState extends State<ZaboravljenaLozinka> {
  final email = TextEditingController();
  final kod = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isConfirmation = false;
  late AuthService _authService;

  @override
  void initState() {
    // Client _client = Client();
    // _authService = AuthService(_client.init());
    _authService = AuthService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/loginBackground.PNG',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 32, 0, 16),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            iconSize: 32,
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('Zaboravljena lozinka',
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                  ),
                  isConfirmation == false
                      ? Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'E-mail za oporavak lozinke:',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TextFormField(
                                    controller: email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '\u26A0 E-mail je obavezno polje!';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: 'E-mail',
                                        prefixIcon: Icon(
                                          Icons.email,
                                        ),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.white,
                                        filled: true),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: ElevatedButton(
                                      child: Text(
                                        "POŠALJI ZAHTJEV",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorPalette.primary,
                                          minimumSize:
                                              const Size.fromHeight(50),
                                          textStyle:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () => _posaljiZahtjev()),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Form(
                          key: formKey2,
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () => _ponovnoPosalji(),
                                      child: Text(
                                        'PONOVNO POŠALJI KOD',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Kod za oporavak lozinke:',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: kod,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '\u26A0 Kod je obavezno polje!';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Kod',
                                      prefixIcon: Icon(Icons.shield_outlined),
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: ElevatedButton(
                                    child: Text(
                                      "POTVRDI",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: ColorPalette.primary,
                                        minimumSize: const Size.fromHeight(50),
                                        textStyle:
                                            TextStyle(color: Colors.white)),
                                    onPressed: () => _potvrdiKod()),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ))
    ]);
  }

  _posaljiZahtjev() async {
    if (formKey.currentState!.validate()) {
      var res = await _authService.requestPass(email.text.replaceAll(' ', ''));
      setState(() {
        isConfirmation = !isConfirmation;
      });
    }
  }

  _potvrdiKod() async {
    if (formKey2.currentState!.validate()) {
      var obj = {'email': email.text, 'token': kod.text.replaceAll(' ', '')};
      var res = await _authService.confirmPass(obj);
      if (res.errors!.isEmpty == true) {
        const snackBar2 = SnackBar(
            content: Text('Pristupni kod je ispravan!'),
            backgroundColor: ColorPalette.info);
        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PromjenaLozinke();
        }));
      } else {
        const snackBar = SnackBar(
            content: Text('Pristupni kod nije ispravan!'),
            backgroundColor: ColorPalette.danger);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  _ponovnoPosalji() async {
    var res = await _authService.requestPass(email.text);
    if (res == true) {
      const snackBar2 = SnackBar(
          content: Text('E-mail za oporavak lozinke je uspješno poslan!'),
          backgroundColor: ColorPalette.info);
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }
}
