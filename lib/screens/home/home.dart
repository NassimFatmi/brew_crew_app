import 'package:flutter/material.dart';
import 'package:hello_world/models/Brew.dart';
import 'package:hello_world/screens/home/settings_form.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/services/database.dart';
import 'package:hello_world/shades/loading.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.brown[50],
              appBar: AppBar(
                title: Text('Brew Crew App'),
                backgroundColor: Colors.brown[400],
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () async {
                        loading = true;
                        await _auth.signOut();
                      },
                      icon: Icon(Icons.person),
                      label: Text('Log out')),
                  FlatButton.icon(
                      onPressed: () {
                        _showSettingsPanel();
                      },
                      icon: Icon(Icons.settings),
                      label: Text('Settings')),
                ],
              ),
              body: BrewList(),
            ),
    );
  }
}
