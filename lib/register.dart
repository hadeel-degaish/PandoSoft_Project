import 'package:pando_app/mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pando_app/signIn.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSuccess;
  String _userEmail;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: const Text(
                        'Join Us!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                            fontFamily: 'Raleway',
                            fontSize: 25),
                      ),
                      alignment: Alignment.center,
                    ),
                    TextFormField(
                      controller: _displayName,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter fullName';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter email text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        }
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
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Raleway',
                                color: Colors.blue,
                                fontSize: 25),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _registerAccount();
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: const Text(
                        'After SignUp Please Verify Your Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                            fontFamily: 'Raleway',
                            fontSize: 15),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _registerAccount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SignIn(),
      ));
    } else {
      _isSuccess = false;
    }
  }
}
