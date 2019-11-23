import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'bloc/durationpartbloc_event.dart';

class DurationPartPicker extends StatefulWidget {
  const DurationPartPicker();

  @override
  _DurationPartPickerState createState() => _DurationPartPickerState();
}

class _DurationPartPickerState extends State<DurationPartPicker> {
  _DurationPartPickerState();
  final double _itemExtent = 40;
  DurationPartBloc durationPartBloc;
  @override
  Widget build(BuildContext context) {
    durationPartBloc = BlocProvider.of<DurationPartBloc>(context);
    return BlocBuilder<DurationPartBloc, DurationPartChanged>(
      bloc: durationPartBloc,
      builder: (BuildContext context, DurationPartChanged state) {
        return buildListWheelScrollView(state.selectedValue);
      },
    );
  }

  Widget buildListWheelScrollView(int value) {
    final FixedExtentScrollController listController =
        FixedExtentScrollController(initialItem: value);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) =>
          alignDurationPartsWhenUserStopsScrolling(
        scrollNotification,
        listController,
      ),
      child: ListWheelScrollView(
        clipToSize: true,
        itemExtent: _itemExtent,
        controller: listController,
        onSelectedItemChanged: (int value) =>
            dispatchDurationPartChanged(value),
        children: createValuesToChooseFrom(value),
      ),
    );
  }

  List<Widget> createValuesToChooseFrom(int initialValue) {
    final List<Container> values = <Container>[];
    for (int index = 0; index < 60; index++) {
      final bool isSelected = index == initialValue;
      final Color backgroundColor = isSelected
          ? Theme.of(context).accentColor
          : Theme.of(context).secondaryHeaderColor;
      final TextStyle style = isSelected
          ? Theme.of(context).textTheme.body2
          : Theme.of(context).textTheme.body1;

      values.add(
        Container(
          width: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text(
              index.toString(),
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
      );
    }

    return values;
  }

  bool alignDurationPartsWhenUserStopsScrolling(
      ScrollNotification scrollNotification,
      FixedExtentScrollController listController) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction == ScrollDirection.idle) {
      listController.jumpTo(
          double.parse(listController.selectedItem.toString()) * _itemExtent);

      return true;
    }

    return false;
  }

  void dispatchDurationPartChanged(int value) {
    durationPartBloc.add(DurationPartChangedEvent(value));
  }

  @override
  void initState() {
    super.initState();
    durationPartBloc = BlocProvider.of<DurationPartBloc>(context);
  }

  @override
  void dispose() {
    durationPartBloc.close();
    super.dispose();
  }
}
