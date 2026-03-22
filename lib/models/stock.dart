import 'package:equatable/equatable.dart';

enum StockChangeDirection { up, down, neutral }
enum Exchange { nse, bse }
enum InstrumentType { eq, idx, monthly, weekly }

class Stock extends Equatable {
  final String symbol;
  final double price;
  final double change;
  final double changePercent;
  final Exchange exchange;
  final InstrumentType instrumentType;

  const Stock({
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.exchange,
    required this.instrumentType,
  });

  StockChangeDirection get changeDirection {
    if (change > 0) return StockChangeDirection.up;
    if (change < 0) return StockChangeDirection.down;
    return StockChangeDirection.neutral;
  }

  String get formattedPrice => _formatIndianNumber(price);

  String get formattedChange => change.toStringAsFixed(2);

  String get formattedChangePercent => '(${changePercent.toStringAsFixed(2)}%)';

  String get exchangeLabel => exchange == Exchange.nse ? 'NSE' : 'BSE';

  String get instrumentLabel {
    switch (instrumentType) {
      case InstrumentType.eq: return 'EQ';
      case InstrumentType.idx: return 'IDX';
      case InstrumentType.monthly: return 'Monthly';
      case InstrumentType.weekly: return 'Weekly';
    }
  }

  String get subLabel {
    if (instrumentType == InstrumentType.idx) return exchangeLabel;
    return '$exchangeLabel | $instrumentLabel';
  }

  static String _formatIndianNumber(double value) {
    final isNegative = value < 0;
    final absValue = value.abs();
    final parts = absValue.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final decPart = parts[1];
    String result;
    if (intPart.length <= 3) {
      result = intPart;
    } else {
      final last3 = intPart.substring(intPart.length - 3);
      final remaining = intPart.substring(0, intPart.length - 3);
      final groups = <String>[];
      for (int i = remaining.length; i > 0; i -= 2) {
        groups.add(remaining.substring(i < 2 ? 0 : i - 2, i));
      }
      result = '${groups.reversed.join(',')},${last3}';
    }
    return '${isNegative ? '-' : ''}$result.$decPart';
  }

  Stock copyWith({
    String? symbol,
    double? price,
    double? change,
    double? changePercent,
    Exchange? exchange,
    InstrumentType? instrumentType,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      exchange: exchange ?? this.exchange,
      instrumentType: instrumentType ?? this.instrumentType,
    );
  }

  @override
  List<Object?> get props => [symbol, price, change, changePercent, exchange, instrumentType];
}
