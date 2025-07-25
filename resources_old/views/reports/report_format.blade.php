<div class="card {{!getLoggedInUser()->hasRole('Admin') ? 'mt-5' : ''}}">
    <div class="card-body reports">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12">
                <h4>{{html_entity_decode($report->name)}} ({{$totalHours}})</h4>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12 text-right formattedDate">
                <h4>{{$report->formatted_date}}</h4>
            </div>
        </div>
        @if(empty($reports))
            <div class="d-flex justify-content-center">
                <span>{{ __('messages.report.no_record_available') }}</span>
            </div>
        @endif
        @foreach($reports as $department)
            <div class="reports__container">
                <div class="reports__department-row">
                    <h5 class="mb-0 reports__department-row-title">
                        <i class="fas fa-caret-up mr-1"></i>
                        <i class="fas fa-building mr-2"></i>
                        {{html_entity_decode(ucwords($department['name']))}}
                    </h5>
                    <h5 class="mb-0">
                        {{$department['time']}} ({{round($department['duration'] * 100 / $totalMinutes, 2)}} %)
                        @can('manage_users')
                            <span
                                class="font-weight-bold d-none"> - [Cost: {{ number_format($department['cost']) }}]</span>
                            <span class="cost-tooltip-hover d-none">
                                <sup><i class="fas fa-question-circle"></i></sup>
                                <div class="cost-tooltip-popup">
                                   The cost of all users will be counted and its total will be shown here.
                                </div>
                            </span>
                        @endcan
                    </h5>
                </div>
                <hr class="my-0"/>
                <div class="collapse-row">
                    @foreach($department['clients'] as $client)
                        <div class="reports__client-row">
                            <h5 class="mb-0 reports__client-row-title">
                                <i class="fas fa-caret-up mr-1"></i>
                                <i class="fas fa-user-tie mr-2"></i>
                                {{html_entity_decode(ucwords($client['name']))}}
                            </h5>
                            <h5 class="mb-0">
                                {{$client['time']}} ({{round($client['duration'] * 100 / $totalMinutes, 2)}} %)
                                @can('manage_users')
                                    <span class="font-weight-bold d-none"> - [Cost: {{ number_format($client['cost']) }}]</span>
                                @endcan
                            </h5>
                        </div>
                        <div class="reports__client-container">
                            @foreach($client['projects'] as $project)
                                <div class="reports__project-row">
                                    <div class="reports__project-header">
                                        <i class="fas fa-caret-up mr-1"></i>
                                        <i class="fa fa-folder-open mr-2"></i>
                                        {{html_entity_decode(ucwords($project['name']))}}
                                    </div>
                                    <span>
                                         {{$project['time']}} ({{round($project['duration'] * 100 / $client['duration'], 2)}} %)
                                         @can('manage_users')
                                            <span class="font-weight-bold d-none">  - [Cost: {{number_format($project['cost'])}}]</span>
                                         @endcan
                                    </span>
                                </div>
                                <div class="reports__project-container">
                                    @foreach($project['users'] as $user)
                                        <div class="reports__developer-task">
                                            <div class="reports__developer-row">
                                                <div class="reports__developer-header">
                                                    <i class="fas fa-caret-up mr-1"></i>
                                                    <i class="fa fa-users mr-2"></i>
                                                    {{html_entity_decode(ucwords($user['name']))}}
                                                </div>
                                                <span>
                                                    {{$user['time']}} ({{round($user['duration'] * 100 / $project['duration'], 2)}} %)
                                                    @can('manage_users')
                                                        <span class="font-weight-bold d-none">  - [Cost: {{ number_format($user['cost'])}}]</span>
                                                    @endcan
                                                </span>
                                            </div>
                                            <div class="reports__task-container">
                                                @foreach($user['tasks'] as $task)
                                                    <div class="reports__task-row">
                                                        <span class="reports__task-header">
                                                            <span data-toggle="modal" class="taskDetails"
                                                                  data-target="#taskDetailsModal"
                                                                  data-id="{{$task['task_id']}}">{{html_entity_decode($task['name'])}}</span>
                                                        </span>
                                                        <span>{{$task['time']}}</span>
                                                    </div>
                                                @endforeach
                                            </div>
                                        </div>
                                    @endforeach
                                </div>
                            @endforeach
                        </div>
                    @endforeach
                </div>
            </div>
        @endforeach
    </div>
</div>

