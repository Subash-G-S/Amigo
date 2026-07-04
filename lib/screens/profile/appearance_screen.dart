import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() =>
      _AppearanceScreenState();
}

class _AppearanceScreenState
    extends State<AppearanceScreen> {

  ThemeMode mode = ThemeMode.system;

  MaterialColor selectedColor = Colors.indigo;

  final colors = [
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

mode = themeProvider.themeMode;
selectedColor = themeProvider.primaryColor;

    return Scaffold(
        
      appBar: AppBar(
        title: const Text("Appearance"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          const Text(
            "Theme",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          RadioListTile(
            value: ThemeMode.system,
            groupValue: mode,
            title: const Text("System Default"),
            onChanged: (value) {
              themeProvider.setTheme(value!);
            },
          ),

          RadioListTile(
            value: ThemeMode.light,
            groupValue: mode,
            title: const Text("Light"),
            onChanged: (value) {
              themeProvider.setTheme(value!);
            },
          ),

          RadioListTile(
            value: ThemeMode.dark,
            groupValue: mode,
            title: const Text("Dark"),
            onChanged: (value) {
              themeProvider.setTheme(value!);
            },
          ),

          const SizedBox(height: 30),

          const Text(
            "Accent Color",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: colors.map((color) {

              return GestureDetector(
                onTap: () {

                  themeProvider.setColor(color);

                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: color,
                  child: selectedColor == color
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              );

            }).toList(),
          ),
        ],
      ),
    );
  }
}