import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_net_ninja/form/form_bloc.dart'
    show FormBloc, UpdateFormEvent;

class InteractiveForm extends StatelessWidget {
  const InteractiveForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<FormBloc>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          onChanged: (value) {
            formBloc.add(UpdateFormEvent('name', value));
          },
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        Text(formBloc.state.data['name'] ?? ''),
      ],
    );
  }
}

class InteractiveFormApp extends StatelessWidget {
  const InteractiveFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Interactive Form'),
        ),
        body: BlocProvider(
          create: (context) => FormBloc(),
          child: const InteractiveForm(),
        ),
      ),
    );
  }
}
