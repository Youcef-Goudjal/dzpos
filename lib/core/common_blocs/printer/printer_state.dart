part of 'printer_bloc.dart';

class PrinterState extends Equatable {
  const PrinterState({
    this.status = Status.initial,
    this.msg,
    this.printer,
    this.devices = const [],
    this.scanning = false,
    this.invoice,
  }) : isConnected = printer != null;

  final Status status;
  final bool scanning;
  final String? msg;
  final BluetoothDevice? printer;
  final List<BluetoothDevice> devices;
  final bool isConnected;
  final FullInvoice? invoice;

  @override
  List<Object?> get props => [
        status,
        printer,
        isConnected,
        devices,
        scanning,
        invoice,
      ];

  PrinterState copyWith({
    Status? status,
    String? msg,
    BluetoothDevice? printer,
    List<BluetoothDevice>? devices,
    bool? scanning,
    bool isDisconnected = false,
    FullInvoice? invoice,
  }) {
    late final p;

    return PrinterState(
      scanning: scanning ?? this.scanning,
      status: status ?? Status.initial,
      printer: isDisconnected ? null : (printer ?? this.printer),
      devices: devices ?? this.devices,
      invoice: invoice ?? this.invoice,
      msg: msg,
    );
  }
}
