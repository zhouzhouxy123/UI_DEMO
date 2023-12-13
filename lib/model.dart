class Record{
  final String title;
  final String intro;
  final String link;

  Record({
    required this.title,
    required this.intro,
    required this.link,
  });
}

class MyState {
  // 这是我的数据
  final List<Record> data;

  // 还有一些临时状态
  final int pageIndex;
  final int recordIndex;

  MyState({
    required this.data,
    this.pageIndex = 0,
    this.recordIndex = 1,
  });
}
