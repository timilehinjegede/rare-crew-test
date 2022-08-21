import 'package:flutter/material.dart';
import 'package:rare_crew/utils/utils.dart';

class AtsHomeCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AtsHomeCustomAppBar({
    Key? key,
    required this.title,
    this.titleValue,
    this.onAvatarTapped,
  }) : super(key: key);

  final String title;
  final int? titleValue;
  final VoidCallback? onAvatarTapped;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: rareCrewColors.background,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.fromLTRB(
          hPadding,
          0,
          hPadding,
          vPadding,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (titleValue != null) const XBox(10),
              if (titleValue != null)
                Container(
                  height: 30,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: rareCrewColors.grey,
                  ),
                  child: Center(
                    child: Text(
                      '$titleValue',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: onAvatarTapped,
                customBorder: const CircleBorder(),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2019/02/11/20/20/woman-3990680_1280.jpg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class AtsCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AtsCustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.onLeadingTapped,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onLeadingTapped;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          IconButton(
            onPressed: onLeadingTapped,
            splashRadius: 25,
            icon: const Icon(
              Icons.close_rounded,
              size: 30,
            ),
          ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: hPadding,
          ),
          child: Row(
            children: [
              ...?actions,
            ],
          ),
        ),
      ],
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
