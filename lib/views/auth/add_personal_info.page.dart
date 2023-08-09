import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:app/utils/constants.dart';
import 'package:app/views/widgets/series.builder.dart';
import 'package:flutter/material.dart';

class AddPersonalInfoPage extends StatefulWidget {
  const AddPersonalInfoPage({super.key});

  @override
  State<AddPersonalInfoPage> createState() => _AddPersonalInfoPageState();
}

class _AddPersonalInfoPageState extends State<AddPersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  DateTime? birthDay;

  String username = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Stack(
        children: [
          SeriesBuilder(
            gap: 20.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Dicci di più su di te",
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: "Nome"),
              ),
              TextField(
                controller: _surnameController,
                decoration: const InputDecoration(hintText: "Cognome"),
              ),
              TextField(
                controller: _userController,
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: const InputDecoration(hintText: "Username"),
              ),
              GestureDetector(
                child: Container(
                  width: double.maxFinite,
                  height: 54.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    birthDay != null
                        ? dateFormat.format(birthDay!)
                        : "Data di nascita",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () async {
                  DateTime? selectedData = await showDatePicker(
                      context: context,
                      initialDate: birthDay ??
                          DateTime.now()
                              .copyWith(year: DateTime.now().year - 14),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now()
                          .copyWith(year: DateTime.now().year - 14));

                  if (selectedData != null) {
                    setState(() {
                      birthDay = selectedData;
                    });
                  }
                },
              ),
              ElevatedButton(
                  onPressed: username.isNotEmpty
                      ? () async {
                          setState(() {
                            isLoading = true;
                          });
                          AuthCubit.instance
                              .updateUserData(
                            userName: username,
                            name: _nameController.text,
                            surname: _surnameController.text,
                          )
                              .then((value) {
                            setState(() {
                              isLoading = value as bool;
                            });
                          });
                        }
                      : null,
                  child: const Text("Salva"))
            ],
          ),
          Positioned(
              child: Visibility(
            visible: isLoading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ))
        ],
      ),
    ));
  }
}
