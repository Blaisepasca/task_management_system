'use strict';

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
            sorter: function(data) {
                return data.sort(function (a, b) {
                    if (a.text > b.text) {
                        return 1;
                    }
                    if (a.text < b.text) {
                        return -1;
                    }
                    return 0;
                });
            },
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

let taskAssignees = [];

// open edit user model
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
                        append($('<option>', { value: i, text: elementTag.value }));
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
                var tagsIds = [];
                var userIds = [];
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
    let $description = $('<div />').html($('#taskEditDescription').summernote('code'));
    let empty = $description.text().trim().replace(/ \r\n\t/g, '') === '';
    var loadingButton = jQuery(this).find('#btnTaskEditSave');
    loadingButton.button('loading');

    if ($('#editTitle').val().length > 250) {
        displayErrorMessage('The title may not be greater than 250 characters');
        loadingButton.button('reset');
        return false;
    }
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
                displaySuccessMessage('Task updated successfully.');
                location.href = taskUrl + result.data.project.prefix + '-' +
                    result.data.task_number;
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

// light box image galary
$(document).on('click', '[data-toggle="lightbox"]', function (event) {
    event.preventDefault();
    $(this).ekkoLightbox({
        showArrows: false
    });
});

function getRandomString () {
    return Math.random().toString(36).substring(2, 8) +
        Math.random().toString(36).substring(2, 8);
}

