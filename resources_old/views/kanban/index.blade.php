@extends('layouts.app')
@section('title')
    {{ __('messages.tasks') }}  {{ __('messages.kanban') }}
@endsection
@section('page_css')
    <link rel="stylesheet" href="{{ asset('assets/css/summernote.min.css') }}">
@endsection
@section('css')
    @livewireStyles
    <link rel="stylesheet" href="{{ asset('assets/css/dragula.css') }}">
    <link rel="stylesheet" href="{{ mix('assets/style/css/kanban.css') }}">
    <link rel="stylesheet" href="{{ mix('assets/style/css/task-details-kanban.css') }}">
@endsection
@section('content')
    <section class="section">
        <div class="section-header">
            <h1>{{ __('messages.task.kanban_list') }}</h1>
            <div class="section-header-breadcrumb justify-content-end">
                <div class="row kanban-header">
                    <div class="col-xs-12 mr-2">
                        <div class="project-drp-container">
                            <label for="projectDropdown"
                                   class="lbl-block mr-2"><b>{{ __('messages.projects') }}</b></label>
                            {{Form::select('drp_projects', $projects, null, ['id'=>'projectDropdown', 'class'=>'form-control'])  }}
                        </div>
                    </div>
                    @can('manage_users')
                    <div class="col-xs-12 mr-2">
                        <div class="user-drp-container">
                            <label for="projectDropdown"
                                   class="lbl-block mr-2"><b>{{ __('messages.users') }}</b></label>
                            {{Form::select('drp_users', [], null, ['id'=>'usersDropdown', 'class'=>'form-control','placeholder' => 'All'])  }}
                        </div>
                    </div>
                    @endcan
                    @if(!getLoggedInUser()->hasRole('Admin'))
                        <input type="hidden" hidden value="{{ Auth::id() }}" id="loginUserId">
                    @endif
                    <div class="col-xs-12">
                        <div>
                            <a href="{{ route('tasks.index') }}"
                               class="btn btn-warning form-btn p-2 ml-2 mr-3"
                               title="{{ __('messages.common.list_view') }}" data-toggle="tooltip"><i
                                        class="fa fa-tasks  font-size-20px"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section-body">
            <div class="card">
                <div class="col-12">
                    <div class="row flex-nowrap pt-3 overflow-auto board-container">
                        <div class="lock-board">
                        </div>
                        @livewire('kanban')
                    </div>
                </div>
            </div>
        </div>
    </section>
    @include('kanban.templates.templates')
@endsection
@include('kanban.task-kanban-details')

@section('page_js')
    <script src="{{ asset('assets/js/summernote.min.js') }}"></script>
@endsection
@section('scripts')
    @livewireScripts
    <script>
        let taskUrl = '{{ url('tasks') }}';
        let loginUserRole = "{{ getLoggedInUser()->hasRole('Admin') ? true : false}}";
        let authUserId = "{{ getLoggedInUserId() }}";
        let taskDetailsKanban = "{{ url('kanban-task-details') }}";
        let deleteAttachment = "{{ (__('messages.task.attachments')) }}";
        let downloadTasks = "{{ route('tasks.index')  }}";
        let usersByProjectUrl = "{{ url('users-by-project')  }}/";
    </script>
    <script src="{{ mix('assets/js/dom-autoscroller.js') }}"></script>
    <script src="{{ mix('assets/js/dragula.js') }}"></script>
    <script src="{{ mix('assets/js/projects/kanban.js') }}"></script>
    <script src="{{ mix('assets/js/input_price_format.js') }}"></script>
@endsection
