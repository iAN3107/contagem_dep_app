import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  Usuario({
    required this.cod,
    required this.nome,
  });

  int cod;
  String nome;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    cod: json["cod"],
    nome: json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "nome": nome,
  };
}
