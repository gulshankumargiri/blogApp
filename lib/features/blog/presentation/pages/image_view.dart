import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';

class ImageView extends StatelessWidget {
  static route(Blog blog)=> MaterialPageRoute(
      builder: (context)=> ImageView(blog: blog,));
  final Blog blog;
  const ImageView({super.key,required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Container(  
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(blog.imageUrl,),
      ),
    );
  }
}
