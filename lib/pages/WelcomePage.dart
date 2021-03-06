import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with AutomaticKeepAliveClientMixin {
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
      if (mounted)
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
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: !isloggedin
                ? CircularProgressIndicator()
                : Column(
                    children: <Widget>[
                      SizedBox(height: 40.0),
                      Container(
                        height: 300,
                        child: Image(
                          image: AssetImage("assets/images/welcome.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: Text(
                              "Ol??, ${user.displayName}! Voc?? est?? logado como ${user.email}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 18.0, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 200,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.login_outlined),
                          label: Text('Sair'),
                          onPressed: signOut,
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20))),
                        ),
                      )
                    ],
                  ),
          ),
        ));
  }

  // M??todo para manter a p??gina de onde parou
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
