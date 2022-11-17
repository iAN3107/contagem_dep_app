import 'package:contagem_dep_app/src/pages/contagem.dart';
import 'package:flutter/material.dart';

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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContagemPage(rua: rua, dep: dep, cod: cod,)));
                },
                child: Text('SIM')),
          ],
        );
      });
}
