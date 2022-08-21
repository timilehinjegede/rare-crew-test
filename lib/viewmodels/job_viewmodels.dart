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
    final jobs = await _read(jobRepositoryProvider).getJobs();

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


// class JobsViewModel extends StateNotifier<AsyncValue<List<Job>>> {
//   JobsViewModel(this._read) : super(const AsyncValue.loading()) {
//     getJobs();
//   }
//   @override
//   AsyncValue<List<Job>> get state => super.state;

//   final Reader _read;

//   void getJobs() async {
//     state = AsyncValue.loading();
//     final jobs = await _read(jobRepositoryProvider).getJobs();

//     state = AsyncValue.data(jobs);
//     log('state data in get jobs ${state.asData?.value}');
//   }

//   void addJob(Job job) async {
//     getJobs();
//     state = AsyncValue.loading();
//     log('state data in get jobs ${state.asData?.value}');

//     final newJobList = [
//       ...state.asData?.value ?? <Job>[],
//       job,
//     ];

//     await _read(jobRepositoryProvider).saveJobs(newJobList);

//     state = AsyncValue.data(newJobList);
//   }

//   void editJob({required String id, required Job job}) async {
//     getJobs();

//     state = AsyncValue.loading();

//     final newJobList = [
//       for (Job job in state.asData?.value ?? [])
//         if (job.id == id)
//           job.copyWith(
//             jobTitle: job.jobTitle,
//             minSalary: job.minSalary,
//             maxSalary: job.maxSalary,
//             createdAt: job.createdAt,
//           )
//         else
//           job,
//     ];

//     await _read(jobRepositoryProvider).saveJobs(newJobList);

//     state = AsyncValue.data(newJobList);
//   }

//   void deleteJob(String jobId) async {
//     getJobs();

//     state = AsyncValue.loading();

//     (state.asData?.value ?? []).removeWhere((job) => job.id != jobId);

//     await _read(jobRepositoryProvider).saveJobs(state.asData?.value ?? <Job>[]);
//     log('I have passed here oooo');
//     log('I have passed here oooo => ${state.data}');
//     ViewState.data(state.data ?? <Job>[]);
//   }
// }
