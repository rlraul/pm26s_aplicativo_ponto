
import 'package:geolocator/geolocator.dart';
import 'package:registro_ponto/DAO/registroPontoDao.dart';
import 'package:registro_ponto/model/registroPonto.dart';

class RegistradorDePonto {

  final _dao = RegistroPontoDao();
  Position? _localizacaoAtual;

  void registrar({required permissao}) async {
    bool tempermissao = await permissao.permissoesPermitidas();
    if (tempermissao) {
    _localizacaoAtual = await Geolocator.getCurrentPosition();

    DateTime data = DateTime.now();

    RegistroPonto registroPonto =
    new RegistroPonto(
      id: null,
      dataHora: data,
      latitude: _localizacaoAtual!.latitude,
      longitude: _localizacaoAtual!.longitude,
    );

    _dao.salvar(registroPonto);
    }
  }
}