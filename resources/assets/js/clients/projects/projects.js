$(document).ready(function () {
    'use strict';

    $('#projectStatus').select2({
        width: '100%',
    });

    $(document).on('change', '#projectStatus', function () {
        let projectStatus = $(this).val();
        projectStatusLivewire(projectStatus);
    });

    window.projectStatusLivewire = function ($projectStatus) {
        window.livewire.emit('projectsStatus', $projectStatus);
    };

});
document.addEventListener('livewire:load', function () {
    window.livewire.hook('message.processed', () => {
        $('#projectStatus').select2({
            width: '100%',
        });
    });
});
