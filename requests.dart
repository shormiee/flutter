import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/widgets/request-card.dart';
import 'package:flutter_chatapp/widgets/request-card.dart';

class Requests extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value (FirebaseAuth.instance.currentUser),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection
                ('request').orderBy('created_at',descending: true) .snapshots(),
              builder: (ctx, requestSnapshot) {
                if (requestSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final requestDocs = requestSnapshot.data.docs;
                return Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: requestDocs.length,
                    itemBuilder: (ctx, index) {
                      final request = requestDocs[index];
                      return RequestCard(
                        request['text'],
                       request['userId'],
                      request['userId'] == futureSnapshot.data.uid,
                     request['tokenId'],
                      );
                    },
                  ),
                );
              }
          );
        });
  }
}
