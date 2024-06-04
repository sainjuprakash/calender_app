import 'package:flutter/material.dart';

class FallBackPage extends StatefulWidget {
  const FallBackPage({super.key});

  @override
  State<FallBackPage> createState() => _FallBackPageState();
}

class _FallBackPageState extends State<FallBackPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Something went wrong "),
      ),
    );
  }
}
