import 'package:flutter/material.dart';
import 'package:inventura_app/common/color_palette.dart';
import 'package:inventura_app/screens/auth/zaboravljena_lozinka.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final lozinka = TextEditingController();
  final username = TextEditingController();
  late bool hidePass;
  late bool emailPrijava;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email.text = 'test@test.com';
    lozinka.text = 'Test1234.';
    hidePass = true;
    emailPrijava = true;

    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    lozinka.dispose();
    super.dispose();
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 48),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text('Prijava',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ),
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Switch(
                              value: emailPrijava,
                              onChanged: (value) {
                                setState(() {
                                  emailPrijava = value;
                                });
                              }),
                        ),
                        Text(
                          'Prijava s E-mail adresom',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    emailPrijava == true
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'E-mail:',
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
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Korisničko ime:',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: username,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '\u26A0 Korisničko ime je obavezno polje!';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Korisničko ime',
                                      prefixIcon: Icon(
                                        Icons.person,
                                      ),
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                              ),
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Lozinka:',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    TextFormField(
                      controller: lozinka,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '\u26A0 Lozinka je obavezno polje!';
                        }
                        return null;
                      },
                      obscureText: hidePass,
                      decoration: InputDecoration(
                          hintText: 'Lozinka',
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(hidePass == true
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                hidePass = !hidePass;
                              });
                            },
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: ElevatedButton(
                          child: Text(
                            "PRIJAVA",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: ColorPalette.primary,
                              minimumSize: const Size.fromHeight(50),
                              textStyle: TextStyle(color: Colors.white)),
                          onPressed: () => onLoginPressed()),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ZaboravljenaLozinka();
                              }));
                            },
                            child: Text('Zaboravljena lozinka?'),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  onLoginPressed() async {
    // Client _client = Client();
    // var _authService = AuthService(_client.init());

    var obj = {
      'username': emailPrijava == true ? null : username.text,
      'email': emailPrijava == true ? email.text.replaceAll(' ', '') : null,
      'password': lozinka.text,
    };

    // _authService.login(obj).then((value) {
    //   if (value) {
    //     Navigator.of(context).pushReplacementNamed('/pocetna');
    //   } else {
    //     displayDialog(context, "Došlo je do pogreške", "");
    //   }
    // });
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
}
