import 'package:authentification/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
        body: Container(
      child: !isloggedin
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                Container(
                  height: 300,
                  child: Image(
                    image: AssetImage("assets/images/start.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Text(
                    "Olá, ${user.displayName} você está logado como ${user.email}",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 200,
                  child: ElevatedButton.icon(icon: Icon(Icons.login_outlined), label: Text('Sair'),
                    onPressed: signOut,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20))),
                  ),
                )
              ],
            ),
    ));
  }
}