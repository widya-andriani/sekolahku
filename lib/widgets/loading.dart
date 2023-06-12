import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/dimen_res.dart';

class Loading extends StatelessWidget {
  final String message;

  const Loading({
    super.key,
    this.message = ""
  });

  Widget _createMessageWidget(String message) {
    return Column(
      children: [
        const SizedBox(height: DimenRes.size_16),
        Text(message, maxLines: 3, textAlign: TextAlign.center)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimenRes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message.isNotEmpty) _createMessageWidget(message)
        ],
      ),
    );
  }
}