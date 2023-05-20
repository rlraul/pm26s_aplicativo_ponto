
import 'package:registro_ponto/model/registroPonto.dart';
import 'package:registro_ponto/provider/provider.dart';

class RegistroPontoDao {

  final dbProvider = Provider.instance;

  Future<bool> salvar(RegistroPonto registroPonto) async {
    final database = await dbProvider.database;
    final valores = registroPonto.toMap();
    if (registroPonto.id == null) {
      registroPonto.id = await database.insert(RegistroPonto.NOME_TABELA, valores);
      return true;
    } else {
      final registrosAtualizados = await database.update(
        RegistroPonto.NOME_TABELA,
        valores,
        where: '${RegistroPonto.ID} = ?',
        whereArgs: [registroPonto.id],
      );
      return registrosAtualizados > 0;
    }
  }

  Future<List<RegistroPonto>> listar() async {
    final database = await dbProvider.database;
    final resultado = await database.query(RegistroPonto.NOME_TABELA,
      columns: [RegistroPonto.ID, RegistroPonto.DATA_HORA, RegistroPonto.LATITUDE, RegistroPonto.LONGITUDE],
    );
    return resultado.map((m) => RegistroPonto.fromMap(m)).toList();
  }
}