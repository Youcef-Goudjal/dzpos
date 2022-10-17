import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadWidget<T> extends StatelessWidget {
  final TextEditingController controller;
  final FutureOr<Iterable<T>> Function(String) suggestionCallback;
  final Widget Function(BuildContext, T value) itemBuilder;
  final void Function(T value) onSuggestionSelected;
  TypeAheadWidget({
    super.key,
    TextEditingController? controller,
    required this.suggestionCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
  }) : controller = controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<T>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
      ),
      suggestionsCallback: suggestionCallback,
      onSuggestionSelected: onSuggestionSelected,
      itemBuilder: itemBuilder,
    );
  }
}
