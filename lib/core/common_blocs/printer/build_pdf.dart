import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/data.dart';
import '../../../product/constants/asset_constants.dart';
import '../../enums.dart';
import '../../utils/utils.dart';

const _darkColor = PdfColors.blueGrey800;
const _lightColor = PdfColors.white;
const baseColor = PdfColors.teal;
const accentColor = PdfColors.blueGrey900;
PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

String? _logo;
PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;
String? _bgShape;
Future<Uint8List> buildPdf(
    PdfPageFormat pageFormat, InvoiceModel invoice) async {
  // Create a PDF document
  final doc = pw.Document();

  // _logo = await rootBundle.loadString("");
  _bgShape = await rootBundle.loadString(AppAssets.bgInvoice);
  doc.addPage(
    pw.MultiPage(
      // pageTheme: _buildTheme(
      //   pageFormat,
      //   await PdfGoogleFonts.cairoRegular(),
      //   await PdfGoogleFonts.cairoBold(),
      //   await PdfGoogleFonts.cairoLight(),
      // ),
      header: (context) => _buildHeader(context, invoice),
      footer: (context) => _buildFooter(context, invoice),
      build: (context) => [
        _contentHeader(context, invoice),
        _contentTable(context, invoice),
        pw.SizedBox(height: 20),
        _contentFooter(context, invoice),
        // pw.SizedBox(height: 20),
        // _termsAndConditions(context),
      ],
    ),
  );
  // return the pdf file
  return doc.save();
}

pw.Widget _contentHeader(pw.Context context, InvoiceModel invoice) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        child: pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          child: pw.FittedBox(
            child: pw.Text(
              'Total: ${formatCurrency(invoice.total)}',
              style: pw.TextStyle(
                color: baseColor,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
      pw.Expanded(
        child: pw.Row(
          children: [
            pw.Container(
              margin: const pw.EdgeInsets.only(left: 10, right: 10),
              height: 70,
              child: pw.Text(
                'Invoice to:',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Container(
                height: 70,
                child: pw.RichText(
                    text: pw.TextSpan(
                        text: '${invoice.account.name}\n',
                        style: pw.TextStyle(
                          color: _darkColor,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                        children: [
                      const pw.TextSpan(
                        text: '\n',
                        style: pw.TextStyle(
                          fontSize: 5,
                        ),
                      ),
                      pw.TextSpan(
                        text: invoice.account.address,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ])),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

pw.Widget _contentTable(pw.Context context, InvoiceModel invoice) {
  final products = invoice.sales;
  return pw.Table.fromTextArray(
    border: null,
    cellAlignment: pw.Alignment.centerLeft,
    headerDecoration: const pw.BoxDecoration(
      borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
      color: baseColor,
    ),
    headerHeight: 25,
    cellHeight: 40,
    cellAlignments: {
      0: pw.Alignment.centerLeft,
      1: pw.Alignment.centerLeft,
      2: pw.Alignment.center,
      3: pw.Alignment.centerRight,
      4: pw.Alignment.center,
      5: pw.Alignment.centerRight,
    },
    headerStyle: pw.TextStyle(
      color: _baseTextColor,
      fontSize: 10,
      fontWeight: pw.FontWeight.bold,
    ),
    cellStyle: const pw.TextStyle(
      color: _darkColor,
      fontSize: 10,
    ),
    rowDecoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: accentColor,
          width: .5,
        ),
      ),
    ),
    headers: List<String>.generate(
      PrintTableValues.values.length,
      (col) => PrintTableValues.values[col].name,
    ),
    data: List<List<String>>.generate(
      products.length,
      (row) => List<String>.generate(
        PrintTableValues.values.length,
        (col) => products[row].getIndex(PrintTableValues.values[col]),
      ),
    ),
  );
}

pw.Widget _contentFooter(pw.Context context, InvoiceModel invoice) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        flex: 2,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Thank you for your business',
              style: pw.TextStyle(
                color: _darkColor,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
              child: pw.Text(
                'Payment Info:',
                style: pw.TextStyle(
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Text(
              invoice.paymentType.name,
              style: const pw.TextStyle(
                fontSize: 8,
                lineSpacing: 5,
                color: _darkColor,
              ),
            ),
          ],
        ),
      ),
      pw.Expanded(
        flex: 1,
        child: pw.DefaultTextStyle(
          style: const pw.TextStyle(
            fontSize: 10,
            color: _darkColor,
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //   children: [
              //     pw.Text('Sub Total:'),
              //     pw.Text(_formatCurrency(_total)),
              //   ],
              // ),
              // pw.SizedBox(height: 5),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //   children: [
              //     pw.Text('Tax:'),
              //     pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
              //   ],
              // ),
              pw.Divider(color: accentColor),
              pw.DefaultTextStyle(
                style: pw.TextStyle(
                  color: baseColor,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total:'),
                    pw.Text(formatCurrency(invoice.total)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

pw.Widget _termsAndConditions(pw.Context context) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Expanded(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              decoration: const pw.BoxDecoration(
                border: pw.Border(top: pw.BorderSide(color: accentColor)),
              ),
              padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
              child: pw.Text(
                'Terms & Conditions',
                style: pw.TextStyle(
                  fontSize: 12,
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Text(
              pw.LoremText().paragraph(40),
              textAlign: pw.TextAlign.justify,
              style: const pw.TextStyle(
                fontSize: 6,
                lineSpacing: 2,
                color: _darkColor,
              ),
            ),
          ],
        ),
      ),
      pw.Expanded(
        child: pw.SizedBox(),
      ),
    ],
  );
}

pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
  return pw.PageTheme(
    pageFormat: pageFormat,
    theme: pw.ThemeData.withFont(
      base: base,
      bold: bold,
      italic: italic,
    ),
    buildBackground: (context) => pw.FullPage(
      ignoreMargins: true,
      child: pw.SvgImage(svg: _bgShape!),
    ),
  );
}

pw.Widget _buildHeader(pw.Context context, InvoiceModel invoice) {
  return pw.Column(
    children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              children: [
                pw.Container(
                  height: 50,
                  padding: const pw.EdgeInsets.only(left: 20),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    "Invoice",
                    style: pw.TextStyle(
                      color: baseColor,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                pw.Container(
                  decoration: const pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                    color: accentColor,
                  ),
                  padding: const pw.EdgeInsets.only(
                      left: 40, top: 10, bottom: 10, right: 20),
                  alignment: pw.Alignment.centerLeft,
                  height: 50,
                  child: pw.DefaultTextStyle(
                    style: pw.TextStyle(
                      color: _accentTextColor,
                      fontSize: 12,
                    ),
                    child: pw.GridView(
                      crossAxisCount: 2,
                      children: [
                        pw.Text('Invoice #'),
                        pw.Text("${invoice.invoiceId}"),
                        pw.Text('Date:'),
                        pw.Text(formatDate(DateTime.now())),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // logo
          pw.Expanded(
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topRight,
                  padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                  height: 72,
                  child:
                      _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
                )
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

pw.Widget _buildFooter(pw.Context context, InvoiceModel invoice) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Container(
        height: 20,
        width: 100,
        child: pw.BarcodeWidget(
          barcode: pw.Barcode.pdf417(),
          data: "Invoice# ${invoice.invoiceId}",
          drawText: false,
        ),
      ),
      pw.Text(
        'Page ${context.pageNumber}/${context.pagesCount}',
        style: const pw.TextStyle(
          fontSize: 12,
          color: PdfColors.white,
        ),
      ),
    ],
  );
}
