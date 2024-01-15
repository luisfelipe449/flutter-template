import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_starter/core/extension/context.dart';
import 'package:scalable_flutter_app_starter/core/navigation/route.dart';
import 'package:scalable_flutter_app_starter/core/ui/input/input_field.dart';
import 'package:scalable_flutter_app_starter/core/ui/widget/labeled_text_button.dart';
import 'package:scalable_flutter_app_starter/core/ui/widget/loading_overlay.dart';
import 'package:scalable_flutter_app_starter/core/ui/widget/responsive.dart';
import 'package:scalable_flutter_app_starter/feature/auth/bloc/auth_cubit.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _onAuthState,
      builder: (context, state) {
        return LoadingOverlay(
          loading: state is AuthLoading,
          child: Scaffold(
            appBar: AppBar(),
            body: ConstrainedWidth.mobile(
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        Image.asset(
                          'assets/images/logot.png',
                          width: 100,
                          height: 100,
                          color: const Color.fromARGB(255, 39, 99, 63),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _isSignUp ? '' : '',
                          style: context.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        InputField.email(
                          controller: _emailController,
                          label: 'Usuário',
                        ),
                        const SizedBox(height: 16),
                        InputField.password(
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          label: 'Senha',
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _submit,
                          child: Text(_isSignUp ? '' : 'Entrar'),
                        ),
                        const SizedBox(height: 50),
                        LabeledTextButton(
                          label: '',
                          action: 'Portal do Servidor',
                          // onTap should send to auth_page_ad.dart
                          onTap: () => AppRoute.authAd.go(context),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showSnackBarMessage(
        state.errorMessage,
        isError: true,
      );
      return;
    }

    if (state is AuthSuccess) {
      if (state.user != null) {
        AppRoute.home.go(context);
      }
    }
  }

  void _submit() {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }

    context.closeKeyboard();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_isSignUp) {
      context.read<AuthCubit>().signUpWithEmailAndPassword(
            email: email,
            password: password,
          );
    } else {
      context.read<AuthCubit>().signInWithEmailAndPassword(
            email: email,
            password: password,
          );
    }
  }
}
