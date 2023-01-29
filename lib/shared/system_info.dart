import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({Key? key}) : super(key: key);

  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<PackageInfo>(
            future: _getPackageInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.hasError) {
                return Text('An error occured!');
              } else if (snapshot.hasData) {
                final vData = snapshot.data!;
                String appVersion = 'v${vData.version}';
                return Container(
                  child: Text(
                    appVersion,
                    style: TextStyle(fontSize: 13.0),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getDeviceInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text('An error occured!');
          } else if (snapshot.hasData) {
            final AndroidDeviceInfo deviceData = snapshot.data!;
            final _deviceId = deviceData.id;
            return Container(
              child: Text(
                '$_deviceId',
                style: TextStyle(fontSize: 13.0),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}


/* 
 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*  Text('App name: ${_data.appName}'),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('Package name: ${_data.packageName}'), 
                    SizedBox(
                      height: 3.0,
                    ), */
                    Text(
                      'v${vData.version}',
                      style: TextStyle(fontSize: 13.0),
                    ),

                    /*    Text('Build number: ${_data.buildNumber}'), */
/*                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('App version: ${_data.version}'),
                        Text('Build number: ${_data.buildNumber}'),
                      ],
                    ) */
                  ],
                );
 */