import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/shades/constances.dart';
import 'package:hello_world/shades/loading.dart';

class SignIn extends StatefulWidget {
  final Function togleView;
  SignIn({this.togleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  var formkey = GlobalKey<FormState>();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('Sign in to brew crew'),
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.togleView();
                    },
                    icon: Icon(Icons.account_circle),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: formkey,
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
                          value.isEmpty ? 'type your email' : null,
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
                      validator: (value) =>
                          value.isEmpty ? 'type your password' : null,
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
                        if (formkey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          var result = await _auth.signInWithEmailAndPassword(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'impossible to connect please verify your informations';
                              loading = false;
                            });
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text('Sign in',
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
