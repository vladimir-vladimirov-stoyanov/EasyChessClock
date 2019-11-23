import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'package:simple_chess_clock/gamemode.dart';
import 'package:simple_chess_clock/repository.dart';
import 'package:simple_chess_clock/routegenerator.dart';
import 'package:simple_chess_clock/sizeConfig.dart';

void main() {
  runApp(SimpleChessClockApp());
}

Repository repository = Repository();
ConfigurationsBloc configurationsBloc = ConfigurationsBloc();
ThemeBloc themeBloc = ThemeBloc();

class SimpleChessClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConfigurationsBloc>(
          builder: (BuildContext context) => configurationsBloc,
        ),
        BlocProvider<ThemeBloc>(
          builder: (BuildContext context) => themeBloc,
        ),
      ],
      child: _buildMaterialAppWithTheme(),
    );
  }

  BlocBuilder<ThemeBloc, ThemeState> _buildMaterialAppWithTheme() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: state.themeData,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const MyHomePage(title: 'Simple Chess Clock'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> playerNames = <String>['Player 1', 'Player 2'];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          BlocBuilder<ThemeBloc, ThemeState>(
            bloc: BlocProvider.of<ThemeBloc>(context),
            builder: (BuildContext context, ThemeState state) {
              return Switch(
                value: state.isDark,
                onChanged: (bool value) {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(value));
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
        bloc: configurationsBloc,
        builder: (BuildContext context, ConfigurationsState state) {
          if (state is InitialConfigurationsState) {
            return buildListView(state.initialConfigurations);
          } else {
            return ListView();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewGameMode,
        child: Icon(Icons.add),
      ),
    );
  }

  ListView buildListView(List<GameMode> modes) {
    return ListView.builder(
      itemCount: modes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.timer),
            title: Row(
              children: <Widget>[
                Expanded(child: Text(modes[index].name, style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(width: 5,),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Icon(Icons.play_arrow),
                  onPressed: () => startGame(modes[index]),
                ),
                const SizedBox(width: 5,),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Icon(Icons.edit),
                  onPressed: () => createEditGameModeScreen(modes[index]),
                ),
              ],
            ),
            
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    configurationsBloc.close();
  }

  void createNewGameMode(){
    repository.currentlyEditedGameMode = GameMode.empty();
    final EditGameModeBloc editGameModeBloc = EditGameModeBloc();
    Navigator.of(context).pushNamed(
            '/add', arguments: editGameModeBloc 
          );
  }

  void startGame(GameMode mode) {
    final GameBloc gameBloc = GameBloc(mode.copyGameMode());
    Navigator.of(context).pushNamed(
      '/game',
      arguments: gameBloc,
    );
  }

  void createEditGameModeScreen(GameMode mode) {
    repository.currentlyEditedGameMode = mode;
    final EditGameModeBloc editGameModeBloc = EditGameModeBloc();

    Navigator.of(context).pushNamed('/edit', arguments: editGameModeBloc);
  }
}
