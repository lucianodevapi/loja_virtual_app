import 'package:flutter/material.dart';
import 'package:loja_virtual_app/helpers/validator.dart';
import 'package:loja_virtual_app/models/user_app.dart';
import 'package:loja_virtual_app/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserApp userApp = UserApp(
    name: '',
    email: '',
    password: '',
    confirmPassword: '',
  );

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.name,
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome completo';
                        } else {
                          null;
                        }
                      },
                      onSaved: (name) => userApp.name = name!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!emailValid(email)) {
                          return 'E-mail inválido';
                        } else {
                          null;
                        }
                      },
                      onSaved: (email) => userApp.email = email!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (password.length < 6) {
                          return 'O campo deve conter no mínimo 6 caracteres.';
                        } else {
                          null;
                        }
                      },
                      onSaved: (password) => userApp.password = password!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Confirmar Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (confirmPassword) {
                        if (confirmPassword!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (confirmPassword.length < 6) {
                          return 'O campo deve conter no mínimo 6 caracteres.';
                        } else {
                          null;
                        }
                      },
                      onSaved: (confirmPassword) =>
                          userApp.confirmPassword = confirmPassword!,
                    ),
                    const SizedBox(height: 40),
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
                                formKey.currentState!.save();
                                if (userApp.password !=
                                    userApp.confirmPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Senhas não coincidem'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                userManager.signUp(
                                  userApp: userApp,
                                  onFail: (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Falha ao cadastrar: $error'),
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
                          : const Text('Criar Conta'),
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
