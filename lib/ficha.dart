import 'package:contracheque/models/snapshot.dart';
import 'package:contracheque/tela_inicial.dart';
import 'package:contracheque/utils_pdf.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/rubrica.dart';

class Ficha extends StatelessWidget {
  const Ficha({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConsultaFicha(title: 'Ficha Financeira'),
    );
  }
}

class ConsultaFicha extends StatefulWidget {
  const ConsultaFicha({super.key, required this.title});

  final String title;

  @override
  State<ConsultaFicha> createState() => _ConsultaFichaState();
}

class _ConsultaFichaState extends State<ConsultaFicha> {
  final TextEditingController _dataInicial = TextEditingController();
  final TextEditingController _dataFinal = TextEditingController();

  Widget _buildDataInicial() {
    return TextField(
      controller: _dataInicial,
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today_rounded), labelText: "Mês inicial"),
      onTap: () async {
        DateTime? escolhaData = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

        if (escolhaData != null) {
          setState(() {
            _dataInicial.text = DateFormat('yyyy-MM-dd').format(escolhaData);
          });
        }
      },
    );
  }

  Widget _buildDataFinal() {
    return TextField(
      controller: _dataFinal,
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today_rounded), labelText: "Mês Final"),
      onTap: () async {
        DateTime? escolhaData = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

        if (escolhaData != null) {
          setState(() {
            _dataFinal.text = DateFormat('yyyy-MM-dd').format(escolhaData);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: true,
          leading:  IconButton(
            icon: const BackButtonIcon(),
            onPressed:() =>  Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TelaInicial()),
            )
          )
        ),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildDataInicial(),
              _buildDataFinal(),
              const SizedBox(height: 40),
              ElevatedButton(
                child: const Text('Gerar PDF'),
                onPressed: () {
                  double valor = 3000;
                  int mes = 7;
                  List<Rubrica> rubricas = [];
                  for(var i = 0; i < 3; i++) {
                    rubricas.add(Rubrica(codigo: "001", descricao: "vencimento Basico", valor: valor, tipo: "Vantagem", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "002", descricao: "Quinquênio", valor: 1000, tipo: "Vantagem", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "003", descricao: "Adicional Noturno", valor: 200, tipo: "Vantagem", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "004", descricao: "Auxílio Alimentação", valor: 150, tipo: "Vantagem", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "005", descricao: "Total liquido", valor: 3500, tipo: "Vantagem", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "006", descricao: "Total de Vantagens", valor: 4000, tipo: "Vantagem", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "007", descricao: "Total de Descontos", valor: 500, tipo: "Desconto", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "008", descricao: "imposto de renda", valor: 300, tipo: "Desconto", referencia: "0$mes/2022"));
                    rubricas.add(Rubrica(codigo: "009", descricao: "IPE", valor: 200, tipo: "Desconto", referencia: "0$mes/2022"));
                    mes++;
                  }
                  Snapshot snapshot = Snapshot(id: "1", nome: "Fulano", matricula: "2020183039", cpf: "12345678-9", setor: "Coordenadoria de RH", codigoCargo: "3", 
                                   descricaoCargo: "Assistente de Departamento Pessoal", unidadeOrganizacional: "Departamento Estadual de Transito", contracheque: rubricas);
                  GeneratePDF generatePdf = GeneratePDF(snapshot: snapshot);
                  generatePdf.generatePDFInvoice();
                },
              )
            ],
          ),
        ));
  }
}
