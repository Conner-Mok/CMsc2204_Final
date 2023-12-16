import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
  
  const String BaseUrl = "https://catfact.ninja";
  class UserClient{
    Dio dio = Dio(BaseOptions(baseUrl: BaseUrl));
    
  Future<List<Map<String, dynamic>>> getCatBreeds() async {
    try {
      var response = await dio.get("/breeds");
      if (response.statusCode == 200) {
        final List<dynamic> breeds = response.data['data'];
        return List.generate(
          breeds.length,
          (index) => {
            'breed': breeds[index]['breed'],
            'country': breeds[index]['country'],
            'origin': breeds[index]['origin'],
            'coat': breeds[index]['coat'],
            'pattern': breeds[index]['pattern'],
          },
        );
      } else {
        
        print('Failed to load cat breeds');
        return []; 
      }
    } catch (e) {
      
      print(e);
      return [];
    }
  }

  }