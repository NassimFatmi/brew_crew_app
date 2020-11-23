import 'package:flutter/material.dart';
import 'package:hello_world/models/appuser.dart';
import 'package:hello_world/screens/authentificate/authentificate.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return user != null
        ? Home()
        : Authentificate(); //return either Home or Authentificate Widget
  }
}
