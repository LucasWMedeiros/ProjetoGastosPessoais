class Transaction{
  final String id;
  final String tittle;
  final double value;
  final DateTime data;

  Transaction({
    required this.id,
    required this.tittle,
    required this.data,
    required this.value
  });
}