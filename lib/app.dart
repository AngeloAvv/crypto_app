import 'package:crypto_app/di/dependency_injector.dart';
import 'package:crypto_app/features/routing/app_router.dart';
import 'package:crypto_app/features/theme/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final _router = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) => DependencyInjector(
        child: MaterialApp.router(
          title: 'Crypto App',
          debugShowCheckedModeBanner: false,
          routeInformationParser: _router.defaultRouteParser(),
          routerDelegate: _router.delegate(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
            extensions: [
              ColorExtension(
                rising: Colors.green[800],
                falling: Colors.red[800],
                neutral: Colors.grey,
              ),
            ],
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              toolbarHeight: 80.0,
            ),
            dividerTheme: const DividerThemeData(
              thickness: 1.0,
              indent: 16.0,
              endIndent: 16.0,
            ),
          ),
        ),
      );
}
