import 'package:flutter/material.dart';
import 'package:interview/data/user.dart';
import 'package:uuid/uuid.dart';

class AddNewUserForm extends StatefulWidget {
  const AddNewUserForm({Key? key}) : super(key: key);

  @override
  State<AddNewUserForm> createState() => _AddNewUserFormState();
}

class _AddNewUserFormState extends State<AddNewUserForm> {
  final _key = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _roleController = TextEditingController();
  final _avatarController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    _avatarController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: ListView(
padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        children: [
          TextFormField(
            controller: _firstNameController,
            validator: (value) => value!.isEmpty ? 'First name is required' : null,
            decoration: const InputDecoration(
              label: Text('First Name'),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _lastNameController,
            validator: (value) => value!.isEmpty ? 'Last name is required' : null,
            decoration: const InputDecoration(
              label: Text('Last Name'),
            ),
          ),
          const SizedBox(height: 10),

          TextFormField(
            controller: _emailController,
            validator: (value) => value!.isEmpty ? 'Email is required' : null,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
          ),
          const SizedBox(height: 10),

          TextFormField(
            controller: _roleController,
            validator: (value) => value!.isEmpty ? 'Role is required' : null,
            decoration: const InputDecoration(
              label: Text('Role'),
            ),
          ),
          const SizedBox(height: 10),

          TextFormField(
            controller: _avatarController,
            decoration: const InputDecoration(
              label: Text('Avatar'),
            ),
          ),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                final user = User(
                  id: Uuid().v4(),
                  avatar: _avatarController.text,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  role: _roleController.text,
                );
                Navigator.pop(context,user);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
