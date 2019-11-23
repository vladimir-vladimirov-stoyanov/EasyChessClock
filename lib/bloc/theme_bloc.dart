import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simple_chess_clock/appThemeData.dart';
import 'package:simple_chess_clock/bloc/theme_state.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState =>
      ThemeState(themeData: appThemeData[AppTheme.Light], isDark: false);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      if(event.isDarkMode){
        yield ThemeState(themeData: appThemeData[AppTheme.Dark], isDark: true);
      }
      else{
        yield ThemeState(themeData: appThemeData[AppTheme.Light], isDark: false);
      }
    }
  }
}
