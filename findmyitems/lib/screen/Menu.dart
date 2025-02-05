import 'package:findmyitems/model/profile.dart';
import 'package:findmyitems/screen/Family.dart';
import 'package:findmyitems/screen/emailprofile.dart';
import 'package:findmyitems/screen/googleprofile.dart';
import 'package:findmyitems/screen/home.dart';
import 'package:findmyitems/screen/mainhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/single_child_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Profile profile = Profile();
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        //Group add button
        leading: IconButton(
          icon: const Icon(Icons.group_add),
          onPressed: () {},
        ),
        title: Text("Menu"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {
                  showprofile();
                  /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GoogleProfileScreen();
                  }));*/
                },
                icon: Icon(Icons.account_circle),
                label: Text("Profile"),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        logout().then((value) {
                          Fluttertoast.showToast(
                              msg: "ออกจากระบบสำเร็จ",
                              gravity: ToastGravity.TOP);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        });
                      },
                      icon: Icon(Icons.logout),
                      label: Text("Logout"),
                    ),
                  ),
                ],
              ))
        ],
      )),
    );
  }

  Future<Null> logout() async {
    // Sign out with email
    await firebaseAuth.signOut();
    // Sign out with google
    await googleSignIn.signOut();
  }

  Future<Null> showprofile() async {
    if (user.photoURL != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return GoogleProfileScreen();
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EmailProfileScreen();
      }));
    }
  }
}
