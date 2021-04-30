import 'dart:convert';

class ResultCep {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;
  double lat;
  double lng;

  ResultCep({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.unidade,
    this.ibge,
    this.gia,
    this.lat,
    this.lng,
  });

  factory ResultCep.fromJson(String str) => ResultCep.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory ResultCep.fromMap(Map<String, dynamic> json) => ResultCep(
        cep: json["cep"] as String,
        logradouro: json["logradouro"] as String,
        complemento: json["complemento"] as String,
        bairro: json["bairro"] as String,
        localidade: json["localidade"] as String,
        uf: json["uf"] as String,
        unidade: json["unidade"] as String,
        ibge: json["ibge"] as String,
        gia: json["gia"] as String,
        lat: json["lat"] as double,
        lng: json["lng"] as double,
      );

  Map<String, dynamic> toMap() => {
        "cep": cep,
        "logradouro": logradouro,
        "complemento": complemento,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
        "unidade": unidade,
        "ibge": ibge,
        "gia": gia,
        "lat": lat,
        "lng": lng,
      };
}
