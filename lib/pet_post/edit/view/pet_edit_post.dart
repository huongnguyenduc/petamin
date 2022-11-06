import 'package:Petamin/pet_post/pet_post.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class PetEditPost extends StatelessWidget {
  const PetEditPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // TODO: GET adopt post data from API and update to initial data
      create: (_) => EditPostCubit(),
      child: const PetEditPostView(),
    );
  }
}

class PetEditPostView extends StatelessWidget {
  const PetEditPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Adopt Post'),
        actions: [
          BlocBuilder<EditPostCubit, EditPostState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<EditPostCubit>().submit();
                },
                icon: SvgPicture.asset(
                  'assets/icons/send.svg',
                  color: state.status.isValidated ? AppTheme.colors.yellow : AppTheme.colors.grey,
                  width: 20.0,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0), child: Column(children: [
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
        SizedBox(height: 28.0,),
        BlocBuilder<EditPostCubit, EditPostState>(
          buildWhen: (previous, current) => previous.initPrice != current.initPrice,
          builder: (context, state) {
            return TextFormField(
              initialValue: state.initPrice,
              style: CustomTextTheme.body2(context),
              keyboardType: TextInputType.number,
              onChanged: (price) =>
                  context.read<EditPostCubit>().priceChanged(price),
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
                errorText: state.price.invalid ? 'Invalid price' : null,
                labelStyle: CustomTextTheme.body2(context,
                    textColor: AppTheme.colors.lightGreen),
              ),
            );
          },
        ),
        SizedBox(height: 8.0,),
        BlocBuilder<EditPostCubit, EditPostState>(
          buildWhen: (previous, current) => previous.initDescription != current.initDescription,
          builder: (context, state) {
            return TextFormField(
              style: CustomTextTheme.body2(context),
              onChanged: (description) =>
                  context.read<EditPostCubit>().descriptionChanged(description),
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
            );
          },
        ),
      ],)),
    );
  }
}

