import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/business_logic/cubit/home_navbar/home_navbar_cubit.dart';

import '../../constants/colors.dart';
import '../widgets/app_bottom_navbar.dart';
import 'movies_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AppBottomNavBar(),
        backgroundColor: MyColors.darkBlue,
        body:SingleChildScrollView(
        child: BlocBuilder<HomeNavBarCubit,HomeNavBarState>(
        builder: (BuildContext context, state) {
          if(state is HomeItemSelected){
            return MoviesScreen();
          }
          else if(state is SettingsItemSelected){
            return Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          }
          else if(state is SearchItemSelected){
            return Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            );
          }
          else{
            return Center(child: CircularProgressIndicator(color: Colors.orange),);
          }
        },
        ),
        ),
    );
  }
}
