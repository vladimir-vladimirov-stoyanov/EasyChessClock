import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_chess_clock/gamemode.dart';

@immutable
abstract class ConfigurationsState extends Equatable {
  const ConfigurationsState();
}

class InitialConfigurationsState extends ConfigurationsState {
  const InitialConfigurationsState(this.initialConfigurations);
  final List<GameMode> initialConfigurations;

  @override
  List<Object> get props => <Object>[initialConfigurations];
}