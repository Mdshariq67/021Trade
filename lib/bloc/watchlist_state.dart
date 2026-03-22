part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {
  const WatchlistInitial();
}

class WatchlistLoading extends WatchlistState {
  const WatchlistLoading();
}

class WatchlistReady extends WatchlistState {
  final List<Stock> stocks;

  const WatchlistReady({required this.stocks});

  WatchlistReady copyWith({List<Stock>? stocks}) {
    return WatchlistReady(stocks: stocks ?? this.stocks);
  }

  @override
  List<Object?> get props => [stocks];
}

class WatchlistError extends WatchlistState {
  final String message;
  const WatchlistError({required this.message});
  @override
  List<Object?> get props => [message];
}
