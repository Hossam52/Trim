import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/widgets/barber_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:loadmore/loadmore.dart';

class PersonsGridView extends StatelessWidget {
  final _controller = EasyRefreshController();
  final bool filterFavorite;
  PersonsGridView({Key key, this.filterFavorite = false});
  @override
  Widget build(BuildContext context) {
    final trimStarList = HomeCubit.getInstance(context).trimStarList;
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => EasyRefresh(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        onLoad: () async {
          print('Load');
          await Future.delayed(Duration(seconds: 2));
          _controller.finishLoad(noMore: false);
        },
        onRefresh: () async {
          print(1);
          await Future.delayed(Duration(seconds: 3));
          _controller.resetLoadState();
        },
        footer: ClassicalFooter(
            overScroll: true,
            loadingText: 'Refreshing...',
            loadedText: 'Refreshed completely.',
            loadReadyText: 'Ready to refresh',
            showInfo: false),
        header: ClassicalHeader(
            refreshingText: 'Loading...',
            refreshedText: 'Loaded completely.',
            refreshReadyText: 'Ready to Load',
            showInfo: false),
        bottomBouncing: false,
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: trimStarList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BarberItem(
                    barber: trimStarList[index], deviceInfo: deviceInfo));
          },
        ),
      ),
    );
  }
}
