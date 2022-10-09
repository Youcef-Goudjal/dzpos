import 'package:flutter/material.dart';

extension ConnectionStateExt on ConnectionState {
  bool get isLoading => this == ConnectionState.waiting;
  bool get isDone => this == ConnectionState.done;
  bool get isActive => this == ConnectionState.active;
}
