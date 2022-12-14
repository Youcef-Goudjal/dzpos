part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class InitialThemeState extends ThemeState {}

class ThemeUpdating extends ThemeState {}

class ThemeUpdated extends ThemeState {}
