import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'package:simple_chess_clock/playerside.dart';

class Game extends StatefulWidget {
  const Game();

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const RotatedBox(
              quarterTurns: 2,
              child: PlayerSide(0),
            ),
            createIconButton(),
            const PlayerSide(1),
          ],
        ),
      ),
    );
  }

  Widget createIconButton() {
    return BlocBuilder<GameBloc, GameState>(
        builder: (BuildContext context, GameState state) {
      bool isGameRunning;
      bool hasGameEnded = false;
      if (state is InitialGameState) {
        isGameRunning = state.isGameRunning;
      } else if (state is EndGameState){
        isGameRunning = false;
        hasGameEnded = true;
      }
      else{
        isGameRunning = true;
      }

      final IconData playPauseButtonIcon =
          isGameRunning ? Icons.pause : hasGameEnded ? Icons.replay : Icons.play_arrow;
      return IconButton(
          icon: Icon(playPauseButtonIcon),
          onPressed: () {
            final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
            if(hasGameEnded){
              gameBloc.add(RestartGameEvent());
            }
            else{
              gameBloc.add(StartStopGameEvent(!isGameRunning));
            }
          });
    });
  }
}
