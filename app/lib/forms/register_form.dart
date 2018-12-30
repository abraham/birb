import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/current_user_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  FirebaseUser _firebaseUser;
  // TODO(abraham): refactor _formData to use a class.
  final Map<String, String> _formData = <String, String>{
    'nickname': '',
    'fullName': '',
    'photoUrl': '',
  };

  @override
  Widget build(BuildContext context) {
    _firebaseUser = CurrentUserModel.of(context).firebaseUser;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            initialValue: _initialNickname(),
            decoration: const InputDecoration(
              labelText: 'Nickname',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Nickname is required';
              }
            },
            onSaved: (String value) => _formData['nickname'] = value,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            initialValue: _firebaseUser.displayName,
            decoration: const InputDecoration(
              labelText: 'Full name',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Full name is required';
              }
            },
            onSaved: (String value) => _formData['fullName'] = value,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  String _initialNickname() {
    return _firebaseUser.displayName.split(' ').first;
  }

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _formData['photoUrl'] = _firebaseUser.photoUrl;

      try {
        await CurrentUserModel.of(context).register(_formData);
      } catch (e) {
        _showSnackBar(context, 'Error submitting form');
      }
    }
  }

  void _showSnackBar(BuildContext context, String msg) {
    final SnackBar snackBar = SnackBar(content: Text(msg));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
