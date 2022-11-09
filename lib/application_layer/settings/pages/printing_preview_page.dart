import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/src/pdf/page_format.dart';
import 'package:printing/printing.dart';

import '../../../core/common_blocs/printer/printer_bloc.dart';
import '../../../core/core.dart';
import '../../application_layer.dart';



class PrintingPreviewPage extends StatelessWidget {
  const PrintingPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Printing_Preview.tr()),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
              alignment: Alignment.center,
              backgroundColor: context.primaryColor,
            ),
            onPressed: () {
              // printing settings
            },
            icon: Center(
              child: Icon(
                Icons.settings,
                color: context.onPrimaryColor,
              ),
            ),
          ),
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(60),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Row(
        //       children: [
        //         const KButton(
        //           icon: Icons.print,
        //           msg: "Printing on Wifi Not supported Yet!!",
        //           text: "Wifi",
        //         ),
        //         5.widthBox,
        //         KButton(
        //           icon: Icons.share,
        //           msg: "Sharing Not supported Yet!!",
        //           text: LocaleKeys.Share.tr(),
        //         ),
        //         5.widthBox,
        //         const KButton(
        //           icon: Icons.picture_as_pdf,
        //           msg: "PDF supported Yet!!",
        //           text: "PDF",
        //         ),
        //         5.widthBox,
        //         const KButton(
        //           icon: Icons.inventory,
        //           msg: "Excel Not supported Yet!!",
        //           text: "EXCEL",
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: Column(
        children: [
          const Expanded(child: _PreviewCore()),
          const _PrintingActions(),
          5.heightBox,
        ],
      ),
    );
  }
}

class _PrintingActions extends StatelessWidget {
  const _PrintingActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PrinterBloc>();
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          5.widthBox,
          BlocBuilder<PrinterBloc, PrinterState>(
            builder: (context, state) {
              if (state.isConnected) {
                return KButton(
                  alignment: false,
                  icon: Icons.bluetooth,
                  text: LocaleKeys.Bluetooth.tr(),
                  onPressed: () {
                    CommonBloc.printerBloc.add(BluetoothPrintRequested());
                  },
                );
              } else {
                return KButton(
                  alignment: false,
                  icon: Icons.search,
                  text: LocaleKeys.Connect.tr(),
                  onPressed: () {
                    showSearchForPrintersDialog(context);
                  },
                );
              }
            },
          ),
          5.widthBox,
          KButton(
            alignment: false,
            icon: Icons.bluetooth_disabled,
            text: LocaleKeys.UnPair.tr(),
            onPressed: () {
              CommonBloc.printerBloc.add(UnPaireRequested());
            },
          ),
          5.widthBox,
          KButton(
            alignment: false,
            icon: Icons.settings_bluetooth,
            text: LocaleKeys.settings.tr(),
            onPressed: () {
              showPrinterSettings(context);
            },
          ),
          5.widthBox,
        ],
      ),
    );
  }
}

class _PreviewCore extends StatelessWidget {
  const _PreviewCore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = <PdfPreviewAction>[
      PdfPreviewAction(
        icon: const Icon(Icons.save),
        onPressed: _saveAsFile,
      )
    ];
    final bloc = context.read<PrinterBloc>();
    return PdfPreview(
      maxPageWidth: 700,
      actions: actions,
      onPrinted: _showPrintedToast,
      onShared: _showSharedToast,
      pdfFileName:
          "${bloc.state.invoice?.invoiceId}-${formatDate(DateTime.now())}",
      build: (format) {
        return bloc.generatePdf(format);
      },
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _saveAsFile(BuildContext context, LayoutCallback build,
      PdfPageFormat pageFormat) async {
    final bloc = context.read<PrinterBloc>();
    final bytes = await build(pageFormat);
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(
        '$appDocPath/${bloc.state.invoice?.invoiceId}-${formatDate(DateTime.now())}.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    // todo: open file
  }
}

class KButton extends StatelessWidget {
  final bool alignment;
  final String? msg;
  final IconData icon;
  final String text;
  final Function()? onPressed;
  final Color? primary, onPrimary;
  const KButton({
    Key? key,
    this.onPressed,
    this.alignment = true,
    this.msg,
    required this.icon,
    required this.text,
    this.primary,
    this.onPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: alignment
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor:
                    primary ?? context.colorScheme.primaryContainer,
              ),
              onPressed: onPressed ??
                  () {
                    statusHandler(context, Status.failure, msg: msg);
                  },
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: onPrimary ?? context.colorScheme.onPrimaryContainer,
                  ),
                  Text(
                    text,
                    style: context.textTheme.titleSmall!.copyWith(
                      color:
                          onPrimary ?? context.colorScheme.onPrimaryContainer,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor:
                    primary ?? context.colorScheme.primaryContainer,
              ),
              onPressed: onPressed ??
                  () {
                    statusHandler(context, Status.failure, msg: msg);
                  },
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: onPrimary ?? context.colorScheme.onPrimaryContainer,
                  ),
                  Text(
                    text,
                    style: context.textTheme.titleSmall!.copyWith(
                      color:
                          onPrimary ?? context.colorScheme.onPrimaryContainer,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
