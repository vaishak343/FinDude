import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'utils/color_scheme.dart';
import 'views/views.dart' show HomeView;

void main() {
  runApp(const MyApp());
}

final _routeConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.light,
      routerConfig: _routeConfig,
    );
  }
}
