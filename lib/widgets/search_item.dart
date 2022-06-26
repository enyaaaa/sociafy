import 'package:flutter/material.dart';

import '../color/colors.dart';

//widget of the search field
class search_item extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const search_item(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  @override
  State<search_item> createState() => _search_itemState();
}

class _search_itemState extends State<search_item> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive =
        TextStyle(color: primary, fontFamily: "Poppins", fontSize: 14);
    final styleHint =
        TextStyle(color: primary, fontFamily: "Poppins", fontSize: 14);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: background,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: primary),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: primary),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
