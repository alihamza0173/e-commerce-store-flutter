import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_store/application/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InternetConnectivityProvider extends ChangeNotifier {
  StreamSubscription<ConnectivityResult>? subscription;

  void init(BuildContext context) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(days: 1),
            content: Text('No Internet connection'),
          ),
        );
      } else if (result == ConnectivityResult.vpn) {
        context.push(AppRoutes.vpnNotAllowed);
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });
  }
}

final internetConnectivityProvider =
    ChangeNotifierProvider((ref) => InternetConnectivityProvider());
