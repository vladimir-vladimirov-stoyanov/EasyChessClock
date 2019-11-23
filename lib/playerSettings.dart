import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'package:simple_chess_clock/durationpicker.dart';
import 'package:simple_chess_clock/main.dart';
import 'package:simple_chess_clock/playerdata.dart';

class PlayerSettings extends StatelessWidget {
  PlayerSettings(this.playerIndex);
  final int playerIndex;
  EditGameModeBloc editGameModeBloc;

  @override
  Widget build(BuildContext context) {
    editGameModeBloc = BlocProvider.of<EditGameModeBloc>(context);
    return FittedBox(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            repository
                .currentlyEditedGameMode.playerConfigurations[playerIndex].name,
            style: Theme.of(context).textTheme.display1,
          ),
          Column(
            children: buildDurationPickers(),
          ),
        ],
      ),
    );
  }

  List<Widget> buildDurationPickers() {
    final List<Widget> durationPickers = <Widget>[];
    for (int i = 0; i < 2; i++) {
      durationPickers.add(
        buildDurationPicker(i),
      );
    }
    return durationPickers;
  }

  Widget buildDurationPicker(int durationTypeIndex) {
    return BlocProvider<DurationPickerBloc>(
      builder: (BuildContext context) =>
          editGameModeBloc.createDurationPickerBloc(
              playerIndex, DurationType.values[durationTypeIndex]),
      child: const DurationPicker(),
    );
  }
}
