import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/system_info.dart';
import '../shared/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/style.dart';
import 'dart:io';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String defaultLocale = Platform.localeName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CurrentUser(),
          SizedBox(
            height: 8.0,
          ),
          VersionInfo(),
          SizedBox(
            height: 13.0,
          ),
          DeviceInfo(),
          SizedBox(
            height: 13.0,
          ),
          Text('$defaultLocale')
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class CurrentUser extends StatelessWidget {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Text(
                'Offline mode',
                style: TextStyle(color: myLightRed),
              ),
            ),
          );
        } else {
          final _user = snapshot.data;
          return Center(
            child: Text(
              '${_user?.email}',
              style: TextStyle(color: myTeal),
            ),
          );
        }
      },
    );
  }
}

class CustomRow extends StatelessWidget {
  final String? rowName;
  final String? rowData;
  const CustomRow({Key? key, this.rowName, this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: primaryColor, width: 1.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 1.0, left: 5.0),
            padding: const EdgeInsets.only(bottom: 1.0, left: 5.0),
            child: Text(
              rowName!,
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 1.0, right: 5.0),
            padding: const EdgeInsets.only(bottom: 1.0, right: 5.0),
            child: Text(rowData!.toUpperCase(),
                style: const TextStyle(/* fontWeight: FontWeight.bold */)),
          )
        ],
      ),
    );
  }
}
