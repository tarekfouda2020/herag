import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class CategoryModel  {

  CategoryModel({
    this.id,
    this.name,
    this.img,
    this.parentId,
    this.isActive,
    this.list,
    this.selected,
    this.showSideManu
  });

  int id;
  String name;
  String img;
  int parentId;
  bool isActive;
  @JsonProperty(defaultValue: false,ignoreIfNull: true)
  bool selected;
  bool showSideManu;
  List<CategoryModel> list;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => JsonMapper.fromMap<CategoryModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

  @override
  String toString() {
    return name;
  }
}