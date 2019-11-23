import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simple_chess_clock/main.dart';
import 'package:simple_chess_clock/playerdata.dart';
import './bloc.dart';

class DurationPickerBloc extends Bloc<DurationPickerEvent, TimeSpanChanged> {
  DurationPickerBloc(this.editGameModeBloc, this.playerIndex, this.durationType, this.initialTimeSpan){
    durationPartBlocs = <int, DurationPartBloc>{};
    currentTimeSpan = initialTimeSpan;
  }
  Map<int, DurationPartBloc> durationPartBlocs;
  final EditGameModeBloc editGameModeBloc;
  final int playerIndex;
  final DurationType durationType;
  final TimeSpan initialTimeSpan;
  TimeSpan currentTimeSpan;

  @override
  TimeSpanChanged get initialState => TimeSpanChanged(initialTimeSpan);

  DurationPartBloc createDurationPartBloc(int durationPartIndex){
    final int initialValue = repository
          .currentlyEditedGameMode
          .playerConfigurations[playerIndex]
          .durations[durationType][durationPartIndex];
    final DurationPartBloc durationPartBloc = DurationPartBloc(initialValue);
    durationPartBlocs[durationPartIndex] = durationPartBloc;
    return durationPartBloc;
  }

  TimeSpan getTimeSpanFromDurationPickers(){
    final int hours = durationPartBlocs[0].currentValue;
    final int minutes = durationPartBlocs[1].currentValue;
    final int seconds = durationPartBlocs[2].currentValue;

    final TimeSpan newTimeSpan =
        TimeSpan(hours, minutes, seconds);
    return newTimeSpan;
  }

  @override
  Stream<TimeSpanChanged> mapEventToState(
    DurationPickerEvent event,
  ) async* {
    if(event is TimeSpanChangedEvent){
      currentTimeSpan = event.newTimeSpan;
      yield TimeSpanChanged(currentTimeSpan);
    }
  }
}
