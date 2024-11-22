
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/caht_page/chat_page.dart';
import '../../main.dart';


void registerAuth(BuildContext context, String email, String password, String infoText, Function(String) onError, UserState userState) async {
  try {
    // メール/パスワードでユーザー登録
    final FirebaseAuth auth = FirebaseAuth.instance;
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userState.setUser(result.user!);
    
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return ChatPage();
      }),
    );
  }catch (e) {
    //loginPage側から渡されるsetStateの入った関数をコールバック関数として呼び出す
    onError("登録に失敗しました：${e.toString()}");

  }
}