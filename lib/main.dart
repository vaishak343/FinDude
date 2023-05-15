import 'package:dynamic_color/dynamic_color.dart';
import 'package:findude/views/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'views/views.dart' show HomeView;

void main() {
  runApp(
    BlocProvider(
      create: (context) => HomeCubit(),
      child: const MyApp(),
    ),
  );
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
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      if (lightDynamic != null && darkDynamic != null) {
        lightColorScheme = lightDynamic.harmonized();
        darkColorScheme = darkDynamic.harmonized();
      } else {
        // fallback schemes.
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C57A9), 
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFFBCC3FF),
          brightness: Brightness.dark,
        );
      }

      return BlocBuilder<HomeCubit, bool>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
            ),
            themeAnimationCurve: Curves.easeIn,
            themeAnimationDuration: const Duration(milliseconds: 300),
            routerConfig: _routeConfig,
          );
        },
      );
    });
  }
}
