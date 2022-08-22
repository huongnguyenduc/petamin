import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetBreed extends StatelessWidget {
  const PetBreed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "What about\nTommy's breed?",
            style: CustomTextTheme.heading2(context, textColor: Colors.white),
          ),
        ),
        SizedBox(
          height: 64,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
            child: Column(
              children: [
                Expanded(
                    child: Align(
                  alignment: const Alignment(0, -1 / 1.5),
                  child: TextField(
                    key: const Key('addPetForm_nameInput_textField'),
                    style: CustomTextTheme.heading2(context),
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'e.g. Bernardline',
                        hintStyle: CustomTextTheme.heading2(context,
                            textColor: AppTheme.colors.lightGrey)),
                  ),
                )),
                ElevatedButton(
                  key: const Key('next_property_raisedButton'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size.fromHeight(40),
                      primary: AppTheme.colors.pink,
                      onSurface: AppTheme.colors.pink),
                  onPressed: () => context.read<PetAddCubit>().previousStep(),
                  child: Text('Next to Gender',
                      style: CustomTextTheme.label(context)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
