part of 'printer_bloc.dart';

class PrinterState extends Equatable {
  const PrinterState({
    this.status = Status.initial,
    this.msg,
    this.printer,
    this.devices = const [],
  }) : isConnected = printer != null;

  final Status status;
  final String? msg;
  final PrinterBluetooth? printer;
  final List<PrinterBluetooth> devices;
  final bool isConnected;

  @override
  List<Object?> get props => [status, printer, isConnected, devices];

  PrinterState copyWith({
    Status? status,
    String? msg,
    PrinterBluetooth? printer,
    List<PrinterBluetooth>? devices,
  }) =>
      PrinterState(
        status: status ?? Status.initial,
        printer: printer ?? this.printer,
        devices: devices ?? this.devices,
        msg: msg,
      );
}
