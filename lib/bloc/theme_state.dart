import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState extends Equatable {
  const ThemeState({
    @required this.themeData,
    @required this.isDark,
  });

  final ThemeData themeData;
  final bool isDark;

  @override
  List<Object> get props => <Object>[themeData, isDark];
}
