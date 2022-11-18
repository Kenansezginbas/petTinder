import 'package:flutter/material.dart';
import 'package:pet_tinder/utils/custom_colors.dart';
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
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: WebViewUrls.presadb,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.blackIconColor,
                  ),
                )
              : Stack(),
        ],
      ),
    );
  }
}
