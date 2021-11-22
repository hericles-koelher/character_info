import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  final String label;
  final Widget? icon;
  final void Function()? onTap;

  const ErrorTile({
    Key? key,
    required this.label,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              if (icon != null) icon!,
            ],
          ),
        ),
      ),
    );
  }
}
