import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSize {
  final Widget? title;
  final bool leading;
  final Widget? profile;
  final Widget? thememode;
  final Color? backgroudcolor;
  const BasicAppBar(
      {super.key,
      this.title,
      this.leading = false,
      this.profile,
      this.thememode,
      this.backgroudcolor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      actions: [
        profile ?? const SizedBox(),
        thememode ?? const SizedBox(),
      ],
      title: title ?? const Text(""),
      backgroundColor: backgroudcolor ?? Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: leading
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ))
          : const SizedBox(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  // TODO: implement child
  Widget get child => const SizedBox();
}
