part of 'screenshot_protection_cubit.dart';

class ScreenshotProtectionState extends Equatable {
  final bool isProtected;
  final List<String> protectedRoutes;

  const ScreenshotProtectionState({
    this.isProtected = false,
    this.protectedRoutes = const [],
  });

  ScreenshotProtectionState copyWith({
    bool? isProtected,
    List<String>? protectedRoutes,
  }) {
    return ScreenshotProtectionState(
      isProtected: isProtected ?? this.isProtected,
      protectedRoutes: protectedRoutes ?? this.protectedRoutes,
    );
  }

  @override
  List<Object> get props => [isProtected, protectedRoutes];
}
