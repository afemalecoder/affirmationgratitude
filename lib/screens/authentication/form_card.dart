part of authentication;

class _FormCard extends StatefulWidget {
  const _FormCard({
    Key? key,
  }) : super(key: key);

  @override
  __FormCardState createState() => __FormCardState();
}

class __FormCardState extends State<_FormCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _name = '';
  String _email = '';
  String _password = '';

  bool isLogin = true;
  bool _isLoading = false;

  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

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
      await context.read<AffirmationAuth>().login(
            context,
            email: _email,
            password: _password,
          );
      Navigator.of(context)
          .pushReplacementNamed(AffirmationNavigation.routeName);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _signUp() async {
    try {
      await context.read<AffirmationAuth>().signUp(
            context,
            displayName: _name,
            email: _email,
            password: _password,
          );
      Navigator.of(context)
          .pushReplacementNamed(AffirmationNavigation.routeName);
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
    return Flexible(
      flex: screenWidth(context) > 600 ? 2 : 1,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: Container(
          height: isLogin ? 400 : 400,
          constraints: BoxConstraints(minHeight: isLogin ? 400 : 400),
          width: screenWidth(context) * 0.75,
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Welcome to Affirtude',
                    style: TextStyle(
                      fontSize: 35,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (!isLogin)
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Username is too short';
                        }
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
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
                  const SizedBox(height: 25.0),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10.0,
                        ),
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: _submit,
                      child: Text(isLogin ? 'LOGIN' : 'SIGN UP'),
                    ),
                 const SizedBox(height: 10),
                  TextButton(
                    onPressed: toggleAuthMode,
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onSurface,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 4.0,
                      ),
                    ),
                    child: Text('${isLogin ? 'SIGN UP' : 'LOGIN'} INSTEAD'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
