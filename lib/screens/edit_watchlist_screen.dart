import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/watchlist_bloc.dart';
import '../models/stock.dart';
import '../theme/app_theme.dart';
class EditWatchlistScreen extends StatelessWidget {
  const EditWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Watchlist 1', style: AppTheme.appBarTitle),
        centerTitle: false,
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is! WatchlistReady) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 2));
          }
          return _EditBody(stocks: state.stocks);
        },
      ),
    );
  }
}

class _EditBody extends StatelessWidget {
  final List<Stock> stocks;

  const _EditBody({required this.stocks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WatchlistNameField(),

        const SizedBox(height: 8),


        Expanded(
          child: ReorderableListView.builder(
            itemCount: stocks.length,
            onReorder: (oldIndex, newIndex) {
              context.read<WatchlistBloc>().add(
                    WatchlistStockReordered(
                        oldIndex: oldIndex, newIndex: newIndex),
                  );
            },
            proxyDecorator: (child, index, animation) {
              return Material(
                color: Colors.transparent,
                elevation: 4,
                shadowColor: Colors.black26,
                child: child,
              );
            },
            itemBuilder: (context, index) {
              final stock = stocks[index];
              return _EditStockRow(
                key: ValueKey(stock.symbol),
                stock: stock,
                onDelete: () => _confirmDelete(context, stock),
              );
            },
          ),
        ),


        SafeArea(child: _BottomActions()),
      ],
    );
  }

  void _confirmDelete(BuildContext context, Stock stock) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Remove ${stock.symbol}?',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        content: Text(
          'This will remove ${stock.symbol} from Watchlist 1.',
          style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppTheme.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx, true);
              context
                  .read<WatchlistBloc>()
                  .add(WatchlistStockRemoved(symbol: stock.symbol));
            },
            child: const Text('Remove',
                style: TextStyle(color: AppTheme.lossRed)),
          ),
        ],
      ),
    );
  }
}
class _WatchlistNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.scaffoldGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Watchlist 1',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textPrimary),
            ),
          ),
          const Icon(Icons.edit, size: 18, color: AppTheme.textMuted),
        ],
      ),
    );
  }
}
class _EditStockRow extends StatelessWidget {
  final Stock stock;
  final VoidCallback onDelete;

  const _EditStockRow({
    super.key,
    required this.stock,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Drag handle
              const Icon(Icons.drag_handle_rounded,
                  color: AppTheme.dragHandleColor, size: 22),
              const SizedBox(width: 16),

              // Symbol
              Expanded(
                child: Text(stock.symbol, style: AppTheme.symbolStyle),
              ),

              // Delete button
              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.delete_outline,
                    color: AppTheme.textPrimary, size: 22),
              ),
            ],
          ),
        ),
        const Divider(height: 0, indent: 16, endIndent: 16),
      ],
    );
  }
}
class _BottomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      color: AppTheme.background,
      child: Column(
        children: [
          // Edit other watchlists button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: AppTheme.editButtonBorder, width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Edit other watchlists',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Save Watchlist button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.saveButtonBg,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Save Watchlist',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
