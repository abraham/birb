import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadConnection extends StatelessWidget {
  const BadConnection();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/connection_error',
            height: 300.0,
          ),
          const Text('Unable to reach the avary'),
        ],
      ),
    );
  }
}
