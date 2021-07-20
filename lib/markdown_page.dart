import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_study/loading_builder.dart';

import 'package:url_launcher/url_launcher.dart';

class MarkdownPage extends StatefulWidget {
  final String path;
  MarkdownPage({required this.path});

  @override
  State<StatefulWidget> createState() => _MarkdownPageState();
}

class _MarkdownPageState extends State<MarkdownPage> {
  String? data;

  @override
  void initState() {
    super.initState();
    loadAsset(widget.path);
  }

  Future<void> loadAsset(String path) async {
    final str = await rootBundle.loadString(path);
    setState(() {
      data = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.path),
      ),
      body: LoadingBuilder(
        child: data == null ? null : Markdown(
          data: data!,
          onTapLink: (text, href, title) async {
            String h = href ?? '';
            if (await canLaunch(h)) {
              await launch(h);
            }
          },
        ),
      ),
    );
  }
}