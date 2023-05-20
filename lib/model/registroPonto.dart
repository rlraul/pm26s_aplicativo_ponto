
import 'package:intl/intl.dart';

class RegistroPonto {

  static const NOME_TABELA = 'registro';
  static const ID = 'id';
  static const DATA_HORA = 'data';
  static const LATITUDE = 'latitude';
  static const LONGITUDE = 'longitude';

  int? id;
  DateTime? dataHora;
  double latitude;
  double longitude;

  RegistroPonto({
    required this.id,
    required this.dataHora,
    required this.latitude,
    required this.longitude
  });

  String get retornarDataInclusaoFormatada {
    this.dataHora = DateTime.now();
    return DateFormat('dd/MM/yyyyTHH:mm:ss').format(this.dataHora!);
  }

  Map<String, dynamic> toMap() => {
    ID: id,
    LATITUDE: latitude,
    LONGITUDE: longitude,
    DATA_HORA:
      dataHora == null ? null : DateFormat("yyyy-MM-dd").format(dataHora!),
  };

  factory RegistroPonto.fromMap(Map<String, dynamic> map) => RegistroPonto(
    id: map[ID] is int ? map[ID] : null,
    latitude: map[LATITUDE] is double ? map[LATITUDE] : 0,
    longitude: map[LONGITUDE] is double ? map[LONGITUDE] : 0,
    dataHora: map[DATA_HORA] is String
        ? DateFormat("yyyy-MM-dd").parse(map[DATA_HORA])
        : null,
  );
}