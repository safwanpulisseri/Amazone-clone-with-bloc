import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shoping_app_with_bloc/model/model_class.dart';

Future<List<ProductModel>> getallproducts() async {
  const url =
      'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';
  Uri uri = Uri.parse(url);

  final respose = await http.get(uri);

  final json = jsonDecode(respose.body) as List;

  final result = json.map((e) => ProductModel.fromjson(e)).toList();

  return result;
}
