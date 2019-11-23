import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DurationPartBloc extends Bloc<DurationPartBlocEvent, DurationPartChanged> {
  DurationPartBloc(this.initialValue){   
    currentValue = initialValue;
  }
  int initialValue;
  int currentValue;

  @override
  DurationPartChanged get initialState => DurationPartChanged(initialValue);

  @override
  Stream<DurationPartChanged> mapEventToState(
    DurationPartBlocEvent event,
  ) async* {
    if(event is DurationPartChangedEvent){
      currentValue = event.value;
      yield DurationPartChanged(currentValue);
    }
  }
}
