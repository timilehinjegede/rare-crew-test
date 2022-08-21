class Job {
  Job({
    required this.id,
    required this.jobTitle,
    required this.minSalary,
    required this.maxSalary,
    required this.createdAt,
  });

  final String? id;
  final String? jobTitle;
  final int? minSalary;
  final int? maxSalary;
  final String? createdAt;

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      jobTitle: json['job_title'],
      minSalary: json['min_salary'],
      maxSalary: json['max_salary'],
      createdAt: json['created_at'],
    );
  }

  Job copyWith({
    String? id,
    String? jobTitle,
    int? minSalary,
    int? maxSalary,
    String? createdAt,
  }) {
    return Job(
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return '$id, $jobTitle, $minSalary, $maxSalary, $createdAt';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'job_title': jobTitle,
        'min_salary': minSalary,
        'max_salary': maxSalary,
        'created_at': createdAt,
      };
}
