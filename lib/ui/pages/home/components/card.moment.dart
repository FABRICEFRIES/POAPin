import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/controllers/card.moment.dart';

class MomentCard extends StatelessWidget {
  const MomentCard({Key? key}) : super(key: key);

  Widget _buildPreviewImage(String? url) {
    if (url != null) {
      return ExtendedImage.network(
        url,
        clipBehavior: Clip.hardEdge,
        cache: true,
        enableLoadState: true,
        clearMemoryCacheWhenDispose: false,
        compressionRatio: 0.6,
        maxBytes: 200 << 10,
        fit: BoxFit.cover,
      );
    }
    return Container(
      color: PColor.background,
    );
  }

  Widget _buildMomentsCount() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            'icons/ic_moments.png',
                            package: 'web3_icons',
                            height: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: GetBuilder<MomentsCardController>(
                          builder: (c) => Container(
                            alignment: Alignment.topCenter,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: c.isLoading
                                  ? Container(
                                      width: 12,
                                      height: 12,
                                      margin: const EdgeInsets.only(top: 8),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  : Text(
                                      c.momentCount.toString(),
                                      maxLines: 1,
                                      softWrap: false,
                                      style: GoogleFonts.shareTechMono(
                                        color: Colors.black87,
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 0.6,
            width: double.infinity,
          ),
          const SizedBox(height: 1),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        shadowColor: Colors.black26,
        child: GetBuilder<MomentsCardController>(
          builder: (c) => Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                tag: 'moment_${c.previewMoment.momentId}',
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.only(top: 40),
                  child:
                      _buildPreviewImage(c.getPreviewImageURL(c.previewMoment)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.3, 1.0],
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: _buildMomentsCount(),
              ),
              InkWell(
                onTap: () {
                  if (c.momentCount > 0 &&
                      c.previewMoment.momentId.isNotEmpty) {
                    Get.toNamed(
                      '/moments',
                      arguments: {
                        'preview': c.previewMoment,
                      },
                    );
                  } else {
                    c.showMomentsDialog();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
