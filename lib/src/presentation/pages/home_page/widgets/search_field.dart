part of '../home_page.dart';

class _SearchField extends StatelessWidget {
  const _SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UiGap.medium.size)
          .copyWith(top: UiGap.small.size),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(UiGap.medium.size),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          isCollapsed: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
          suffixIconConstraints: const BoxConstraints(maxHeight: 40),
          suffixIcon: IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 25,
            splashRadius: 18,
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
