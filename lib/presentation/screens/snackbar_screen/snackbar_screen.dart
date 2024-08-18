import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/presentation/screens/home/home_screen.dart';

class SnackbarScreen extends StatelessWidget {
  static const String name = "snackbar_screen";

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text("Hola munda"),
      action: SnackBarAction(label: "OK!", onPressed: () {}),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Estás seguro ?'),
        content: const Text(
            "Laboris aliqua consequat enim veniam est qui aute commodo velit minim exercitation. Consequat incididunt amet laborum occaecat cupidatat nostrud commodo officia consequat cillum ex non amet. Reprehenderit consequat ut duis ea excepteur id officia non nulla culpa consectetur in aliquip. Qui irure ipsum elit sunt esse pariatur. Cupidatat qui consectetur enim velit."),
            actions: [
              TextButton(
                onPressed:()=>context.pop(), 
                child: const Text("Cancelar")
              ),
              FilledButton(
                onPressed: ()=>context.pop(), 
                child: const Text("Aceptar"))
            ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snackbars y Diálogos"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  showAboutDialog(context: context, children: [
                    const Text("Estas són las licencias utilizadas.")
                  ]);
                },
                child: const Text('Licencias usadas')),
            FilledButton.tonal(
                onPressed: () =>openDialog(context),
                child: const Text('Mostrar diálogo')),
               
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCustomSnackbar(context),
        icon: const Icon(Icons.remove_red_eye_outlined),
        label: const Text('Mostrar Snackbar'),
      ),
    );
  }
}
