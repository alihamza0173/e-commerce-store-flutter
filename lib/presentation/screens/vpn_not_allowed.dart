import 'package:flutter/material.dart';

class VpnNotAllowed extends StatelessWidget {
  const VpnNotAllowed({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('VPN not allowed'),
      ),
    );
  }
}
