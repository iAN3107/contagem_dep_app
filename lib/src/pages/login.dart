import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              'CONTAGEM',
              style: TextStyle(fontSize: 20),
            ), SizedBox(height: 15,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),prefixIcon:Icon(
                  Icons.account_circle,
                ),
              ),
            ), SizedBox(height: 15,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Depósito',
                border: OutlineInputBorder(),prefixIcon:Icon(
                  Icons.warehouse,
                ),
              ),
            ), SizedBox(height: 15,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Rua',
                border: OutlineInputBorder(),prefixIcon:Icon(
                  Icons.edit_road,
                ),
              ),
            ),SizedBox(height: 15,),
            ElevatedButton(onPressed: (){}, child: Text('INICIAR CONTAGEM'))
          ],
        ),
      ),
    )));
  }
}
