import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/application_layer/settings/widgets/search_printers_dialog.dart';
import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application_layer.dart';

class PrintingPreviewPage extends StatelessWidget {
  const PrintingPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Printing Preview"),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const KButton(
                  icon: Icons.print,
                  msg: "Printing on Wifi Not supported Yet!!",
                  text: "Wifi",
                ),
                5.widthBox,
                const KButton(
                  icon: Icons.share,
                  msg: "Sharing Not supported Yet!!",
                  text: "Share",
                ),
                5.widthBox,
                const KButton(
                  icon: Icons.picture_as_pdf,
                  msg: "PDF supported Yet!!",
                  text: "open",
                ),
                5.widthBox,
                const KButton(
                  icon: Icons.inventory,
                  msg: "Excel Not supported Yet!!",
                  text: "EXCEL",
                ),
              ],
            ),
          ),
        ),
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
                  text: "Bluetooth",
                  onPressed: () {
                    bloc.add(PrintRequested());
                  },
                );
              } else {
                return KButton(
                  alignment: false,
                  icon: Icons.search,
                  text: "Connect",
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
            text: "UnPair",
            onPressed: () {
              CommonBloc.printerBloc.add(UnPaireRequested());
            },
          ),
          5.widthBox,
          KButton(
            alignment: false,
            icon: Icons.settings_bluetooth,
            text: "Settings",
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
    return const Center(
      child: Text("Preview not seported Yet!!"),
    );
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
