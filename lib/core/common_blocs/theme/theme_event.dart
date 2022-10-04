part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode? themeMode;
  final FlexScheme? flexScheme;

  const ThemeChanged({
    this.themeMode,
    this.flexScheme,
  });
}
