import 'package:Petamin/pet_post/pet_post.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetTransfer extends StatelessWidget {
  const PetTransfer(
      {Key? key,
      required this.petId,
      required this.petName,
      required this.petAvatar})
      : super(key: key);
  final String petId;
  final String petName;
  final String petAvatar;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransferPetCubit(context.read<PetaminRepository>()),
      child: PetTransferView(
        petId: petId,
        petAvatar: petAvatar,
        petName: petName,
      ),
    );
  }
}

class PetTransferView extends StatelessWidget {
  const PetTransferView(
      {Key? key,
      required this.petId,
      required this.petName,
      required this.petAvatar})
      : super(key: key);
  final String petId;
  final String petName;
  final String petAvatar;
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
                  if (state.reciverId != '')
                    context
                        .read<TransferPetCubit>()
                        .transferPet(petId, context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/send.svg',
                  // TODO: check if form is valid
                  color: state.reciverId == ''
                      ? AppTheme.colors.grey
                      : AppTheme.colors.yellow,
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
                      radius: 30.0, backgroundImage: NetworkImage(petAvatar)),
                  SizedBox(width: 16.0),
                  Text(petName, style: CustomTextTheme.subtitle(context)),
                ],
              ),
              SizedBox(
                height: 28.0,
              ),
              Text("Suggested user", style: CustomTextTheme.body2(context)),
              SizedBox(
                height: 12.0,
              ),
              DropdownSearch<Profile>(
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
                  // var response = await Dio().get(
                  //   "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
                  //   queryParameters: {"filter": filter},
                  // );
                  var response = await context
                      .read<PetaminRepository>()
                      .getUserPagination(query: filter, limit: 1000, page: 1);
                  return response.users;
                },
                itemAsString: (item) => item.name!,
                onChanged: (Profile? data) {
                  print(data);
                  context
                      .read<TransferPetCubit>()
                      .updateReciverId(data!.userId!);
                },
              )
            ],
          )),
    );
  }
}
