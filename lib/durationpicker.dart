import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'package:simple_chess_clock/durationpartpicker.dart';
import 'package:simple_chess_clock/playerdata.dart';
import 'package:flutter/foundation.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker();

  @override
  _DurationPickerState createState() {
    return _DurationPickerState();
  }
}

class _DurationPickerState extends State<DurationPicker> {
  DurationPickerBloc durationPickerBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<DurationPickerBloc, TimeSpanChanged>(
            builder: (BuildContext context, TimeSpanChanged state) {
          return buildDurationButton(state.timeSpan);
        })
      ],
    );
  }

  Widget buildDurationButton(TimeSpan timeSpan) {
    final String durationString =
        '${describeEnum(durationPickerBloc.durationType)}: ${timeSpan.hours} : ${timeSpan.minutes} : ${timeSpan.seconds}';

    return OutlineButton(
          child: Text(durationString, style: Theme.of(context).textTheme.headline,),
          onPressed: () {
            _showDurationPartsDialog();
          });
    
  }

  void _showDurationPartsDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: generateDurationParts(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        durationPickerBloc.add(TimeSpanChangedEvent(
                            durationPickerBloc
                                .getTimeSpanFromDurationPickers()));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  List<Widget> generateDurationParts() {
    final List<Widget> parts = <Widget>[];
    for (int durationPartIndex = 0;
        durationPartIndex < 3;
        durationPartIndex++) {
      parts.add(Container(
        width: 60,
        height: 130,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(3),
        child: buildDurationPart(durationPartIndex),
      ));
    }
    return parts;
  }

  Widget buildDurationPart(int durationPartIndex) {
    return BlocProvider<DurationPartBloc>(
      builder: (BuildContext context) =>
          durationPickerBloc.createDurationPartBloc(durationPartIndex),
      child: const DurationPartPicker(),
    );
  }

  @override
  void initState() {
    super.initState();
    durationPickerBloc = BlocProvider.of<DurationPickerBloc>(context);
  }

  @override
  void dispose() {
    durationPickerBloc.close();
    super.dispose();
  }
}
