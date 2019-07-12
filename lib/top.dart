import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/menu.dart';
import 'state.dart';

class _TopAppBlocState extends State<TopAppBloc> {
  @override
  Widget build(BuildContext context) {
    final update = Provider.of<UpdateAction>(context);
    return Container(
        color: const Color(0xffcecece),
        child: Column(children: <Widget>[
          const TopMenu(),
          Container(
              height: 1.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: const Text("")),
          Row(
            children: <Widget>[
              Expanded(
                child: update.state.appBarZone,
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 30.0, 0),
                    child: update.state.statusZone,
                  )
                ],
              )
            ],
          ),
          Container(
              height: 1.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: const Text("")),
        ]));
  }
}

class TopAppBloc extends StatefulWidget {
  @override
  _TopAppBlocState createState() => _TopAppBlocState();
}
