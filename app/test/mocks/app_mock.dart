import 'package:birb/models/current_user_model.dart';
import 'package:birb/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

ScopedModel<CurrentUserModel> appMock({
  @required Widget child,
  @required CurrentUserModel mock,
}) {
  return ScopedModel<CurrentUserModel>(
    model: mock,
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
      routes: <String, WidgetBuilder>{
        RegisterPage.routeName: (BuildContext context) => const RegisterPage(),
      },
    ),
  );
}
