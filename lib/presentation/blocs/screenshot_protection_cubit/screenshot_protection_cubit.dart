import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'screenshot_protection_state.dart';

class ScreenshotProtectionCubit extends Cubit<ScreenshotProtectionState> {
  ScreenshotProtectionCubit() : super(const ScreenshotProtectionState());

  void addProtectedRoute(String route) {
    final currentRoutes = List<String>.from(state.protectedRoutes);
    if (!currentRoutes.contains(route)) {
      currentRoutes.add(route);
      emit(state.copyWith(protectedRoutes: currentRoutes));
    }
  }

  void removeProtectedRoute(String route) {
    final currentRoutes = List<String>.from(state.protectedRoutes);
    currentRoutes.remove(route);
    emit(state.copyWith(protectedRoutes: currentRoutes));
  }

  void enableProtection() {
    if (Platform.isAndroid) {
      // ignore: constant_identifier_names
      const FLAG_SECURE = 0x00002000;
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top],
      );
      SystemChannels.platform
          .invokeMethod('SystemUiMode.setEnabledSystemUIMode', FLAG_SECURE);
    }
    emit(state.copyWith(isProtected: true));
  }

  void disableProtection() {
    if (Platform.isAndroid) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
    emit(state.copyWith(isProtected: false));
  }

  bool isRouteProtected(String route) {
    return state.protectedRoutes.contains(route);
  }
}
