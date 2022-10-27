import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_tinder/service/post_report_service.dart';
import 'package:pet_tinder/utils/custom_input_decoration.dart';
import 'package:pet_tinder/widgets/a.dart';
import 'package:pet_tinder/widgets/custom_app_bar.dart';

class PostReportPage extends StatefulWidget {
  final postID;
  const PostReportPage({super.key, this.postID});

  @override
  State<PostReportPage> createState() => _PostReportPageState();
}

class _PostReportPageState extends State<PostReportPage> {
  final formKey = GlobalKey<FormState>();

  var reasonForComplaint;
  @override
  Widget build(BuildContext context) {
    print("post id $widget.postID");
    return Scaffold(
      appBar: CustomAppBar(title: "Şikayet Et", actions: []),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 3,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Lütfen Alanları Doldurunuz";
                  } else if (val.length <= 10) {
                    return "Daha Detaylı Anlatınız";
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  reasonForComplaint = val!;
                },
                decoration: CustomInputDecoration.customInputDecorationDialog(
                    "Şikayet Sebebini Yazınız"),
                cursorColor: Colors.black,
              ),
            ),
          ),
          CustomElevatedButton(
            buttonText: "Şikayet Et",
            onPressed: postReport,
          )
        ],
      ),
    );
  }

  void postReport() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      PostReportService().savePostReport(
          postID: widget.postID, resultData: "", whoIsSendReport: "kenan");
      formKey.currentState!..reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Şikayetiniz Alındı"),
        ),
      );
    }
  }
}
