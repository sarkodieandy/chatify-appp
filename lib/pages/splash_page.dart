import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
// Services
import '../services/navigation_services.dart';
import '../services/media_services.dart';
import '../services/cloud_storage_service.dart';
import '../services/database_services.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    Key? key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then(
      (_) {
        _setup().then(
          (_) => widget.onInitializationComplete(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpShareChat',
      theme: ThemeData(
        dialogBackgroundColor: const Color.fromRGBO(36, 35, 49, 0.1),
        scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 0.1),
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await Firebase.initializeApp();
      _registerServices();
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationServices>(
      NavigationServices(),
    );
    GetIt.instance.registerSingleton<MediaService>(
      MediaService(),
    );
    GetIt.instance.registerSingleton<CloudStorageService>(
      CloudStorageService(),
    );
    GetIt.instance.registerSingleton<DatabaseServices>(
      DatabaseServices(),
    );
  }
}
