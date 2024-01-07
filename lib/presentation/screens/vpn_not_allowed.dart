import 'package:flutter/material.dart';

class VpnNotAllowed extends StatelessWidget {
  const VpnNotAllowed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('VPN not allowed'),
          const Text('Please turn off your VPN and try again'),
          FilledButton.tonal(onPressed: () {}, child: const Text('Retry')),
        ],
      ),
    );
  }
}
