import 'package:brick/brick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:pull_to_refresh/pull_to_refresh.dart';

const _tag = 'ListRefreshWidget';

/// 用法
/// '''dart
///ListRefreshWidget<int>(
///    enableLoadMore: true,
///    refreshNotifier: _intListNotifier,
///    itemBuilder: (context, value, index) {
///      debugPrint('_PullRefreshPageState.build: value $value; index $index');
///      return Container(
///        color: index % 2 == 0 ? Colors.cyan : Colors.cyanAccent,
///        child: ListTile(
///          title: TextPlain(text: '$index', size: 14, color: Colors.black),
///        ),
///      );
///    },
///  )
/// '''

/// 列表类型
enum ListType {
  /// 竖直列表
  list,

  /// 网格
  grid,
}

class ListRefreshWidget<T> extends StatefulWidget {
  final ListType listType;

  final EdgeInsets padding;

  /// 支持加载更多
  final bool enableLoadMore;

  /// 支持下拉刷新
  final bool enableRefresh;

  /// 自动加载数据
  final bool enableAutoRefresh;

  /// [loader] 需要继承 [ListRefreshLoader] 提供数据
  final ListRefreshLoader<T> loader;

  /// ListView item view 构造方法
  final Function(BuildContext context, T value, int index) itemBuilder;

  /// 第一次加载数据默认loading widget
  final Widget? loadingWidget;

  /// 第一次加载的时候是否显示loading widget
  final bool showLoadingWhenFirstLoad;

  /// 第一次加载失败 widget
  final Widget? failureWidget;

  /// 空数据 widget
  final Widget? emptyWidget;

  /// 收缩布局
  final bool shrinkWrap;

  /// 刷新列表完成后的回调
  final VoidCallback? onRefreshCompleted;

  final ScrollPhysics physics;

  /// 网格类型需要传
  final SliverGridDelegate? gridDelegate;

  const ListRefreshWidget({
    super.key,
    this.padding = EdgeInsets.zero,
    this.enableLoadMore = false,
    this.enableRefresh = true,
    required this.loader,
    required this.itemBuilder,
    this.listType = ListType.list,
    this.enableAutoRefresh = true,
    this.loadingWidget,
    this.showLoadingWhenFirstLoad = true,
    this.emptyWidget,
    this.failureWidget,
    this.shrinkWrap = false,
    this.onRefreshCompleted,
    this.physics = const BouncingScrollPhysics(),
    this.gridDelegate,
  });

  @override
  State<ListRefreshWidget<T>> createState() => _ListRefreshWidgetState<T>();
}

class _ListRefreshWidgetState<T> extends State<ListRefreshWidget<T>> {
  late RefreshController _refreshController;

  late ListRefreshLoader<T> _refreshNotifier;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _refreshNotifier = widget.loader;
    _refreshController = _refreshNotifier._refreshController;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.enableAutoRefresh) {
        _refreshNotifier.refresh(showLoading: true);
        widget.loader.scrollController = _scrollController;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _refreshNotifier,
      child:
          Consumer(builder: (builderContext, ListRefreshLoader<T> notifier, _) {
        debugPrint(
            '_ListRefreshWidgetState.build: isDataEmpty ${notifier.isDataEmpty}');
        switch (notifier.loadingStatus) {
          case LoadingStatus.loading:
            return loadingWidget();
          case LoadingStatus.success:
            if (notifier.isDataEmpty) {
              return emptyWidget();
            }
            return refreshBody(notifier);
          case LoadingStatus.failure:
            return failureWidget();
        }
      }),
    );
  }

  Widget refreshBody(ListRefreshLoader<T> notifier) {
    return SmartRefresher(
      enablePullUp: widget.enableLoadMore,
      enablePullDown: widget.enableRefresh,
      controller: _refreshController,
      scrollController: _scrollController,
      onRefresh: () async {
        debugPrint('_ListRefreshWidgetState.build: refresh');
        await _refreshNotifier.refresh(resetControllerStatus: false);
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        widget.onRefreshCompleted?.call();
      },
      onLoading: () async {
        debugPrint('_ListRefreshWidgetState.build: onLoading');
        _refreshNotifier.load(
          onLoadNoMoreDataSuccess: (data) {
            _refreshController.loadNoData();
          },
          onLoadSuccess: (data) {
            _refreshController.loadComplete();
          },
          onLoadFailure: () {
            _refreshController.loadFailed();
          },
        );
      },
      child: widget.listType == ListType.list
          ? bodyListView(notifier)
          : bodyGridView(notifier),
    );
  }

  Widget bodyListView(ListRefreshLoader<T> notifier) {
    return ListView.builder(
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      itemCount: notifier.data.length,
      physics: widget.physics,
      primary: false,
      itemBuilder: (builderContext, index) {
        return widget.itemBuilder
            .call(builderContext, notifier.data[index], index);
      },
    );
  }

  Widget bodyGridView(ListRefreshLoader<T> notifier) {
    return GridView.builder(
      gridDelegate: widget.gridDelegate!,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      itemCount: notifier.data.length,
      physics: widget.physics,
      primary: false,
      itemBuilder: (builderContext, index) {
        return widget.itemBuilder
            .call(builderContext, notifier.data[index], index);
      },
    );
  }

  /// loading widget
  Widget loadingWidget() {
    return Center(
      child: widget.loadingWidget ??
          const SizedBox(
            height: 24,
            width: 24,
            child: CupertinoActivityIndicator(
              radius: 24 * 0.5,
            ),
          ),
    );
  }

  /// 默认无数据的填充页面
  Widget emptyWidget() {
    return Container(
      alignment: Alignment.topCenter,
      child: widget.emptyWidget ??
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: const TextPlain(text: '暂无数据', size: 14, color: Colors.black),
          ),
    );
  }

  /// 加载失败
  Widget failureWidget() {
    return Container(
      alignment: Alignment.topCenter,
      child: widget.failureWidget ??
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: const TextPlain(text: '加载失败', size: 14, color: Colors.black),
          ),
    );
  }
}

