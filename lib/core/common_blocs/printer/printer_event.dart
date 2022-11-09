part of 'printer_bloc.dart';

abstract class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object?> get props => [];
}

class UnPaireRequested extends PrinterEvent {}

class PrintRequested extends PrinterEvent {
  final InvoiceModel invoice;

  const PrintRequested(this.invoice);
  @override
  List<Object?> get props => [invoice];
}

class StartScanDevices extends PrinterEvent {}

class StopScanDevices extends PrinterEvent {}

class DevicesScanned extends PrinterEvent {
  // final List<BluetoothDevice> devices;
  final List<PrinterBluetooth> devices;

  const DevicesScanned(this.devices);
  @override
  List<Object> get props => [devices];
}

class PrinterSelected extends PrinterEvent {
  // final BluetoothDevice printer;
  final PrinterBluetooth printer;

  const PrinterSelected(this.printer);
  @override
  List<Object> get props => [printer];
}

class BluetoothPrintRequested extends PrinterEvent {}
