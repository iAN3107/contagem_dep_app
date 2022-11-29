import 'package:flutter/material.dart';

usuarioInexistente(context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuario não existe!', style: TextStyle(fontSize: 20),)));
}

depositoOuRuaJaContada(context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não tem nada para ser contado nesta rua/depósito!', style: TextStyle(fontSize: 20),)));
}

retornaErrosCod(context, text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$text', )));
}