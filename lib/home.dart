import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'dart:async';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Map> _recuperarPreco() async{
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context,snapshot) {

        String resultado;
       switch (snapshot.connectionState){
         case ConnectionState.none:
         case ConnectionState.waiting:
           print("conexão waiting");
           resultado = "Carregando...";
           break;
         case ConnectionState.active:
         case ConnectionState.done:
           print("conexão done");
           if(snapshot.hasError){
             resultado = "erro ao carregar os dados.";
             }else {
             double valor = snapshot.data! ["BRL"] ["buy"];
             resultado = "preco do bitcon: ${valor.toString()}";
           }
           break;

       }
       return Center(
         child: Text(resultado),
       );

      },

    );
  }
}
