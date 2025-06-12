// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _senhaFocus = FocusNode();

  Future<void> _loginWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        FocusScope.of(context).requestFocus(_emailFocus);
      } else if (e.code == 'user-not-found') {
        FocusScope.of(context).requestFocus(_emailFocus);
      } else if (e.code == 'wrong-password') {
        FocusScope.of(context).requestFocus(_senhaFocus);
      }

      print('Erro code: ${e.code}');
      print('Erro message: ${e.message}');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Erro desconhecido')));
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_emailFocus);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              focusNode: _emailFocus,
              controller: _emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              focusNode: _senhaFocus,
              controller: _senhaController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _loginWithEmailAndPassword();
              },
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loginWithEmailAndPassword,
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
