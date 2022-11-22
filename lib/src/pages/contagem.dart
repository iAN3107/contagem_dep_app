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
  TextStyle textoDesc = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: SQLServer().retornaContagem(rua: widget.rua, dep: widget.dep),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<ContagemPendentes> contagem = snapshot.data;
          List<DataRow> listaLotes = [];
          int tamanhoLista = contagem.length;
          List<TextEditingController> unidadesExistentes = [];
          List<TextEditingController> caixasExistentes = [];
          List<int> total = [];
          for (var i = 0; i < tamanhoLista; i++) {
            unidadesExistentes.add(TextEditingController());
            caixasExistentes.add(TextEditingController());

            listaLotes.add(DataRow(cells: [
              DataCell(Center(
                child: Text('${contagem[i].lote}'),
              )),
              DataCell(Center(
                child: Text('${contagem[i].validade}'),
              )),
              DataCell(Center(
                child: TextFormField(
                  controller: caixasExistentes[i],
                  keyboardType: TextInputType.number,
                ),
              )),
              DataCell(Center(
                child: TextFormField(
                  controller: unidadesExistentes[i],
                  keyboardType: TextInputType.number,
                ),
              )),
              DataCell(Center(
                child: TextFormField(),
              )),
            ]));
          }

          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text('CONTADOR: ${widget.nome} ', style: textoDesc),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 6.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('ENDEREÇO', style: textoDesc),
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
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
                                        child:
                                            Text('${contagem[0].deposito}'))),
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 6.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'PRODUTO',
                          style: textoDesc,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: DataTable(columns: [
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'SKU',
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Descrição',
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Fator Caixa',
                                    textAlign: TextAlign.center,
                                  ))),
                                ], rows: [
                                  DataRow(cells: [
                                    DataCell(Center(
                                        child: Text('${contagem[0].cod}'))),
                                    DataCell(Center(
                                        child:
                                            Text('${contagem[0].descricao}'))),
                                    DataCell(Center(
                                        child:
                                            Text('${contagem[0].fatorCaixa}'))),
                                  ])
                                ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 6.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'CONTAGEM',
                          style: textoDesc,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: DataTable(columns: [
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Lote',
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Validade',
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Caixa',
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Unidade',
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Total',
                                    textAlign: TextAlign.center,
                                  ))),
                                ], rows: listaLotes),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed: () {
                              print(caixasExistentes[0].text);
                            },
                            child: Text('ENVIAR'))
                      ],
                    ),
                  )),
            ),
          );
        }

        return Center();
      },
    ));
  }
}
