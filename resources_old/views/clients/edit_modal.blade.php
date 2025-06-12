<div id="EditModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">{{ __('messages.client.edit_client') }}</h5>
                <button type="button" aria-label="Close" class="close outline-none" data-dismiss="modal">×</button>
            </div>
            {{ Form::open(['id' => 'editForm', 'files' => true]) }}
            <div class="modal-body">
                <div class="alert alert-danger display-none" id="editValidationErrorsBox"></div>
                {{ Form::hidden('client_id', null, ['id' => 'clientId']) }}
                <div class="row">
                    <div class="form-group col-sm-6">
                        {{ Form::label('name', __('messages.client.name').':') }}<span class="required">*</span>
                        {{ Form::text('name', '', ['id' => 'edit_name', 'class' => 'form-control', 'required','tabindex' => '1']) }}
                    </div>
                    <div class="form-group col-sm-6">
                        {{ Form::label('department_id', __('messages.client.department').':') }}<span
                                class="required">*</span>
                        {{ Form::select('department_id', $departments, null, ['id' => 'edit_department_id', 'class' => 'form-control', 'required','placeholder'=>'Select Department','tabindex' => '2']) }}
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-12">
                        {{ Form::label('email', __('messages.client.email').':') }}
                        {{ Form::email('email', '', ['id' => 'edit_email', 'class' => 'form-control','tabindex' => '3']) }}
                        <label id="delete-warning" class="mb-0"></label>
                    </div>
                </div>
                @can('manage_users')
                    <div class="row" id="edit_password">
                        <div class="form-group col-sm-6">
                            {{ Form::label('password', __('messages.user.new_password').':') }}
                            <div class="input-group">
                                <input class="form-control input-group__addon" id="new_edit_password" type="password"
                                       name="password" tabindex="4">
                                <div class="input-group-append input-group__icon">
                                <span class="input-group-text changeType">
                                    <i class="icon-ban icons"></i>
                                </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            {{ Form::label('password_confirmation', __('messages.user.confirm_password').':') }}<span
                                    class="required confirm-pwd">*</span>
                            <div class="input-group">
                                <input class="form-control input-group__addon" id="new_confirm_edit_password" type="password"
                                       name="password_confirmation" tabindex="5">
                                <div class="input-group-append input-group__icon">
                                <span class="input-group-text changeType">
                                    <i class="icon-ban icons"></i>
                                </span>
                                </div>
                            </div>
                        </div>
                    </div>
                @endcan
                <div class="row">
                    <div class="form-group col-sm-12">
                        {{ Form::label('website', __('messages.client.website').':') }}
                        {{ Form::url('website', '', ['id' => 'edit_website', 'class' => 'form-control','tabindex' => '6']) }}
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-sm-4 col-xl-3">
                        <div class="form-group">
                            {{ Form::label('photo', __('messages.client.image').':') }} <br>
                            <label
                                    class="image__file-upload btn btn-primary text-color-white"
                                    tabindex="7"> {{ __('messages.setting_menu.choose') }}
                                {{ Form::file('photo',['id'=>'clientEditProfile','class' => 'd-none']) }}
                            </label>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class=" preview-image-video-container">
                            <img id='editPreviewImage' class="img-thumbnail thumbnail-preview"
                                 src="{{asset('assets/img/user-avatar.png')}}"/>
                        </div>
                    </div>
                </div>
                <div class="text-right">
                    {{ Form::button(__('messages.common.save'), ['type' => 'submit', 'class' => 'btn btn-primary', 'id' => 'btnEditSave', 'data-loading-text' => "<span class='spinner-border spinner-border-sm'></span> Processing..." , 'tabindex' => '8']) }}
                    <button type="button" class="btn btn-light ml-1"
                            data-dismiss="modal">{{ __('messages.common.cancel') }}</button>
                </div>
            </div>
            {{ Form::close() }}
        </div>
    </div>
</div>
