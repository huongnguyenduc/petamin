import 'package:Petamin/pet_post/pet_post.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetTransfer extends StatelessWidget {
  const PetTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // TODO: GET Pet data and suggested user
      create: (_) => TransferPetCubit(),
      child: const PetTransferView(),
    );
  }
}

class PetTransferView extends StatelessWidget {
  const PetTransferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Pet'),
        actions: [
          BlocBuilder<TransferPetCubit, TransferPetState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<TransferPetCubit>().transferPet();
                },
                icon: SvgPicture.asset(
                  'assets/icons/send.svg',
                  // TODO: check if form is valid
                  color: AppTheme.colors.yellow,
                  width: 20.0,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('assets/images/cat-1.jpg'),
                  ),
                  SizedBox(width: 16.0),
                  Text("Tyler", style: CustomTextTheme.subtitle(context)),
                ],
              ),
              SizedBox(
                height: 28.0,
              ),
              Text("Suggested user", style: CustomTextTheme.body2(context)),
              SizedBox(
                height: 12.0,
              ),
              DropdownSearch<UserModel>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    autofocus: true,
                    autocorrect: false,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: InputDecoration(
                      labelText: 'New owner name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colors.pink),
                      ),
                    ),
                  ),
                ),
                asyncItems: (String filter) async {
                  var response = await Dio().get(
                    "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
                    queryParameters: {"filter": filter},
                  );
                  var models = UserModel.fromJsonList(response.data);
                  return models;
                },
                onChanged: (UserModel? data) {
                  print(data);
                },
              )
            ],
          )),
    );
  }
}
