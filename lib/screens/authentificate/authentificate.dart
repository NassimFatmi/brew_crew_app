import 'package:flutter/material.dart';
import 'package:hello_world/screens/authentificate/register.dart';
import 'package:hello_world/screens/authentificate/signin.dart';

class Authentificate extends StatefulWidget {
  @override
  _AuthentificateState createState() => _AuthentificateState();
}

class _AuthentificateState extends State<Authentificate> {
  bool showSignIn = true;
  void togleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(
            togleView: togleView,
          )
        : Register(
            togleView: togleView,
          );
  }
}
