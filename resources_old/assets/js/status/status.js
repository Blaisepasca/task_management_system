$(document).ready(function () {
    'use strict';
    
    $(document).on('submit', '#addNewForm', function (event) {
        event.preventDefault();
        var loadingButton = jQuery(this).find('#btnSave');
        loadingButton.button('loading');
        $.ajax({
            url: statusCreateUrl,
            type: 'POST',
            data: $(this).serialize(),
            success: function (result) {
                if (result.success) {
                    displaySuccessMessage(result.message);
                    $('#AddModal').modal('hide');
                    window.livewire.emit('refresh');
                }
            },
            error: function (result) {
                printErrorMessage('#validationErrorsBox', result);
            },
            complete: function () {
                loadingButton.button('reset');
                window.livewire.emit('refresh');
            },
        });
    });

    $(document).on('submit', '#editForm', function (event) {
        event.preventDefault();
        var loadingButton = jQuery(this).find('#btnEditSave');
        loadingButton.button('loading');
        var id = $('#statusId').val();
        $.ajax({
            url: statusUrl + id,
            type: 'put',
            data: $(this).serialize(),
            success: function (result) {
                if (result.success) {
                    displaySuccessMessage(result.message);
                    $('#EditModal').modal('hide');
                    window.livewire.emit('refresh');
                }
            },
            error: function (result) {
                manageAjaxErrors(result);
            },
            complete: function () {
                loadingButton.button('reset');
                window.livewire.emit('refresh');
            },
        });
    });

    $('#AddModal').on('hidden.bs.modal', function () {
        resetModalForm('#addNewForm', '#validationErrorsBox');
    });

    $('#EditModal').on('hidden.bs.modal', function () {
        resetModalForm('#editForm', '#editValidationErrorsBox');
    });

    window.renderData = function (id) {
        $.ajax({
            url: statusUrl + id + '/edit',
            type: 'GET',
            success: function (result) {
                if (result.success) {
                    let element = document.createElement('textarea');
                    element.innerHTML = result.data.name;
                    $('#statusId').val(result.data.id);
                    $('#statusName').val(element.value);
                    $('#EditModal').appendTo('body').modal('show');
                }
            },
            error: function (result) {
                manageAjaxErrors(result);
            },
        });
    };

    $(document).on('click', '.edit-btn', function (event) {
        let statusId = $(event.currentTarget).attr('data-id');
        renderData(statusId);

    });

    $(document).on('click', '.delete-btn', function (event) {
        let statusId = $(event.currentTarget).attr('data-id');
        deleteItem(statusUrl + statusId, '#status_table', 'Status', 'location.reload()');
    });

    $(document).on('click', '.addNewStatus', function () {
        $('#AddModal').appendTo('body').modal('show');
    });

    $('.modal').on('show.bs.modal', function () {
        $(this).appendTo('body');
    });
});
