import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EditGameModeState extends Equatable {
  const EditGameModeState();
}

class SwitchSameSettingsState extends EditGameModeState {
  const SwitchSameSettingsState(this.sameSettings);  
  
  final bool sameSettings;

  @override
  List<Object> get props => <Object>[sameSettings];
}