part of '../home_page.dart';

class _FailureBody extends StatelessWidget {
  final AppFailure? failure;
  const _FailureBody({
    Key? key,
    this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: UiGap.big.size),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            failure?.error ?? '',
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
          UiGap.big.verticalSpace,
          OutlinedButton(
            onPressed: () {
              BlocProvider.of<HomePageBloc>(context)
                  .add(const HomePageRefreshCalled());
            },
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
