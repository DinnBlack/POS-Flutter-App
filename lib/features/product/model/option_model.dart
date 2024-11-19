import 'item_option_model.dart';

class OptionModel {
  final String title;
  final List<ItemOptionModel> itemOptions;

//<editor-fold desc="Data Methods">
  const OptionModel({
    required this.title,
    required this.itemOptions,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OptionModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          itemOptions == other.itemOptions);

  @override
  int get hashCode => title.hashCode ^ itemOptions.hashCode;

  @override
  String toString() {
    return 'OptionModel{' +
        ' title: $title,' +
        ' itemOptions: $itemOptions,' +
        '}';
  }

  OptionModel copyWith({
    String? title,
    List<ItemOptionModel>? itemOptions,
  }) {
    return OptionModel(
      title: title ?? this.title,
      itemOptions: itemOptions ?? this.itemOptions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'itemOptions': this.itemOptions,
    };
  }

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      title: map['title'] as String,
      itemOptions: map['itemOptions'] as List<ItemOptionModel>,
    );
  }

//</editor-fold>
}