//file upload dropzon js
Dropzone.options.dropzone = {
    maxFilesize: 12,
    renameFile: function (file) {
        let dt = new Date();
        let time = dt.getTime();
        let randomString = getRandomString();
        return time + '_' + randomString + '_' + (file.name).replace(/\s/g, '').
            replace(/\(/g, '_').
            replace(/\)/g, '');
    },
    thumbnailWidth: 125,
    acceptedFiles: 'image/*,.pdf,.doc,.docx,.xls,.xlsx',
    addRemoveLinks: true,
    dictRemoveFile: 'x',
    timeout: 50000,
    init: function () {
        let thisDropzone = this;
        $.get(taskUrl + taskId + '/get-attachments', function (data) {
            $.each(data.data, function (key, value) {
                let mockFile = { name: value.name, id: value.id };

                thisDropzone.options.addedfile.call(thisDropzone, mockFile, mockFile.id);
                thisDropzone.options.thumbnail.call(thisDropzone, mockFile,
                    value.url);
                thisDropzone.emit('complete', mockFile);
                thisDropzone.emit('thumbnail', mockFile, value.url, mockFile.id);
                $('.dz-remove').eq(key).attr('data-file-id', value.id);
                $('.dz-remove').eq(key).attr('data-file-url', value.url);
            });
        });
        this.on('thumbnail', function (file, dataUrl, mediaId = null) {
            $(file.previewTemplate).
                find('.dz-details').
                css('display', 'none');
            previewFile(file, dataUrl, mediaId);
            let fileNameExtArr = file.name.split('.');
            let fileName = fileNameExtArr[0].replace(/\s/g, '').
                replace(/\(/g, '_').
                replace(/\)/g, '');
            let ext = file.name.split('.').pop();
            let previewEle = '';
            let clickDownload = true;
            $(file.previewElement).
                find('.download-link').
                on('click', function () {
                    clickDownload = false;
                });
            if ($.inArray(ext, ['jpg', 'JPG', 'jpeg', 'png', 'PNG']) > -1) {
                previewEle = '<a class="' + fileName +
                    '" data-fancybox="gallery" href="' + dataUrl +
                    '" data-toggle="lightbox" data-gallery="example-gallery"></a>';
                $('.previewEle').append(previewEle);
            }

            file.previewElement.addEventListener('click', function () {
                if (clickDownload) {
                    let fileName = file.previewElement.querySelector(
                        '[data-dz-name]').innerHTML;
                    let fileExt = fileName.split('.').pop();
                    if ($.inArray(fileExt,
                        ['jpg', 'JPG', 'jpeg', 'png', 'PNG']) >
                        -1) {
                        let onlyFileName = fileName.split('.')[0];
                        $('.' + onlyFileName).trigger('click');
                    } else {
                        window.open(dataUrl, '_blank');
                    }
                }
                clickDownload = true;
            });
        });
        this.on('addedfile', function (file, dataUrl, mediaId = null) {
            previewFile(file, dataUrl, mediaId);
        });

        function previewFile (file, dataUrl, mediaId) {
            let downloadPath = dataUrl;
            let ext = file.name.split('.').pop();
            if (ext == 'pdf') {
                $(file.previewElement).
                    find('.dz-image img').
                    attr('src', '/assets/img/pdf_icon.png');
            } else if (ext.indexOf('doc') != -1 || ext.indexOf('docx') !=
                -1) {
                $(file.previewElement).
                    find('.dz-image img').
                    attr('src', '/assets/img/doc_icon.png');
            } else if (ext.indexOf('xls') != -1 || ext.indexOf('xlsx') != -1 ||
                ext.indexOf('csv') !=
                -1) {
                $(file.previewElement).
                    find('.dz-image img').
                    attr('src', '/assets/img/xls_icon.png');
            }
            if($(file.previewElement).find('.download-link').attr('href') === 'undefined'){
                $(file.previewElement).find('.download-link').hide();
            }
            if ($(file.previewElement).find('.download-link').length < 1) {
                var anchorEl = document.createElement('a');
                anchorEl.setAttribute('href',downloadTasks + '/media/'+mediaId);
                anchorEl.setAttribute('class','download-link');
                anchorEl.innerHTML = "<br>Download";
                file.previewElement.appendChild(anchorEl);
            }
            $('.dz-image').
                last().
                find('img').
                attr({ width: '100%', height: '100%' });
        }
    },
    processing: function () {
        $('.dz-remove').html('x');
        $('.dz-details').hide();
    },
    removedfile: function (file) {
        swal({
                title: deleteHeading + ' !',
                text: deleteMessage + ' "' + deleteAttachment + '" ?',
                type: 'warning',
                showCancelButton: true,
                closeOnConfirm: false,
                showLoaderOnConfirm: true,
                confirmButtonColor: '#6777EF',
                cancelButtonColor: '#d33',
                cancelButtonText: noMessages,
                confirmButtonText: yesMessages,
            },
            function () {
                let attachmentId = file.previewElement.querySelector(
                    '[data-file-id]').
                    getAttribute('data-file-id');
                screenLock();
                $.ajax({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="_token"]').
                            attr('content'),
                    },
                    type: 'post',
                    url: taskUrl + attachmentId + '/delete-attachment',
                    data: { filename: name },
                    complete: function () {
                        location.reload(true);
                    },
                    error: function (e) {
                        console.log('error', e);
                    },
                });
                let fileRef;
                return (fileRef = file.previewElement) != null
                    ?
                    fileRef.parentNode.removeChild(file.previewElement)
                    : void 0;
            });

    },
    success: function (file, response) {
        let attachment = response.data;
        let fileuploded = file.previewElement.querySelector('[data-dz-name]');
        let fileName = attachment.file_name;
        let fileNameExtArr = fileName.split('.');
        let newFileName = fileNameExtArr[0];
        let newFileExt = fileNameExtArr[1];
        let prevFileName = (fileuploded.innerHTML.split('.')[0]).replace(/\s/g,
            '').replace(/\(/g, '_').
            replace(/\)/g, '');
        fileuploded.innerHTML = fileName;

        $(file.previewTemplate).
            find('.dz-remove').
            attr('data-file-id', attachment.id);
        $(file.previewTemplate).
            find('.dz-remove').
            attr('data-file-url', attachment.file_url);
        $(file.previewElement).find('.download-link').attr('href', downloadTasks + '/media/'+attachment.id);
        if ($.inArray(newFileExt, ['jpg', 'JPG', 'jpeg', 'png', 'PNG']) >
            -1) {
            $('.previewEle').
                find('.' + prevFileName).
                attr('href', attachment.file_url);
            $('.previewEle').
                find('.' + prevFileName).
                attr('class', newFileName);
        } else {
            file.previewElement.addEventListener('click', function () {
                window.open(attachment.file_url, '_blank');
            });
            $(file.previewElement).find('.download-link').addClass('sdfaskdfjaksdfjaskldfjlasdf');
        }
    },
    error: function (file, response) {
        swal('error!', response.message, 'error');
        let fileRef;
        return (fileRef = file.previewElement) != null ?
            fileRef.parentNode.removeChild(file.previewElement) : void 0;

        return false;
    },
};

