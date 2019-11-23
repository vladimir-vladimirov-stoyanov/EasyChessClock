import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class DurationPartChanged extends Equatable {
   const DurationPartChanged(this.selectedValue);

  final int selectedValue;

  @override
  List<Object> get props => <Object>[selectedValue];
}
