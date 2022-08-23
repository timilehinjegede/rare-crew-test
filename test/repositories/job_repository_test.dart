import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';

class JobRepositoryTestImpl implements JobRepository {
  List<Job> _jobs = [];

  @override
  List<Job> getJobs() {
    return _jobs;
  }

  @override
  Future<void> saveJobs(List<Job> jobs) async {
    _jobs = jobs;
  }
}

void main() {
  group(
    'Test Job Repository',
    () {
      final container = ProviderContainer(
        overrides: [
          jobRepositoryProvider.overrideWithProvider(
            Provider(
              (ref) => JobRepositoryTestImpl(),
            ),
          ),
        ],
      );

      test(
        'Get jobs - returns an empty list when there are no jobs',
        () async {
          final jobs = container.read(jobRepositoryProvider).getJobs();
          expect(jobs.isEmpty, true);
        },
      );
      test(
        'Get jobs - returns a list of jobs when there are jobs',
        () async {
          final jobs = container.read(jobRepositoryProvider).getJobs();

          // add some jobs
          jobs.add(
            Job(
              id: 'id',
              jobTitle: 'jobTitle',
              minSalary: 0,
              maxSalary: 0,
              createdAt: 'createdAt',
            ),
          );

          expect(jobs.isNotEmpty, true);
        },
      );
      test(
        'Save jobs - adds to the list of available jobs',
        () async {
          final jobsToSave = [
            Job(
              id: 'id_1',
              jobTitle: 'jobTitle_1',
              minSalary: 0,
              maxSalary: 0,
              createdAt: 'createdAt_1',
            ),
            Job(
              id: 'id_2',
              jobTitle: 'jobTitle_2',
              minSalary: 0,
              maxSalary: 0,
              createdAt: 'createdAt_2',
            ),
          ];
          container.read(jobRepositoryProvider).saveJobs(jobsToSave);

          final jobs = container.read(jobRepositoryProvider).getJobs();
          expect(jobs.length, 2);
        },
      );
    },
  );
}
