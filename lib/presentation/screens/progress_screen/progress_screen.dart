import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = "progress_Screen";
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
        child: Column(
      children: [
        const SizedBox(height: 30),
        const Text("Circular progress indicator"),
        const SizedBox(height: 10),
        CircularProgressIndicator(
          strokeWidth: 3,
          color: colors.primary,
          backgroundColor: Colors.black12,
        ),
        const SizedBox(height: 20),
        const Text('Circula indicador controlado'),
        const SizedBox(height: 10),
        const _ControlledProgressIndicator()
      ],
    ));
  }
}

class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 300),(value){
        return (value *2 )/100;
      }).takeWhile((value)=>value<100),
      builder:(context, snapshot) {
         final value=snapshot.data??0;
         return   Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value:value,
              strokeWidth: 2,
              backgroundColor: Colors.black12,
            ),
            SizedBox(width: 10),
            Expanded(
                child: LinearProgressIndicator(
                  value:value ,
                  backgroundColor: Colors.black12))
          ],
        ),
      );
      }
    );
  }
}
