import 'dart:async';

// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:dzpos/core/common_blocs/printer/build_pdf.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:pdf/pdf.dart';

import '../../../application_layer/application_layer.dart';
import '../../../core/enums.dart';
import '../../../core/services/database.dart';
import 'build_thermal.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  // BlueThermalPrinter printerManager = BlueThermalPrinter.instance;
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  PrinterBloc() : super(const PrinterState()) {
    on<UnPaireRequested>(_onUnPaire);
    on<PrintRequested>(_onPrintRequested);
    on<StartScanDevices>(_onStartScanDevices);
    on<StopScanDevices>(_onStopScanDevices);
    on<DevicesScanned>(_onDeviceScanned);
    on<PrinterSelected>(_onPrinterSelected);
    on<BluetoothPrintRequested>(_onBluetoothPrint);
    _onSetupPrinter();
  }
  late final CapabilityProfile profile;
  final paper =
      PaperType.fromString(StorageKeys.paperType.storedValue ?? "p80") ==
              PaperType.p80
          ? PaperSize.mm80
          : PaperSize.mm58;

  _onSetupPrinter() async {
    profile = await CapabilityProfile.load();
    final address = StorageKeys.printerMac.storedValue ?? "";
    final name = StorageKeys.printerName.storedValue ?? "";
    if (address != "" && address != "") {
      final device = BluetoothDevice.fromJson(
        {
          "name": name,
          "address": address,
        },
      );
      add(PrinterSelected(PrinterBluetooth(device)));
    }
    // esc bluetooth manager
    printerManager.scanResults.listen((printers) {
      add(DevicesScanned(printers));
    });
  }

  FutureOr<void> _onUnPaire(
      UnPaireRequested event, Emitter<PrinterState> emit) async {
    if (state.isConnected) {
      try {
        StorageKeys.printerName.setValue("");
        StorageKeys.printerMac.setValue("");
        emit(state.copyWith(printer: null, isDisconnected: true));
      } on Exception {
        // TODO
      }
    }
  }

  FutureOr<void> _onStartScanDevices(
      StartScanDevices event, Emitter<PrinterState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
      scanning: true,
      devices: [],
      printer: null,
      isDisconnected: true,
    ));
   
    printerManager.startScan(Duration(seconds: 4));
  }

  FutureOr<void> _onStopScanDevices(
      StopScanDevices event, Emitter<PrinterState> emit) {
  
  }

  FutureOr<void> _onPrinterSelected(
      PrinterSelected event, Emitter<PrinterState> emit) {
    StorageKeys.printerName.setValue(event.printer.name ?? "");
    StorageKeys.printerMac.setValue(event.printer.address ?? "");

    // printerManager.connect(event.printer);
    printerManager.selectPrinter(event.printer);
    emit(state.copyWith(
      status: Status.success,
      printer: event.printer,
      msg: "Printer Selected",
    ));
  }

  FutureOr<void> _onDeviceScanned(
      DevicesScanned event, Emitter<PrinterState> emit) {
    emit(state.copyWith(
      devices: event.devices,
    ));
  }

  FutureOr<void> _onPrintRequested(
      PrintRequested event, Emitter<PrinterState> emit) async {
    emit(state.copyWith(
      invoice: event.invoice,
    ));
  }

  Future<Uint8List> generatePdf(PdfPageFormat format) {
    return buildPdf(format, state.invoice!);
  }

  FutureOr<void> _onBluetoothPrint(
      BluetoothPrintRequested event, Emitter<PrinterState> emit) async {
    if (state.invoice != null) {
      final bytes = await buildThermal(profile, paper, state.invoice!);
      await printerManager.printTicket(bytes);
    }
  }
}
