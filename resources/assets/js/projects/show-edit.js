'use strict';

const editPickr = Pickr.create({
    el: '.color-wrapper',
    theme: 'nano', // or 'monolith', or 'nano'
    closeWithKey: 'Enter',
    autoReposition: true,
    defaultRepresentation: 'HEX',
    swatches: [
        'rgba(244, 67, 54, 1)',
        'rgba(233, 30, 99, 1)',
        'rgba(156, 39, 176, 1)',
        'rgba(103, 58, 183, 1)',
        'rgba(63, 81, 181, 1)',
        'rgba(33, 150, 243, 1)',
        'rgba(3, 169, 244, 1)',
        'rgba(0, 188, 212, 1)',
        'rgba(0, 150, 136, 1)',
        'rgba(76, 175, 80, 1)',
        'rgba(139, 195, 74, 1)',
        'rgba(205, 220, 57, 1)',
        'rgba(255, 235, 59, 1)',
        'rgba(255, 193, 7, 1)',
    ],

    components: {
        // Main components
        preview: true,
        hue: true,

        // Input / output Options
        interaction: {
            input: true,
            clear: false,
        },
    },
});

editPickr.on('change', function () {
    const color = editPickr.getColor().toHEXA().toString();
    if (wc_hex_is_light(color)) {
        $('.editValidationErrorsBox').text('');
        $('.editValidationErrorsBox').show().html('');
        $('.editValidationErrorsBox').text('Pick a different color');
        setTimeout(function () {
            $('.editValidationErrorsBox').slideUp();
        }, 5000);
        $(':input[id="btnEditSave"]').prop('disabled', true);
        return;
    }
    $(':input[id="btnEditSave"]').prop('disabled', false);
    editPickr.setColor(color);
    $('#edit_color').val(color);
});

$(document).ready(function () {
    $('#edit_client_id').select2({
        width: '100%',
        placeholder: 'Select Client',
    });
    $('#editCurrency,#edit_budget_type,#budget_type,#editStatusProject').
        select2({
            width: '100%',
        });

    $('#edit_user_ids').select2({
        width: '100%',
        placeholder: 'Select Users',
    });
});

$('#editDescription').summernote({
    placeholder: 'Add Project description...',
    minHeight: 200,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['strikethrough']],
        ['para', ['paragraph']]],
});

$('#ProjectEditModal').on('show.bs.modal', function () {
    $('.pcr-button').css('border', '1px solid grey');
    $('.project_remaining_user').popover('hide');
});

$(document).on('submit', '#editFormProject', function (event) {
    event.preventDefault();
    let form = $(this);
    let $description = $('<div />').
        html($('#editDescription').summernote('code'));
    let empty = $description.text().trim().replace(/ \r\n\t/g, '') === '';
    if ($('#editPrice').val() == 0) {
        displayErrorMessage('The budget amount should be a minimum of 1.');
        return false;
    }
    if (removeCommas($('#editPrice').val()).length > 12) {
        displayErrorMessage('Maximum 12 digits budget amount is allowed.');
        return false;
    }
    var loadingButton = jQuery(this).find('#btnEditSave');
    loadingButton.button('loading');
    if ($('#editDescription').summernote('isEmpty')) {
        $('#editDescription').val('');
    }else if (empty){
        displayErrorMessage('Description field is not contain only white space');
        loadingButton.button('reset');
        return false;
    }
    let formdata = $(this).serializeArray();
    formdata[formdata.length] = {
        name: 'color',
        value: $('#edit_color').val(),
    };
    var id = $('#projectId').val();
    $.ajax({
        url: projectUrl + id,
        type: 'put',
        data: formdata,
        success: function (result) {
            if (result.success) {
                displaySuccessMessage(result.message);
                $('#ProjectEditModal').modal('hide');
                $('#projects_table').DataTable().ajax.reload(null, false);
                revokerTracker();
                location.reload(true);
            }
        },
        error: function (result) {
            displayErrorMessage(result.responseJSON.message);
        },
        complete: function () {
            loadingButton.button('reset');
        },
    });
});

$('#ProjectEditModal').on('hidden.bs.modal', function () {
    $('#editDescription').summernote('code', '');
    resetModalForm('#editFormProject', '#editValidationErrorsBox');
});

window.renderData = function (id) {
    $.ajax({
        url: projectUrl + id + '/edit',
        type: 'GET',
        success: function (result) {
            if (result.success) {
                let project = result.data.project;
                let element = document.createElement('textarea');
                element.innerHTML = project.name;
                $('#projectId').val(project.id);
                $('#edit_name').val(element.value);
                $('#edit_prefix').val(project.prefix);
                editPickr.setColor(project.color);
                $('#edit_client_id').val(project.client_id).trigger('change');
                $('#editStatusProject').val(project.status).trigger('change');
                $('#editDescription').summernote('code', project.description);
                if (!isEmpty(project.price)) {
                    $('#editPrice').val(getFormattedPrice(project.price));
                }
                $('#editCurrency').val(project.currency).trigger('change');
                $('#edit_budget_type').
                    val(project.budget_type).
                    trigger('change');
                var valArr = result.data.users;
                $('#edit_user_ids').val(valArr);
                $('#edit_user_ids').trigger('change');
                $('#ProjectEditModal').modal('show');
            }
        },
        error: function (result) {
            manageAjaxErrors(result);
        },
    });
};

