import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/secure_route_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SecureRouteWrapper(
      routeName: '/home',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
