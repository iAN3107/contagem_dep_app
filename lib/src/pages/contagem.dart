import 'package:contagem_dep_app/src/models/contagem_pendentes.dart';
import 'package:contagem_dep_app/src/services/sql.dart';
import 'package:flutter/material.dart';

class ContagemPage extends StatefulWidget {
  final cod;
  final dep;
  final rua;

  const ContagemPage({Key? key, this.cod, this.dep, this.rua})
      : super(key: key);

  @override
  State<ContagemPage> createState() => _ContagemPageState();
}

class _ContagemPageState extends State<ContagemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: FutureBuilder(future: SQLServer().retornaContagem(rua: widget.rua, dep: widget.dep),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.hasData) {
          ContagemPendentes contagem = snapshot.data;
          return Text(contagem.descricao);
        }

        return Center();
      },
    )));
  }
}
