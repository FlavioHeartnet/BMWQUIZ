class Options{
  int? id;
  String? option;

  Options({this.id, this.option});

  static List<Options> getOptions(){
    return <Options>[
      Options(id: 1, option: "England"),
      Options(id: 2, option: "USA"),
      Options(id: 3, option: "Germany"),
      Options(id: 4, option: "Japan")
    ];
  }
}