import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simple_chess_clock/main.dart';
import './bloc.dart';

class ConfigurationsBloc
    extends Bloc<ConfigurationsEvent, ConfigurationsState> {

  

  @override
  ConfigurationsState get initialState =>
      InitialConfigurationsState(repository.getconfigurations);

  @override
  Stream<ConfigurationsState> mapEventToState(
    ConfigurationsEvent event,
  ) async* {
    // if (event is EditDurationEvent) {
    //   yield EditDurationState();
    // }
  }

  
}
