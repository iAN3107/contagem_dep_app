import 'package:contagem_dep_app/src/models/contagem_pendentes.dart';
import 'package:contagem_dep_app/src/models/usuario.dart';
import 'package:contagem_dep_app/src/services/sql_config.dart';
import 'package:sql_conn/sql_conn.dart';

class SQLServer {
  var connection = SqlConn.connect(
      ip: "192.168.11.100",
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
        "SELECT * FROM PENDENTES WHERE deposito = '$deposito' and rua = '$rua' and status = 0");
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


  Future<ContagemPendentes> retornaContagem({dep, rua}) async {
    await connection;

    var res = await SqlConn.readData(
        "SELECT * FROM PENDENTES WHERE deposito = '$dep' and rua = '$rua' and status = 0");

    List<ContagemPendentes> contagem = contagemPendentesFromJson(res);

    return ContagemPendentes(
        cod: contagem[0].cod, deposito: contagem[0].deposito, rua: contagem[0].rua, bloco: contagem[0].bloco,
        nivel: contagem[0].nivel, apartamento: contagem[0].apartamento, descricao: contagem[0].descricao,
        fatorCaixa: contagem[0].fatorCaixa, lote: contagem[0].lote, validade: contagem[0].validade, status: contagem[0].status);
  }
}
