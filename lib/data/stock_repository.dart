import '../models/stock.dart';

class StockRepository {
  List<Stock> getInitialStocks() {
    return const [
      Stock(
        symbol: 'RELIANCE SEP 1370 PE',
        price: 19.20,
        change: 1.00,
        changePercent: 5.49,
        exchange: Exchange.nse,
        instrumentType: InstrumentType.monthly,
      ),
      Stock(
        symbol: 'HDFCBANK',
        price: 966.85,
        change: 0.85,
        changePercent: 0.09,
        exchange: Exchange.nse,
        instrumentType: InstrumentType.eq,
      ),
      Stock(
        symbol: 'ASIANPAINT',
        price: 2537.40,
        change: 6.60,
        changePercent: 0.26,
        exchange: Exchange.nse,
        instrumentType: InstrumentType.eq,
      ),
      Stock(
        symbol: 'RELIANCE SEP 1880 CE',
        price: 0.00,
        change: 0.00,
        changePercent: 0.00,
        exchange: Exchange.nse,
        instrumentType: InstrumentType.monthly,
      ),
      Stock(
        symbol: 'RELIANCE',
        price: 1374.00,
        change: -4.50,
        changePercent: -0.33,
        exchange: Exchange.nse,
        instrumentType: InstrumentType.eq,
      ),
      Stock(
        symbol: 'NIFTY IT',
        price: 35181.95,
        change: 871.51,
        changePercent: 2.54,
        exchange: Exchange.nse,
        instrumentType: InstrumentType.idx,
      ),
      Stock(
        symbol: 'MRF',
        price: 147625.00,
        change: 550.00,
        changePercent: 0.37,
        exchange: Exchange.nse,
        instrumentType: InstrumentType.eq,
      ),
    ];
  }
}
