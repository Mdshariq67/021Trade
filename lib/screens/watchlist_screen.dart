import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/watchlist_bloc.dart';
import '../models/stock.dart';
import '../theme/app_theme.dart';
import 'edit_watchlist_screen.dart';

export 'edit_watchlist_screen.dart';
class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MarketTickerBar(),
            _SearchBar(),
            _WatchlistTabBar(),
            _SortBar(),
            const Divider(height: 0),
            Expanded(
              child: BlocBuilder<WatchlistBloc, WatchlistState>(
                builder: (context, state) {
                  return switch (state) {
                    WatchlistInitial() => _triggerLoad(context),
                    WatchlistLoading() => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2)),
                    WatchlistReady(stocks: final stocks) =>
                      _StockListView(stocks: stocks),
                    WatchlistError(message: final msg) =>
                      _ErrorView(message: msg),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }

  Widget _triggerLoad(BuildContext context) {
    context.read<WatchlistBloc>().add(const WatchlistLoaded());
    return const SizedBox.shrink();
  }
}
class _MarketTickerBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _TickerItem(
              label: 'SENSEX 18TH SEP 8...',
              exchange: 'BSE',
              price: '1,225.55',
              change: '144.50 (13.3...)',
              isPositive: true,
            ),
          ),
          const SizedBox(width: 8),
          const VerticalDivider(width: 1, color: AppTheme.divider),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _TickerItem(
                    label: 'NIFTY BANK',
                    exchange: '',
                    price: '54,168.50',
                    change: '-18.40 (-0.03...)',
                    isPositive: false,
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: AppTheme.textMuted, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TickerItem extends StatelessWidget {
  final String label;
  final String exchange;
  final String price;
  final String change;
  final bool isPositive;

  const _TickerItem({
    required this.label,
    required this.exchange,
    required this.price,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (exchange.isNotEmpty) ...[
              const SizedBox(width: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppTheme.textMuted.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(exchange,
                    style: const TextStyle(
                        fontSize: 9, color: AppTheme.textMuted)),
              ),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(price,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary)),
        Text(
          change,
          style: TextStyle(
              fontSize: 12,
              color: isPositive ? AppTheme.gainGreen : AppTheme.lossRed),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: AppTheme.scaffoldGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            SizedBox(width: 12),
            Icon(Icons.search, color: AppTheme.textMuted, size: 20),
            SizedBox(width: 8),
            Text('Search for instruments',
                style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

class _WatchlistTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
      child: Row(
        children: [
          _Tab(label: 'Watchlist 1', isActive: true),
          const SizedBox(width: 24),
          _Tab(label: 'Watchlist 5', isActive: false),
          const SizedBox(width: 24),
          _Tab(label: 'Watchlist 6', isActive: false),
          const Spacer(),
          Builder(
            builder: (ctx) => InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () => Navigator.of(ctx).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: ctx.read<WatchlistBloc>(),
                    child: const EditWatchlistScreen(),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.edit_outlined, size: 18, color: AppTheme.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;

  const _Tab({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: isActive
                ? AppTheme.tabActiveStyle
                : AppTheme.tabInactiveStyle),
        const SizedBox(height: 6),
        if (isActive)
          Container(height: 2, width: 70, color: AppTheme.tabActive),
      ],
    );
  }
}
class _SortBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () {},
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.sortBtnBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tune, size: 16, color: AppTheme.textSecondary),
                  SizedBox(width: 6),
                  Text('Sort by',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _StockListView extends StatelessWidget {
  final List<Stock> stocks;

  const _StockListView({required this.stocks});

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) {
      return _EmptyView();
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: stocks.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 0, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return _WatchlistStockRow(stock: stock);
      },
    );
  }
}

class _WatchlistStockRow extends StatelessWidget {
  final Stock stock;

  const _WatchlistStockRow({required this.stock});

  @override
  Widget build(BuildContext context) {
    final isGain = stock.changeDirection == StockChangeDirection.up;
    final isNeutral = stock.changeDirection == StockChangeDirection.neutral;
    final changeColor = isNeutral
        ? AppTheme.neutral
        : isGain
            ? AppTheme.gainGreen
            : AppTheme.lossRed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: symbol + sub label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stock.symbol, style: AppTheme.symbolStyle),
                const SizedBox(height: 2),
                Text(stock.subLabel, style: AppTheme.subLabelStyle),
              ],
            ),
          ),

          // Right: price + change
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(stock.formattedPrice,
                  style: AppTheme.priceStyle.copyWith(color: changeColor)),
              const SizedBox(height: 2),
              Text(
                '${stock.formattedChange} ${stock.formattedChangePercent}',
                style: AppTheme.changeStyle.copyWith(color: changeColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.show_chart, size: 48, color: AppTheme.textMuted),
          const SizedBox(height: 12),
          const Text('No stocks in watchlist',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 15)),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () => context
                .read<WatchlistBloc>()
                .add(const WatchlistReset()),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(message,
            style: const TextStyle(color: AppTheme.lossRed)));
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const items = ['Watchlist', 'Orders', 'GTT+', 'Portfolio', 'Funds', 'Profile'];
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.divider)),
          color: AppTheme.background,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items
              .asMap()
              .entries
              .map((e) => _NavItem(
                    label: e.value,
                    isActive: e.key == 0,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool isActive;

  const _NavItem({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        color: isActive ? AppTheme.tabActive : AppTheme.textMuted,
      ),
    );
  }
}

