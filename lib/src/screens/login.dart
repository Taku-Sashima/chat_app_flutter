import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/register.dart';
import '../services/login.dart';
import '../../main.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State {
  //新規登録用
  String newUserEmail = "";
  String newUserPassword = "";
  //ログイン用
  String loginUserEmail = "";
  String loginUserPassword = "";

  String infoText = "";


  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            color: const Color.fromARGB(100, 30, 100, 200),
            // border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
            boxShadow: const [BoxShadow(
              color: Colors.grey,
              spreadRadius: 10,
              blurRadius: 20,
              offset: Offset(0, 0),
            )],
            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              const SizedBox(height: 8),

              TextFormField(
                decoration: const InputDecoration(labelText: "パスワード（６文字以上）"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),

              Container(
                child: Text(infoText),
              ),
              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('ログイン'),
                  onPressed: () => {
                    loginAuth(context, newUserEmail, newUserPassword, infoText,
                      (String errorMessage) {
                        setState(() {
                          infoText = errorMessage;
                        });
                      },
                      userState,
                    ),
                  }
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('新規登録'),
                  onPressed: () => {
                    registerAuth(context, newUserEmail, newUserPassword, infoText,
                      (String errorMessage) {
                        setState(() {
                          infoText = errorMessage;
                        });
                      },
                      userState,
                    ),
                  }
                ),
              ),
              
            ],
          ),
        )
      ),
    );
  }
}