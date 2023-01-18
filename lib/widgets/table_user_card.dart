import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_core/utils/currency_formatter.dart';
import 'package:oyt_front_product/models/product_model.dart';
import 'package:oyt_front_table/models/users_table.dart';

class TableUserCard extends ConsumerWidget {
  const TableUserCard({
    this.isExpanded = true,
    this.showPrice = false,
    required this.userTable,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  final UserTable userTable;
  final bool isExpanded;
  final bool showPrice;
  final void Function(UserTable userTable, ProductDetailModel productDetail)? onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          subtitle: showPrice
              ? Text(
                  'Total: \$ ${CurrencyFormatter.format(userTable.price)}',
                  style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(.7)),
                )
              : null,
          leading: const CircleAvatar(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
          title: Text(
            '${userTable.firstName} ${userTable.lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (isExpanded)
          ...userTable.orderProducts
              .map(
                (e) => Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(e.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.description),
                            const SizedBox(height: 5),
                            Text(
                              'Total: \$${CurrencyFormatter.format(e.totalWithToppings ?? 0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                        trailing: onEdit != null
                            ? IconButton(
                                onPressed: () => onEdit!(userTable, e),
                                icon: const Icon(Icons.edit),
                              )
                            : null,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            e.imgUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
      ],
    );
  }
}
