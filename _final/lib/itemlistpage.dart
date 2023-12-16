import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Repositories/UserClient.dart';
import 'CatDetails.dart';

void main() {
  runApp(const MyApp());
}

final UserClient userClient = UserClient();


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
      home: ItemListPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ItemListPage extends StatefulWidget {
  final UserClient userClient = UserClient();
  ItemListPage({super.key, required this.title});
  



  final String title;

  @override
  State<ItemListPage> createState() => _ItemListPage();
}

bool _loading = false;

class _ItemListPage extends State<ItemListPage> {


  List<Map<String, dynamic>> catBreeds = [];

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchCatBreeds();
  }

  Future<void> _fetchCatBreeds() async {
    try {
      List<Map<String, dynamic>> breeds = await UserClient().getCatBreeds();
      setState(() {
        catBreeds = breeds;
      });
    } catch (e) {
      print(e);
    }
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Breeds'),
      ),
      body: ListView.builder(
        itemCount: catBreeds.length,
        itemBuilder: (context, index) {
          final item = catBreeds[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Breed: ${item['breed']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatDetailPage(catBreed: item),
                  ),
                );
              },
            ),
          );
        },
      ),
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchCatBreeds();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cat breeds reloaded'),
            ),
          );
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
