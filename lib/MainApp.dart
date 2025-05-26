import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smn/pages/pagina_inicial.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_lista_municipios.dart';
import 'package:smn/providers/provider_municipio.dart';
import 'package:smn/providers/provider_pronosticos.dart';
import 'package:smn/providers/provider_tema.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   final ThemeData temaClaro = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.pink.shade50,
  primaryColor: Colors.pinkAccent,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.pinkAccent,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.pinkAccent,
    onPrimary: Colors.pink,
    background: Colors.pink.shade100,
    onBackground: Colors.black,
    surface: Colors.pink.shade50,
    onSurface: Colors.black,
  ),
);

final ThemeData temaOscuro = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF0A1B2F), // azul celeste oscuro personalizado
  primaryColor: Colors.cyanAccent,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.cyan.shade700,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
  colorScheme: ColorScheme.dark(
    primary: Colors.cyanAccent,
    onPrimary: Colors.white,
    background: const Color(0xFF0A1B2F),
    onBackground: Colors.white,
    surface: const Color(0xFF123049),
    onSurface: Colors.white,
  ),
);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderTema(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderMunicipio(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderListaMunicipios(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderPronosticos(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderDias(),
        ),
      ],
      child: Builder(builder: (context) {
        return Consumer<ProviderTema>(builder: (context, tema, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: temaClaro,
            darkTheme: temaOscuro,
            themeMode: tema.temaActual,
            debugShowCheckedModeBanner: false,
            home: PaginaInicial(),
          );
        });
      }),
    );
  }
}
