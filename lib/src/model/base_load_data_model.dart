import 'package:brick/src/common/enum/loading_status.dart';
import 'package:brick/src/model/base_model.dart';
import 'package:flutter/foundation.dart';

abstract class BaseLoadDataModel<T> extends BaseChangeNotifierModel {
  LoadingStatus status = LoadingStatus.success;

  T? data;

  BaseLoadDataModel({this.data});

  /// [onLoadComplete] 加载完成
  Future load({
    bool showLoading = true,
    VoidCallback? onLoadComplete,
    VoidCallback? onLoadFailure,
  }) async {
    if (showLoading) {
      status = LoadingStatus.loading;
      notifyListeners();
    }
    try {
      data = await feed();
      onHandleSuccess(data, onLoadComplete);
    } catch (e, stackTrace) {
      onHandleFailure(e, stackTrace, onLoadFailure);
    }
  }

  /// 不显示loading动画
  /// [onLoadComplete] 加载完成
  Future loadData({
    VoidCallback? onLoadComplete,
    VoidCallback? onLoadFailure,
  }) async {
    load(
        showLoading: false,
        onLoadComplete: onLoadComplete,
        onLoadFailure: onLoadFailure);
  }

  void onHandleSuccess(T? data, VoidCallback? onLoadComplete) {
    feedAfter(data);
    status = LoadingStatus.success;
    notifyListeners();
    onLoadComplete?.call();
  }

  void onHandleFailure(
      dynamic exception, stackTrace, VoidCallback? onLoadFailure) {
    if (kDebugMode) {
      print(exception);
      print(stackTrace);
    }
    status = LoadingStatus.failure;
    notifyListeners();
    onLoadFailure?.call();
  }

  /// 加载数据接口
  Future<T> feed();

  /// 加载数据完成回调
  /// 只有加载成功后会回调
  void feedAfter(T? data) {}

  /// 更新数据
  void update(T? data) {
    this.data = data;
    notifyListeners();
  }

  void updateLoadingStatus(LoadingStatus value) {
    status = value;
    notifyListeners();
  }
}
