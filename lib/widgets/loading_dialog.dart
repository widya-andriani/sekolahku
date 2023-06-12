import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/color_res.dart';
import '../res/dimen_res.dart';
import '../res/string_res.dart';
import 'loading.dart';


typedef OnShowDataWidget<T> = Widget Function(T data);
typedef OnErrorFuture = Function(Object error, Object stackTrace);

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({
    super.key,
    required this.message
  });



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(DimenRes.size_16))),
      child: SizedBox(
        width: DimenRes.size_400,
        height: DimenRes.size_150,
        child: Loading(message: message),
      ),
    );
  }
  
}

class LoadingBlocker extends StatelessWidget {
  final String message;
  final Widget? toBlock;

  const LoadingBlocker({
    super.key,
    this.message = "",
    this.toBlock
  });

  Widget get _background => const Opacity(
    opacity: 0.4,
    child: ModalBarrier(dismissible: false, color: ColorRes.black),
  );

  Widget get _blockerDialog => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(DimenRes.size_60),
          child: Container(
            constraints: const BoxConstraints(
                minWidth: DimenRes.size_400,
                minHeight: DimenRes.size_150
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DimenRes.size_16)
              ),
              child: Loading(message: message),
            ),
          ),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    final content = toBlock;
    return Material(
      child: Stack(
        children: [
          if (content != null) content,
          _background,
          _blockerDialog
        ],
      ),
    );
  }
}

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final OnShowDataWidget<T> onShowDataWidget;
  final Widget noDataWidget;
  final Widget loadingWidget;
  final OnErrorFuture? onErrorFuture;

  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.onShowDataWidget,
    required this.noDataWidget,
    required this.loadingWidget,
    this.onErrorFuture
  });

  Future<T?> getFuture() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return await future;
    } catch (e, s) {
      //debugError(e, s);
      onErrorFuture?.call(e, s);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
        future: getFuture(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return loadingWidget;
            case ConnectionState.done:
              final data = snapshot.data;
              if (data != null) {
                return onShowDataWidget.call(data);
              }
          }
          return noDataWidget;
        });
  }
}