/// 加载数据成功
typedef OnLoadSuccess<T> = Function(List<T> data);

/// 加载数据成功，没有更多数据
typedef OnLoadNoMoreDataSuccess<T> = Function(List<T> data);

/// 数据加载失败
typedef OnLoadFailure<T> = Function();

abstract class ListRefreshLoader<T> extends ChangeNotifier {
  final RefreshController _refreshController = RefreshController();

  ScrollController? _scrollController;

  /// 默认起始页索引
  int startPage = 1;

  List<T> data = [];

  int page = 1;

  int pageSize = 15;

  bool _noMoreData = false;

  /// 加载状态
  LoadingStatus loadingStatus = LoadingStatus.success;

  ListRefreshLoader({this.startPage = 1, this.pageSize = 15}) {
    page = startPage;
  }

  int get dataLength => data.length;

  bool get isDataEmpty => data.isEmpty;

  bool get isDataNotEmpty => data.isNotEmpty;

  /// 子类需要实现此方法来提供数据源
  Future<List<T>> feed(int page, int pageSize);

  set scrollController(ScrollController value) {
    _scrollController = value;
  }

  /// 刷新数据
  /// 返回true代表刷新成功
  Future<bool> refresh({
    bool resetControllerStatus = true,
    bool scrollToTop = true,
    bool showLoading = false,
  }) async {
    if (showLoading) {
      loadingStatus = LoadingStatus.loading;
      notifyListeners();
    }
    page = startPage;
    bool success = await load(clear: true);
    if (resetControllerStatus) {
      _refreshController.refreshCompleted(resetFooterState: true);
    }
    if (scrollToTop) {
      if (_scrollController?.hasClients ?? false) {
        _scrollController?.jumpTo(0);
      }
    }
    return success;
  }

  /// 开始加载数据
  /// 返回true代表load成功
  /// [clear] 清除之前的数据
  Future<bool> load({
    OnLoadSuccess? onLoadSuccess,
    OnLoadNoMoreDataSuccess? onLoadNoMoreDataSuccess,
    OnLoadFailure? onLoadFailure,
    bool clear = false,
  }) async {
    List<T> result;
    try {
      result = await feed(page, pageSize);
      if (result.length < pageSize) {
        _noMoreData = true;
      } else {
        _noMoreData = false;
      }
      if (clear) {
        data.clear();
      }
      data.addAll(result);
      page++;
      loadingStatus = LoadingStatus.success;
      notify();
      if (_noMoreData) {
        onLoadNoMoreDataSuccess?.call(data);
      } else {
        onLoadSuccess?.call(data);
      }
      return true;
    } catch (e, stackTrace) {
      debugPrint('ListRefreshNotifier.loadMore: ');
      if (kDebugMode) {
        print(e);
        print(stackTrace);
      }
      loadingStatus = LoadingStatus.failure;
      notify();
      onLoadFailure?.call();
      return false;
    }
  }

  /// refresh 前需要重置页码
  void resetPage({int? pageIndex, int? pageSize}) {
    if (pageIndex != null) {
      page = pageIndex;
    } else {
      page = startPage;
    }
    if (pageSize != null) {
      this.pageSize = pageSize;
    }
  }

  /// 修改当前加载状态
  void updateLoadStatus(LoadingStatus status) {
    loadingStatus = status;
    notify();
  }

  /// 清空数据
  /// [distribute] 是否发送通知
  void clearData({bool distribute = false}) {
    data.clear();
    if (distribute) {
      notify();
    }
  }

  /// 重置所有状态值
  void resetLoader() {
    resetPage();
    data.clear();
    _noMoreData = false;
    loadingStatus = LoadingStatus.success;
  }

  /// 刷新所有监听 widget
  void notify() {
    notifyListeners();
  }

  void release() {
    dispose();
  }
}
