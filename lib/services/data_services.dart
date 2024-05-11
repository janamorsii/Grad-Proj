import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelista_flutter/model/data_model.dart';
//define DataServices part of the cubit
class DataServices{
  String baseUrl="http://mark.bslmeiyu.com/api";
  Future<List<DataModel>>getInfo() async{
    var apiUrl='/getplaces';
    http.Response res= await http.get(Uri.parse(baseUrl+apiUrl));
    try{
        if (res.statusCode==200){
          List<dynamic>list= json.decode(res.body); //decoding the body(of api) becuase flutter doesnt understand json, only map
          print(list);
          return list.map((e) =>DataModel.fromJson(e)).toList(); // (e) would point to the attributes belonging to each id(break down the full API into pieces by id number), then pass it to list 
        }else{
          return <DataModel>[]; //if its not true retrun empty as well
        }
    }catch(e){
        print(e);
        return <DataModel>[]; //return empty if we have an error
    }
  }
}