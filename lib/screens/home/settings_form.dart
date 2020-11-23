import 'package:flutter/material.dart';
import 'package:hello_world/models/appuser.dart';
import 'package:hello_world/services/database.dart';
import 'package:hello_world/shades/constances.dart';
import 'package:hello_world/shades/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String currentName;
  String currentSugras;
  int currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your Brew settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: snapshot.data.name,
                  decoration: inputTextDecoration,
                  onChanged: (value) => setState(() {
                    currentName = value;
                  }),
                  validator: (value) =>
                      value.isEmpty ? 'type a your email please' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField(
                  decoration: inputTextDecoration,
                  value: currentSugras ?? snapshot.data.sugars,
                  onChanged: (sugars) {
                    currentSugras = sugars;
                  },
                  items: sugars
                      .map((sugar) => DropdownMenuItem(
                          value: sugar, child: Text('$sugar sugars')))
                      .toList(),
                ),
                Slider(
                  onChanged: (value) {
                    setState(() {
                      currentStrength = value.round();
                    });
                  },
                  value: (currentStrength ?? snapshot.data.strength).toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor:
                      Colors.brown[currentStrength ?? snapshot.data.strength],
                  inactiveColor: Colors.brown,
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  onPressed: () async {
                    await DatabaseService(uid: user.uid).updateUserData(
                        currentSugras ?? snapshot.data.sugars,
                        currentName ?? snapshot.data.name,
                        currentStrength ?? snapshot.data.strength);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
