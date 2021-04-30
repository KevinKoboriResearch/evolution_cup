


import 'package:http/http.dart' as http;
import 'package:mewnu/models/checkout/result_cep.dart';

class ViaCepService {
  Future<ResultCep> fetchCep({String cep}) async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
