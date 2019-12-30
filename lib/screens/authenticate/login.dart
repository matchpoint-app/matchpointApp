import 'package:flutter/material.dart';
import 'package:matchpoint/screens/authenticate/register.dart';
import 'package:matchpoint/screens/home/home.dart';
import 'package:matchpoint/services/auth.dart';

class Login extends StatefulWidget {
  final Function callback;

  Login(this.callback);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Matchpoint',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'ModerneSans',
            decoration: TextDecoration.none,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                controller: emailController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                onChanged: (text) {
                  this._isButtonDisabled = false;
                },
                autocorrect: false,
                obscureText: true,
                enableSuggestions: false,
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 10),
                  child: FlatButton(
                    disabledColor: Colors.black38,
                    onPressed: () async {
                            dynamic result = await _auth.signIn(
                                emailController.value.text,
                                passwordController.value.text);

                            if (result == null) {
                              print('error');
                            } else {
                              this.widget.callback(new Home());
                            }
                          },
                    color: Colors.black38,
                    padding: EdgeInsets.all(10),
                    child: Text('Login',
                        style: TextStyle(
                            color:  Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                  child: FlatButton(
                    onPressed: () {
                      this.widget.callback(new Register());
                    },
                    color: Colors.black38,
                    padding: EdgeInsets.all(10),
                    child: Text('Register',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
