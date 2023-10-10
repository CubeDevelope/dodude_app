import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/user.model.dart';
import 'package:app/views/widgets/series.builder.dart';
import 'package:flutter/material.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();

  late UserModel user;

  @override
  Widget build(BuildContext context) {
    user = AppProvider.instance.currentUser;
    _numberController.text = user.phoneNumber!;
    _nameController.text = user.name!;
    _surnameController.text = user.surname!;
    _nickNameController.text = user.username!;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32.0),
        child: SeriesBuilder(
          gap: 10.0,
          children: [
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(hintText: "Numero di telefono"),
              enabled: false,
            ),
            TextField(
              controller: _nameController,
              enabled: false,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: _surnameController,
              enabled: false,
              decoration: const InputDecoration(hintText: "Cognome"),
            ),
            TextField(
              controller: _nickNameController,
              enabled: false,
              decoration: const InputDecoration(hintText: "Nickname"),
            ),
            ListTile(
              onTap: () {
                //AuthCubit.instance.deleteUser();
              },
              leading: Icon(Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error),
              title: Text(
                "Elimina account",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            )
          ],
        ),
      ),
    );
  }
}
