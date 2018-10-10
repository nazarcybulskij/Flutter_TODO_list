import 'package:flutter/material.dart';

class StatCounter extends StatelessWidget {
  final int numActive;
  final int numCompited;

  const StatCounter(
      {@required this.numActive, @required this.numCompited, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Compited Todos",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text("${numCompited}",
                style: Theme.of(context).textTheme.subhead),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child:
                Text("Active Todos", style: Theme.of(context).textTheme.title),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text("${numActive}",
                style: Theme.of(context).textTheme.subhead),
          ),
        ],
      ),
    );
  }
}
