import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movieapi/business_logic/cubit/home_navbar/home_navbar_cubit.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeNavBarCubit>(context),
      child: GNav(
          onTabChange:(index) => BlocProvider.of<HomeNavBarCubit>(context).onSelectedIndexChange(index),
          selectedIndex: BlocProvider.of<HomeNavBarCubit>(context).selectedIndex,
          gap: 12,
          activeColor: Colors.white,
          iconSize: 24,
          tabMargin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Colors.white10,
          color: Colors.white70,
          tabs: [
            GButton(
              icon: CupertinoIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: CupertinoIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
    );
  }
}
