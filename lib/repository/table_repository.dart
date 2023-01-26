import 'package:oyt_front_core/failure/failure.dart';
import 'package:oyt_front_table/data_sources/table_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_table/models/tables_socket_response.dart';

final tableRepositoryProvider = Provider<TableRepository>(TableRepositoryImpl.fromRef);

abstract class TableRepository {
  Future<Failure?> addTable(String tableName);
  Future<Failure?> updateTable(TableResponse table);
}

class TableRepositoryImpl implements TableRepository {
  TableRepositoryImpl({required this.tableDataSource});

  factory TableRepositoryImpl.fromRef(Ref ref) {
    final tableDataSource = ref.read(tableDataSourceProvider);
    return TableRepositoryImpl(tableDataSource: tableDataSource);
  }

  final TableDataSource tableDataSource;

  @override
  Future<Failure?> addTable(String tableName) async {
    try {
      await tableDataSource.addTable(tableName);
      return null;
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Failure?> updateTable(TableResponse table) async {
    try {
      await tableDataSource.updateTable(table);
      return null;
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
