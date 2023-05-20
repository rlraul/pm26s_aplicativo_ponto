
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registro_ponto/DAO/registroPontoDao.dart';
import 'package:registro_ponto/model/registroPonto.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ListaPontosRegistradosPage extends StatefulWidget{

  @override
  _ListaPontosRegistradosPageState createState() => _ListaPontosRegistradosPageState();
}

class _ListaPontosRegistradosPageState extends State<ListaPontosRegistradosPage>{

  final _dao = RegistroPontoDao();
  final _pontosRegistrados = <RegistroPonto>[];

 @override
 void initState(){
   super.initState();
   _atualizarLista();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
    );
  }

  AppBar _criarAppBar() {
    return AppBar(
      title: Text('Lista de Pontos Registrados'),
    );
  }

  Widget _criarBody() {
    if (_pontosRegistrados.isEmpty || _pontosRegistrados == null) {
      return const Center(
        child: Text('Nenhum ponto registrado!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );
    }
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final pontoRegistrado = _pontosRegistrados[index];
          return Card(
            child: Column (
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                ListTile(
                  leading: Icon(Icons.album),
                  subtitle: Text(_formatarPontoRegistrado(pontoRegistrado)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          _abrirLocalizacaoPonto(pontoRegistrado);
                        },
                        child: Text('Abrir mapa')
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: _pontosRegistrados.length
    );
  }

  String _formatarPontoRegistrado(RegistroPonto registroPonto) {
    return 'Código: ${registroPonto.id} | Data: ${registroPonto.dataHora} | ' +
        'Latitude: ${registroPonto.latitude} | Longitude: ${registroPonto.longitude}';
  }

  void _atualizarLista() async {
    final pontosRegistrados = await _dao.listar();

    setState(() {
      _pontosRegistrados.clear();
      if (pontosRegistrados.isNotEmpty) {
        _pontosRegistrados.addAll(pontosRegistrados);
      }
    });
  }

  _abrirLocalizacaoPonto(RegistroPonto pontoTuristico) {
    MapsLauncher.launchCoordinates(pontoTuristico!.latitude, pontoTuristico!.longitude);
  }

  List<PopupMenuEntry<String>> _criarItensMenuPopup(RegistroPonto pontoTuristico) => [
    PopupMenuItem(
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Abrir Mapa'),
          ),
        ],
      ),
      onTap: _abrirLocalizacaoPonto(pontoTuristico),
    ),
  ];
}