

import 'dart:async';

import 'package:flutter/material.dart';

import 'name_viewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Name Viewer'),
        ),
        body: Center(
          child: NameViewer(),
        ),
      ),
    );
  }
}

class NameViewer extends StatefulWidget {
  @override
  _NameViewerState createState() => _NameViewerState();
}

class _NameViewerState extends State<NameViewer> {
  late final NameBloc _nameBloc;

  @override
  void initState() {
    super.initState();
    _nameBloc = NameBloc();
  }

  @override
  void dispose() {
    _nameBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<int>(
          stream: _nameBloc.currentIndex,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                _nameBloc.getName(snapshot.data!),
                style: TextStyle(fontSize: 24),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _nameBloc.previousName();
              },
              child: Text('<'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                _nameBloc.nextName();
              },
              child: Text('>'),
            ),
          ],
        ),
        SizedBox(height: 20),
        StreamBuilder<bool>(
          stream: _nameBloc.atEnd,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Names came to the end'),
                  ),
                );
              });
            }
            return Container(); // Placeholder, you can replace it with your desired UI
          },
        ),
      ],
    );
  }
}

