import 'package:Petamin/home/home.dart';
import 'package:Petamin/pet_post/pet_post.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetEditPost extends StatelessWidget {
  const PetEditPost(
      {required this.petId,
      required this.petName,
      required this.petImage,
      Key? key})
      : super(key: key);
  final String petId;
  final String petName;
  final String petImage;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // TODO: GET adopt post data from API and update to initial data
      create: (_) => EditPostCubit(context.read<PetaminRepository>())
        ..getAdoptDetail(petId),
      child:  PetEditPostView(petName: petName, petImage: petImage),
    );
  }
}

class PetEditPostView extends StatefulWidget {
  const PetEditPostView({required this.petName, required this.petImage ,Key? key}) : super(key: key);
  final String petName;
  final String petImage;
  @override
  State<PetEditPostView> createState() => _PetEditPostViewState();
}

class _PetEditPostViewState extends State<PetEditPostView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Adopt Post'),
        actions: [
          BlocBuilder<EditPostCubit, EditPostState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<EditPostCubit>().submit(
                      priceController.text, descriptionController.text);
                },
                icon: SvgPicture.asset(
                  'assets/icons/send.svg',
                  color: 
                      AppTheme.colors.yellow,
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
            children: [
              Row(
                children: [             
                  Avatar(
                    photo: widget.petImage,
                    ),
                  SizedBox(width: 16.0),
                  Text(widget.petName,
                      style: CustomTextTheme.subtitle(context)),
                ],
              ),
              SizedBox(
                height: 28.0,
              ),
              BlocListener<EditPostCubit, EditPostState>(
                listener: (context, state) =>
                    priceController.text = state.initPrice,
                child:  TextFormField(
                    controller: priceController,
                    style: CustomTextTheme.body2(context),
                    keyboardType: TextInputType.number,
                    // onChanged: (price) =>
                    //     context.read<EditPostCubit>().priceChanged(price),
                     decoration: InputDecoration(
                      fillColor: AppTheme.colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.colors.pink, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.colors.lightPurple, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      helperText: '',
                      labelText: 'Price',
                     // errorText: state.price.invalid ? 'Invalid price' : null,
                      labelStyle: CustomTextTheme.body2(context,
                          textColor: AppTheme.colors.lightGreen),
                    ),
                  ),
              ),
              SizedBox(
                height: 8.0,
              ),
               BlocListener<EditPostCubit, EditPostState>(
                listener: (context, state) =>
                    descriptionController.text = state.initDescription,
                child: TextFormField(
                    controller: descriptionController,
                    style: CustomTextTheme.body2(context),
                    // onChanged: (description) => context
                    //     .read<EditPostCubit>()
                    //     .descriptionChanged(description),
                    decoration: InputDecoration(
                      fillColor: AppTheme.colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.colors.pink, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.colors.lightPurple, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      helperText: '',
                      labelText: 'Description',
                      labelStyle: CustomTextTheme.body2(context,
                          textColor: AppTheme.colors.lightGreen),
                    ),
                  ),
              ),
            ],
          )),
    );
  }
}
