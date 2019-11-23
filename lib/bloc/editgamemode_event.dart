import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EditGameModeEvent extends Equatable {
  const EditGameModeEvent();
}

class SwitchSameSettingsEvent extends EditGameModeEvent {
  const SwitchSameSettingsEvent(this.sameSettings);

  final bool sameSettings;

  @override
  List<Object> get props => <Object>[sameSettings];
}