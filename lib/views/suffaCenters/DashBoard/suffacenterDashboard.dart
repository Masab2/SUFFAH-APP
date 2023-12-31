import 'package:flutter/material.dart';

class SuffaCenterDashboard extends StatefulWidget {
  const SuffaCenterDashboard({super.key});

  @override
  State<SuffaCenterDashboard> createState() => _SuffaCenterDashboardState();
}

class _SuffaCenterDashboardState extends State<SuffaCenterDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: Text('Suffa Center'))],
      ),
    );
  }
}
