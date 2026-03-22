part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
  @override
  List<Object?> get props => [];
}

class WatchlistLoaded extends WatchlistEvent {
  const WatchlistLoaded();
}

class WatchlistStockReordered extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;
  const WatchlistStockReordered({required this.oldIndex, required this.newIndex});
  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class WatchlistStocksSwapped extends WatchlistEvent {
  final int indexA;
  final int indexB;
  const WatchlistStocksSwapped({required this.indexA, required this.indexB});
  @override
  List<Object?> get props => [indexA, indexB];
}

class WatchlistStockRemoved extends WatchlistEvent {
  final String symbol;
  const WatchlistStockRemoved({required this.symbol});
  @override
  List<Object?> get props => [symbol];
}

class WatchlistReset extends WatchlistEvent {
  const WatchlistReset();
}
