import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/create_job_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/get_jobs_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/create_job_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_job_event.dart';
part 'create_job_state.dart';

class CreateJobBloc extends Bloc<CreateJobEvent, JobsState> {
  final CreateJobUseCase createJobUseCase;
  final GetJobsUsecase getJobsUsecase;
  CreateJobBloc(this.createJobUseCase, this.getJobsUsecase)
    : super(CreateJobInitial()) {
    on<JobTypeChanged>(_onJobTypeChanged);
    on<LocationChanged>(_onLocationChanged);
    on<CreateJobSubmitted>(_onCreateJob);
    on<GetJobRequested>(_onGetJobs);
  }

  void _onJobTypeChanged(JobTypeChanged event, Emitter<JobsState> emit) {
    emit(state.copyWith(jobtype: event.jobType));
  }

  void _onLocationChanged(LocationChanged event, Emitter<JobsState> emit) {
    emit(state.copyWith(location: event.location));
  }

  Future<void> _onCreateJob(
    CreateJobSubmitted event,
    Emitter<JobsState> emit,
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
    Emitter<JobsState> emit,
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
}
