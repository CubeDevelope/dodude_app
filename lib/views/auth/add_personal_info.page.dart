import 'package:app/business_logic/blocs/app.provider.dart';
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
  bool isUsernameAvailable = true;

  _checkUsername() async {
    bool available = false;

    if (username.isNotEmpty && username.length > 4) {
      available = await AppProvider.instance.authCubit.checkUsername(username);
      if (available != isUsernameAvailable) {
        setState(() {
          isUsernameAvailable = available;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SeriesBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          gap: 20.0,
          mainAxisAlignment: MainAxisAlignment.center,
          isScrollable: true,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _userController,
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                    if (username.isNotEmpty) _checkUsername();
                  },
                  decoration: const InputDecoration(hintText: "Username"),
                ),
                Visibility(
                  visible: username.length > 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Ciao",
                      style: TextStyle(
                          color:
                              isUsernameAvailable ? Colors.green : Colors.red),
                    ),
                  ),
                )
              ],
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
                        DateTime.now().copyWith(year: DateTime.now().year - 14),
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
                onPressed: isUsernameAvailable
                    ? () async {
                        setState(() {
                          isLoading = true;
                        });
                        AppProvider.instance.authCubit
                            .addInformationToDB(
                          userName: username,
                          name: _nameController.text,
                          surname: _surnameController.text,
                        )
                            .then((value) {
                          setState(() {
                            isLoading = value;
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
    );
  }
}
