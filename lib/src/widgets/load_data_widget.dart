import 'package:brick/src/common/enum/loading_status.dart';
import 'package:brick/src/model/base_load_data_model.dart';
import 'package:brick/src/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 可以默认加载数据的 widget
class LoadDataWidget<T> extends StatefulWidget {
  /// 加载数据
  final BaseLoadDataModel<T> loader;

  /// 自动加载数据
  final bool autoLoad;

  /// appbar widget
  /// 使用场景：appbar 需要根据加载的数据动态刷新
  final PreferredSizeWidget Function(
      BuildContext context, BaseLoadDataModel loader, T? data)? appBarBuilder;

  /// child widget 构造器
  final Widget Function(BuildContext context, T? data) builder;

  /// loading widget
  /// 默认是 ios 转圈圈
  final Widget Function(BuildContext context)? loadingBuilder;

  /// 默认 [SizedBox]
  final Widget Function(BuildContext context)? failureBuilder;

  /// 加载完成回调
  final VoidCallback? onLoadComplete;

  /// 加载失败
  final VoidCallback? onLoadFailure;

  const LoadDataWidget({
    Key? key,
    required this.loader,
    required this.builder,
    this.autoLoad = true,
    this.appBarBuilder,
    this.loadingBuilder,
    this.failureBuilder,
    this.onLoadComplete,
    this.onLoadFailure,
  }) : super(key: key);

  @override
  State<LoadDataWidget<T>> createState() => _LoadDataWidgetState<T>();
}

class _LoadDataWidgetState<T> extends State<LoadDataWidget<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.autoLoad) {
      widget.loader.load(
        onLoadComplete: widget.onLoadComplete,
        onLoadFailure: widget.onLoadFailure,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.loader,
      child: Consumer<BaseLoadDataModel<T>>(
        builder: (context, value, child) {
          debugPrint('_LoadDataWidgetState.Consumer: ');
          if (widget.appBarBuilder != null) {
            return appBarBody(value);
          }
          return noAppBarBody(value);
        },
      ),
    );
  }

  /// app bar 需要Scaffold包裹下
  Widget appBarBody(BaseLoadDataModel value) {
    return Scaffold(
      appBar: widget.appBarBuilder!(context, value, value.data),
      body: bodyWidget(value),
    );
  }

  Widget noAppBarBody(BaseLoadDataModel value) {
    return bodyWidget(value);
  }

  Widget bodyWidget(BaseLoadDataModel loader) {
    Widget body;
    switch (loader.status) {
      case LoadingStatus.loading:
        body = Center(
          child: widget.loadingBuilder == null
              ? const LoadingWidget()
              : widget.loadingBuilder!.call(context),
        );
        break;
      case LoadingStatus.success:
        body = widget.builder(context, loader.data);
        break;
      case LoadingStatus.failure:
        body = widget.failureBuilder == null
            ? const SizedBox.shrink()
            : widget.failureBuilder!.call(context);
        break;
    }
    return body;
  }
}
