import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oyt_front_core/constants/lotti_assets.dart';
import 'package:oyt_front_core/theme/theme.dart';
import 'package:oyt_front_table/models/users_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TableStatusCard extends ConsumerWidget {
  const TableStatusCard({required this.tableStatus, super.key});

  final TableStatus? tableStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: ref.watch(themeProvider.notifier).roundedBoxDecoration,
      child: Row(
        children: [
          Lottie.asset(LottieAssets.ordering, width: 140),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text('${tableStatus?.translatedValue}...'),
            ],
          ),
        ],
      ),
    );
  }
}
