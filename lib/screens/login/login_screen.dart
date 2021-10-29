import 'package:flutter/material.dart';
import 'package:loja_virtual_app/helpers/validator.dart';
import 'package:loja_virtual_app/models/user_app.dart';
import 'package:loja_virtual_app/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: const Text(
                'CRIAR CONTA',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      enabled: !userManager.loading,
                      controller: emailController,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      enabled: !userManager.loading,
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return 'O campo deve conter no mínimo 6 caracteres!';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: userManager.loading ? null : () {},
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: userManager.loading
                                ? Colors.grey[400]
                                : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                userManager.signIn(
                                  userApp: UserApp(
                                    name: '',
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword: '',
                                  ),
                                  onFail: (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Falha ao entrar: $error'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Colors.white,
                              ),
                            )
                          : const Text('Entrar'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
