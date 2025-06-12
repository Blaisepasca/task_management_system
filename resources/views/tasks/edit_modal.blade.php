<div id="EditModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">{{ __('messages.task.edit_task') }}</h5>
                <button type="button" aria-label="Close" class="close outline-none" data-dismiss="modal">×</button>
            </div>
            {{ Form::open(['id'=>'editForm']) }}
            <div class="modal-body">
                <div class="alert alert-danger display-none" id="editValidationErrorsBox"></div>
                {{ Form::hidden('tag_id',null,['id'=>'tagId']) }}
                <div class="row">
                    <div class="form-group col-sm-6">
                        {{ Form::label('title', __('messages.task.title').':') }}<span class="required">*</span>
                        {{ Form::text('title', null, ['id'=>'editTitle','class' => 'form-control','required']) }}
                    </div>
                    <div class="form-group col-sm-6">
                        {{ Form::label('project_id', __('messages.task.project').':') }}<span
                                class="required">*</span>
                        {{ Form::select('project_id', $projects, null, ['class' => 'form-control','required', 'id' => 'editProjectId', 'placeholder'=>'Select Project']) }}
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-6">
                        {{ Form::label('priority',  __('messages.task.priority').':') }}
                        {{ Form::select('priority',$priority, null, ['class' => 'form-control','id'=>'editPriority','placeholder'=>'Select Priority']) }}
                    </div>
                    <div class="form-group col-sm-6">
                        {{ Form::label('status', __('messages.task.status').':') }}
                        {{ Form::select('status',$taskStatus, null, ['class' => 'form-control','id'=>'editStatus']) }}
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-6">
                        {{ Form::label('due_date', __('messages.task.due_date').':') }}
                        {{ Form::text('due_date', null, ['id'=>'editDueDate','class' => 'form-control', 'autocomplete' => 'off']) }}
                    </div>
                    <div class="form-group col-sm-6">
                        {{ Form::label('estimate_time', __('messages.task.estimate_time').':') }}
                        <div class="input-group mb-3">
                            {{ Form::text('estimate_time_hours', null, ['id'=>'editEstimateTimeHours','class' => 'form-control', 'autocomplete' => 'off']) }}
                            {{ Form::number('estimate_time_days', null, ['id' => 'editEstimateTimeDays', 'class' => 'form-control', 'autocomplete' => 'off','min' => 0 ,'max' => 30]) }}
                            <div class="input-group-append">
                                <input type="hidden" name="estimate_time_type" value="" id="editTypes">
                                <button name="type" type="button" class="input-group-text btn"
                                        id="editDays">{{__('messages.task.in_days')}}</button>
                                <button name="type" type="button" class="input-group-text btn" id="editHours"
                                        value="1">{{__('messages.task.in_hours')}}</button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-sm-6 task-tags">
                        {{ Form::label('tags', __('messages.task.tags').':') }}
                        {{ Form::select('tags[]',[], null, ['class' => 'form-control','id'=>'editTagIds', 'multiple' => true]) }}
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-12 task-assignees">
                        {{ Form::label('assign_to', __('messages.task.assign_to').':') }}
                        {{ Form::select('assignees[]',[], null, ['class' => 'form-control','id'=>'editAssignee', 'multiple' => true]) }}
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-12">
                        {{ Form::label('description', __('messages.common.description').':') }}
                        {{ Form::textarea('description', null, ['class' => 'form-control', 'id' => 'taskEditDescription']) }}
                    </div>
                </div>
                <div class="text-right">
                    {{ Form::button(__('messages.common.save'), ['type'=>'submit','class' => 'btn btn-primary','id'=>'btnTaskEditSave','data-loading-text'=>"<span class='spinner-border spinner-border-sm'></span> Processing..."]) }}
                    <button type="button" class="btn btn-light ml-1"
                            data-dismiss="modal">{{ __('messages.common.cancel') }}</button>
                </div>
            </div>
            {{ Form::close() }}
        </div>
    </div>
</div>
