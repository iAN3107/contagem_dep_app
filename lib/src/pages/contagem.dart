import 'package:contagem_dep_app/src/models/contagem_pendentes.dart';
import 'package:contagem_dep_app/src/services/sql.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ContagemPage extends StatefulWidget {
  final cod;
  final dep;
  final rua;
  final nome;

  const ContagemPage({Key? key, this.cod, this.dep, this.rua, this.nome})
      : super(key: key);

  @override
  State<ContagemPage> createState() => _ContagemPageState();
}

class _ContagemPageState extends State<ContagemPage> {
  TextStyle textoContador = TextStyle(
    fontSize: 22,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: SQLServer().retornaContagem(rua: widget.rua, dep: widget.dep),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<ContagemPendentes> contagem = snapshot.data;
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '${widget.nome} ',
                        style: textoContador,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(columns: [
                                DataColumn(
                                    label: Expanded(
                                        child: Text(
                                  'Depósito',
                                  textAlign: TextAlign.center,
                                ))),
                                DataColumn(
                                    label: Expanded(
                                        child: Text(
                                  'Rua',
                                  textAlign: TextAlign.center,
                                ))),
                                DataColumn(
                                    label: Expanded(
                                        child: Text(
                                  'Bloco',
                                  textAlign: TextAlign.center,
                                ))),
                                DataColumn(
                                    label: Expanded(
                                        child: Text(
                                  'Nivel',
                                  textAlign: TextAlign.center,
                                ))),
                                DataColumn(
                                    label: Expanded(
                                        child: Text(
                                  'Apartamento',
                                  textAlign: TextAlign.center,
                                ))),
                              ], rows: [
                                DataRow(cells: [
                                  DataCell(Center(
                                      child: Text('${contagem[0].deposito}'))),
                                  DataCell(Center(
                                      child: Text('${contagem[0].rua}'))),
                                  DataCell(Center(
                                      child: Text('${contagem[0].bloco}'))),
                                  DataCell(Center(
                                      child: Text('${contagem[0].nivel}'))),
                                  DataCell(Center(
                                      child:
                                          Text('${contagem[0].apartamento}')))
                                ])
                              ]),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          );
        }

        return Center();
      },
    ));
  }
}
