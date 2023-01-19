import 'package:flutter/material.dart';
import '../utils/date_time_helper.dart';
import '../utils/web.dart';
import '../shared/app_version_info.dart';
import '../shared/bottom_nav_bar.dart';
import '../styles/style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _currentYear = DateTimeHelper().currentYear(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'about'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          /* mainAxisSize: MainAxisSize.max, */
          children: [
            Container(
              margin: EdgeInsets.only(top: 55.0),
              child: Text(
                'Ldgr',
                style:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3.0),
              ),
            ),
            Divider(
              indent: 110.0,
              endIndent: 110.0,
              thickness: 1.0,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 50.0, top: 10.0),
              padding: EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Text(
                'A lightweight, single-entry bookkeeping app for your small business',
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: 0.5),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: GestureDetector(
                    onTap: () =>
                        WebService().openUrl('https://johnapps.de', context),
                    child: Text(
                      '\u00A9 JOHN APPS $_currentYear',
                      style: TextStyle(
                        letterSpacing: 0.1,
                        wordSpacing: 3.0,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 0.5,
                  ))),
                ),
                SizedBox(
                  height: 21.0,
                ),
                AppInfo(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
