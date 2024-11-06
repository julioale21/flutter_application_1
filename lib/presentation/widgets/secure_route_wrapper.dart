import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/blocs/screenshot_protection_cubit/screenshot_protection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecureRouteWrapper extends StatefulWidget {
  final Widget child;
  final String routeName;

  const SecureRouteWrapper({
    required this.child,
    required this.routeName,
    super.key,
  });

  @override
  State<SecureRouteWrapper> createState() => _SecureRouteWrapperState();
}

class _SecureRouteWrapperState extends State<SecureRouteWrapper> {
  @override
  void initState() {
    super.initState();
    context
        .read<ScreenshotProtectionCubit>()
        .addProtectedRoute(widget.routeName);
    context.read<ScreenshotProtectionCubit>().enableProtection();
  }

  @override
  void dispose() {
    context
        .read<ScreenshotProtectionCubit>()
        .removeProtectedRoute(widget.routeName);
    // Solo deshabilitamos la protección si no hay más rutas protegidas
    if (context
        .read<ScreenshotProtectionCubit>()
        .state
        .protectedRoutes
        .isEmpty) {
      context.read<ScreenshotProtectionCubit>().disableProtection();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
