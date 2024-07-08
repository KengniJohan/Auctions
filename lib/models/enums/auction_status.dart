enum AuctionStatus {
  newed,
  inProcess,
  rescheduled,
  canceled,
  finished;

  String toName() => toString().split('.').last.toUpperCase();

  static AuctionStatus fromName(String name) => AuctionStatus.values.firstWhere(
        (status) => status.toName() == name,
        orElse: () => AuctionStatus.newed,
      );
}
