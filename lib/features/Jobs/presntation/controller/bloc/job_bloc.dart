import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/Jobs/domain/entites/applcation_entite.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/apply_job_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/create_job_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/get_applied_jobs_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/get_jobs_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/apply_job_param.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/create_job_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final CreateJobUseCase createJobUseCase;
  final GetJobsUsecase getJobsUsecase;
  final ApplyJobUseCase applyJobUseCase;
  final GetAppliedJobsUsecase getAppliedJobsUseCase;
  JobBloc(
    this.createJobUseCase,
    this.getJobsUsecase,
    this.applyJobUseCase,
    this.getAppliedJobsUseCase,
  ) : super(CreateJobInitial()) {
    on<JobTypeChanged>(_onJobTypeChanged);
    on<LocationChanged>(_onLocationChanged);
    on<CreateJobSubmitted>(_onCreateJob);
    on<GetJobRequested>(_onGetJobs);
    on<ApplyJobRequested>(_onApplyJob);
    on<GetAppliedJobsRequested>(_onGetAppliedJobs);
  }

  void _onJobTypeChanged(JobTypeChanged event, Emitter<JobState> emit) {
    emit(state.copyWith(jobtype: event.jobType));
  }

  void _onLocationChanged(LocationChanged event, Emitter<JobState> emit) {
    emit(state.copyWith(location: event.location));
  }

  Future<void> _onCreateJob(
    CreateJobSubmitted event,
    Emitter<JobState> emit,
  ) async {
    emit(state.copyWith(createJobState: RequestState.loading));
    final result = await createJobUseCase(
      CreateJobParams(
        title: event.jobTitle,
        jobType: event.jobType,
        location: event.location,
        salary: event.salaryRange,
        description: event.description,
        requirements: event.requirements,
        companyName: event.companyName,
        companyImage: event.companyImage,
        companyId: event.companyId,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          createJobState: RequestState.error,
          createJobMessage: failure.message,
        ),
      ),
      (job) => emit(
        state.copyWith(
          createJobState: RequestState.loaded,
          job: job,
          createJobMessage: 'Job created successfully',
        ),
      ),
    );
  }

  Future<void> _onGetJobs(
    GetJobRequested event,
    Emitter<JobState> emit,
  ) async {
    emit(state.copyWith(getJobsState: RequestState.loading));
    final result = await getJobsUsecase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          getJobsState: RequestState.error,
          getJobsMessage: failure.message,
        ),
      ),
      (jobs) => emit(
        state.copyWith(
          getJobsState: RequestState.loaded,
          jobs: jobs,
          getJobsMessage: 'Jobs fetched successfully',
        ),
      ),
    );
  }

  Future<void> _onApplyJob(
    ApplyJobRequested event,
    Emitter<JobState> emit,
  ) async {
    emit(state.copyWith(applyJobState: RequestState.loading));
    final result = await applyJobUseCase(
      ApplyJobParams(
        jobId: event.jobId,
        userId: event.userId,
        companyId: event.companyId,
        companyImage: event.companyImage,
        companyName: event.companyName,
        jobTitle: event.jobTitle,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          applyJobState: RequestState.error,
          applyJobMessage: failure.message,
        ),
      ),
      (success) => emit(
        state.copyWith(
          applyJobState: RequestState.loaded,
          applyJobMessage: 'Applied to job successfully',
        ),
      ),
    );
  }

  Future<void> _onGetAppliedJobs(
    GetAppliedJobsRequested event,
    Emitter<JobState> emit,
  ) async {
    emit(state.copyWith(getApplyJobState: RequestState.loading));
    final result = await getAppliedJobsUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          getApplyJobState: RequestState.error,
          getApplyJobMessage: failure.message,
        ),
      ),
      (jobs) => emit(
        state.copyWith(
          getApplyJobState: RequestState.loaded,
          appliedJobs: jobs,
          getApplyJobMessage: 'Applied jobs fetched successfully',
        ),
      ),
    );
  }
}
