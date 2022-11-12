import 'package:Petamin/home/widgets/avatar.dart';
import 'package:Petamin/pet_post/pet_post.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetCreatePost extends StatelessWidget {
  const PetCreatePost(
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
      create: (_) => CreatePostCubit(context.read<PetaminRepository>()),
      child: PetCreatePostView(
        petId: petId,
        petImage: petImage,
        petName: petName,
      ),
    );
  }
}

class PetCreatePostView extends StatefulWidget {
  const PetCreatePostView(
      {required this.petId,
      required this.petName,
      required this.petImage,
      Key? key})
      : super(key: key);
  final String petId;
  final String petName;
  final String petImage;

  @override
  State<PetCreatePostView> createState() => _PetCreatePostViewState();
}

class _PetCreatePostViewState extends State<PetCreatePostView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Adopt Post'),
        actions: [
          BlocBuilder<CreatePostCubit, CreatePostState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return IconButton(
                onPressed: ()  {
                   context.read<CreatePostCubit>().submit(
                      priceController.text,
                      descriptionController.text,
                      widget.petId);
                },
                icon: SvgPicture.asset(
                  'assets/icons/send.svg',
                  color: state.status != PostAdoptStatus.isPosted
                      ? AppTheme.colors.yellow
                      : AppTheme.colors.grey,
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
              TextFormField(
                controller: priceController,
                style: CustomTextTheme.body2(context),
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  fillColor: AppTheme.colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.colors.pink, width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.colors.lightPurple, width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0))),
                  helperText: '',
                  labelText: 'Price',
                  labelStyle: CustomTextTheme.body2(context,
                      textColor: AppTheme.colors.lightGreen),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: descriptionController,
                maxLength: 100,
                style: CustomTextTheme.body2(context),
                decoration: InputDecoration(
                  fillColor: AppTheme.colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.colors.pink, width: 2.0),
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
            ],
          )),
    );
  }
}
