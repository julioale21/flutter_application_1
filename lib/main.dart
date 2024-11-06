import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/router/app_router.dart';
import 'package:flutter_application_1/presentation/blocs/screenshot_protection_cubit/screenshot_protection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScreenshotProtectionCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}