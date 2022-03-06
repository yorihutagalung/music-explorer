part of '../home_page.dart';

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: UiGap.big.size),
      child: const Text(
        "No music found.\nTry to search musics by artist name \nin the field above",
        textAlign: TextAlign.center,
      ),
    );
  }
}
