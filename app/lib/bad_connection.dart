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
            'assets/bad_connection.svg',
            height: 300.0,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Bad Connection: Unable to reach the avary'),
          ),
        ],
      ),
    );
  }
}