$(document).on('click', '.edit-btn', function (event) {
    let projectId = $(event.currentTarget).attr('data-id');
    renderData(projectId);
});

$('.modal').on('show.bs.modal', function () {
    $(this).appendTo('body');
});

//popover on more users  of  project detail screen
$('[data-toggle=popover]').popover({
    html: true,
    content: function () {
        return $('#popover-content').html();
    },
});

$(function () {
    $('#editAssignTo').select2({
        width: '100%',
        placeholder: 'Select Assignee',
    });
    $('#editProjectId').select2({
        width: '100%',
        placeholder: 'Select Project',
    });
    $('#editStatus').select2({
        width: '100%',
    });
    $('#editAssignee').select2({
        width: '100%',
        placeholder: 'Select Assignee',
    });

    if (canManageTags) {
        $('#editTagIds').select2({
            width: '100%',
            tags: true,
            placeholder: 'Select Tags',
            createTag: function (tag) {
                var found = false;
                $('#editTagIds option').each(function () {
                    if ($.trim(tag.term).toUpperCase() ===
                        $.trim($(this).text()).toUpperCase()) {
                        found = true;
                    }
                });
                if (!found) {
                    return {
                        id: tag.term,
                        text: tag.term,
                    };
                }
            },
        });
    } else {
        $('#editTagIds').select2({
            width: '100%',
            placeholder: 'Select Tags',
        });
    }
    $('#editPriority').select2({
        width: '100%',
    });

    $('#dueDate,#editDueDate').datetimepicker({
        format: 'YYYY-MM-DD',
        useCurrent: false,
        icons: {
            previous: 'icon-arrow-left icons',
            next: 'icon-arrow-right icons',
        },
        sideBySide: true,
        minDate: moment().millisecond(0).second(0).minute(0).hour(0),
    });

    $('#dueDate, #editDueDate').on('dp.show', function () {
        matchWindowScreenPixels({
            dueDate: '#dueDate',
            editDueDate: '#editDueDate',
        }, 'tsk');
    });

    $(window).resize(function () {
        matchWindowScreenPixels({
            dueDate: '#dueDate',
            editDueDate: '#editDueDate',
        }, 'tsk');
    }).trigger('resize');

    $('[data-toggle="tooltip"]').tooltip();

});
let quillTask = $('#taskEditDescription').summernote({
    placeholder: 'Add Task description...',
    minHeight: 200,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['strikethrough']],
        ['para', ['paragraph']]],
});

let taskAssignees = [];

$(document).on('click', '.edit-task-btn', function (event) {
    let id = $(event.currentTarget).attr('data-id');
    $.ajax({
        url: taskUrl + id + '/edit',
        type: 'GET',
        success: function (result) {
            if (result.success) {
                let task = result.data.task;
                let allTags = result.data.tags;
                let elementTag = document.createElement('textarea');
                $('#editTagIds').empty();
                $.each(allTags, function (i, e) {
                    elementTag.innerHTML = e;
                    $('#editTagIds').
                        append($('<option>',
                            { value: i, text: elementTag.value }));
                });

                let desc = task.description;
                let element = document.createElement('textarea');
                element.innerHTML = task.title;
                $('#tagId').val(task.id);
                $('#editTitle').val(element.value);
                $('#taskEditDescription').summernote('code', task.description);
                $('#editDueDate').val(task.due_date);
                $('#editProjectId').val(task.project.id).trigger('change');
                $('#editStatus').val(task.status).trigger('change');
                if (task.estimate_time_type == null && task.estimate_time ==
                    null) {
                    $('#editDays').removeClass('btn-primary text-white');
                }
                if (task.estimate_time_type == 0 || task.estimate_time ==
                    null) {
                    $('#editEstimateTimeDays').hide();
                    $('#editEstimateTimeHours').val(task.estimate_time).show();
                    $('#editHours').addClass('btn-primary text-white');
                    $('#editTypes').val(0);
                } else {
                    $('#editEstimateTimeHours').hide();
                    $('#editEstimateTimeDays').val(task.estimate_time).show();
                    $('#editDays').addClass('btn-primary text-white');
                    $('#editTypes').val(1);
                }
                let tagsIds = [];
                let userIds = [];
                $(task.tags).each(function (i, e) {
                    tagsIds.push(e.id);
                });
                $(task.task_assignee).each(function (i, e) {
                    userIds.push(e.id);
                    taskAssignees.push(e.id);
                });
                $('#editTagIds').val(tagsIds).trigger('change');

                $('#editAssignee').val(userIds).trigger('change');
                $('#editPriority').val(task.priority).trigger('change');

                setTimeout(function () {
                    $.each(task.task_assignee, function (i, e) {
                        $('#editAssignee option[value=\'' + e.id + '\']').
                            prop('selected', true).
                            trigger('change');
                    });
                    $('#EditModal').appendTo('body').modal('show');

                }, 1500);
            }
        },
        error: function () {

        },
    });
});

