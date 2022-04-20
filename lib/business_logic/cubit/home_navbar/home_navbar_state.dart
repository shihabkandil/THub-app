part of 'home_navbar_cubit.dart';

@immutable
abstract class HomeNavBarState {}


class SelectedIndexChanged extends HomeNavBarState{
  final index;
  SelectedIndexChanged(this.index);
}

class HomeItemSelected extends HomeNavBarState{}

class SettingsItemSelected extends HomeNavBarState{}

class SearchItemSelected extends HomeNavBarState{}