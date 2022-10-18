import 'package:dzpos/application_layer/settings/settings.dart';
import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future showSearchForPrintersDialog(BuildContext context) async {
  final bloc = context.read<PrinterBloc>();
  return showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: bloc,
        child: const SearchForDevicesDialog(),
      );
    },
  );
}

class SearchForDevicesDialog extends StatefulWidget {
  const SearchForDevicesDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchForDevicesDialog> createState() => _SearchForDevicesDialogState();
}

class _SearchForDevicesDialogState extends State<SearchForDevicesDialog> {
  @override
  void initState() {
    CommonBloc.printerBloc.add(StartScanDevices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = CommonBloc.printerBloc;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Dialog(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Printers"),
          ),
          floatingActionButton: StreamBuilder<bool>(
            stream: bloc.printerManager.isScanningStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState.isLoading) {
                return FloatingActionButton(
                  onPressed: () {},
                  child: const CircularProgressIndicator(),
                );
              }
              if (snapshot.data!) {
                return FloatingActionButton(
                  onPressed: () {
                    bloc.add(StopScanDevices());
                  },
                  backgroundColor: context.error,
                  child: Icon(
                    Icons.stop,
                    color: context.onError,
                  ),
                );
              } else {
                return FloatingActionButton(
                  onPressed: () {
                    bloc.add(StartScanDevices());
                  },
                  child: const Icon(Icons.search),
                );
              }
            },
          ),
          body: BlocBuilder<PrinterBloc, PrinterState>(
            builder: (context, state) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final printer = state.devices[index];
                  return ListTile(
                    selected: state.printer == printer,
                    title: Text(printer.name ?? "Default"),
                    subtitle: Text(printer.address!),
                    onTap: () {
                      bloc.add(PrinterSelected(printer));
                    },
                  );
                },
                separatorBuilder: (context, index) => 10.heightBox,
                itemCount: state.devices.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
