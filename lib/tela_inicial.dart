
import 'dart:io';

import 'package:contracheque/ficha.dart';
import 'package:contracheque/login_page.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buttons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: true,
        leading:  IconButton(
          icon: const BackButtonIcon(),
          onPressed:() =>  Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage(),
            )
          )
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            const Text(
              'Olá, Kellton. \nO Que você deseja fazer?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(), fixedSize: const Size(200, 60)),
              child: const Text('Consultar contracheque'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:() =>  Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Ficha())),
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(), fixedSize: const Size(200, 60)),
              child: const Text('Consultar ficha financeira'),
            ),
          ],
        ),
      ),
    );
  }
}
