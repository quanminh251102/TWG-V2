import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZoomButtons extends StatelessWidget {
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final Color? myLocationColor;
  final Color? myLocationColorIcon;
  final IconData myLocationIcon;
  final void Function()? onPressed;
  static const _fitBoundsPadding = EdgeInsets.all(12);

  const ZoomButtons(
      {super.key,
      this.minZoom = 1,
      this.maxZoom = 21,
      this.mini = true,
      this.padding = 2.0,
      this.alignment = Alignment.topRight,
      this.zoomInColor,
      this.zoomInColorIcon,
      this.zoomInIcon = Icons.zoom_in,
      this.zoomOutColor,
      this.zoomOutColorIcon,
      this.zoomOutIcon = Icons.zoom_out,
      this.myLocationColor,
      this.myLocationColorIcon,
      this.myLocationIcon = Icons.my_location,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);

    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: mini,
              backgroundColor: zoomInColor ?? Theme.of(context).primaryColor,
              onPressed: () {
                final paddedMapCamera = CameraFit.bounds(
                  bounds: camera.visibleBounds,
                  padding: _fitBoundsPadding,
                ).fit(camera);
                var zoom = paddedMapCamera.zoom + 1;
                if (zoom > maxZoom) {
                  zoom = maxZoom;
                }
                MapController.of(context).move(paddedMapCamera.center, zoom);
              },
              child: Icon(zoomInIcon,
                  color: zoomInColorIcon ?? IconTheme.of(context).color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: mini,
              backgroundColor: zoomOutColor ?? Theme.of(context).primaryColor,
              onPressed: () {
                final paddedMapCamera = CameraFit.bounds(
                  bounds: camera.visibleBounds,
                  padding: _fitBoundsPadding,
                ).fit(camera);
                var zoom = paddedMapCamera.zoom - 1;
                if (zoom < minZoom) {
                  zoom = minZoom;
                }
                MapController.of(context).move(paddedMapCamera.center, zoom);
              },
              child: Icon(zoomOutIcon,
                  color: zoomOutColorIcon ?? IconTheme.of(context).color),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'myLocationButton',
              mini: mini,
              backgroundColor:
                  myLocationColor ?? Theme.of(context).primaryColor,
              onPressed: onPressed,
              child: Icon(myLocationIcon,
                  color: myLocationColorIcon ?? IconTheme.of(context).color),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
