import 'package:flutter/material.dart';

class SubpageAppBar extends StatelessWidget {
  final String title;
  const SubpageAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42.5,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          const SizedBox(width: 10),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
