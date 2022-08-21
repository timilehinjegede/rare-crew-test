// ignore_for_file: unnecessary_getters_setters
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/models/job_dto.dart';
import 'package:rare_crew/viewmodels/job_viewmodels.dart';

final jobFormProvider =
    Provider.autoDispose.family<JobFormViewModel, Job?>((ref, job) {
  return JobFormViewModel(ref.read, job);
});

class JobFormViewModel {
  late final JobsViewModel _jobsViewModel;

  late String jobId;

  var jobTitle = '';
  var minSalary = 0;
  var maxSalary = 0;
  var createdAt = DateTime.now();

  var isNewJob = false;

  JobFormViewModel(final Reader read, final Job? job) {
    _jobsViewModel = read(jobsListProvider.notifier);

    _initJob(job);
  }

  _initJob(Job? job) {
    if (job != null) {
      jobId = job.id!;
      jobTitle = job.jobTitle!;
      minSalary = job.minSalary!;
      maxSalary = job.maxSalary!;
      createdAt = DateTime.parse(job.createdAt!);
    } else {
      resetFields();
      isNewJob = true;
    }
  }

  createOrEditJob() {
    final job = Job(
      id: jobId,
      jobTitle: jobTitle,
      minSalary: minSalary,
      maxSalary: maxSalary,
      createdAt: createdAt.toIso8601String(),
    );
    if (isNewJob) {
      _jobsViewModel.addJob(job);
    } else {
      _jobsViewModel.editJob(id: jobId, editedJob: job);
    }
  }

  deleteJob() {
    if (!isNewJob) _jobsViewModel.deleteJob(jobId);
  }

  bool validateForm() {
    final isJobTitleValid = jobTitle.trim().isNotEmpty;
    final isMinimumSalaryValid = minSalary > 0 && minSalary <= maxSalary;
    final isMaximumSalaryValid = maxSalary > 0 && maxSalary >= minSalary;

    return isJobTitleValid && isMinimumSalaryValid && isMaximumSalaryValid;
  }

  void resetFields() {
    jobTitle = '';
    minSalary = 0;
    maxSalary = 0;
    createdAt = DateTime.now();
  }
}
