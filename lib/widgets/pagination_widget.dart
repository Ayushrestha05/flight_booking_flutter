import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartListViewWithPagination<T> extends StatefulWidget {
  final Function() onRefresh;
  final Function() onLoading;
  final bool isScrollable;
  final Widget child;
  final bool showRefresh;
  // final RefreshController refreshController;
  // final Widget Function(T item, int index) itemBuilder;
  const SmartListViewWithPagination({
    Key? key,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
    this.showRefresh = true,
    // required this.refreshController,
    // required this.itemBuilder,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  State<SmartListViewWithPagination> createState() =>
      _SmartListViewWithPaginationState();
}

class _SmartListViewWithPaginationState
    extends State<SmartListViewWithPagination>
    with AutomaticKeepAliveClientMixin {
  // late RefreshController _refreshController;

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: widget.showRefresh,

      onRefresh: () async {
        widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        widget.onLoading();
        _refreshController.loadComplete();
      },
      // enablePullDown: !widget.isChat,
      header: WaterDropHeader(
        complete: SizedBox(),
        waterDropColor: Theme.of(context).brightness == Brightness.light
            ? Colors.blue
            : Colors.black,
      ),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed! Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = CircularProgressIndicator();
          } else {
            body = SizedBox();
          }
          return Container(
            height: 55.0.h,
            child: Center(child: body),
          );
        },
      ),
      child: widget.child,
      // child: ListView.builder(
      //   itemCount: widget.items.length,
      //   physics: widget.isScrollable
      //       ? AlwaysScrollableScrollPhysics()
      //       : NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   itemBuilder: (_, index) {
      //     return widget.itemBuilder(widget.items[index], index);
      //   },
      // ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
