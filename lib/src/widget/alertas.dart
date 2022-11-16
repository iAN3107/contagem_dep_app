import 'package:flutter/material.dart';

confirmaContagem(context, nome) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(title: Text('ATENÇÃO'),
          content: Text(
              'Tem certeza que deseja iniciar essa contagem como $nome?'),
          actions: [
            ElevatedButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text('NÃO')),
            ElevatedButton(onPressed: () {}, child: Text('SIM')),
          ],);
      }
  );
}