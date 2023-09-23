/// widget 默认参数配置
final WidgetConfig widgetConfig = WidgetConfig._(
  appBarHeight: 44,
  appbarTitleSize: 18,
);

class WidgetConfig {
  double appBarHeight;

  int appbarTitleSize;

  WidgetConfig._({
    required this.appBarHeight,
    required this.appbarTitleSize,
  });
}
