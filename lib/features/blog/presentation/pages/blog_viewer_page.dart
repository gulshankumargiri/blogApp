
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/formate_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/image_view.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>MaterialPageRoute(
    builder: (context)=> BlogViewerPage(blog: blog,),
  );
  final Blog blog;
      const BlogViewerPage({super.key,required this.blog});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(blog.title,style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
            
                ),),
                SizedBox(height: 20,),
                Text('By ${blog.posterName}',
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                SizedBox(height: 2,),
                Text('${formatDateBydMMMYYYY(blog.updatedAt)} . '
                    '${calculateReadingTime(blog.content)} min'),
                SizedBox(height: 6,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, ImageView.route(blog));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(blog.imageUrl,
                        height: MediaQuery.of(context).size.height/4,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,),
                      ),
                    ),
                Text(blog.content,style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,height: 2
            
                ),
            
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
