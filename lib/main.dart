// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:_final/Repositories/DataService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final Dio dio = Dio();
  DataService dataService = DataService();

  String username = 'Conner';
  String password = '123';
  


  void _login() async {
    // Fetch saved credentials
    dataService.AddItem('username', username);
    dataService.AddItem('password', password);
    String? savedUsername = await dataService.SecureStorage.read(key: username);
    String? savedPassword = await dataService.SecureStorage.read(key: 'password');

    // Check if username exists
    if (savedUsername == null || savedUsername.isEmpty) {
      _showSnackBar('Username does not exist');
      return;
    }

    // Check if password is correct
    if (savedPassword != passwordController.text) {
      _showSnackBar('Incorrect password');
      return;
    }

    // Password is correct, show success message
    _showSnackBar('Login success');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

    void _navigateToAboutPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Log In'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: InkWell(
              onTap: _navigateToAboutPage,
              child: Text(
                'About',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text('This app will allow you to select information about cats. The information that will be provided are Facts about these cats and their breeds. When selecting information about breeds you will be able to know their breed, country, origin, coat, and pattern. For facts you can select one or many facts to be displayed at once. This app is useful since the it can be used to exapnd knowledge of cats. This can also be used as a template for other purposes of the animal. \n  Developed by Conner Mokhtary for CMSC 2204',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ),
    );
  }
}
