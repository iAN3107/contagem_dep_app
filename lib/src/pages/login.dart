import 'package:contagem_dep_app/src/services/sql.dart';
import 'package:contagem_dep_app/src/widget/alertas.dart';
import 'package:contagem_dep_app/src/widget/toasts.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final CodController = TextEditingController();
  final DepositoController = TextEditingController();
  final RuaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var codError = false;

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                'CONTAGEM',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (codError!) {
                    return 'Código inválido';
                  }
                  if (value!.isEmpty) {
                    return 'Digite um código!';
                  }
                },
                controller: CodController,
                decoration: InputDecoration(
                  errorText: null,
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.account_circle,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite um Depósito!';
                  }
                },
                controller: DepositoController,
                decoration: InputDecoration(
                  labelText: 'Depósito',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.warehouse,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite uma Rua!';
                  }
                },
                controller: RuaController,
                decoration: InputDecoration(
                  labelText: 'Rua',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.edit_road,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      formKey.currentState!.validate();
                      if (CodController.text.isNotEmpty &
                          DepositoController.text.isNotEmpty &
                          RuaController.text.isNotEmpty) {
                        if (await SQLServer().validaLogin(CodController.text)) {
                          codError = false;
                          formKey.currentState!.validate();
                          if (await SQLServer().verificaContagem(
                              DepositoController.text, RuaController.text)) {
                            confirmaContagem(context, await SQLServer().retornaNome(CodController.text));
                          } else {
                            depositoOuRuaJaContada(context);
                          }
                        } else {
                          codError = true;
                          formKey.currentState!.validate();
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('INICIAR CONTAGEM'))
            ],
          ),
        ),
      ),
    )));
  }
}
