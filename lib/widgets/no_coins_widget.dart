import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';

class NoCoinsWidget extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const NoCoinsWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => CourtesyWidget(
        title: 'Oops!',
        message: 'No coins found.',
        onPressed: onPressed,
      );
}
