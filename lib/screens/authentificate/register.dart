import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/shades/constances.dart';
import 'package:hello_world/shades/loading.dart';

class Register extends StatefulWidget {
  final Function togleView;
  Register({this.togleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('Sign up to brew crew'),
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.togleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('sign in'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          inputTextDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value.isEmpty ? 'type a your email please' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          inputTextDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value.length < 6
                          ? 'type a valid password with +6 chars'
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          var result = await _auth.registerWithEmailAndPassword(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'cant register please verify your informations';
                              loading = true;
                            });
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text('Register',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
