import 'package:affirmation_gratitude/service/affirmation_auth.dart';
import 'package:affirmation_gratitude/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:affirmation_gratitude/widgets/sizedEmptyScreenSpace.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    deviceSize(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/registration_login.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 94.0,
                      ),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(logo),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: screenWidth(context) > 600 ? 2 : 1,
                    child: const AuthenticationCard(),
                  ),
                  const SizedBox(height: 140),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthenticationCard extends StatefulWidget {
  const AuthenticationCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthenticationCardState createState() => _AuthenticationCardState();
}

class _AuthenticationCardState extends State<AuthenticationCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _email = '';
  String _password = '';

  bool isLogin = true;
  bool _isLoading = false;

  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    if (isLogin) {
      try {
        await _login();
      } catch (_) {
        return;
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      try {
        await _signUp();
      } catch (_) {
        return;
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _login() async {
    try {
      // Provider.of<AffirmationAuth>(context, listen: false)
      await context.read<AffirmationAuth>().login(
            context,
            email: _email,
            password: _password,
          );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _signUp() async {
    try {
      await context.read<AffirmationAuth>().signUp(
            context,
            email: _email,
            password: _password,
          );
    } catch (_) {
      rethrow;
    }
  }

  // switches from login to signUp mode or other way around
  void toggleAuthMode() {
    setState(() => isLogin = !isLogin);
  }

  @override
  Widget build(BuildContext context) {
    deviceSize(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: isLogin ? 320 : 260,
        constraints: BoxConstraints(minHeight: isLogin ? 320 : 260),
        width: screenWidth(context) * 0.75,
        padding: const EdgeInsets.all(16.00),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short';
                    }
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                if (!isLogin)
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Password do not match';
                        }
                      }),
                horizontalSpaceRegular,
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 8.0,
                      ),
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: _submit,
                    child: Text(isLogin ? 'LOGIN' : 'SIGN UP'),
                  ),
                TextButton(
                  onPressed: toggleAuthMode,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 4.0,
                    ),
                    textStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  child: Text('${isLogin ? 'SIGN UP' : 'LOGIN'} INSTEAD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
