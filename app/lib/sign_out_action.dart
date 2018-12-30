import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './models/current_user_model.dart';

class SignOutAction extends StatelessWidget {
  const SignOutAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CurrentUserModel>(
      builder: (
        BuildContext context,
        Widget child,
        CurrentUserModel model,
      ) {
        return model.status == Status.Authenticated
            ? IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () => _signOut(context),
              )
            : Container();
      },
    );
  }

  void _signOut(BuildContext context) {
    CurrentUserModel.of(context).signOut();
  }
}
