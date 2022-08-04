import 'package:flutter/material.dart';

abstract class BaseStateless extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context);
}
