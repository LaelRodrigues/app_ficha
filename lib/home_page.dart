import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'check_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Página inicial',
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () {
                sair();
              },
              child: Text('Sair'))
        ],
      ),
    );
  }

  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CheckPage(),
            ),
          ),
        );
  }
}
