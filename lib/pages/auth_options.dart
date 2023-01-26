import 'package:flutter/material.dart';
import '../shared/snackbar_messages.dart';
import '../styles/colors.dart';
import '../utils/router.dart';
import 'email_login.dart';
import 'home.dart';

class AuthOptionsPage extends StatelessWidget {
  const AuthOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ldgr',
            style: TextStyle(
              letterSpacing: 3.0,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 34.0),
            padding: EdgeInsets.all(3.0),
            child: Text(
              'the bookkeeping app'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3.0),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10.0),
            child: OutlinedButton.icon(
              onPressed: () => SnackBarMessage().underConstruction(context),
              label: Text(
                'Continue with Google',
                style: TextStyle(
                  wordSpacing: 3.0,
                  letterSpacing: 0.1,
                  color: blackColor,
                ),
              ),
              /* icon: Icon(Icons.save), */
              icon: Image.asset(
                'assets/logos/google.png',
                height: 24.0,
                width: 24.0,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 8.0, bottom: 13.0),
            child: OutlinedButton.icon(
              onPressed: () => SnackBarMessage().underConstruction(context),
              label: Text(
                'Continue with Facebook',
                style: TextStyle(
                  wordSpacing: 3.0,
                  letterSpacing: 0.1,
                  color: blackColor,
                ),
              ),
              /* icon: Icon(Icons.save), */
              icon: Image.asset(
                'assets/logos/facebook.png',
                height: 24.0,
                width: 24.0,
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            indent: 50.0,
            endIndent: 50.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10.0),
            child: OutlinedButton.icon(
              onPressed: () =>
                  PageRouter().navigateToPage(LoginPage(), context),
              label: Text(
                'Continue with Email',
                style: TextStyle(
                  wordSpacing: 3.0,
                  letterSpacing: 0.1,
                  color: blackColor,
                ),
              ),
              icon: Icon(Icons.mail_outline),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10.0),
            child: OutlinedButton(
              onPressed: () => PageRouter().navigateToPage(HomePage(), context),
              child: Text(
                'Offline',
                style: TextStyle(
                  wordSpacing: 3.0,
                  letterSpacing: 0.1,
                  color: blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
