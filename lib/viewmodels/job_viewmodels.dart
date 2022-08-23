import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/models/job_dto.dart';
import 'package:rare_crew/core/repositories/job_repository.dart';

final jobsViewModelProvider = Provider<JobsViewModel>((ref) {
  return JobsViewModel(ref.read);
});

final jobsListProvider = StateNotifierProvider<JobsViewModel, List<Job>>(
  (ref) {
    return ref.read(jobsViewModelProvider);
  },
);

class JobsViewModel extends StateNotifier<List<Job>> {
  JobsViewModel(this._read) : super([]) {
    getJobs();
  }

  final Reader _read;

  void getJobs() async {
    final jobs = _read(jobRepositoryProvider).getJobs();

    state = jobs;
  }

  void addJob(Job job) async {
    final newJobList = [
      ...state,
      job,
    ];

    await _read(jobRepositoryProvider).saveJobs(newJobList);

    state = newJobList;
  }

  void editJob({required String id, required Job editedJob}) async {
    state = [
      for (var job in state)
        if (job.id == id)
          job = job.copyWith(
            id: editedJob.id,
            jobTitle: editedJob.jobTitle,
            minSalary: editedJob.minSalary,
            maxSalary: editedJob.maxSalary,
          )
        else
          job,
    ];

    await _read(jobRepositoryProvider).saveJobs(state);
  }

  void deleteJob(String jobId) async {
    state = state.where((job) => job.id != jobId).toList();

    await _read(jobRepositoryProvider).saveJobs(state);
  }
}
