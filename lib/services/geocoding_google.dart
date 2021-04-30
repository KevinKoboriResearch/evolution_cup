


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mewnu/services/via_cep.dart';
import 'package:mewnu/models/checkout/result_cep.dart';

const String cep = '71650075';
const String keyAPI = 'AIzaSyBBWKFtzYc6Vl__rkHpqepUa8WoqEyiRK8';

class GeocodingGoogleService {
  Future<ResultCep> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final ResultCep result = await ViaCepService().fetchCep(cep: cleanCep);
    final dynamic geolocation = await getGeolocationFromCep(cleanCep);
    result.lat = double.parse(geolocation['lat'].toString());
    result.lng = double.parse(geolocation['lng'].toString());
    return result;
  }

  Future<dynamic> getGeolocationFromCep(String cleanCep) async {
    final endpoint =
        "https://maps.googleapis.com/maps/api/geocode/json?&address=$cleanCep&key=$keyAPI";

    final response = await http.get(Uri.parse(endpoint));

    final dynamic data = json.decode(response.body);

    return data['results'][0]['geometry']['location'];
  }
}
