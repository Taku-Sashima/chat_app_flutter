import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/caht_page/chat_page.dart';
import '../../main.dart';


void loginAuth(BuildContext context, String email, String password, String infoText, Function(String) onError, UserState userState) async {
  try {
    // メアドとパスワードでログイン
    final FirebaseAuth auth = FirebaseAuth.instance;
    final result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    userState.setUser(result.user!);
    
    // チャット画面に遷移＋ログイン画面を破棄
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return ChatPage();
      }),
    );
  }catch (e) {
    //loginPage側から渡されるsetStateの入った関数をコールバック関数として呼び出す
    onError("ログインに失敗しました：${e.toString()}");

  }
}