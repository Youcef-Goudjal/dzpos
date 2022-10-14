import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadWidget extends StatelessWidget {
  final TextEditingController controller;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final void Function(dynamic) onSuggestionSelected;
  TypeAheadWidget({
    super.key,
    TextEditingController? controller,
    required this.suggestionCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
  }) : controller = controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
      ),
      suggestionsCallback: suggestionCallback,
      onSuggestionSelected: onSuggestionSelected,
      itemBuilder: itemBuilder,
    );
  }
}
