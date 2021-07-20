import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_study/loading_builder.dart';
import 'package:flutter_study/markdown_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Study',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Study'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> pageList = [];

  @override
  void initState() {
    super.initState();
    fetchMarkDown();
  }

  void fetchMarkDown() async {
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final markdowns = manifestMap.keys.where((element) => element.endsWith('.md')).toList();
    setState(() {
      pageList.addAll(markdowns);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: LoadingBuilder(
          child: pendingListView(),
        ),
      ),
    );
  }

  Widget? pendingListView(){
    if(pageList.isEmpty){
      return null;
    }
    else {
      return ListView.builder(
        itemBuilder: (context, index) => TextButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MarkdownPage(path: pageList[index]),));
          },
          child: Text(
            pageList[index],
          ),
        ),
        itemCount: pageList.length,
      );
    }
  }

}
