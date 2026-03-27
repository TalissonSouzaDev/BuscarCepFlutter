final class Address {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  Address({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  String get getCep => cep;
  String get getLogradouro => logradouro;
  String get getComplemento => complemento;
  String get getBairro => bairro;
  String get getLocalidade => localidade;
  String get getUf => uf;
}