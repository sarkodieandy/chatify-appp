import 'package:flutter/material.dart';
import 'package:gee/pages/login_page.dart';
import 'package:provider/provider.dart';
import './pages/splash_page.dart';
import './services/navigation_services.dart';
import './providers/authentication_provider.dart';
import './pages/home_page.dart';
import './pages/register_page.dart';
import './pages/chat_page.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          const MainApp(),
        );
      },
    ),
  );
}

// finishing the splash screen
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext context) {
            return AuthenticationProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'ExpShareChat',
        theme: ThemeData(
          dialogBackgroundColor: const Color.fromRGBO(36, 35, 49, 0.1),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 0.1),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationServices.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext context) => const LoginPage(),
          '/register': (BuildContext context) => const RegisterPage(),
          '/home': (BuildContext context) => const HomePage(),
          '/chat': (BuildContext context) => ChatsPage(),
        },
      ),
    );
  }
}
