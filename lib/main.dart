import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:will_messages/screens/auth_screen.dart';
import 'package:will_messages/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.pink,
      backgroundColor: Colors.pink,
    );
    return MaterialApp(
      title: 'WillMessages',
      theme: theme.copyWith(
        // NOTICE might not work
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
