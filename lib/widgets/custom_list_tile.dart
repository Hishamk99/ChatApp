import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.txt,
    required this.icon,
    required this.onTap,
  });
  final String txt;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
        title: Text(
          txt,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: onTap,
      ),
    );
  }
}
