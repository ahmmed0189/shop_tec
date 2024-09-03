import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_tec/src/data/auth_repository.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/features/authentification/validators.dart';
import 'package:shop_tec/src/features/registration/presentation/confimemail_page.dart';
import 'package:shop_tec/src/features/registration/presentation/textformfield/field_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _pwController;
  late TextEditingController _confirmPwController;
  late TextEditingController _fullNameController;
  bool _isLoading = false; // Loading indicator state

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _confirmPwController = TextEditingController();
    _fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = Provider.of<AuthRepository>(context);
    Provider.of<DatabaseRepository>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(27.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/logo/logo.png'),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Let\'s create your account',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode
                        .onUserInteraction, // Immediate feedback for validation
                    child: Column(
                      children: [
                        FieldForm(
                          controller: _fullNameController,
                          label: "Full Name",
                        ),
                        const SizedBox(height: 20),
                        FieldForm(
                          controller: _emailController,
                          label: "Email",
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 20),
                        FieldForm(
                          controller: _pwController,
                          label: "Password",
                          validator: validatePw,
                        ),
                        const SizedBox(height: 20),
                        FieldForm(
                          controller: _confirmPwController,
                          label: "Confirm Password",
                          validator: (value) {
                            return validateRepeatPw(_pwController.text, value!)
                                ? null
                                : "Passwords must match";
                          },
                        ),
                        const SizedBox(height: 20),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    try {
                                      await authRepository
                                          .signUpWithEmailAndPassword(
                                        _emailController.text,
                                        _pwController.text,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ConfimEmailPage(
                                            email: _emailController
                                                .text, // Pass the user's email
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Sign-up failed: $e')),
                                      );
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 80.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ],
                    ),
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
