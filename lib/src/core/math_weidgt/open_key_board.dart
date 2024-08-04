import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final TextEditingController _controller = TextEditingController();
final FocusNode _focusNode = FocusNode();

void openKeyboard({required context, required void Function(String) action}) {
  _focusNode.addListener(() {
    if (!_focusNode.hasFocus) {
      Navigator.pop(context);
    }
  });

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: _controller,
          autofocus: true,
          focusNode: _focusNode,
          keyboardType: TextInputType.number,
          onSubmitted: (value) => action(value),
          decoration: InputDecoration(
            prefixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
          ),
        ),
      );
    },
  ).whenComplete(() {
    _controller.clear();
    FocusScope.of(context).unfocus();
    _focusNode.unfocus();
    // Restore the system UI overlays when the modal is closed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  });
}
