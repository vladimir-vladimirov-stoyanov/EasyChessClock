import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged(this.isDarkMode);

  final bool isDarkMode;

  @override
  List<Object> get props => <Object>[isDarkMode];
}
