import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogPageDetail extends StatefulWidget {
  final url;
  const BlogPageDetail({super.key, required this.url});

  @override
  State<BlogPageDetail> createState() => _BlogPageDetailState();
}

class _BlogPageDetailState extends State<BlogPageDetail> {
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
        initialUrl: widget.url,
      ),
    );
  }
}
