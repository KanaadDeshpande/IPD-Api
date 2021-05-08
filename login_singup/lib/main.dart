import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'signup.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      print('Incomplete');
      return Container(
        child: Text(
          'Please Enter all Details',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    } else {
      Map data = {'email': email, 'password': password};
      var jsonResponse = null;
      var response = await http.post(
          Uri.parse('https://ruturaaj16.pythonanywhere.com/account/login/'),
          body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print('OK');
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
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
                'Sign In',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
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
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  child: Text('Login'),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    login(nameController.text, passwordController.text);
                  },
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text('Do not have account?'),
                  TextButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
