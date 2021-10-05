import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      // child: Platform.isAndroid ? const CircularProgressIndicator() : const CupertinoActivityIndicator(),
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
