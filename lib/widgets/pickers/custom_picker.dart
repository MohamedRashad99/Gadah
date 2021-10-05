import 'package:flutter/material.dart';

///Use with `CustomPickerSheet`
Future<T?> showCustomPickerSheet<T>(
    {required BuildContext context, required WidgetBuilder builder}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}

class CustomPickerSheet extends StatelessWidget {
  final Widget? content;
  final Widget? title;
  final List<Widget> options;

  const CustomPickerSheet({
    Key? key,
    this.content,
    this.title,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            title ?? const SizedBox(),
            const SizedBox(height: 5),
            content ?? const SizedBox(),
            const Divider(),
            ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final _option = options[index];
                return _option;
              },
            )
          ],
        ),
      ),
    );
  }
}
