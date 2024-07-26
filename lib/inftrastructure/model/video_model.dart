import 'package:photo_manager/photo_manager.dart';

class PhotoVideoModel {
  String image;
  bool selected;
  String id;
  AssetEntity entity;

  PhotoVideoModel({required this.image, this.selected = false, required this.id,required this.entity });
}
