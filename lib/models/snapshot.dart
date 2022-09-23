import 'package:contracheque/models/rubrica.dart';

class Snapshot {
  String id;
  String nome;
  String matricula;
  String cpf;
  String setor;
  String codigoCargo;
  String descricaoCargo;
  String unidadeOrganizacional;
  List<Rubrica> contracheque;
  Snapshot({
    required this.id,
    required this.nome,
    required this.matricula,
    required this.cpf,
    required this.setor,
    required this.codigoCargo,
    required this.descricaoCargo,
    required this.unidadeOrganizacional,
    required this.contracheque,
  });
}
