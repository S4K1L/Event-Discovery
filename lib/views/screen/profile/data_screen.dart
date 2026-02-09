import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DataScreen extends StatefulWidget {
  final String title;
  final String endPoint;

  const DataScreen({super.key, required this.title, required this.endPoint});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String htmlData = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContent();
  }

  Future<void> fetchContent() async {
    try {
      final response = await http.get(Uri.parse(widget.endPoint));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // assuming API returns: { "content": "<h1>Title</h1>..." }
        setState(() {
          htmlData = data["content"] ?? "";
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blue[50],
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.grey[600],
          ),
        ),
        title: Text(
          widget.title,
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : htmlData.isEmpty
            ? const Center(child: Text("No content available"))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Html(
                  data: htmlData,
                  style: {
                    "body": Style(
                      fontSize: FontSize(14),
                      color: AppColors.grey[800],
                    ),
                    "h1": Style(fontSize: FontSize(22)),
                    "h2": Style(fontSize: FontSize(18)),
                    "p": Style(margin: Margins.only(bottom: 12)),
                  },
                ),
              ),
      ),
    );
  }
}
