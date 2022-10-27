import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostReportService {
  savePostReport({postID, resultData, whoIsSendReport}) async {
    final _firebaseFirestore = FirebaseFirestore.instance.collection("Reports");
    try {
      final result = await _firebaseFirestore.add({
        "postID": postID,
        "result": resultData,
        "whoIsSendReport": whoIsSendReport,
      });
    } catch (e) {}
  }
}
