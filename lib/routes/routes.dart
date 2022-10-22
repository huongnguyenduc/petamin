import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:Petamin/app/app.dart';
import 'package:Petamin/home/home.dart';
import 'package:Petamin/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  SessionStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case SessionStatus.authenticated:
      return [HomePage.page()];
    case SessionStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
