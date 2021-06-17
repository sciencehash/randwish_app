import 'package:flutter/material.dart';

class ViewLoadingIndicator extends StatelessWidget {
  final bool withScaffold;

  const ViewLoadingIndicator({
    Key? key,
    this.withScaffold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
          )
        : Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(strokeWidth: 1),
            ),
          );
  }
}
