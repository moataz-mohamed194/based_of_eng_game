import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../cubit/current_game_phonetics_cubit.dart';
import '../../games/math/CT_number/manager/ct_number_cubit.dart';

final TextEditingController _controller = TextEditingController();
final FocusNode _focusNode = FocusNode();

void openKeyboard({required context, required void Function(String) action}) {
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
    print('_focusNode:$_focusNode');
    _controller.clear();
    FocusScope.of(context).unfocus();
    _focusNode.unfocus();
    // Restore the system UI overlays when the modal is closed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  });
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
}
