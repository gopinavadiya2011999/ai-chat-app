import 'package:aichat/inftrastructure/constant/color_constant.dart';
import 'package:aichat/inftrastructure/constant/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageItemWidget extends StatelessWidget {
  const ImageItemWidget({
    super.key,
    required this.entity,
    required this.option,
    this.onTap,
    required this.selected,
  });
  final bool selected;
  final AssetEntity entity;
  final ThumbnailOption option;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(0.7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Positioned.fill(
                child: AssetEntityImage(
                  entity,
                  isOriginal: false,
                  thumbnailSize: option.size,
                  thumbnailFormat: option.format,
                  fit: BoxFit.cover,
                ),
              ),
              selected
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          margin: const EdgeInsets.all(7),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(color: ThemeColors.primary(context), shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            ImageConstant.tick,
                            width: 10,
                            height: 10,
                            colorFilter: ColorFilter.mode(ThemeColors.secondary(context), BlendMode.srcIn),
                          )),
                    )
                  : Container(),
              selected
                  ? Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: ThemeColors.primary(context), width: 2)),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
