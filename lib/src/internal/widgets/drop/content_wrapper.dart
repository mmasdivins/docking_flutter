import 'package:docking/src/internal/widgets/drop/drop_anchor_widget.dart';
import 'package:docking/src/layout/docking_layout.dart';
import 'package:docking/src/layout/drop_position.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
abstract class ContentWrapperBase extends StatelessWidget {
  const ContentWrapperBase(
      {Key? key,
      required this.layout,
      required this.listener,
      required this.child})
      : super(key: key);

  final DockingLayout layout;
  final Widget child;
  final DropWidgetListener listener;

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double centerWidthRatio = 50;
        final double centerWidth = centerWidthRatio * constraints.maxWidth / 100;
        final double horizontalEdgeWidth = (constraints.maxWidth - centerWidth) / 2;
        final double verticalEdgeHeight = constraints.maxHeight / 2;

        return Stack(
          children: [
            Positioned.fill(child: child),
            Positioned(
              child: buildDropAnchor(DropPosition.left),
              width: horizontalEdgeWidth,
              bottom: 0, top: 0, left: 0,
            ),
            Positioned(
              child: buildDropAnchor(DropPosition.right),
              width: horizontalEdgeWidth,
              bottom: 0, top: 0, right: 0,
            ),
            Positioned(
              child: buildDropAnchor(DropPosition.top),
              height: verticalEdgeHeight,
              top: 0,
              left: horizontalEdgeWidth,
              right: horizontalEdgeWidth,
            ),
            Positioned(
              child: buildDropAnchor(DropPosition.bottom),
              height: verticalEdgeHeight,
              bottom: 0,
              left: horizontalEdgeWidth,
              right: horizontalEdgeWidth,
            ),
          ],
        );
      },
    );
  }

  DropAnchorBaseWidget buildDropAnchor(DropPosition dropPosition);
}

@internal
class ItemContentWrapper extends ContentWrapperBase {
  ItemContentWrapper(
      {required DockingLayout layout,
      required DropWidgetListener listener,
      required DockingItem dockingItem,
      required Widget child})
      : _dockingItem = dockingItem,
        super(layout: layout, listener: listener, child: child);

  final DockingItem _dockingItem;

  @override
  DropAnchorBaseWidget buildDropAnchor(DropPosition dropPosition) {
    return ItemDropAnchorWidget(
        layout: layout,
        listener: listener,
        dropPosition: dropPosition,
        dockingItem: _dockingItem);
  }
}

@internal
class TabsContentWrapper extends ContentWrapperBase {
  TabsContentWrapper(
      {required DockingLayout layout,
      required DropWidgetListener listener,
      required DockingTabs dockingTabs,
      required Widget child})
      : _dockingTabs = dockingTabs,
        super(layout: layout, listener: listener, child: child);

  final DockingTabs _dockingTabs;

  @override
  DropAnchorBaseWidget buildDropAnchor(DropPosition dropPosition) {
    return TabsDropAnchorWidget(
        layout: layout,
        listener: listener,
        dropPosition: dropPosition,
        dockingTabs: _dockingTabs);
  }
}
