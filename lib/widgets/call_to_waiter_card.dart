import 'package:flutter/material.dart';

class CallToWaiterCard extends StatelessWidget {
  const CallToWaiterCard({
    required this.needWaiter,
    required this.onCallWaiter,
    super.key,
  });

  final bool needWaiter;
  final void Function(bool isCalling) onCallWaiter;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                needWaiter ? '¿Estas llamando al mesero?' : '¿Necesitas ayuda?',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
              child: TextButton(
                onPressed: () => onCallWaiter(needWaiter),
                child: Text(
                  needWaiter ? 'Dejar de llamar al mesero' : 'Llamar al mesero',
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
