import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_table/models/tables_socket_response.dart';
import 'package:oyt_front_table/models/users_table.dart';
import 'package:oyt_front_widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:oyt_front_widgets/bottom_sheet/bottom_sheet_constants.dart';

class ChangeTableStatusSheet extends ConsumerStatefulWidget {
  const ChangeTableStatusSheet({
    required this.usersTable,
    required this.onTableStatusChanged,
    required this.table,
    super.key,
  });

  final TableResponse table;
  final UsersTable usersTable;
  final void Function(TableStatus) onTableStatusChanged;

  static Future<void> show({
    required BuildContext context,
    required TableResponse table,
    required UsersTable usersTable,
    required void Function(TableStatus) onTableStatusChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: BottomSheetConstants.shape,
      isScrollControlled: true,
      builder: (context) => ChangeTableStatusSheet(
        table: table,
        onTableStatusChanged: onTableStatusChanged,
        usersTable: usersTable,
      ),
    );
  }

  @override
  ConsumerState<ChangeTableStatusSheet> createState() => _ChangeTableStatusSheetState();
}

class _ChangeTableStatusSheetState extends ConsumerState<ChangeTableStatusSheet> {
  late TableStatus _tableStatus;

  @override
  void initState() {
    _tableStatus = widget.usersTable.tableStatus ?? TableStatus.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Mesa ${widget.table.name}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(Icons.close)),
            ],
          ),
          Text('Estado actual: ${widget.usersTable.tableStatus?.translatedValue}'),
          const SizedBox(height: 10),
          const Text('Selecciona el nuevo estado:'),
          ...TableStatus.values.map(
            (e) => RadioListTile<TableStatus>(
              value: e,
              groupValue: _tableStatus,
              onChanged: (v) => v == null ? null : setState(() => _tableStatus = v),
              title: Text(e.translatedValue),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onChangeStatus,
              child: const Text('Cambiar estado'),
            ),
          ),
        ],
      ),
    );
  }

  void onChangeStatus() {
    widget.onTableStatusChanged(_tableStatus);
    Navigator.of(context).pop();
  }
}