$(document).on('change', '#editProjectId', function (event) {
    let projectId = $(this).val();
    loadProjectAssignees(projectId, 'editAssignee');
});

function loadProjectAssignees (projectId, selector) {
    let url = usersOfProjects + '?projectIds=' + projectId;
    $('#' + selector).empty();
    $('#' + selector).trigger('change');
    $.ajax({
        url: url,
        type: 'GET',
        success: function (result) {
            const users = result.data;
            for (const key in users) {
                if (users.hasOwnProperty(key)) {
                    $('#' + selector).
                        append(
                            $('<option>', { value: key, text: users[key] }));
                }
            }
        },
    });
}

$(document).on('submit', '#editForm', function (event) {
    event.preventDefault();
    let $description = $('<div />').
        html($('#taskEditDescription').summernote('code'));
    let empty = $description.text().trim().replace(/ \r\n\t/g, '') === '';
    var loadingButton = jQuery(this).find('#btnTaskEditSave');
    loadingButton.button('loading');

    if ($('#taskEditDescription').summernote('isEmpty')) {
        $('#taskEditDescription').val('');
    } else if (empty) {
        displayErrorMessage(
            'Description field is not contain only white space');
        loadingButton.button('reset');
        return false;
    }
    if ($('#editTitle').val().trim() == '') {
        displayErrorMessage('Title field is not contain only white space');
        loadingButton.button('reset');
        return false;
    }
    var id = $('#tagId').val();
    let stopwatchTaskId = getItemFromLocalStorage('task_id');
    let isClockRunning = getItemFromLocalStorage('clockRunning');
    if (id === stopwatchTaskId && isClockRunning === 'true') {
        swal({
            'title': 'Warning',
            'text': 'Please stop timer before updating task.',
            'type': 'warning',
        });
        loadingButton.button('reset');
        return false;
    }
    let formdata = $(this).serializeArray();
    let desc = quillTask.summernote('code');  // retrieve the HTML content from the Summernote container

    $.ajax({
        url: taskUrl + id,
        type: 'put',
        data: formdata,
        success: function (result) {
            if (result.success) {
                $('#EditModal').modal('hide');
                window.livewire.emit('refresh');
                loadingButton.button('reset');
                displaySuccessMessage('Task updated successfully.');
            }
        },
        error: function (result) {
            loadingButton.button('reset');
            printErrorMessage('#editValidationErrorsBox', result);
        },
    });
});

$('#EditModal').on('hidden.bs.modal', function () {
    // to empty content of the Summernote Editor instance/container
    quillTask.summernote('code', '');
    resetModalForm('#editForm', '#editValidationErrorsBox');
});

$(document).ready(function () {
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        localStorage.setItem('activeTab', $(e.target).attr('href'));
    });
    var activeTab = localStorage.getItem('activeTab');

    if (activeTab) {
        $('.nav-tabs a[href="' + activeTab + '"]').tab('show');
        localStorage.removeItem('activeTab');
    }
});

let updateTaskStatus;
let currentCheckbox;

$(function () {

    $(document).on('change', 'input.complete-task-checkbox', function (e) {
        let taskId = ($(this).attr('data-check'));
        currentCheckbox = $(this);
        let stopwatchTaskId = getItemFromLocalStorage('task_id');
        let isClockRunning = getItemFromLocalStorage('clockRunning');
        if (taskId === stopwatchTaskId && isClockRunning === 'true') {
            swal({
                'title': 'Warning',
                'text': 'Please stop timer before completing task.',
                'type': 'warning',
            });
            currentCheckbox.prop('checked', false);
            return false;
        } else {
            if ($('#filter_status').val() != '') {
                $(this).parentsUntil('.task-list').toggle('slide');
            }
        }
        updateTaskStatus(taskId);
    });

    updateTaskStatus = (id) => {
        $.ajax({
            url: taskUrl + id + '/update-status',
            type: 'POST',
            cache: false,
            success: function (result) {
                if (result.success) {
                    window.livewire.emit('refresh');
                    revokerTracker();
                }
            },
        });
    };
});

$(document).ready(function () {
    $('#editEstimateTimeHours').datetimepicker({
        format: 'HH',
        useCurrent: false,
        icons: {
            previous: 'icon-arrow-left icons',
            next: 'icon-arrow-right icons',
            up: 'icon-arrow-up icons',
            down: 'icon-arrow-down icons',
        },
        sideBySide: true,
    });

    $('#editEstimateTimeDays').hide();

    $(document).on('click', '#editHours', function () {
        $('#editDays').removeClass('btn btn-primary text-white');
        $(this).addClass('btn btn-primary text-white');
        $('#editTypes').val(0);
        $('#editEstimateTimeDays').hide().val('');
        $('#editEstimateTimeHours').show();
    });

    $(document).on('click', '#editDays', function () {
        $('#editHours').removeClass('btn btn-primary text-white');
        $(this).addClass('btn btn-primary text-white');
        $('#editTypes').val(1);
        $('#editEstimateTimeHours').hide().val('');
        $('#editEstimateTimeDays').show();
    });
});
