import 'dart:convert';

import 'package:aero_monster/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Aero Monster"),
        ),
        body: const Login(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController mail = TextEditingController();
TextEditingController password = TextEditingController();

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: mail,
              decoration: const InputDecoration(
                  icon: Icon(Icons.mail), labelText: 'Correo: '),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un correo';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                  icon: Icon(Icons.password), labelText: 'Contraseña: '),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese una contraseña';
                } else {
                  return null;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await http
                          .post(
                            Uri.parse('http://192.168.100.77:8081/login'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(
                              <String, String>{
                                'mail': mail.text,
                                'password': password.text
                              },
                            ),
                          )
                          .then((response) => {
                                if (response.statusCode == 200)
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const homePage(),
                                      ),
                                    )
                                  }
                              });
                    }
                  },
                  child: const Text('Ingresar')),
            ),
          ],
        ),
      ),
    );
  }
}
