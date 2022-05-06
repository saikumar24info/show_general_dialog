// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AnimatedDialog',
        ),
      ),
      body: Center(
        child: Column(children: [
          ElevatedButton(
              onPressed: () => _rotateDialog(), child: Text('Rorate Dialog')),
          ElevatedButton(
              onPressed: () => _scaleDialog(context),
              child: Text('Scale Dialog'))
        ]),
      ),
    );
  }

  Widget _dialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Alert :"),
      content: const Text('Your Jio plan is expiry soon.'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Okay"))
      ],
    );
  }

  void _rotateDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.rotate(
          angle: math.radians(a1.value * 360),
          child: _dialog(ctx),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Future<Object?> _scaleDialog(BuildContext context) {
    return showGeneralDialog(
        context: context,
        transitionDuration: Duration(microseconds: 300),
        transitionBuilder: (context, a1, a2, child) {
          return Transform.scale(
            scale: Curves.easeInToLinear.transform(a1.value),
            child: _dialog(context),
          );
        },
        pageBuilder: (context, a1, a2) {
          return Container();
        });
  }
}
