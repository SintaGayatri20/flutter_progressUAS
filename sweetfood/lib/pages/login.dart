import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response = await http
        .post("http://192.168.43.38/apiflutter/login/login_api", body: {
      "username": user.text,
      "password": pass.text,
    });

    //print(response.body);

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser['level'] == 'user') {
        Navigator.pushReplacementNamed(context, '/pages/home');
      } else if (datauser['level'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/pages/admin');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            color: Colors.red.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(top: 80),
                ),
                new Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: new TextField(
                              controller: user,
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  icon: Icon(Icons.people),
                                ),
                            ),
                          ),
                        ),
                      ),

                      new Padding(padding: EdgeInsets.only(top: 20)),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: new TextField(
                              controller: pass,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  icon: Icon(Icons.lock_outline),
                                ),
                            ),
                          ),
                        ),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 20)),

                      new RaisedButton(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        color: Colors.purple[200],
                        onPressed: () {
                          _login();
                        },
                      ),
                      new Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        msg,
                        style: new TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
