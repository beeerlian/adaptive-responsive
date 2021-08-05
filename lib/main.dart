

import 'package:flutter/material.dart';
import 'package:latihan_adaptive_respnsive_app/model/employe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 500) {
            return WideView();
          } else {
            return SmallView();
          }
        },
      ),
    );
  }
}

class WideView extends StatefulWidget {
  @override
  _WideViewState createState() => _WideViewState();
}

class _WideViewState extends State<WideView> {
  Employe? _employe;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListOfEmployes(onEmpoyeTap: (employe) {
            setState(() => _employe = employe);
          }),
          flex: 2,
        ),
        Expanded(
          child: _employe == null
              ? Placeholder()
              : DetailEmploye(_employe!),
          flex: 3,
        ),
      ],
    );
  }
}

class SmallView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListOfEmployes(
      onEmpoyeTap: (employe) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(),
              body: DetailEmploye(employe),
            ),
          ),
        );
      },
    );
  }
}

class ListOfEmployes extends StatelessWidget {
  final void Function(Employe)? onEmpoyeTap;
  const ListOfEmployes({required this.onEmpoyeTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var employe in employes)
          ListTile(
            title: Text(employe.name),
            onTap: () => onEmpoyeTap!(employe),
          )
      ],
    );
  }
}

class DetailEmploye extends StatelessWidget {
  final Employe employe;
  DetailEmploye(this.employe);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          employe.email== null?Text("data kosong"):Text(employe.email),
          employe.location== null?Text("data kosong"):Text(employe.location),
          RaisedButton(onPressed: (){
            Navigator.of(context).pop();
          })
        ],
      ),
    );
  }
}
