class SavingModel {
  final String title, category;
  final int currentSaving, savingTarget;
  final DateTime startDate, endDate;

  SavingModel({
    required this.title,
    required this.category,
    required this.currentSaving,
    required this.savingTarget,
    required this.startDate,
    required this.endDate
  });
}