import 'dart:async';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:dzpos/core/common_blocs/printer/build_pdf.dart';
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
    await printerManager.disconnect();
    emit(state.copyWith(
      printer: null,
    ));
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
    Application.pref
        .setString(StorageKeys.printerMac.name, event.printer.address ?? "");

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
    final profiles = await CapabilityProfile.getAvailableProfiles();
    print(profiles);
  }

  Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    ticket.setGlobalCodeTable("CP1256");
    final data = await CharsetConverter.encode("CP1256", "مرحبا");
    List<int> bytes = [];
    // bytes += ticket.text("مرحبا");
    // bytes += data;
    bytes += ticket.textEncoded(data,
        styles: const PosStyles.defaults(
          align: PosAlign.center,
          codeTable: "CP1256",
        ));

    print(bytes);
    // bytes += ticket.feed(2);
    bytes += ticket.cut();
    return bytes;
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
}
