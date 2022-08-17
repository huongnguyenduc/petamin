import 'package:flutter/widgets.dart';
import 'package:Petamin/app/app.dart';
import 'package:Petamin/home/home.dart';
import 'package:Petamin/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
