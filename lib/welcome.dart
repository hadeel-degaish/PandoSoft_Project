import 'package:pando_app/register.dart';
import 'package:pando_app/signIn.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login App"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: Text(
              'Welcome To LogIn App',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  fontFamily: 'Raleway',
                  fontSize: 25),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: SizedBox(
              width: 300.0,
              height: 60.0,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  "SignIn",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                      fontFamily: 'Raleway',
                      fontSize: 25),
                ),
                onPressed: () => _pushPage(context, SignIn()),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: SizedBox(
              width: 300.0,
              height: 60.0,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  "SignUp",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                      fontFamily: 'Raleway',
                      fontSize: 25),
                ),
                onPressed: () => _pushPage(context, Register()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