function addCommentSection (comment) {
    let id = comment.id;
    let icons = '';
    if (comment.created_by == authId) {
        icons = '<a class="dropdown dropdown-list-toggle">' +
            '<a href="javascript:void(0)" data-toggle="dropdown" class="notification-toggle ' +
            'action-dropdown d-none position-xs-bottom uCommentToggle">' +
            '<i class="fas fa-ellipsis-v action-toggle-mr"></i>' +
            '</a>' +
            '<div class="dropdown-menu dropdown-menu-right">' +
            '<div class="dropdown-list-content dropdown-list-icons">' +
            '<a href="#" class="dropdown-item dropdown-item-desc edit-comment" data-id="' +
            id + '"><i' +
            ' class="fas fa-edit mr-2 card-edit-icon"></i>Edit</a>' +
            '<a href="#" class="dropdown-item dropdown-item-desc del-comment" data-id="' +
            id + '"><i' +
            ' class="fas fa-trash mr-2 card-delete-icon"></i>Delete</a>' +
            '</div>' +
            '</div>' +
            '</a>';
    }

    return '<div class="task-chat-item position-relative comment-item-' + id +
        ' task-chat-right" data-comment-item="' +
        id + '">' +
        '<img src="' + comment.created_user.img_avatar +
        '" class="user__img profile uProfileLayout mr-3" alt="User Image" data-toggle="tooltip" data-html="true" title="' +
        comment.created_user.name + '"/>' +
        '<div class="task-chat-details">' +
        '<div class="task-chat-text comment-' + id + '">' + comment.comment +
        '</div>' +
        '<div class="task-chat-time">Just now</div>' +
        '</div>' + icons +
        '</div>';
}

$(document).on('click', '#btnComment', function (event) {
    let comment = quillComment.summernote('code');
    const editMode = $(this).data('edit-mode');
    const commentId = $(this).data('comment-id');
    let $description = $('<div />').html($('#commentContainer').summernote('code'));
    let empty = $description.text().trim().replace(/ \r\n\t/g, '') === '';
    let commentUrl = null;
    if (quillComment.summernote('isEmpty')) {
        displayErrorMessage('Please Enter comment');
        return false;
    }else if (empty){
        displayErrorMessage('Comment is not contain only white space');
        return false;
    }
    if (editMode === 0)
        commentUrl = baseUrl + 'tasks/' + taskId + '/comments';
    else
        commentUrl = baseUrl + 'tasks/' + taskId + '/comments/' + commentId +
            '/update';

    let loadingButton = $(this);
    loadingButton.button('loading');
    $.ajax({
        url: commentUrl,
        type: 'post',
        data: { 'comment': comment },
        success: function (result) {
            if (result.success) {
                if (editMode === 0)
                    processAddCommentResponce(result.data.comment);
                else {
                    $('.comment-' + commentId).html(comment);
                    quillComment.summernote('code', '');
                    $('#btnComment').data('edit-mode', 0);
                    $('#btnComment').data('comment-id', 0);
                }
            }
            loadingButton.button('reset');
        },
        error: function (result) {
            loadingButton.button('reset');
            printErrorMessage('#taskValidationErrorsBox', result);
        },
    });
});

// $(document).on('click', '.download-link', function () {
//     $.fileDownload($(this).attr('href')).done(function () { alert('File download a success!'); })
//     .fail(function () { alert('File download failed!'); });
// })

$(document).on('click', '.del-comment', function (event) {
    let commentId = $(this).data('id');
    swal({
            title: 'Delete !',
            text: 'Are you sure want to delete this "Comment" ?',
            type: 'warning',
            showCancelButton: true,
            closeOnConfirm: false,
            showLoaderOnConfirm: true,
            confirmButtonColor: '#6777EF',
            cancelButtonColor: '#d33',
            cancelButtonText: 'No',
            confirmButtonText: 'Yes',
        },
        function () {
            $.ajax({
                url: baseUrl + 'tasks/' + taskId + '/comments/' + commentId,
                type: 'DELETE',
                success: function (result) {
                    if (result.success) {
                        processDeleteCommentResponce(commentId, taskId);
                    }
                    swal({
                        title: 'Deleted!',
                        text: 'Comment has been deleted.',
                        type: 'success',
                        confirmButtonColor: '#6777EF',
                        timer: 2000,
                    });
                },
                error: function (data) {
                    swal({
                        title: '',
                        text: data.responseJSON.message,
                        type: 'error',
                        confirmButtonColor: '#6777EF',
                        timer: 5000,
                    });
                },
            });
        });
});

