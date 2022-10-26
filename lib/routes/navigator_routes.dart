import 'package:Petamin/chat/view/chat_list_page.dart';
import 'package:Petamin/explore/explore.dart';
import 'package:Petamin/home/cubit/home_cubit.dart';
import 'package:Petamin/landing/landing.dart';
import 'package:Petamin/pet_list/pet.dart';
import 'package:Petamin/profile/view/profile_page.dart';
import 'package:flutter/widgets.dart';
import 'package:Petamin/home/home.dart';

List<Page<dynamic>> onGenerateAppViewWindows(
  HomeState state,
  List<Page<dynamic>> pages,
) {
  switch (state.selectedIndex) {
    case 0:
      return [LandingPage.page()];
    case 1:
      return [ExplorePage.page()];
    case 2:
      return [PetListPage.page()];
    case 3:
      return [ChatListPage.page()];
    case 4:
      return [ProfilePage.page()];
    default:
      return [LandingPage.page()];
  }
}
