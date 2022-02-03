import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/BrandModel.dart';
import 'package:http/http.dart'as http;
class RequestService{
  late FormData formData;
  String _BASE_URL="https://carrestfulapi.azurewebsites.net/api/brands/";

  RequestService(){
    formData=FormData();
  }
  Future<List<BrandModel>?> getData() async{
   try{
     var _response = await http.get(Uri.parse(_BASE_URL));
     if(_response.statusCode==200){
       final parsed = json.decode(_response.body).cast<Map<String, dynamic>>();
       return parsed.map<BrandModel>((json) => BrandModel.fromJson(json)).toList();
     }
     return null;
   }on Exception catch(ex){
     print(ex.toString());
   }
  }

  Future<bool?> sendData(file,String nameText,String madebyText) async {
    if(file==null){
      formData= FormData.fromMap({
        "name": nameText,
        "madeby": madebyText,
      });
    }else {
      formData = FormData.fromMap({
        "name": nameText,
        "madeby": madebyText,
        'image': await MultipartFile.fromFile(file.path)
      });
    }
    final response = await Dio().post(_BASE_URL, data: formData);
    if(response.statusCode==201){
      return true;
    }else{
      return false;
    }
  }
  Future<bool?> updateData(file,int id,String nameText,String madebyText) async {
    if(file==null){
      formData= FormData.fromMap({
        "id":id,
        "name": nameText,
        "madeby": madebyText,
      });
    }else {
      formData = FormData.fromMap({
        "id":id,
        "name": nameText,
        "madeby": madebyText,
        'image': await MultipartFile.fromFile(file.path)
      });
    }
    final response = await Dio().put("$_BASE_URL$id", data: formData,queryParameters: {
       "id":id,
    });
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
  Future<bool?> deleteData(int id) async {
      formData= FormData.fromMap({
        "id":id,
      });
    final response = await Dio().delete("$_BASE_URL$id", data: formData,queryParameters: {
      "id":id,
    });
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
}
