// import 'package:flutter/material.dart';
// import 'package:brick/src/widgets/app_bar_basic_widget.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// /// web view page
// /// 目前欠缺 加载进度条
// /// jsbridge
// class WebviewPage extends StatefulWidget {
//   final String url;
//
//   /// webview 标题
//   final String title;
//
//   /// webview 标题颜色
//   final Color titleColor;
//
//   final double titleSize;
//
//   final Widget? right;
//
//   final Color? backgroundColor;
//
//   /// title bar 背景色
//   final Color? titleBarBackgroundColor;
//
//   final bool enableJavascript;
//
//   final ValueChanged<int>? onProgress;
//
//   final ValueChanged<String>? onPageStarted;
//
//   final ValueChanged<String>? onPageFinished;
//
//   const WebviewPage({
//     Key? key,
//     required this.url,
//     required this.title,
//     this.titleSize = 16,
//     this.titleColor = Colors.white,
//     this.right,
//     this.onProgress,
//     this.onPageStarted,
//     this.onPageFinished,
//     this.backgroundColor,
//     this.titleBarBackgroundColor = Colors.blue,
//     this.enableJavascript = true,
//   })  : assert(url.length > 0),
//         assert(title.length > 0),
//         super(key: key);
//
//   @override
//   State createState() => _WebviewPageState();
// }
//
// class _WebviewPageState extends State<WebviewPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarBasicWidget(
//         backgroundColor: widget.titleBarBackgroundColor,
//         title: widget.title,
//         textSize: widget.titleSize,
//         textColor: widget.titleColor,
//         right: widget.right,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               child: WebViewWrapperWidget(
//             url: widget.url,
//             backgroundColor: widget.backgroundColor,
//             enableJavascript: widget.enableJavascript,
//             onProgress: widget.onProgress,
//             onPageStarted: widget.onPageStarted,
//             onPageFinished: widget.onPageFinished,
//           ))
//         ],
//       ),
//     );
//   }
// }
//
// class WebViewWrapperWidget extends StatefulWidget {
//   final String url;
//
//   final Color? backgroundColor;
//
//   final bool enableJavascript;
//
//   final ValueChanged<int>? onProgress;
//
//   final ValueChanged<String>? onPageStarted;
//
//   final ValueChanged<String>? onPageFinished;
//
//   const WebViewWrapperWidget({
//     Key? key,
//     required this.url,
//     this.backgroundColor,
//     this.enableJavascript = false,
//     this.onProgress,
//     this.onPageStarted,
//     this.onPageFinished,
//   }) : super(key: key);
//
//   @override
//   State<WebViewWrapperWidget> createState() => _WebViewWrapperWidgetState();
// }
//
// class _WebViewWrapperWidgetState extends State<WebViewWrapperWidget> {
//   WebViewController? _controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool canBack = await _controller?.canGoBack() ?? false;
//         if (canBack) {
//           await _controller?.goBack();
//           return false;
//         }
//         return true;
//       },
//       child: WebViewWidget(
//         onWebViewCreated: (controller) {
//           _controller = controller;
//         },
//         initialUrl: widget.url,
//         javascriptMode:
//             widget.enableJavascript ? JavascriptMode.unrestricted : JavascriptMode.disabled,
//         onProgress: widget.onProgress,
//         onPageStarted: widget.onPageStarted,
//         onPageFinished: widget.onPageFinished,
//         backgroundColor: widget.backgroundColor,
//       ),
//     );
//   }
// }
