import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   @override
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         backgroundColor: Colors.blueAccent,
//         accentColor: Colors.deepPurpleAccent,
//         accentColorBrightness: Brightness.dark,
//         buttonTheme: ButtonTheme.of(context).copyWith(
//           buttonColor: Colors.pinkAccent,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//       home:

      // StreamBuilder(stream:FirebaseAuth.instance.authStateChanges(),
      //     builder: (ctx, userSnapshot) {
      //     if (userSnapshot.hasData)
      //    {
      //         return ChatScreen();
      //    }
      //    return AuthScreen();
      //     }
      // ),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chatapp/screens/home.dart';
import 'package:flutter_chatapp/screens/login.dart';
import 'package:flutter_chatapp/screens/admin_home.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //
  @override
  void initState() {
    super.initState();
    configOneSignal();
  }

  void configOneSignal()
  {
    OneSignal.shared.setAppId(cappId);
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(
                  snapshot.data.uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc;
                  if (user['role'] == 'admin') {
                    return AdminHomePage();
                  } else {
                    return HomePage();
                  }
                }
                else {
                  return Material(child: Center(child: CircularProgressIndicator(),),);
                    //AllUser();

                }
              },
            );
          }
          return LoginPage();
        }
    );
  }
}
