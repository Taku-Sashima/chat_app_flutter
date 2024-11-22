import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login.dart';
import '../add_post_page.dart';
import './widget/chat_list.dart';

class ChatPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            // ログアウト
            // 内部で保持しているログイン情報等が初期化される
            await FirebaseAuth.instance.signOut();
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return LoginPage();
              }),
            );
          },
        ),
        title: const Text('チャット'),
      ),

      body:ChatList(),


      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // 投稿画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage();
            }),
          );
        },
      ),
    );
  }
}