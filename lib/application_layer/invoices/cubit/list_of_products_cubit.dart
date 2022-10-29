import 'dart:async';

import 'package:dzpos/core/enums.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/database.dart';

part 'list_of_products_state.dart';

class ListOfProductsCubit extends Cubit<ListOfProductsState> {
  late StreamSubscription? _subscription;
  InvoicesRepository invoicesRepository;
  ListOfProductsCubit(this.invoicesRepository)
      : super(const ListOfProductsState(status: Status.loading)) {
    _subscription = invoicesRepository.watchProducts.listen((event) {
      emit(state.copyWith(
        products: event,
        status: Status.success,
      ));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  deleteProduct(FullProduct product) {
    invoicesRepository.deleteProduct(product.productId);
  }

  void exportFromExcel() {}

  void importFromExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["xls", "xlsx"],
      type: FileType.custom,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      if (result.files.isNotEmpty) {
        final data = result.files.first.bytes;
        var excel = Excel.decodeBytes(data!);
        final sheet = excel.sheets[excel.sheets.keys.first];
        if (sheet != null) {
          for (var row in sheet.rows) {
            final name = row[0]?.value ?? "";
            final code = row[1]?.value ?? "";
            final unitInStock = row[2]?.value ?? 0;
            final sellPrice = row[3]?.value ?? 0;
            final purchasePrice = row[4]?.value ?? 0;
            final box = row[5]?.value ?? 1;
            final product = await invoicesRepository.createEmptyProduct();
            invoicesRepository.writeProduct(
              product.copyWith(
                product: product.product.copyWith(
                  name: name,
                  code: code,
                  unitInStock: unitInStock,
                ),
                unitsList: [
                  ProductUnit(
                    id: -1,
                    type: UnitType.sell,
                    price: sellPrice,
                    box: box,
                    subTotal: -1,
                    productId: -1,
                  ),
                  ProductUnit(
                    id: -1,
                    type: UnitType.buy,
                    price: purchasePrice,
                    box: box,
                    subTotal: -1,
                    productId: -1,
                  ),
                ],
              ),
            );
          }
        }
      }
    }
  }
}
