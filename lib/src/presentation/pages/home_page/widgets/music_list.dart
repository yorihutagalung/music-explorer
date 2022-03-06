part of '../home_page.dart';

class _MusicList extends StatelessWidget {
  const _MusicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      separatorBuilder: (context, _) => Padding(
        padding: EdgeInsets.symmetric(horizontal: UiGap.normal.size),
        child: Divider(
          color: Theme.of(context).primaryColor,
          height: 0,
        ),
      ),
      itemBuilder: (context, index) {
        final number = index + 1;
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(UiGap.normal.size),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  width: 60,
                  height: 60,
                ),
                UiGap.normal.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Music no #$number"),
                      UiGap.small.verticalSpace,
                      Text(
                        "Album of music of #$number",
                      ),
                      UiGap.small.verticalSpace,
                      Text(
                        "Description of music of #$number",
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
