
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registro_ponto/pages/listaPontosRegistradosPage.dart';
import 'package:registro_ponto/service/permissoesDeLocalizacao.dart';
import 'package:registro_ponto/service/registradorDePonto.dart';

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro do ponto remoto"),
      ),
      body: _criarBody(),
    );
  }

  Widget _criarBody() => ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            child: Text("Registrar ponto"),
            onPressed: () => _ChamarRegistradorPonto(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            child: Text("Verificar histórico"),
            onPressed: _abrirPageListaRegistros,
          ),
        ),
      ],
  );

  void _ChamarRegistradorPonto(BuildContext context) {
    PermissoesDeLocalizacao permissoes = new PermissoesDeLocalizacao(context);

    RegistradorDePonto registradorDePonto = new RegistradorDePonto();
    registradorDePonto.registrar(permissao: permissoes);
  }

  void _abrirPageListaRegistros() {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) => ListaPontosRegistradosPage(),
    ),
    );
  }

}