import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'providers/post_provider.dart';
import 'providers/theme_provider.dart';

import 'theme/app_theme.dart';

import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(const AmigoApp());
}

class AmigoApp extends StatelessWidget {
  const AmigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => PostProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),

      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: AppTheme.light(
              themeProvider.primaryColor,
            ),

            darkTheme: AppTheme.dark(
              themeProvider.primaryColor,
            ),

            themeMode: themeProvider.themeMode,

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}