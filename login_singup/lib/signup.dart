import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = new TextEditingController();
  final first_nameController = new TextEditingController();
  final last_nameController = new TextEditingController();
  final passwordController = new TextEditingController();
  bool _isLoading = false;

  signup(String email, String first_name, String last_name,
      String password) async {
    if (email.isEmpty ||
        first_name.isEmpty ||
        last_name.isEmpty ||
        password.isEmpty) {
      print('Incomplete');
    } else {
      Map data = {
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'password': password
      };
      var jsonResponse = null;
      var response = await http.post(
          Uri.parse(
              'https://ruturaaj16.pythonanywhere.com/account/user-register/'),
          body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print('OK');
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Personalized Kitchen'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  hintText: 'Email ID',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: first_nameController,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  hintText: 'First Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: last_nameController,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  hintText: 'Last Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  hintText: 'Password',
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50.0,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  child: Text('Sign Up'),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    signup(emailController.text, first_nameController.text,
                        last_nameController.text, passwordController.text);
                  },
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text('Already have an account ?'),
                  TextButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
