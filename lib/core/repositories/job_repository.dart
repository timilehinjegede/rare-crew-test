import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/models/job_dto.dart';
import 'package:rare_crew/core/repositories/auth_repository.dart';

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepositoryImpl(ref.read);
});

const _jobsKey = 'jobs';

abstract class JobRepository {
  Future<List<Job>> getJobs();
  Future<void> saveJobs(List<Job> jobs);
}

class JobRepositoryImpl implements JobRepository {
  JobRepositoryImpl(this._read);

  final Reader _read;

  @override
  Future<List<Job>> getJobs() async {
    final prefs = _read(sharedPreferencesProvider);

    final List<String> jobStringList = prefs.getStringList(_jobsKey) ?? [];

    final List<Job> jobs = jobStringList.map((jobString) {
      final Map<String, dynamic> jobMap = json.decode(jobString);
      return Job.fromJson(jobMap);
    }).toList();

    return jobs;
  }

  @override
  Future<void> saveJobs(List<Job> jobs) async {
    final prefs = _read(sharedPreferencesProvider);

    final List<String> jobStringList = jobs.map((job) {
      final Map<String, dynamic> jobMap = job.toJson();
      return json.encode(jobMap);
    }).toList();

    await prefs.setStringList(_jobsKey, jobStringList);
  }
}
