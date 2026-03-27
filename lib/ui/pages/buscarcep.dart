import 'package:buscarcep/data/http/http.dart';
import 'package:buscarcep/domain/entities/address.dart';
import 'package:buscarcep/domain/models/addressmodel.dart';
import 'package:buscarcep/infra/http/http_adapter.dart';
import 'package:buscarcep/ui/components/button.dart';
import 'package:buscarcep/ui/components/input.dart';
import 'package:flutter/material.dart';

class Buscarcep extends StatefulWidget {
  const Buscarcep({super.key});

  @override
  State<Buscarcep> createState() => _BuscarcepState();
}

class _BuscarcepState extends State<Buscarcep> {
  final TextEditingController cepController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 250, 246, 246),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo ao App de Busca de CEP!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: InputField(
                label: 'Digite o CEP',
                controller: cepController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: Button(
                text: 'Buscar',
                isLoading: isLoading,
                onPressed: () => _consultarCep(cepController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _consultarCep(String cep) async {
    setState(() => isLoading = true);

      final Http http = HttpAdapter();

    final response = await http.get('https://viacep.com.br/ws/$cep/json/');

    if (response.containsKey('erro')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CEP não encontrado.')),
      );
    } else {
      final Address address = AddressModel.fromJson(response).toEntity();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Endereço Encontrado'),
          content: Text(
            'CEP: ${address.cep}\n'
            'Logradouro: ${address.logradouro}\n'
            'Bairro: ${address.bairro}\n'
            'Cidade: ${address.localidade}\n'
            'Estado: ${address.uf}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        ),
      );
    }

    setState(() => isLoading = false);
  }
}