import 'dart:convert';

List<ContagemPendentes> contagemPendentesFromJson(String str) =>
    List<ContagemPendentes>.from(
        json.decode(str).map((x) => ContagemPendentes.fromJson(x)));

String contagemPendentesToJson(List<ContagemPendentes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    required this.emContagem,
  });

  dynamic cod;
  dynamic deposito;
  dynamic rua;
  dynamic bloco;
  dynamic nivel;
  dynamic apartamento;
  dynamic descricao;
  int fatorCaixa;
  dynamic lote;
  dynamic validade;
  dynamic status;
  dynamic emContagem;

  factory ContagemPendentes.fromJson(Map<String, dynamic> json) =>
      ContagemPendentes(
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
        emContagem: json["emContagem"],
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
        "emContagem": emContagem,
      };
}
