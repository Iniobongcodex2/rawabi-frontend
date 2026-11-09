import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/services_screen.dart';
import 'screens/documents_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/support_screen.dart';

void main() {
  runApp(const RawabiApp());
}

class RawabiApp extends StatelessWidget {
  const RawabiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder listens for language changes
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Rawabi Mobile',
          debugShowCheckedModeBanner: false,
          locale: locale, // Sets the language
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            primaryColor: const Color(0xFF1E3A8A),
            scaffoldBackgroundColor: Colors.grey[50],
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ServicesScreen(),
    const DocumentsScreen(),
    const SupportScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // We get the translator here so it can translate the bottom bar
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard), 
            label: loc.translate('home')
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.grid_view), 
            label: loc.translate('services')
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.folder), 
            label: loc.translate('documents')
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat), 
            label: loc.translate('support')
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person), 
            label: loc.translate('profile')
          ),
        ],
      ),
    );
  }
}