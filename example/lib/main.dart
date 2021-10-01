import 'package:example/validation_rules.dart';
import 'package:flutter/material.dart';
import 'package:validation_notifier/validation_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              constraints: BoxConstraints(
                maxWidth: 512,
                maxHeight: constraints.maxHeight,
              ),
              child: const _LoginForm(),
            ),
          );
        },
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final email = ValidationNotifier<String>(
    rules: [
      RequiredStringRule(),
      EmailFormatRule(),
    ],
  );

  final password = ValidationNotifier<String>(
    rules: [
      RequiredStringRule(),
      StringLengthRule(length: 8),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<ValidationResult<String>>(
          valueListenable: email,
          builder: (context, value, child) {
            return TextFormField(
              onChanged: (v) => email.valueToValidate = v,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: value.errorMessage,
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        ValueListenableBuilder<ValidationResult<String>>(
          valueListenable: password,
          builder: (context, value, child) {
            return TextFormField(
              onChanged: (v) => password.valueToValidate = v,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: value.errorMessage,
              ),
              obscureText: true,
            );
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onLogin,
          child: const Text('LOGIN'),
        )
      ],
    );
  }

  void _onLogin() {
    email.validate();
    password.validate();

    if (email.value.state == ValidationState.valid && password.value.state == ValidationState.valid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields are valid')));
    } else {
      // Invalid
    }
  }
}
