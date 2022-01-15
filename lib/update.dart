import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class UpdateApp {
  void checkVersion(BuildContext context) async {
    final newVersion =
        NewVersion(iOSId: 'com.app.tiksee', iOSAppStoreCountry: 'RU');
    newVersion.showAlertIfNecessary(context: context);
  }
}
