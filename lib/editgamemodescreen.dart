import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'package:simple_chess_clock/main.dart';
import 'package:simple_chess_clock/playerSettings.dart';
import 'package:simple_chess_clock/sizeConfig.dart';

class EditGameModeScreen extends StatefulWidget {
  const EditGameModeScreen(this.title);
  final String title;
  @override
  _EditGameModeScreenState createState() => _EditGameModeScreenState();
}

class _EditGameModeScreenState extends State<EditGameModeScreen> {
  final List<String> settingsText = const <String>[
    'Different times for both players',
    'Same times for both players',
  ];
  EditGameModeBloc editGameModeBloc;
  @override
  Widget build(BuildContext context) {
    return buildEditGameModeScreen();
  }

  Widget buildEditGameModeScreen() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
            initialValue: repository.currentlyEditedGameMode.name,
            onChanged: (String newName) {
              editGameModeBloc.currentName = newName;
            },
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          PlayerSettings(0),
          buildDivider(),
          BlocBuilder<EditGameModeBloc, EditGameModeState>(
              builder: (BuildContext context, EditGameModeState state) {
            if (state is SwitchSameSettingsState && !state.sameSettings) {
              return PlayerSettings(1);
            }

            return const SizedBox.shrink();
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('Save'),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  final String gameModeValidation =
                      editGameModeBloc.checkIsCurrentlyEditedGameModeValid();
                  if (gameModeValidation.isEmpty) {
                    editGameModeBloc.updateCurrentlyEditedGameMode();
                    Navigator.of(context).pop();
                  } else {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(gameModeValidation),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildDivider() {
    const Expanded divider = Expanded(
      child: Divider(
        thickness: 5,
      ),
    );
    return Row(children: <Widget>[
      divider,
      BlocBuilder<EditGameModeBloc, EditGameModeState>(
          builder: (BuildContext context, EditGameModeState state) {
        if (state is SwitchSameSettingsState) {
          return RaisedButton(
            child: Text('${settingsText[state.sameSettings ? 0 : 1]}'),
            onPressed: () => editGameModeBloc
                .add(SwitchSameSettingsEvent(!state.sameSettings)),
          );
        }
        return null;
      }),
      divider
    ]);
  }

  @override
  void initState() {
    editGameModeBloc = BlocProvider.of<EditGameModeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    editGameModeBloc.close();
    super.dispose();
  }
}