function processAddCommentResponce (result) {
    let commentDiv = addCommentSection(result);
    $('.comments .activities').removeClass('d-none');
    $('.comments .activities').append(commentDiv);
    quillComment.summernote('code', '');  // to empty content of the Summernote Editor instance/container
    $('.no_comments').hide();
    $('.task-chat-content').
        scrollTop($('.task-chat-content').get(0).scrollHeight);
}

function processDeleteCommentResponce (commentId, taskId) {
    let commentDiv = '.comment-item-' + commentId;
    $('div').remove(commentDiv);

    $.ajax({
        url: baseUrl + 'tasks/' + taskId + '/comments-count',
        type: 'GET',
        success: function (result) {
            if (result.data == 0) {
                $('.no_comments').show();
                $('.no_comments').removeClass('d-none');
                $('.task-chat-content').addClass('d-none');
            }
        },
    });
}

function processUpdateCommentResponce (commentId, comment) {
    $('.comment-display-' + commentId).html(comment).removeClass('d-none');
    $('.comment-edit-' + commentId).addClass('d-none');
    $('.comment-save-icon-' + commentId).addClass('d-none');
    $('.comment-cancel-icon-' + commentId).addClass('d-none');
}

let quillCommentEdit = [];
$(document).on('click', '.edit-comment', function () {
    let commentId = $(this).data('id');
    let commentData = $.trim($('.comment-' + commentId).html());
    quillComment.summernote('code', '');
    quillComment.summernote('code', commentData);
    $('#btnComment').data('edit-mode', 1);
    $('#btnComment').data('comment-id', commentId);
});

/*
   - This method will create separate SummernoteEditor instance (but only once, then after it will use the existing created one) when some
   one will edit the comment.

   - After creating the instance, it will set the data back to the editor in order to edit the comment.
 */
window.setCommentEditData = function (commentId) {
    // create new SummernoteEditor instance
    quillCommentEdit[commentId] = $('#commentEditContainer' + commentId).
        summernote({
            placeholder: 'Add Comment...',
            minHeight: 200,
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough']],
                ['para', ['paragraph']]],
        });

    let commentData = $.trim($('.comment-display-' + commentId).html());

    quillCommentEdit[commentId].summernote('code', commentData);  // to set the HTML content to SummernoteEditor instance/container
};

$(document).on('click', '.cancel-comment', function (event) {
    let commentId = $(this).data('id');
    $(this).addClass('d-none');
    $('.comment-display-' + commentId).removeClass('d-none');
    $('.comment-edit-' + commentId).addClass('d-none');
    $('.comment-save-icon-' + commentId).addClass('d-none');
});

$(document).on('click', '.save-comment', function (event) {
    let commentId = $(this).data('id');
    let comment = quillCommentEdit[commentId].summernote('code');  // retrieve the HTML content from the Summernotecontainer

    // this will check whether the SummernoteEditor has empty and doesn't have any content entered in it
    if (quillCommentEdit[commentId].summernote('isEmpty')) {
        return false;
    }
    $.ajax({
        url: baseUrl + 'tasks/' + taskId + '/comments/' + commentId +
            '/update',
        type: 'post',
        data: { 'comment': comment.trim() },
        success: function (result) {
            if (result.success) {
                processUpdateCommentResponce(commentId, comment);
            }
        },
        error: function (result) {
            printErrorMessage('#taskValidationErrorsBox', result);
        },
    });
});

// Summernote editor initialization scripts
let quillComment = $('#commentContainer').summernote({
    placeholder: 'Add Comment...',
    minHeight: 200,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['strikethrough']],
        ['para', ['paragraph']]],
});

let quillTask = $('#taskEditDescription').summernote({
    placeholder: 'Add Task description...',
    minHeight: 200,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['strikethrough']],
        ['para', ['paragraph']]],
});

$(document).on('click', '#btnCancel', function () {
    quillComment.summernote('code', '');
    $('#btnComment').data('edit-mode', 0);
    $('#btnComment').data('comment-id', 0);
});

//modal not closed on click outside
$('.modal').modal({ show: false, backdrop: 'static' });

$(document).on('change','#taskStatus' ,function (){
    let taskId = $(this).data('id');
    let val = '';

    if($(this).prop('checked') == false){
        val = 0;
    }else
    {
        val = 1;
    }
    $.ajax({
        url: taskUrl + taskId + '/update-task-status',
        method: 'PUT',
        data: { status: val },
        cache: false,
        success: function () {
            location.reload();
        },
    })
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
