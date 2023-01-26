import 'package:oyt_front_core/external/api_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_core/logger/logger.dart';
import 'package:oyt_front_table/models/tables_socket_response.dart';

final tableDataSourceProvider = Provider<TableDataSource>(TableDataSourceImpl.fromRef);

abstract class TableDataSource {
  Future<void> addTable(String tableName);
  Future<void> updateTable(TableResponse table);
}

class TableDataSourceImpl implements TableDataSource {
  TableDataSourceImpl({required this.apiHandler});

  factory TableDataSourceImpl.fromRef(Ref ref) {
    final apiHandler = ref.read(apiHandlerProvider);
    return TableDataSourceImpl(apiHandler: apiHandler);
  }

  final ApiHandler apiHandler;

  @override
  Future<void> addTable(String tableName) async {
    try {
      await apiHandler.post('/table', {'name': tableName});
    } catch (e, s) {
      Logger.logError(e.toString(), s);
      rethrow;
    }
  }

  @override
  Future<void> updateTable(TableResponse table) async {
    try {
      await apiHandler.put('/table', table.toUpdateTableMap());
    } catch (e, s) {
      Logger.logError(e.toString(), s);
      rethrow;
    }
  }
}
