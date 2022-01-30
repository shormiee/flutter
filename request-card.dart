import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  RequestCard(this.request, this.uid, bool bool,
   this.tokenId
      );
 // final key key;
  final String request;
  final String uid;
   final String tokenId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
        decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(3),
        ),
          width: 200,
         height: 70,
         margin: EdgeInsets.symmetric(
             vertical: 2,
             horizontal: 50),
          padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 16),
         child: Column(
           children: [
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(),);
                  }

                  return Text(
                   snapshot.data['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                }
              ),
              Text(
               request, style: TextStyle(
                 color: Colors.white,
                 fontSize: 17,
                 fontWeight: FontWeight.bold
             ),
             ),
           ],
         ),
        ),
      ],
    );
  }
}
