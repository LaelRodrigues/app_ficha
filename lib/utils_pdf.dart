import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'models/rubrica.dart';
import 'models/snapshot.dart';

class GeneratePDF {
  Snapshot snapshot;
  GeneratePDF({
    required this.snapshot,
  });

  generatePDFInvoice() async {
    final pw.Document doc = pw.Document();
    final pw.Font customFont =
        pw.Font.ttf((await rootBundle.load('assets/RobotoSlabt.ttf')));
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
            margin: pw.EdgeInsets.zero,
            theme:
                pw.ThemeData(defaultTextStyle: pw.TextStyle(font: customFont))),
        header: _buildHeader,
        footer: _buildPrice,
        build: (context) => _buildContent(context),
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
        color: PdfColors.blue,
        height: 150,
        child: pw.Padding(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8), child: pw.PdfLogo()),
                        pw.Text('Ficha financeira',
                            style: const pw.TextStyle(
                                fontSize: 22, color: PdfColors.white))
                      ]),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Governo do estado do RN',
                          style: const pw.TextStyle(
                              fontSize: 22, color: PdfColors.white)),
                      pw.Text(
                          'SEARH',
                          style: const pw.TextStyle(color: PdfColors.white)),
                    ],
                  )
                ]
              )
            )
          );
  }

  List<pw.Widget> _buildContent(pw.Context context) {
    return [
      pw.Padding(
          padding: const pw.EdgeInsets.only(top: 30, left: 25, right: 25),
          child: _buildContentClient()),
      pw.Padding(
          padding: const pw.EdgeInsets.only(top: 50, left: 25, right: 25),
          child: _contentTable(context)),
    ];
  }

   pw.Widget _buildContentClient() {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _titleText('Nome'),
              pw.Text(snapshot.nome),
              _titleText('Matricula'),
              pw.Text(snapshot.matricula)
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              _titleText('Unidade Organizacional'),
              pw.Text(snapshot.unidadeOrganizacional),
              _titleText('Setor'),
              pw.Text(snapshot.setor)
            ],
          ),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            _titleText('CPF'),
            pw.Text(snapshot.cpf),
            _titleText('Data de emissão'),
            pw.Text(DateFormat('dd/MM/yyyy').format(DateTime.now()))
          ])
        ]);
  }

   _titleText(String text) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(top: 8),
        child: pw.Text(text,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)));
    }

  pw.Widget _contentTable(pw.Context context) {
    // Define uma lista usada no cabeçalho
    const tableHeaders = ['Codigo', 'Descrição', 'Valor', 'Tipo', 'Mês/ano'];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(),
      headerHeight: 25,
      cellHeight: 40,
      // Define o alinhamento das células, onde a chave é a coluna
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      // Define um estilo para o cabeçalho da tabela
      headerStyle: pw.TextStyle(
        fontSize: 10,
        color: PdfColors.blue,
        fontWeight: pw.FontWeight.bold,
      ),
      // Define um estilo para a célula
      cellStyle: const pw.TextStyle(
        fontSize: 10,
      ),
      // Define a decoração
      rowDecoration: pw.BoxDecoration(),
      headers: tableHeaders,
      // retorna os valores da tabela, de acordo com a linha e a coluna
      data: List<List<String>>.generate(
        snapshot.contracheque.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => _getValueIndex(snapshot.contracheque[row], col),
        ),
      ),
    );
  }

  String _getValueIndex(Rubrica contracheque, int col) {
    switch (col) {
      case 0:
        return contracheque.codigo.toString();
      case 1:
        return contracheque.descricao;
      case 2:
        return _formatValue(contracheque.valor);
      case 3:
        return contracheque.tipo;
      case 4:
        return contracheque.referencia;
    }
    return '';
  }

  String _formatValue(double value) {
    final NumberFormat numberFormat = NumberFormat("#,##0.00", "pt_BR");
    return numberFormat.format(value);
  }

   pw.Widget _buildPrice(pw.Context context) {
    return pw.Container(
      color: PdfColors.blue,
      height: 130,
      child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Padding(
                padding: const pw.EdgeInsets.only(left: 16),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [])),
            pw.Padding(
                padding: const pw.EdgeInsets.all(16),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: []))
          ]),
    );
  }
}
