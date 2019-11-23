import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_chess_clock/gamemode.dart';

@immutable
abstract class ConfigurationsEvent extends Equatable {
  const ConfigurationsEvent();
}

class EditConfigurationEvent extends ConfigurationsEvent{
  const EditConfigurationEvent(this.gameMode);

  final GameMode gameMode;

  @override
  List<Object> get props => <Object>[gameMode];
}