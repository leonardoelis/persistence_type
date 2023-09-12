import 'package:flutter/material.dart';
import 'package:persistence_type/floor/models/book.dart';

class FormBookWidget extends StatelessWidget {
  FormBookWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const title = Text("Novo Livro");
    return Scaffold(
        appBar: AppBar(
          title: title,
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration:
                        InputDecoration(hintText: "Nome", labelText: "Nome"),
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nome Inválido";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Autor", labelText: "Autor"),
                    controller: _authorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Autor inválido";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                      child: const Text("Salvar"),
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                              Book book = Book(_nameController.text, _authorController.text);
                              Navigator.pop(context, book);
                            }
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
