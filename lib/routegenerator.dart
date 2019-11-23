import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/editgamemode_bloc.dart';
import 'package:simple_chess_clock/bloc/game_bloc.dart';
import 'package:simple_chess_clock/editgamemodescreen.dart';
import 'package:simple_chess_clock/game.dart';
import 'package:simple_chess_clock/main.dart';
import 'package:simple_chess_clock/settings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
   

    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => const MyHomePage());
      case '/edit':
        return MaterialPageRoute<dynamic>(builder: (_) {
          return BlocProvider<EditGameModeBloc>(
            builder: (BuildContext context) => settings.arguments,
            child: const EditGameModeScreen('Edit Game Mode'),
          );
        });
      case '/game':
        return MaterialPageRoute<dynamic>(
          builder: (_) {
          return BlocProvider<GameBloc>(
            builder: (BuildContext context) => settings.arguments,
            child: const Game(),
          );
        }
            );
      case '/add':
        return MaterialPageRoute<dynamic>(builder: (_) {
          return BlocProvider<EditGameModeBloc>(
            builder: (BuildContext context) => settings.arguments,
            child: const EditGameModeScreen('Add Game Mode'),
          );
        });
      case '/settings':
        return MaterialPageRoute<dynamic>(builder: (_) {
           return const SettingsPage();
          
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: const Text('ERROR'),
        ),
      );
    });
  }
}
