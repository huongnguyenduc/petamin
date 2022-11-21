import 'package:Petamin/home/cubit/home_cubit.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigator extends StatelessWidget {
  const CustomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        context.select((HomeCubit cubit) => cubit.state.selectedIndex);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => context.read<HomeCubit>().onMenuItemTapped(index),
      backgroundColor: AppTheme.colors.green,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: AppTheme.colors.pink,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/compass.svg',
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/compass.svg',
              color: AppTheme.colors.pink,
            ),
            label: 'Explore'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/pet.svg',
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/pet.svg',
              color: AppTheme.colors.pink,
            ),
            label: 'Pet'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/chat.svg',
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/chat.svg',
              color: AppTheme.colors.pink,
            ),
            label: 'Chat'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/user.svg',
              color: AppTheme.colors.pink,
            ),
            label: 'Profile')
      ],
      iconSize: 28,
      selectedItemColor: AppTheme.colors.pink,
      unselectedItemColor: AppTheme.colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
