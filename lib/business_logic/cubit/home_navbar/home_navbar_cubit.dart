import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_navbar_state.dart';

class HomeNavBarCubit extends Cubit<HomeNavBarState> {
  HomeNavBarCubit({int? selectedIndex})
      :_selectedIndex = selectedIndex ?? 0 , super(HomeItemSelected());

  int _selectedIndex;

  void onSelectedIndexChange(int index){
    _selectedIndex = index;
    if(_selectedIndex == 0)
      emit(HomeItemSelected());
    else if(_selectedIndex ==1)
      emit(SearchItemSelected());
    else if(_selectedIndex == 2)
      emit(SettingsItemSelected());
  }

  get selectedIndex {
    return _selectedIndex;
  }

}
