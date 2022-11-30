import 'package:contagem_dep_app/src/models/contagem_pendentes.dart';
import 'package:contagem_dep_app/src/models/usuario.dart';
import 'package:contagem_dep_app/src/services/sql_config.dart';
import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';

class SQLServer {
  var connection = SqlConn.connect(
      ip: "192.168.11.99",
      port: "1433",
      databaseName: "APP_CONTAGEM",
      username: 'sa',
      password: senha());

  Future<bool> validaLogin(cod) async {
    await connection;

    var res = await SqlConn.readData("SELECT * FROM USUARIOS where cod = $cod");
    List<Usuario> usuario = usuarioFromJson(res);

    if (usuario.isNotEmpty) {
      return true;
    }

    return false;
  }

  // VERIFICA SE TEM ALGUMA CONTAGEM PARA ESSA RUA DO DEPÓSITO
  Future<bool> verificaContagem(deposito, rua) async {
    await connection;

    var res = await SqlConn.readData(
        "SELECT * FROM PENDENTES WHERE deposito = '$deposito' and rua = '$rua' and status = 0 and emContagem = 0");
    List<ContagemPendentes> pendentes = contagemPendentesFromJson(res);

    if (pendentes.isNotEmpty) {
      return true;
    }
    return false;
  }

  //RETORNA O NOME DO CONTADOR PARA ELE FAZER A VERIFICAÇÃO QUE É ELE MESMO!
  Future<String> retornaNome(cod) async {
    await connection;

    var res = await SqlConn.readData("SELECT * FROM USUARIOS where cod = $cod");
    List<Usuario> usuario = usuarioFromJson(res);

    return usuario[0].nome;
  }

  Future<List<ContagemPendentes>> retornaContagem({dep, rua}) async {
    await connection;

    var res = await SqlConn.readData(
        "SELECT * FROM PENDENTES WHERE deposito = '$dep' and rua = '$rua' and status = 0");

    //SELECIONA A PRIMEIRA CONTAGEM DA LISTA DO SQL
    List<ContagemPendentes> buscaContagem = contagemPendentesFromJson(res);

    //BUSCA A LISTA DE LOTES DA CONTAGEM
    var selecionaContagem = await SqlConn.readData(
        "SELECT * FROM PENDENTES WHERE deposito = '${buscaContagem[0].deposito}'"
        " and rua = '${buscaContagem[0].rua}' and  cod = '${buscaContagem[0].cod}'"
        " and bloco = '${buscaContagem[0].bloco}' and nivel = '${buscaContagem[0].nivel}'"
        " and apartamento = '${buscaContagem[0].apartamento}'"
        " and descricao = '${buscaContagem[0].descricao}'"
        " and fatorCaixa = '${buscaContagem[0].fatorCaixa}' and status = 0 and emContagem = 0");

    List<ContagemPendentes> retornaContagens =
        contagemPendentesFromJson(selecionaContagem);

    try {
      var emContagem = await SqlConn.writeData(
          "UPDATE PENDENTES SET emContagem = 1 WHERE deposito = '${buscaContagem[0].deposito}'"
          " and rua = '${buscaContagem[0].rua}' and  cod = '${buscaContagem[0].cod}'"
          " and bloco = '${buscaContagem[0].bloco}' and nivel = '${buscaContagem[0].nivel}'"
          " and apartamento = '${buscaContagem[0].apartamento}'"
          " and descricao = '${buscaContagem[0].descricao}'"
          " and fatorCaixa = '${buscaContagem[0].fatorCaixa}' and status = 0");
    } catch (e) {
      print(e);
    }

    return retornaContagens;
  }

  Future<void> cadastraContagem(
      {codigoContador,
      cod,
      descricao,
      nomeContador,
      deposito,
      rua,
      bloco,
      nivel,
      apartamento,
      lote,
      validade,
        fatorCaixa,
      caixa,
      unidade,
      total}) async {
    await connection;
    try {
      var res = await SqlConn.writeData(
          "INSERT INTO CONCLUIDOS VALUES('$cod', '$codigoContador', '$nomeContador', '$deposito', "
          " '$rua', '$bloco', '$nivel', '$apartamento', '$lote', '$validade',$fatorCaixa, $caixa,"
          " $unidade, $total, '$descricao')");
      debugPrint(res.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> retiraPendenteContagem(
      {sku, deposito, rua, bloco, nivel, apartamento}) async {
    try {
      var res = await SqlConn.writeData(
          "UPDATE Pendentes SET STATUS = 1, emContagem = 0 where cod = '$sku' and deposito = '$deposito' and rua = '$rua' and bloco = '$bloco' and nivel = '$nivel' and apartamento = '$apartamento' and status = 0 and emContagem = 1");
    } catch (e) {
      print('erroaqui' + e.toString());
    }
  }
}
