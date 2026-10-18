import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/widgets/app_error_view.dart';
import 'package:tawasul/core/widgets/app_loading_indicator.dart';
import 'package:tawasul/core/widgets/list_skeleton.dart';

/// Paginated list bound to any Stream [PagedValueNotifier]
/// (channels, users, …), with skeleton loading, pull-to-refresh,
/// infinite scroll, empty and error states.
class AppPagedListView<T> extends StatefulWidget {
  const AppPagedListView({
    required this.controller,
    required this.itemBuilder,
    required this.emptyBuilder,
    this.header,
    this.padding,
    super.key,
  });

  final PagedValueNotifier<int, T> controller;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final WidgetBuilder emptyBuilder;

  /// Optional widget scrolled above the items (e.g. stories).
  final Widget? header;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppPagedListView<T>> createState() => _AppPagedListViewState<T>();
}

class _AppPagedListViewState<T> extends State<AppPagedListView<T>> {
  int? _requestedPageKey;

  /// Requests the next page at most once per page key.
  void _loadMore(int nextPageKey) {
    if (_requestedPageKey == nextPageKey) return;
    _requestedPageKey = nextPageKey;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.controller.loadMore(nextPageKey),
    );
  }

  Future<void> _refresh() {
    _requestedPageKey = null;
    return widget.controller.refresh(resetValue: false);
  }

  @override
  Widget build(BuildContext context) => PagedValueListenableBuilder<int, T>(
    valueListenable: widget.controller,
    builder: (context, value, _) => value.when(
      (items, nextPageKey, _) {
        final hasMore = nextPageKey != null;
        return RefreshIndicator.adaptive(
          onRefresh: _refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              if (widget.header != null)
                SliverToBoxAdapter(child: widget.header),
              // Keeps the last items clear of a floating bottom bar.
              SliverSafeArea(
                top: false,
                sliver: items.isEmpty
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        child: widget.emptyBuilder(context),
                      )
                    : SliverPadding(
                        padding: widget.padding ?? EdgeInsets.zero,
                        sliver: SliverList.builder(
                          itemCount: items.length + (hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              _loadMore(nextPageKey!);
                              return Padding(
                                padding: EdgeInsets.all(AppSpacing.lg.r),
                                child: const AppLoadingIndicator(size: 22),
                              );
                            }
                            return widget.itemBuilder(
                              context,
                              items[index],
                              index,
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
      loading: () => const ListSkeleton(),
      error: (error) => AppErrorView(
        error: error,
        onRetry: () => widget.controller.refresh(),
      ),
    ),
  );
}
