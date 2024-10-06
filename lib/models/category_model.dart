class CategoryModel {
  final String title;
  final int count;

//<editor-fold desc="Data Methods">
  const CategoryModel({
    required this.title,
    required this.count,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          count == other.count);

  @override
  int get hashCode => title.hashCode ^ count.hashCode;

  @override
  String toString() {
    return 'CategoryModel{' + ' title: $title,' + ' count: $count,' + '}';
  }

  CategoryModel copyWith({
    String? title,
    int? count,
  }) {
    return CategoryModel(
      title: title ?? this.title,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'count': this.count,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      title: map['title'] as String,
      count: map['count'] as int,
    );
  }

//</editor-fold>
}