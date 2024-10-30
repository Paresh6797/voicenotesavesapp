import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../logic/debug/app_bloc_observer.dart';
import '../../presentation/routers/app_router.dart';
import '../themes/app_theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return kReleaseMode ? _releaseWidget(context) : _debugWidget(context);
  }
}

// /// release mode material app.
_releaseWidget(BuildContext context) => MaterialApp(
      title: "Voice Note App",
      theme: appLightTheme(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.navigatorKey,
      initialRoute: AppRouter.login,
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        var responsiveChild = _responsiveWrapperWidget(context, child!);
        return responsiveChild;
      },
    );
//
// /// debug mode material app.
_debugWidget(BuildContext context) => BlocOverrides.runZoned(
    () => MaterialApp(
          title: "Voice Note App",
          useInheritedMediaQuery: true,
          theme: appLightTheme(context),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          navigatorKey: AppRouter.navigatorKey,
          initialRoute: AppRouter.login,
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: (context, child) {
            var responsiveChild = _responsiveWrapperWidget(context, child!);
            return responsiveChild;
          },
        ),
    blocObserver: AppBlocObserver());

/// used to make responsive. set breakpoint here.
_responsiveWrapperWidget(BuildContext context, Widget child) =>
    ResponsiveBreakpoints.builder(
      child: child,
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
