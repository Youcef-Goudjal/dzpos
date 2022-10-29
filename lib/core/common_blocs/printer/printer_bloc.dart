import 'dart:async';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:dzpos/application_layer/settings/widgets/printer_settings_dialog.dart';
import 'package:dzpos/core/common_blocs/printer/build_pdf.dart';
import 'package:dzpos/core/common_blocs/printer/build_thermal.dart';
import 'package:dzpos/product/application.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';

import '../../../core/enums.dart';
import '../../../core/services/database.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  BlueThermalPrinter printerManager = BlueThermalPrinter.instance;
  PrinterBloc() : super(const PrinterState()) {
    on<UnPaireRequested>(_onUnPaire);
    on<PrintRequested>(_onPrintRequested);
    on<StartScanDevices>(_onStartScanDevices);
    on<StopScanDevices>(_onStopScanDevices);
    on<DevicesScanned>(_onDeviceScanned);
    on<PrinterSelected>(_onPrinterSelected);
    on<PrinterStateChanged>(_onPrinterStateChanged);
    on<BluetoothPrintRequested>(_onBluetoothPrint);
    printerManager.onStateChanged().listen((event) {
      add(PrinterStateChanged(event));
    });
    final address = Application.pref.getString(StorageKeys.printerMac.name);
    final name = Application.pref.getString(StorageKeys.printerName.name);
    if (address != "" && address != null) {
      emit(state.copyWith(
        printer: BluetoothDevice(name, address),
      ));
    }
  }

  FutureOr<void> _onUnPaire(
      UnPaireRequested event, Emitter<PrinterState> emit) async {
    if (state.isConnected) {
      try {
        StorageKeys.printerName.setValue("");
        StorageKeys.printerMac.setValue("");
        emit(state.copyWith(
          printer: null,
        ));
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
    ));
    final devices = await printerManager.getBondedDevices();
    emit(state.copyWith(
      devices: devices,
      scanning: false,
    ));
  }

  FutureOr<void> _onStopScanDevices(
      StopScanDevices event, Emitter<PrinterState> emit) {
    // printerManager.stopScan();
  }

  FutureOr<void> _onPrinterSelected(
      PrinterSelected event, Emitter<PrinterState> emit) {
    StorageKeys.printerName.setValue(event.printer.name ?? "");
    StorageKeys.printerMac.setValue(event.printer.address ?? "");

    printerManager.connect(event.printer);
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

  FutureOr<void> _onPrinterStateChanged(
      PrinterStateChanged event, Emitter<PrinterState> emit) {
    switch (event.state) {
      case BlueThermalPrinter.CONNECTED:
        emit(state.copyWith(
          status: Status.success,
          msg: "${state.printer?.name} connected",
        ));
        break;
      case BlueThermalPrinter.DISCONNECTED:
        emit(state.copyWith(
          status: Status.success,
          msg: "device disconnected",
        ));
        break;
      case BlueThermalPrinter.STATE_BLE_TURNING_ON:
        emit(state.copyWith(
          status: Status.success,
          msg: "Bluetooth ON",
        ));
        break;
      case BlueThermalPrinter.STATE_BLE_TURNING_OFF:
        emit(state.copyWith(
          status: Status.failure,
          msg: "Bluetooth OFF",
        ));
        break;
      case BlueThermalPrinter.ERROR:
        emit(state.copyWith(
          status: Status.failure,
          msg: "error",
        ));
        break;
      default:
    }
  }

  Future<Uint8List> generatePdf(PdfPageFormat format) {
    return buildPdf(format, state.invoice!);
  }

  FutureOr<void> _onBluetoothPrint(
      BluetoothPrintRequested event, Emitter<PrinterState> emit) async {
    if (state.invoice != null) {
      final profile = await CapabilityProfile.load();
      final paper =
          PaperType.fromString(StorageKeys.paperType.storedValue ?? "p80") ==
                  PaperType.p80
              ? PaperSize.mm80
              : PaperSize.mm58;
      final bytes = await buildThermal(profile, paper, state.invoice!);
      printerManager.writeBytes(Uint8List.fromList(bytes));
    }
  }
}
