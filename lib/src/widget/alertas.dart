import 'package:contagem_dep_app/src/pages/contagem.dart';
import 'package:contagem_dep_app/src/services/sql.dart';
import 'package:flutter/material.dart';

import '../pages/login.dart';

confirmaContagem({context, nome, cod, dep, rua}) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text('ATENÇÃO'),
          content:
              Text('Tem certeza que deseja iniciar essa contagem como $nome?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('NÃO')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContagemPage(
                            nome: nome,
                            rua: rua,
                            dep: dep,
                            cod: cod,
                          )));
                },
                child: Text('SIM')),
          ],
        );
      });
}

confirmaEnvio(
    {context,
    sku,
    deposito,
    rua,
    bloco,
    nivel,
    apartamento,
    tamanhoLista,
    contagem,
    codContador,
    nomeContador,
    caixasExistentes,
    unidadesExistentes,
    totalExistentes}) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text('ATENÇÃO'),
          content: Text('Tem certeza que deseja enviar essa contagem e sair?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('NÃO')),
            ElevatedButton(
                onPressed: () async {
                  try {
                    for (var i = 0; i < tamanhoLista; i++) {
                      await SQLServer().cadastraContagem(
                          cod: contagem[i].cod,
                          rua: contagem[i].rua,
                          apartamento: contagem[i].apartamento,
                          bloco: contagem[i].bloco,
                          validade: contagem[i].validade,
                          nivel: contagem[i].nivel,
                          deposito: contagem[i].deposito,
                          descricao: contagem[i].descricao,
                          lote: contagem[i].lote,
                          codigoContador: codContador,
                          nomeContador: nomeContador,
                          caixa: caixasExistentes[i].text,
                          unidade: unidadesExistentes[i].text,
                          total: totalExistentes[i].text);
                    }

                    await SQLServer().retiraPendenteContagem(
                        sku: sku,
                        deposito: deposito,
                        rua: rua,
                        bloco: bloco,
                        nivel: nivel,
                        apartamento: apartamento);

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: Text('SIM')),
          ],
        );
      });
}

irParaProximo(
    {context,
    sku,
    deposito,
    rua,
    bloco,
    nivel,
    apartamento,
    tamanhoLista,
    contagem,
    codContador,
    nomeContador,
    caixasExistentes,
    unidadesExistentes,
    totalExistentes}) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text('ATENÇÃO'),
          content: Text('Deseja enviar esta e iniciar outra contagem?'),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text('NÃO')),
            ElevatedButton(
                onPressed: () async {
                  for (var i = 0; i < tamanhoLista; i++) {
                    await SQLServer().cadastraContagem(
                        cod: contagem[i].cod,
                        rua: contagem[i].rua,
                        apartamento: contagem[i].apartamento,
                        bloco: contagem[i].bloco,
                        validade: contagem[i].validade,
                        nivel: contagem[i].nivel,
                        deposito: contagem[i].deposito,
                        descricao: contagem[i].descricao,
                        lote: contagem[i].lote,
                        codigoContador: codContador,
                        nomeContador: nomeContador,
                        caixa: caixasExistentes[i].text,
                        unidade: unidadesExistentes[i].text,
                        total: totalExistentes[i].text);
                  }

                  await SQLServer().retiraPendenteContagem(
                      sku: sku,
                      deposito: deposito,
                      rua: rua,
                      bloco: bloco,
                      nivel: nivel,
                      apartamento: apartamento);

                  if (await SQLServer().verificaContagem(deposito, rua)) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return irParaProximo(
                          context: context,
                          sku: sku,
                          deposito: deposito,
                          rua: rua,
                          bloco: bloco,
                          nivel: nivel,
                          apartamento: apartamento);
                    }));
                  } else {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  }
                },
                child: Text('SIM')),
          ],
        );
      });
}
