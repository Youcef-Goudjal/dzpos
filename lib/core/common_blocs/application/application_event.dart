part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class SetupApplication extends ApplicationEvent {}

class ApplicationWillClose extends ApplicationEvent {}
