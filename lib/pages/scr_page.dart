import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pet_tinder/utils/web_view_urls.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SCRPage extends StatefulWidget {
  const SCRPage({super.key});

  @override
  State<SCRPage> createState() => _SCRPageState();
}

class _SCRPageState extends State<SCRPage> {
  final webViewUrl = WebViewUrls();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Oku", actions: []),
      body: WebView(
        initialUrl: WebViewUrls.presadb,
      ),
    );
  }
}
