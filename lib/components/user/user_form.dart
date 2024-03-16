import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:univates_app/db/sqllite.dart';

class UserForm extends StatefulWidget {
  final Map<String, dynamic>? user;
  const UserForm({super.key, this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

List<String> radioValues = ["User", "Admin"];

class _UserFormState extends State<UserForm> {
  String currentRadioValue = radioValues[0];
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!['nome'] ?? '';
      _emailController.text = widget.user!['email'] ?? '';
      _passController.text = widget.user!['senha'] ?? '';
      currentRadioValue = widget.user!['tipo_usuario'] ?? radioValues[0];
      _selectedDate = DateTime.parse(widget.user!['data_nascimento'] ?? '');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira um nome";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira um email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira uma senha";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Radio(
                    value: 'user',
                    groupValue: currentRadioValue,
                    onChanged: (value) {
                      setState(() {
                        currentRadioValue = value!;
                      });
                    },
                  ),
                  const Text('User'),
                  Radio(
                    value: 'admin',
                    groupValue: currentRadioValue,
                    onChanged: (value) {
                      setState(() {
                        currentRadioValue = value!;
                      });
                    },
                  ),
                  const Text('Admin'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.date_range)),
                  Text(formattedDate),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> updatedUser = {
                            'nome': _nameController.text,
                            'email': _emailController.text,
                            'senha': _passController.text,
                            'tipo_usuario': currentRadioValue,
                            'data_nascimento': _selectedDate.toIso8601String(),
                          };

                          bool saved = await _saveData(updatedUser);

                          if (saved) {
                            Navigator.pop(super.context, true);
                          }
                        }
                      },
                      child: const Text("Save")),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => {Navigator.pop(context, true)},
                      child: const Text("Cancel")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _saveData(user) async {
    DatabaseHelper db = DatabaseHelper();
    final id = widget.user == null ? 0 : widget.user!['id'];
    int dbReturn = 0;

    if (id > 0) {
      dbReturn = await db.update("usuario", user, id);
    } else {
      dbReturn = await db.insert("usuario", user);
    }

    return (dbReturn > 0 ? true : false);
  }
}
