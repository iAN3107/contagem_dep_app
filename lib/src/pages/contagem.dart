import 'package:contagem_dep_app/src/models/contagem_pendentes.dart';
import 'package:contagem_dep_app/src/pages/login.dart';
import 'package:contagem_dep_app/src/services/sql.dart';
import 'package:contagem_dep_app/src/widget/alertas.dart';
import 'package:contagem_dep_app/src/widget/toasts.dart';
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


  late Future<List<ContagemPendentes>> contagemPendentes;

  @override
  void initState() {
    super.initState();

    contagemPendentes =
        SQLServer().retornaContagem(rua: widget.rua, dep: widget.dep);
  }

  final formKey = GlobalKey<FormState>();
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

  TextStyle textoDesc =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.blue);    return Scaffold(
        body: FutureBuilder(
      future: contagemPendentes,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<ContagemPendentes> contagem = snapshot.data;

          if (contagem.isEmpty) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          }

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
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return retornaErrosCod(
                          context, 'PREENCHA TODOS OS CAMPOS!');
                    }

                    try {
                      int.parse(value!);
                    } catch (e) {
                      return retornaErrosCod(
                          context, 'PREENCHA COM APENAS NÚMEROS!');
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
                      return retornaErrosCod(
                          context, 'PREENCHA TODOS OS CAMPOS!');
                    }
                    try {
                      int.parse(value!);
                    } catch (e) {
                      return retornaErrosCod(
                          context, 'PREENCHA TODOS OS CAMPOS!');
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
              ),
              DataCell(Center(
                child: Text('${contagem[i].validade}'),
              )),
            ]));
          }

          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text('${widget.cod} - ${widget.nome}',
                              style: textoDesc),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 6.0,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('ENDEREÇO', style: textoDesc),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth: constraints.maxWidth),
                                    child: DataTable(
                                        columnSpacing: 5,
                                        headingRowColor:
                                            MaterialStateProperty.all(
                                                Colors.black12),
                                        headingRowHeight: 35,
                                        columns: [
                                          DataColumn(
                                              label: Expanded(
                                                  child: Text(
                                            'DEP',
                                            textAlign: TextAlign.center,
                                          ))),
                                          DataColumn(
                                              label: Expanded(
                                                  child: Text(
                                            'RUA',
                                            textAlign: TextAlign.center,
                                          ))),
                                          DataColumn(
                                              label: Expanded(
                                                  child: Text(
                                            'BLC',
                                            textAlign: TextAlign.center,
                                          ))),
                                          DataColumn(
                                              label: Expanded(
                                                  child: Text(
                                            'NVL',
                                            textAlign: TextAlign.center,
                                          ))),
                                          DataColumn(
                                              label: Expanded(
                                                  child: Text(
                                            'APTO',
                                            textAlign: TextAlign.center,
                                          ))),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(Center(
                                                child: Text(
                                                    '${contagem[0].deposito}'))),
                                            DataCell(Center(
                                                child: Text(
                                                    '${contagem[0].rua}'))),
                                            DataCell(Center(
                                                child: Text(
                                                    '${contagem[0].bloco}'))),
                                            DataCell(Center(
                                                child: Text(
                                                    '${contagem[0].nivel}'))),
                                            DataCell(Center(
                                                child: Text(
                                                    '${contagem[0].apartamento}')))
                                          ])
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'PRODUTO',
                            style: textoDesc,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(scrollDirection: Axis.horizontal,
                            child: Text(
                              '${contagem[0].descricao}',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth),
                              child: DataTable(
                                  columnSpacing: 2,
                                  headingRowColor:
                                      MaterialStateProperty.all(Colors.black12),
                                  headingRowHeight: 35,
                                  columns: [
                                    DataColumn(
                                        label: Expanded(
                                            child: Text(
                                      'SKU',
                                      textAlign: TextAlign.center,
                                    ))),
                                    DataColumn(
                                        label: Expanded(
                                            child: Text(
                                      'Fator Caixa',
                                      textAlign: TextAlign.center,
                                    ))),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Center(
                                          child: Text('${contagem[0].cod}'))),
                                      DataCell(Center(
                                          child: Text(
                                              '${contagem[0].fatorCaixa}'))),
                                    ])
                                  ]),
                            ),
                          ),
                          Text(
                            'CONTAGEM',
                            style: textoDesc,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Form(
                              key: formKey,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: constraints.maxWidth),
                                child: DataTable(
                                    columnSpacing: 10,
                                    headingRowColor: MaterialStateProperty.all(
                                        Colors.black12),
                                    headingRowHeight: 35,
                                    columns: [
                                      DataColumn(
                                          label: Expanded(
                                              child: Text(
                                        'Lote',
                                        textAlign: TextAlign.center,
                                      ))),
                                      DataColumn(
                                          label: Expanded(
                                              child: Text(
                                        'CX',
                                        textAlign: TextAlign.center,
                                      ))),
                                      DataColumn(
                                          label: Expanded(
                                              child: Text(
                                        'UNI',
                                        textAlign: TextAlign.center,
                                      ))),
                                      DataColumn(
                                          label: Expanded(
                                              child: Text(
                                        'Total',
                                        textAlign: TextAlign.center,
                                      ))),
                                      DataColumn(
                                          label: Expanded(
                                              child: Text(
                                        'Validade',
                                        textAlign: TextAlign.center,
                                      ))),
                                    ],
                                    rows: listaLotes),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      confirmaEnvio(
                                          apartamento: contagem[0].apartamento,
                                          unidadesExistentes:
                                              unidadesExistentes,
                                          totalExistentes: totalExistentes,
                                          tamanhoLista: tamanhoLista,
                                          contagem: contagem,
                                          codContador: widget.cod,
                                          nomeContador: widget.nome,
                                          nivel: contagem[0].nivel,
                                          bloco: contagem[0].bloco,
                                          deposito: contagem[0].deposito,
                                          sku: contagem[0].cod,
                                          rua: contagem[0].rua,
                                          context: context,
                                          caixasExistentes: caixasExistentes);
                                    }
                                  },
                                  child: Text('ENVIAR')),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      irParaProximo(
                                          apartamento: contagem[0].apartamento,
                                          unidadesExistentes:
                                              unidadesExistentes,
                                          totalExistentes: totalExistentes,
                                          tamanhoLista: tamanhoLista,
                                          contagem: contagem,
                                          codContador: widget.cod,
                                          nomeContador: widget.nome,
                                          nivel: contagem[0].nivel,
                                          bloco: contagem[0].bloco,
                                          deposito: contagem[0].deposito,
                                          sku: contagem[0].cod,
                                          rua: contagem[0].rua,
                                          context: context,
                                          caixasExistentes: caixasExistentes);
                                    }
                                  },
                                  child: Text('PROXIMA'))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )),
              ),
            ),
          );
        }

        return Center();
      },
    ));
  }
}
