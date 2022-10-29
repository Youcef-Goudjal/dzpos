part of 'printer_bloc.dart';

abstract class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object?> get props => [];
}

class UnPaireRequested extends PrinterEvent {}

class PrintRequested extends PrinterEvent {
  final FullInvoice invoice;

  const PrintRequested(this.invoice);
  @override
  List<Object?> get props => [invoice];
}

class StartScanDevices extends PrinterEvent {}

class StopScanDevices extends PrinterEvent {}

class DevicesScanned extends PrinterEvent {
  final List<BluetoothDevice> devices;

  const DevicesScanned(this.devices);
  @override
  List<Object> get props => [devices];
}

class PrinterSelected extends PrinterEvent {
  final BluetoothDevice printer;

  const PrinterSelected(this.printer);
  @override
  List<Object> get props => [printer];
}

class PrinterStateChanged extends PrinterEvent {
  final int? state;

  const PrinterStateChanged(this.state);
  @override
  List<Object?> get props => [state];
}

class BluetoothPrintRequested extends PrinterEvent {}
