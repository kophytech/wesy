class Schedule {
  final String? id;
  final String? title;
  final String? startDate;
  final String? endDate;
  final bool? allDay;
  final String? notes;

  Schedule({
    this.id,
    this.title,
    this.startDate,
    this.endDate,
    this.allDay,
    this.notes,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as String?,
      title: json['title'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      allDay: json['allDay'] as bool?,
      notes: json['notes'] as String?,
    );
  }
}
