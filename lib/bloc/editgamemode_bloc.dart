import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simple_chess_clock/bloc/durationpicker_bloc.dart';
import 'package:simple_chess_clock/main.dart';
import 'package:simple_chess_clock/playerdata.dart';
import './bloc.dart';

class EditGameModeBloc extends Bloc<EditGameModeEvent, EditGameModeState> {
  EditGameModeBloc() {
    durationPickerBlocs = <DurationType, List<DurationPickerBloc>>{
      DurationType.Time: List<DurationPickerBloc>.filled(2, null),
      DurationType.Increment: List<DurationPickerBloc>.filled(2, null),
    };
  }
  
  Map<DurationType, List<DurationPickerBloc>> durationPickerBlocs;
  String currentName = repository.currentlyEditedGameMode.name;

  void updateCurrentlyEditedGameMode() {
    repository.currentlyEditedGameMode.name = currentName;
    if(!repository.getconfigurations.contains(repository.currentlyEditedGameMode)){
      repository.getconfigurations.add(repository.currentlyEditedGameMode);
    }
    updatePlayerConfigurationForDurationType(DurationType.Time);
    updatePlayerConfigurationForDurationType(DurationType.Increment);  
  }

  void updatePlayerConfigurationForDurationType(DurationType durationType){
    for (int i = 0; i < durationPickerBlocs[durationType].length; i++) {
      
      if(i == 1 && repository.currentlyEditedGameMode.sameSettingsForBothPlayers){
        final DurationPickerBloc currentBloc = durationPickerBlocs[durationType][i - 1];
        repository.currentlyEditedGameMode.playerConfigurations[i].durations[durationType] = currentBloc.currentTimeSpan;
      }
      else{
        final DurationPickerBloc currentBloc = durationPickerBlocs[durationType][i];
        repository.currentlyEditedGameMode.playerConfigurations[i].durations[durationType] = currentBloc.currentTimeSpan;
      }
      
    }
  }

  DurationPickerBloc createDurationPickerBloc(
      int playerIndex, DurationType durationType) {
    final TimeSpan initialTimeSpan = repository.currentlyEditedGameMode
        .playerConfigurations[playerIndex].durations[durationType];
    final DurationPickerBloc durationPickerBloc =
        DurationPickerBloc(this, playerIndex, durationType, initialTimeSpan);
    durationPickerBlocs[durationType][playerIndex] = durationPickerBloc;
    return durationPickerBloc;
  }

  @override
  EditGameModeState get initialState => SwitchSameSettingsState(repository.currentlyEditedGameMode.sameSettingsForBothPlayers);

  @override
  Stream<EditGameModeState> mapEventToState(
    EditGameModeEvent event,
  ) async* {
      if(event is SwitchSameSettingsEvent){
        repository.currentlyEditedGameMode.sameSettingsForBothPlayers = event.sameSettings;
     			yield SwitchSameSettingsState(event.sameSettings);
     	}
       
  }

  String checkIsCurrentlyEditedGameModeValid() {
    if(currentName.isEmpty){
      return 'Name cannot be empty';
    }
    else if(!arePlayerTimesMoreThanZero()){
      return 'Player cannot have less than 5s time';
    }
    else{
      return '';
    }
  }

  bool arePlayerTimesMoreThanZero(){
    for (int i = 0; i < durationPickerBlocs[DurationType.Time].length; i++) {
      if(i == 1 && repository.currentlyEditedGameMode.sameSettingsForBothPlayers){
        final DurationPickerBloc currentBloc = durationPickerBlocs[DurationType.Time][i - 1];
         if(currentBloc.currentTimeSpan.getDuration().inSeconds < 5){
           return false;
         }
      }
      else{
        final DurationPickerBloc currentBloc = durationPickerBlocs[DurationType.Time][i];
        if(currentBloc.currentTimeSpan.getDuration().inSeconds < 5){
           return false;
         }
      }
    }

    return true;
  }
}
