import 'dart:convert';

List<ContagemPendentes> contagemPendentesFromJson(String str) => List<ContagemPendentes>.from(json.decode(str).map((x) => ContagemPendentes.fromJson(x)));

String contagemPendentesToJson(List<ContagemPendentes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContagemPendentes {
  ContagemPendentes({
    required this.cod,
    required this.deposito,
    required this.rua,
    required this.bloco,
    required this.nivel,
    required this.apartamento,
    required this.descricao,
    required this.fatorCaixa,
    required this.lote,
    required this.validade,
    required this.status,
  });

  int cod;
  int deposito;
  int rua;
  int bloco;
  int nivel;
  int apartamento;
  String descricao;
  int fatorCaixa;
  int lote;
  String validade;
  int status;

  factory ContagemPendentes.fromJson(Map<String, dynamic> json) => ContagemPendentes(
    cod: json["cod"],
    deposito: json["deposito"],
    rua: json["rua"],
    bloco: json["bloco"],
    nivel: json["nivel"],
    apartamento: json["apartamento"],
    descricao: json["descricao"],
    fatorCaixa: json["fatorCaixa"],
    lote: json["lote"],
    validade: json["validade"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "deposito": deposito,
    "rua": rua,
    "bloco": bloco,
    "nivel": nivel,
    "apartamento": apartamento,
    "descricao": descricao,
    "fatorCaixa": fatorCaixa,
    "lote": lote,
    "validade": validade,
    "status": status,
  };
}
