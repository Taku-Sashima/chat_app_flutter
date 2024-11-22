import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';


class ChatList extends StatefulWidget{

  @override
  createState() => _ChatList();
}

class _ChatList extends State<ChatList>{

  @override
  Widget build(BuildContext context){
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text('ログイン情報：${user.email}'),
          ),

          Expanded(
            // 非同期処理の結果を元にWidgetを作れる
            child: StreamBuilder<QuerySnapshot>(
              // 投稿メッセージ一覧を取得（非同期処理）
              // 投稿日時でソート
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                // データが取得できた場合
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  // 取得した投稿メッセージ一覧を元にリスト表示
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                          subtitle: Text(document['email']),
                          title: Text(document['text']),
                          trailing: document['email'] == user.email? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // 投稿メッセージのドキュメントを削除
                              await FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(document.id)
                                  .delete();
                            },
                          )
                          : null,
                        ),
                      );
                      
                    }).toList(),
                  );
                }
                // データが読込中の場合
                return const Center(
                  child: Text('読込中...'),
                );
              },
            ),
          ),
        ],
      )

    );
  }
  
}