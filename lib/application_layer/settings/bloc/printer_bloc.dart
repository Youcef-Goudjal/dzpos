import 'dart:async';

import 'package:charset_converter/charset_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  PrinterBloc() : super(const PrinterState()) {
    on<UnPaireRequested>(_onUnPaire);
    on<PrintRequested>(_onPrintRequested);
    on<StartScanDevices>(_onStartScanDevices);
    on<StopScanDevices>(_onStopScanDevices);
    on<DevicesScanned>(_onDeviceScanned);
    on<PrinterSelected>(_onPrinterSelected);
    printerManager.scanResults.listen((event) {
      add(DevicesScanned(event));
    });
  }

  FutureOr<void> _onUnPaire(
      UnPaireRequested event, Emitter<PrinterState> emit) {
    emit(state.copyWith(
      printer: null,
    ));
  }

  FutureOr<void> _onStartScanDevices(
      StartScanDevices event, Emitter<PrinterState> emit) {
    emit(state.copyWith(
      devices: [],
      printer: null,
    ));
    printerManager.startScan(const Duration(seconds: 4));
  }

  FutureOr<void> _onStopScanDevices(
      StopScanDevices event, Emitter<PrinterState> emit) {
    printerManager.stopScan();
  }

  FutureOr<void> _onPrinterSelected(
      PrinterSelected event, Emitter<PrinterState> emit) {
    //TODO: save @ of the printer
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
    try {
      printerManager.selectPrinter(state.printer!);
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();

      final res = await printerManager.printTicket(
        await demoReceipt(paper, profile),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];
    // bytes += ticket.text("أهلا", styles: const PosStyles(codeTable: "utf"));
    bytes += await CharsetConverter.encode("windows-1256", "أهلا");

    print(bytes);
    // bytes += ticket.feed(2);
    // bytes += ticket.cut();
    return bytes;
  }
}

List charset = [
  "Adobe-Standard-Encoding",
  "Big5",
  "Big5-HKSCS",
  "BOCU-1",
  "CESU-8",
  "cp1363",
  "cp851",
  "EUC-JP",
  "EUC-KR",
  "GB18030",
  "GBK",
  "hp-roman8",
  "HZ-GB-2312",
  "IBM-Thai",
  "IBM00858",
  "IBM01140",
  "IBM01141",
  "IBM01142",
  "IBM01143",
  "IBM01144",
  "IBM01145",
  "IBM01146",
  "IBM01147",
  "IBM01148",
  "IBM01149",
  "IBM037",
  "IBM1026",
  "IBM1047",
  "IBM273",
  "IBM277",
  "IBM278",
  "IBM280",
  "IBM284",
  "IBM285",
  "IBM290",
  "IBM297",
  "IBM420",
  "IBM424",
  "IBM437",
  "IBM500",
  "IBM775",
  "IBM850",
  "IBM852",
  "IBM855",
  "IBM857",
  "IBM860",
  "IBM861",
  "IBM862",
  "IBM863",
  "IBM864",
  "IBM865",
  "IBM866",
  "IBM868",
  "IBM869",
  "IBM870",
  "IBM871",
  "IBM918",
  "ISO-2022-CN",
  "ISO-2022-CN-EXT",
  "ISO-2022-JP",
  "ISO-2022-JP-1",
  "ISO-2022-JP-2",
  "ISO-2022-KR",
  "ISO-8859-1",
  "ISO-8859-10",
  "ISO-8859-13",
  "ISO-8859-14",
  "ISO-8859-15",
  "ISO-8859-2",
  "ISO-8859-3",
  "ISO-8859-4",
  "ISO-8859-5",
  "ISO-8859-6",
  "ISO-8859-7",
  "ISO-8859-8",
  "ISO-8859-9",
  "KOI8-R",
  "KOI8-U",
  "macintosh",
  "SCSU",
  "Shift_JIS",
  "TIS-620",
  "US-ASCII",
  "UTF-16",
  "UTF-16BE",
  "UTF-16LE",
  "UTF-32",
  "UTF-32BE",
  "UTF-32LE",
  "UTF-7",
  "UTF-8",
  "windows-1250",
  "windows-1251",
  "windows-1252",
  "windows-1253",
  "windows-1254",
  "windows-1255",
  "windows-1256",
  "windows-1257",
  "windows-1258",
];
