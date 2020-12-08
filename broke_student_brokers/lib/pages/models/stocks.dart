class Stocks {
  final int balance;
  final bool botState;
  final List cumulativeCurrentValue;
  final List currentHoldings;
  final List orders;
  final Map userDetails;

  Stocks(
      {this.balance,
      this.botState,
      this.cumulativeCurrentValue,
      this.currentHoldings,
      this.orders,
      this.userDetails});
}
