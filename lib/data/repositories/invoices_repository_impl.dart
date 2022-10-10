import 'package:dzpos/core/common_blocs/common_blocs.dart';
import "package:dzpos/domain/repositories/invoices_repository.dart";

class InvoicesRepositoryImpl implements InvoicesRepository {
  final invoicesDao = CommonBloc.invoicesDao;
}
