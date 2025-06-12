@extends('layouts.app')
@section('title')
    {{ __('messages.report.report_details') }}
@endsection
@section('page_css')
    <link href="{{mix('assets/style/css/report.css')}}" rel="stylesheet" type="text/css"/>
@endsection

@section('content')
    <section class="section">
        <div class="section-header my-0">
            <h1 class="page__heading">{{ __('messages.report.report_details') }}</h1>
            <div class="filter-container section-header-breadcrumb">
                <div class="ml-auto">
                   
                    <a href="{{ route('reports.edit', $report->id) }}"
                       class="btn btn-primary filter-container__btn mr-2 report-action-btn">
                        {{ __('messages.common.edit') }}
                    </a>
                    <a class="btn btn-light report-action-btn"
                       href="{{ route('reports.index')}}">{{ __('messages.common.back') }}</a>
                    @if($invoiceId)
                    <a class="btn btn-success pull-right ml-2"
                        href="{{ route('invoices.pdf',['invoice' => $invoiceId])  }}"
                        target="_blank">{{ __('messages.expense.download') }}</a>
                    @endif
                </div>
            </div>
        </div>
        <div class="section-body">
            @if(Auth::user()->hasRole('Admin'))
                <div class="report-note form-btn d-none ml-auto my-0">
                    <div class="report-note w-100 justify-content-end my-0 py-0 text-danger text-right">
                        {{ __('messages.common.note') }}: {{ __('messages.report.cost_is_calculated_base_on_salary') }}
                        <span class="cost-count-tooltip-hover text-dark">
                            <sup><i class="fas fa-question-circle"></i></sup>
                                <div class="cost-count-tooltip-popup">
                                    DaySalary = User Salary / WorkingDayOfMonth (Setting); <br>
                                    HourSalary = DaySalary / WorkingHourOfDay (Setting); <br>
                                    MinuteSalary = HourSalary / 60; <br>
                                    Cost =  round(MinuteSalary * Task minutes);
                                </div>
                            </span>
                    </div>
                </div>
            @endif
            @include('flash::message')
            <div class="row">
                <div class="col-lg-12">
                    @include('reports.report_format')
                    @include('tasks.task_details')
                </div>
            </div>
        </div>
        </div>
    </section>
@endsection
@section('scripts')
    <script>
        let reportUrl = "{{ url('reports') }}/";
        let taskUrl = '{{url('tasks')}}/';
        let taskDetailUrl = '{{url('task-details')}}';
        let taskDetailActionColumnIsVisible = false;
        let reportStartDate = '{{$report->start_date->startOfDay()}}';
        let reportEndDate = '{{$report->end_date->endOfDay()}}';
        let usersOfProjects = "{{ url('users-of-projects') }}";
        let projectsOfClient = "{{ url('projects-of-client') }}";
    </script>
    <script src="{{ mix('assets/js/report/report-show.js') }}"></script>
    <script src="{{ mix('assets/js/report/report.js') }}"></script>
    <script src="{{ mix('assets/js/task/task_time_entry.js') }}"></script>
@endsection
