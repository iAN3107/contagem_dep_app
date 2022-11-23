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

  List<TextEditingController> unidadesExistentes = [];
  List<TextEditingController> caixasExistentes = [];
  List<TextEditingController> totalExistentes = [];

  int _calculaTotal(caixa, unidade, int fatorCaixa) {
    try {
      int calculo = int.parse(caixa) * fatorCaixa + int.parse(unidade);
      return calculo;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: SQLServer().retornaContagem(rua: widget.rua, dep: widget.dep),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final formKey = GlobalKey<FormState>();
          List<ContagemPendentes> contagem = snapshot.data;
          List<DataRow> listaLotes = [];
          int tamanhoLista = contagem.length;
          int fatorCaixa = contagem[0].fatorCaixa;
          for (var i = 0; i < tamanhoLista; i++) {
            unidadesExistentes.add(TextEditingController());
            caixasExistentes.add(TextEditingController());
            totalExistentes.add(TextEditingController());
            totalExistentes[i].text =
                '${_calculaTotal(caixasExistentes[i].text, unidadesExistentes[i].text, fatorCaixa)}';

            listaLotes.add(DataRow(cells: [
              DataCell(Center(
                child: Text('${contagem[i].lote}'),
              )),
              DataCell(Center(
                child: Text('${contagem[i].validade}'),
              )),
              DataCell(Center(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite algo!';
                    }

                    try {
                      int.parse(value);
                    } catch (e) {
                      return 'Digite um número!';
                    }
                  },
                  controller: caixasExistentes[i],
                  keyboardType: TextInputType.number,
                ),
              )),
              DataCell(Center(
                child: TextFormField(
                  onChanged: (values) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite um número!';
                    }
                    try {
                      int.parse(value);
                    } catch (e) {
                      return 'Digite um número!';
                    }
                  },
                  controller: unidadesExistentes[i],
                  keyboardType: TextInputType.number,
                ),
              )),
              DataCell(
                Center(
                    child: TextFormField(
                  controller: totalExistentes[i],
                  enabled: false,
                )),
              )
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
                                child: Form(
                                  key: formKey,
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
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
                                      codigoContador: widget.cod,
                                      nomeContador: widget.nome,
                                      caixa: caixasExistentes[i].text,
                                      unidade: unidadesExistentes[i].text,
                                      total: totalExistentes[i].text);
                                }
                              }
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
