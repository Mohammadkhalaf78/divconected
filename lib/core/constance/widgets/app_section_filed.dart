import 'package:flutter/material.dart';

class AppSelectedForm<T> extends StatelessWidget {
  const AppSelectedForm({
    super.key,
    required this.controller,
    required this.labelText,
    required this.items,
    required this.itemLabel,
    required this.onSelected,
  });

  final TextEditingController controller;
  final String labelText;
  final List<T> items;
  final String Function(T item) itemLabel;
  final void Function(T selected) onSelected;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      controller: controller,
      onTap: () async {
        final selected = await showModalBottomSheet<T>(
          context: context,
          builder: (bottomSheetContext) {
            return ListView(
              shrinkWrap: true,
              children: items.map((item) {
                return ListTile(
                  title: Text(itemLabel(item)),
                  onTap: () {
                    Navigator.pop(bottomSheetContext, item);
                  },
                );
              }).toList(),
            );
          },
        );
        if (!context.mounted) return;
        if (selected != null) {
          controller.text = itemLabel(selected);
          onSelected(selected);
        }
      },
    );
  }
}
