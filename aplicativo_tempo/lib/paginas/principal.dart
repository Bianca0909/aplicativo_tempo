import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../util/componentes.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController cepController = TextEditingController();

  String retorno = "";
  String rua = "Rua:";
  String complemento = "Complemento:";
  String bairro = "Bairro:";
  String cidade = "Cidade:";
  String estado = "Estado:";

  limpaTela() {
    setState(() {
      retorno = "";
      cepController.text = "";
      formController = GlobalKey<FormState>();
    });
  }

  buscarEndereco() async {
    //async = método assíncrono
    String url = 'https://viacep.com.br/ws/${cepController.text}/json/';
    Response resposta = await get(Uri.parse(url));
    Map endereco = json.decode(resposta.body);
    setState(() {
      rua = "Rua: ${endereco['logradouro']}";
      complemento = "Complemento: ${endereco['complemento']}";
      bairro = "Bairro: ${endereco['bairro']}";
      cidade = "Cidade: ${endereco['localidade']}";
      estado = "Estado: ${endereco['uf']}";
    });
    print(endereco);
    buscarNome();
  }

  buscarNome() async {
    String url =
        'https://api.hgbrasil.com/weather?format=json-cors&key=c2b3048c&city_name=$cidade,$estado';
    Response resposta = await get(Uri.parse(url));
    Map tempo = json.decode(resposta.body);

    setState(() {
      retorno = "Tempo: ${tempo['results']['temp']}";
    });
    print(tempo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Componentes().criaAppBar('Tempo agora', limpaTela),
      body: Form(
        key: formController,
        child: Column(children: [
          const SizedBox(height: 20),
          Componentes().iconeGrande(),
          Componentes().criaInputTexto(TextInputType.number, 'Informe o CEP',
              cepController, 'Informe o CEP'),
          Componentes()
              .criaBotao(formController, buscarEndereco, 'Pesquisar previsão'),
          Componentes().criarContainerDados(retorno),
        ]),
      ),
    );
  }
}
