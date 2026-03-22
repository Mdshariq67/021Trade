import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/stock_repository.dart';
import '../models/stock.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final StockRepository _repository;

  WatchlistBloc({required StockRepository repository})
      : _repository = repository,
        super(const WatchlistInitial()) {
    on<WatchlistLoaded>(_onLoaded);
    on<WatchlistStockReordered>(_onReordered);
    on<WatchlistStocksSwapped>(_onSwapped);
    on<WatchlistStockRemoved>(_onRemoved);
    on<WatchlistReset>(_onReset);
  }

  void _onLoaded(WatchlistLoaded event, Emitter<WatchlistState> emit) {
    emit(const WatchlistLoading());
    try {
      final stocks = _repository.getInitialStocks();
      emit(WatchlistReady(stocks: stocks));
    } catch (e) {
      emit(WatchlistError(message: 'Failed to load watchlist: $e'));
    }
  }

  void _onReordered(WatchlistStockReordered event, Emitter<WatchlistState> emit) {
    final currentState = state;
    if (currentState is! WatchlistReady) return;
    final stocks = List<Stock>.from(currentState.stocks);
    int newIndex = event.newIndex;
    if (event.oldIndex < newIndex) newIndex -= 1;
    final stock = stocks.removeAt(event.oldIndex);
    stocks.insert(newIndex, stock);
    emit(currentState.copyWith(stocks: stocks));
  }

  void _onSwapped(WatchlistStocksSwapped event, Emitter<WatchlistState> emit) {
    final currentState = state;
    if (currentState is! WatchlistReady) return;
    if (event.indexA == event.indexB) return;
    final len = currentState.stocks.length;
    if (event.indexA < 0 || event.indexB < 0 || event.indexA >= len || event.indexB >= len) return;
    final stocks = List<Stock>.from(currentState.stocks);
    final temp = stocks[event.indexA];
    stocks[event.indexA] = stocks[event.indexB];
    stocks[event.indexB] = temp;
    emit(currentState.copyWith(stocks: stocks));
  }

  void _onRemoved(WatchlistStockRemoved event, Emitter<WatchlistState> emit) {
    final currentState = state;
    if (currentState is! WatchlistReady) return;
    final stocks = currentState.stocks.where((s) => s.symbol != event.symbol).toList();
    emit(currentState.copyWith(stocks: stocks));
  }

  void _onReset(WatchlistReset event, Emitter<WatchlistState> emit) {
    emit(const WatchlistLoading());
    try {
      final stocks = _repository.getInitialStocks();
      emit(WatchlistReady(stocks: stocks));
    } catch (e) {
      emit(WatchlistError(message: 'Failed to reset watchlist: $e'));
    }
  }
}
