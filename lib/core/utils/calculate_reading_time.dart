int calculateReadingTime(String content){
  final wordCount = content.split(RegExp(r'\s+')).length;

//   speed = d/t...(you can 200 for lowest and
//   300 for highest and also this returns double
//   so you have to change it and have to make sure
//   that returns an Integer


final readingTime =wordCount/225;
return readingTime.ceil();
}