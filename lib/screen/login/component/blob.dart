import 'dart:async';
import 'package:flutter/material.dart';

import 'animated_blob.dart';
import 'blob_config.dart';
import 'blob_controller.dart';
import 'blob_generator.dart';
import 'models.dart';
import 'simple_blob.dart';

class Blob extends StatefulWidget {
  final double size;
  final bool debug;
  final BlobStyles? styles;
  final BlobController? controller;
  final Widget? child;
  final int? edgesCount;
  final int? minGrowth;
  final List<String>? id;
  final Duration? duration;
  final bool loop;
  final bool isAnimated;

  static int count = 0;

  const Blob.animatedFromID({super.key, 
    required this.id,
    required this.size,
    this.debug = false,
    this.styles,
    this.duration = const Duration(
      milliseconds: BlobConfig.animDurationMs,
    ),
    this.loop = false,
    this.controller,
    this.child,
  })  : isAnimated = true,
        edgesCount = null,
        minGrowth = null;

  @override
  State<Blob> createState() => _BlobState();

  BlobData _randomBlobData() {
    String? randomID = (id == null || id!.isEmpty) ? null : _randomID();
    return BlobGenerator(
      edgesCount: edgesCount,
      minGrowth: minGrowth,
      size: Size(size, size),
      id: randomID,
    ).generate();
  }

  String _randomID() {
    Blob.count++;
    if (id!.length == 1) return id![0];
    return id![Blob.count % id!.length];
  }
}

class _BlobState extends State<Blob> {
  BlobData? blobData;
  BlobData? fromBlobData;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _updateBlob();
    if (widget.loop) {
      timer = Timer.periodic(
        Duration(milliseconds: widget.duration!.inMilliseconds),
        (_) => _updateBlob(),
      );
    } else if (widget.controller != null) {
      widget.controller!.onChange(_updateBlob);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAnimated) {
      return SimpleBlob(
        blobData: blobData!,
        size: widget.size,
        styles: widget.styles,
        debug: widget.debug,
        child: widget.child,
      );
    }
    return AnimatedBlob(
      fromBlobData: fromBlobData,
      toBlobData: blobData!,
      size: widget.size,
      styles: widget.styles,
      debug: widget.debug,
      duration: widget.duration,
      child: widget.child,
    );
  }

  BlobData _updateBlob() {
    if (widget.isAnimated) {
      fromBlobData = blobData;
    }
    blobData = widget._randomBlobData();
    setState(() {});
    return blobData!;
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    if (widget.controller != null) widget.controller!.dispose();
    super.dispose();
  }
}
