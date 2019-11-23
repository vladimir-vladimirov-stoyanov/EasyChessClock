import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Dark Mode:',
            style: Theme.of(context).textTheme.headline,
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            bloc: BlocProvider.of<ThemeBloc>(context),
            builder: (BuildContext context, ThemeState state) {
              return Switch(
                value: state.isDark,
                onChanged: (bool value) {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(value));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
