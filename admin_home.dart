import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/widgets/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_chatapp/widgets/new-request.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('office helpers screen'),
        actions: [
          DropdownButton(icon: Icon(Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,

          ),
            items: [
              DropdownMenuItem(child: Container(child: Row(
                children: [
                  Icon(
                      Icons.exit_to_app
                  ),
                  SizedBox(width: 8,),
                  Text('Logout'),
                ],
              ),
              ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                AuthHelper.logOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
         reverse: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
             Container(
                 height: 520,
                 color: Colors.white,
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Requests(),
                   ],
                 )),

            ],

          ),

        ),
      ),
    );
  }
}