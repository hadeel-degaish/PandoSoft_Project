import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            withEmailPassword(),
          ],
        );
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: const Text(
                    'Welcome back!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                        fontFamily: 'Raleway',
                        fontSize: 30),
                  ),
                  padding: const EdgeInsets.only(bottom: 80.0),
                  alignment: Alignment.center,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter your email';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter your password';
                    return null;
                  },
                  obscureText: true,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.blue,
                      child: const Text(
                        "SignIn",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                            fontFamily: 'Raleway',
                            fontSize: 25),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _signInWithEmailAndPassword();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MainPage();
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }
}
