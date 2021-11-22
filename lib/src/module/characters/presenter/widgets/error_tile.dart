import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  final String label;
  final Widget? icon;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const ErrorTile({
    Key? key,
    required this.label,
    this.icon,
    this.onTap,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              if (icon != null) ...[
                const SizedBox(height: 10),
                icon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
