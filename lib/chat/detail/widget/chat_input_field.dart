import 'package:Petamin/chat/chat.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField({
    Key? key,
  }) : super(key: key);

  final TextEditingController _textMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        color: AppTheme.colors.superLightPurple,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textMessageController,
              onChanged: (message) => {
                context.read<ChatDetailCubit>().typeMessage(message),
              },
              decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                  hintStyle:
                      CustomTextTheme.caption(context, textColor: AppTheme.colors.grey, fontWeight: FontWeight.w700)),
              onSubmitted: (message) => {
                context.read<ChatDetailCubit>().sendMessage(),
                _textMessageController.clear(),
              },
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () async {
              context.read<ChatDetailCubit>().sendMessage();
              _textMessageController.clear();
            },
            child: Container(
              height: 32.0,
              width: 32.0,
              child: Center(
                  child: AnimateIcon(
                controller: _textMessageController,
                defaultColor: AppTheme.colors.grey,
                activeColor: AppTheme.colors.pink,
                icon: 'assets/icons/location.svg',
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimateIcon extends StatefulWidget {
  const AnimateIcon(
      {Key? key, required this.controller, required this.defaultColor, required this.activeColor, required this.icon})
      : super(key: key);
  final TextEditingController controller;
  final Color defaultColor;
  final Color activeColor;
  final String icon;

  @override
  State<AnimateIcon> createState() => _AnimateIconState(controller, defaultColor, activeColor, icon);
}

class _AnimateIconState extends State<AnimateIcon> {
  late TextEditingController _textMessageController;
  late Color iconColor;
  late Color _defaultColor;
  late Color _activeColor;
  late String _icon;

  _AnimateIconState(TextEditingController textMessageController, Color defaultColor, Color activeColor, String icon) {
    this._textMessageController = textMessageController;
    this._defaultColor = defaultColor;
    this._activeColor = activeColor;
    this._icon = icon;
    iconColor = _defaultColor;
    _textMessageController.addListener(_textMessageChanged);
  }

  _textMessageChanged() {
    if (_textMessageController.text.isEmpty) {
      setState(() {
        iconColor = _defaultColor;
      });
    } else if (iconColor == _defaultColor) {
      setState(() {
        iconColor = _activeColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _icon,
      width: 18.0,
      height: 18.0,
      color: iconColor,
    );
  }
}
