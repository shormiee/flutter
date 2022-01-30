// import 'dart:convert';
// import 'dart:io';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:http/http.dart';
import 'package:flutter_chatapp/widgets/requests.dart';


class NewRequest extends StatefulWidget {


  @override
  _NewRequestState createState() => _NewRequestState();
}
class _NewRequestState extends State<NewRequest> {
  final user = FirebaseAuth.instance.currentUser;

  List<String> get tokenId => null;

  Future<Response> sendNotification(List<String> tokenIdList, String contents, String heading) async{

    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": cappId,//kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color":"FF9976D2",

       // "small_icon":"ic_stat_onesignal_default",

        "large_icon":"https://www.filepicker.io/api/file/zPloHSmnQsix82nlj9Aj?filename=name.jpg",

        "headings": {"en": heading},

        "contents": {"en": contents},


      }),
    );
  }





  var _selectedRequest = '';
  //var _sendRequest = '';
void _sendRequest() async {
final user = FirebaseAuth.instance.currentUser;
final userData =  await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  FirebaseFirestore.instance.collection('request').add({
    'text': _selectedRequest,
    'userId': user.uid,
    "created_at": Timestamp.now(),
    'name': userData['name'],
     'tokenId' : userData['tokenId'],
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  child: const Text('coffee'),
                onPressed: (
                    ) {
                    //print(data.docs[0]['text']);
                   _selectedRequest = 'Coffee';
                  }

                  ),
             SizedBox(
               width: 30,
                ),
              ElevatedButton(
                child: const Text('water'),
                onPressed: () {
                    _selectedRequest = 'Water';
                },
              ),
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                child: const Text('tea'),
                onPressed: () {
                  _selectedRequest = 'tea';
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 60,
                // decoration: BoxDecoration(
                //  color: Colors.red,
                // ),
                child: ElevatedButton(
                 child: Text('done'),
                  onPressed: () {
                  setState(() {
                     // ignore: unnecessary_statements
                    if( _selectedRequest == '') {
                      Text('select a request');
                    }
                    else {
                      _sendRequest();
                    }
                    sendNotification(tokenId, _selectedRequest, "you have a request");
                     //_selectedRequest.isEmpty ? null : _sendRequest();
                  },


                  );
                },
                ),

                  // onRefresh: () {
                  //   // implement later
                  //   return;
                  // }
              ),
            ],
          ),
        ],
      ),
    );
  }


}
// class PushNotificationService {
//   static final _notifications = FlutterLocalNotificationsPlugin();
//   static Future _notificationsDetails() async {
//     return NotificationDetails(
//       android:AndroidNotificationDetails(
//         'channel id',
//         'channel name',
//         importance: Importance.max,
//       ),
//       iOS: IOSNotificationDetails(),
//     );
//   }
//
//   static Future showNotification (
//       {
//         int uid = 0,
//         String title,
//         String body,
//         String payload,
//       })
//   async => _notifications.show(uid, title, body,await _notificationsDetails(),
//     payload: payload,
//
//   );}