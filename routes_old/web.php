<?php

use App\Http\Controllers\ActivityLogController;
use App\Http\Controllers\ActivityTypeController;
use App\Http\Controllers\Auth;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\Client;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\EventsController;
use App\Http\Controllers\ExpenseController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\StatusController;
use App\Http\Controllers\TagController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\TaxController;
use App\Http\Controllers\TimeEntryCalenderController;
use App\Http\Controllers\TimeEntryController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserNotificationController;
use App\Models\Permission;
use App\Models\ProjectActivity;
use App\Models\Role;
use App\Models\User;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return redirect('login');
});

/*
|--------------------------------------------------------------------------
| Auth Login Route
|--------------------------------------------------------------------------
*/
//Auth::routes();
\Illuminate\Support\Facades\Auth::routes(['verify' => true, 'register' => false]);
Route::get('login', [Auth\LoginController::class, 'showLoginForm'])->name('login');

Route::post('login', [Auth\LoginController::class, 'login']);

Route::get('activate', [AuthController::class, 'verifyAccount']);

Route::post('set-password', [AuthController::class, 'setPassword']);

Route::get('tracker-notification', [HomeController::class, 'trackerNotification'])->name('tracker.notification.command');

Route::group(['middleware' => ['auth', 'validate.user', 'xss', 'user.activated']], function () {
    Route::get('/dashboard', [HomeController::class, 'index'])->name('home');
    Route::get('/dashboard-total-hours', [HomeController::class, 'getTotalHours']);
    Route::get('/users-work-report', [HomeController::class, 'workReport'])->name('users-work-report');
    Route::get('/developer-work-report', [HomeController::class, 'developerWorkReport'])->name('developers-work-report');
    Route::get('/users-open-tasks', [HomeController::class, 'userOpenTasks'])->name('users-open-tasks');
    Route::get('/users-project-status', [HomeController::class, 'userProjectStatus'])->name('users-project-status');
    Route::get('/client-invoices-status', [HomeController::class, 'clientInvoiceStatus'])->name('client-invoices-status');

    Route::post('logout', [Auth\LoginController::class, 'logout']);
    Route::group(['middleware' => ['permission:manage_activities']], function () {
        Route::resource('activity-types', ActivityTypeController::class);
    });

    Route::get('user-assign-projects', [ProjectController::class, 'userAssignProjects'])->name('user.projects');
    Route::get('user-assign-projects/{project}', [ProjectController::class, 'userAssignProjectsShow'])->name('user.projects.show');

    Route::group(['middleware' => ['permission:manage_clients']], function () {
        Route::resource('clients', ClientController::class);
        Route::post('clients/{client}/update', [ClientController::class, 'update'])->name('clients.update');
    });

    Route::group(['middleware' => ['permission:manage_users']], function () {
        Route::post('users/{user}/active-de-active', [UserController::class, 'activeDeActiveUser'])
            ->name('active-de-active-user');
        Route::resource('users', UserController::class)->parameters(['users' => 'user']);
        Route::post('users/{user}/update', [UserController::class, 'update'])->name('users.update');
        Route::get('users/{user}/send-email', [UserController::class, 'resendEmailVerification'])->name('send-email');
        Route::get('/logs', '\Rap2hpoutre\LaravelLogViewer\LogViewerController@index');
    });

    Route::get('users/{user}/edit', [UserController::class, 'edit'])->name('users.edit');
    Route::get('users/{user}', [UserController::class, 'show'])->name('users.show');
    Route::post('users/profile-update', [UserController::class, 'profileUpdate'])->name('update-profile');
    Route::post('users/change-password', [UserController::class, 'changePassword'])->name('change-password');
    Route::post('update-language', [UserController::class, 'updateLanguage']);
    Route::resource('notifications', NotificationController::class);

    Route::group(['middleware' => ['permission:manage_tags']], function () {
        Route::resource('tags', TagController::class);
    });

//    Route::group(['middleware' => ['permission:manage_projects']], function () {
    Route::resource('projects', ProjectController::class);
//    });
    // tasks routes
    Route::group(['middleware' => ['permission:manage_all_tasks']], function () {
        Route::resource('tasks', TaskController::class);
        Route::post('tasks/{task}/update-status', [TaskController::class, 'updateStatus'])->name('task.update-status');
        Route::post('tasks/{task}/add-attachment', [TaskController::class, 'addAttachment'])->name('task.add-attachment');
        Route::post('tasks/{media}/delete-attachment', [TaskController::class, 'deleteAttachment'])
            ->name('task.delete-attachment');
        Route::get('tasks/{task}/get-attachments', [TaskController::class, 'getAttachment'])->name('task.attachments');
        Route::post('tasks/{task}/comments', [CommentController::class, 'addComment'])->name('task.comments');
        Route::post(
            'tasks/{task}/comments/{comment}/update',
            [CommentController::class, 'editComment']
        )->name('task.update-comment');
        Route::delete(
            'tasks/{task}/comments/{comment}',
            [CommentController::class, 'deleteComment']
        )->name('task.delete-comment');
        Route::get('task-details/{task}', [TaskController::class, 'getTaskDetails'])->name('task.get-details');
        Route::get('tasks/{task}/comments-count', [TaskController::class, 'getCommentsCount'])->name('task.comments-count');
        Route::get('tasks/{task}/users', [TaskController::class, 'getTaskUsers'])->name('task.users');
        Route::get('tasks/{task}/edit-assignees', [TaskController::class, 'editAssignee'])->name('task.edit-assignee');
        Route::get('tasks/{task}/kanban-edit', [TaskController::class, 'editKanbanTask'])->name('task.kanban-edit');
        Route::post('tasks/{task}/kanban-edit', [TaskController::class, 'updateKanbanTask'])->name('task.kanban-update');
        Route::get('kanban-task-details/{task}', [TaskController::class, 'getKanbanTaskDetails'])->name('kanban-task-details');
        Route::post('kanban-task-details/{task}/task-edit', [TaskController::class, 'updateKanbanTaskDetails'])->name('kanban-task-details-update');
        Route::post('kanban-task-details/{task}/add-attachment',
            [TaskController::class, 'addAttachmentTaskDetails'])->name('task.add-attachment');
        Route::get('users-by-project/{project}', [TaskController::class, 'getUserByProject'])->name('users-by-project');
        Route::get('tasks/{user}/project-by-users', [TaskController::class, 'getProjectsByUser'])->name('project-by-users');
    });

    Route::group(['middleware'=> ['permission:manage_status']], function () {
        Route::get('status', [StatusController::class, 'index'])->name('status.index');
        Route::post('status', [StatusController::class, 'store'])->name('status.store');
        Route::get('status/{status}/edit', [StatusController::class, 'edit'])->name('status.edit');
        Route::put('status/{status}', [StatusController::class, 'update'])->name('status.update');
        Route::delete('status/{status}', [StatusController::class, 'destroy'])->name('status.destroy');
    });
    Route::resource('time-entries', TimeEntryController::class);
    Route::get('task-time-entry', [TimeEntryController::class, 'taskTimeEntryFilter']);
    Route::post('time-entries/{time_entry}/update', [TimeEntryController::class, 'update']);
    Route::get('time-entries/{time_entry}', [TimeEntryController::class, 'showTimeEntryNote']);
    Route::post('start-timer', [TimeEntryController::class, 'getStartTimer']);
    Route::get('copy-today-activity', [TimeEntryController::class, 'copyTodayActivity'])->name('copy-today-activity');

    Route::group(['middleware'=> ['permission:manage_reports']], function () {
        Route::resource('reports', ReportController::class);
        Route::post('reports/preview', [ReportController::class, 'showPreview'])->name('reports.preview');
    });
    Route::get('users-of-projects', [ProjectController::class, 'users'])->name('users-of-projects');
    Route::get('projects-of-client', [ClientController::class, 'projects'])->name('projects-of-client');
    Route::get('clients-of-department', [DepartmentController::class, 'clients'])->name('clients-of-department');

    Route::get('my-tasks', [TaskController::class, 'myTasks'])->name('my-tasks');
    Route::get('user-last-task-work', [TimeEntryController::class, 'getUserLastTask'])->name('user-last-task-work');
    Route::get('projects/{project}/tasks', [TimeEntryController::class, 'getTasks'])->name('project-tasks');
    Route::put('tasks/{task}/update-task-status', [TaskController::class, 'updateTaskStatus'])->name('tasks.update-status');
    Route::get('my-projects', [ProjectController::class, 'getMyProjects'])->name('my-projects');
    Route::get('get-user-lists', [UserController::class, 'getUserLists']);
    Route::get('tasks-kanban', [TaskController::class, 'getKanbanTasks'])->name('kanban.index');

    Route::group(['middleware' => ['permission:manage_roles']], function () {
        Route::resource('roles', RoleController::class);
    });

    Route::group(['middleware' => ['permission:manage_department']], function () {
        Route::resource('departments', DepartmentController::class);
        Route::post('departments/{department}/update', [DepartmentController::class, 'update']);
    });

    Route::group(['middleware' => ['permission:manage_time_entries']], function () {
        Route::get('projects/{user}/users', [ProjectController::class, 'getProjectsByUser']);
        Route::get('projects/{project}/project-users', [TimeEntryController::class, 'getUsers'])->name('project-users');
    });

    Route::group(['middleware' => ['permission:manage_calendar_view']], function () {
        Route::get('time-entries-calendar', [TimeEntryCalenderController::class, 'index'])->name('time-entries-calendar.index');
        Route::get('time-entries-calendar-list', [TimeEntryCalenderController::class, 'timeEntriesCalendarList']);
    });

    Route::group(['middleware' => ['permission:manage_taxes']], function () {
        Route::get('taxes', [TaxController::class, 'index'])->name('taxes.index');
        Route::post('taxes', [TaxController::class, 'store'])->name('taxes.store');
        Route::get('taxes/{tax}/edit', [TaxController::class, 'edit'])->name('taxes.edit');
        Route::put('taxes/{tax}', [TaxController::class, 'update'])->name('taxes.update');
        Route::delete('taxes/{tax}', [TaxController::class, 'destroy'])->name('taxes.destroy');
    });

    Route::group(['middleware' => ['permission:manage_invoices']], function () {
        Route::get('invoices', [InvoiceController::class, 'index'])->name('invoices.index');
        Route::post('invoices', [InvoiceController::class, 'store'])->name('invoices.store');
        Route::put('invoices/{invoice}', [InvoiceController::class, 'update'])->name('invoices.update');
        Route::get('invoices/{invoice}/edit', [InvoiceController::class, 'edit'])->name('invoices.edit');
        Route::delete('invoices/{invoice}', [InvoiceController::class, 'destroy'])->name('invoices.destroy');
        Route::get('invoices/{invoice}', [InvoiceController::class, 'show'])->name('invoices.show');
        Route::get('invoices/{project}/tasks', [InvoiceController::class, 'getProjectTasks'])->name('get.project-tasks');
        Route::get('invoices/{id}/details', [InvoiceController::class, 'getTaskDetails'])->name('get.task-details');
        Route::get('invoices/{client}/projects', [InvoiceController::class, 'getClientProjects'])->name('get.client-projects');
        Route::get('invoice-download/{fkanban}', [InvoiceController::class, 'downloadInvoice']);
        Route::post('invoices/{invoice}/update-status', [InvoiceController::class, 'updateStatus']);
        Route::get('generate-invoice/{report}', [InvoiceController::class, 'createInvoice'])->name('invoices.generate');
    });

    Route::get('invoices/{invoice}/pdf', [InvoiceController::class, 'convertToPdf'])->name('invoices.pdf');

    Route::group(['middleware' => ['permission:manage_expenses']], function () {
        Route::resource('expenses', ExpenseController::class);
        Route::get('expenses-project/{client}', [ExpenseController::class, 'getProjects'])->name('expenses.project');
        Route::post('expenses/{media}/delete-attachment',
            [ExpenseController::class, 'deleteAttachment'])->name('expense.delete-attachment');
        Route::get('expenses/{media}/download',
            [ExpenseController::class, 'downloadAttachment'])->name('expenses.download.attachment');
    });

    Route::group(['middleware' => ['permission:manage_settings']], function () {
        Route::get('settings', [SettingController::class, 'edit'])->name('settings.edit');
        Route::post('settings', [SettingController::class, 'update'])->name('settings.update');
        Route::post('invoice-settings', [SettingController::class, 'invoiceSettingUpdate'])->name('invoice-settings.settings');
    });

    Route::get('tasks/media/{id}', [TaskController::class, 'downloadAttachment'])->name('download-attachment');

    Route::group(['middleware' => ['permission:manage_activity_log']], function () {
        Route::get('activity-logs', [ActivityLogController::class, 'index'])->name('activity-logs');
        Route::delete('activity-logs/{id}', [ActivityLogController::class, 'destroy'])->name('activity-delete');
    });
    Route::get('events', [EventsController::class, 'index'])->name('events.index');
    Route::post('events', [EventsController::class, 'store'])->name('events.store');
    Route::get('events/{event}/edit', [EventsController::class, 'edit'])->name('events.edit');
    Route::post('events/{event}/update', [EventsController::class, 'update'])->name('events.update');
    Route::post('events/{event}/drop-update', [EventsController::class, 'dropUpdate'])->name('events.drop.update');
    Route::get('events-data', [EventsController::class, 'getEventsData'])->name('events.data');
    Route::delete('events/{event}', [EventsController::class, 'destroy'])->name('events.delete');

    //Header Notification
    Route::get('/get-notifications', [UserNotificationController::class, 'index']);
    Route::post('/notification/{notification}/read',
        [UserNotificationController::class, 'readNotification'])->name('notifications.read');
    Route::post('/read-all-notification',
        [UserNotificationController::class, 'readAllNotification'])->name('notifications.read.all');

});

Route::group([
    'middleware' => ['auth', 'permission:role_client', 'xss', 'user.activated', 'validate.user'], 'prefix' => 'client',
], function () {
    //dashboard
    Route::get('dashboard', [Client\DashboardController::class, 'index'])->name('dashboard');

    Route::get('{id}/edit-profile', [Client\ClientController::class, 'edit']);
    Route::post('profile-update', [Client\ClientController::class, 'profileUpdate'])->name('update-profile');
    Route::post('change-password', [Client\ClientController::class, 'changePassword'])->name('change-password');
    Route::get('project-status', [Client\DashboardController::class, 'projectStatus'])->name('project-status');
    Route::get('client-invoices', [Client\DashboardController::class, 'getClientInvoices'])->name('client-invoices');

    Route::get('invoices', [Client\InvoiceController::class, 'index'])->name('client.invoices.index');
    Route::get('invoices/{invoice}', [Client\InvoiceController::class, 'show'])->name('client.invoices.show');
    Route::post('invoices/{invoice}/change-status', [Client\InvoiceController::class, 'changeStatus'])->name('invoices.change-status');
    Route::get('invoices/{invoice}/edit', [Client\InvoiceController::class, 'edit'])->name('client.invoices.edit');

    Route::get('projects', [Client\ProjectController::class, 'index'])->name('client.projects.index');
    Route::get('projects/{project}', [Client\ProjectController::class, 'show'])->name('client.projects.show');

    Route::get('get-notifications', [Client\DashboardController::class, 'getNotifications'])->name('client.notifications.index');
    Route::post('notification/{notification}/read',
        [Client\DashboardController::class, 'readNotification'])->name('client.notifications.read');
    Route::post('read-all-notification',
        [Client\DashboardController::class, 'readAllNotification'])->name('client.notifications.read.all');
});

Route::get('/upgrade-to-v1-2-0', function () {
    $calendarViewPermission = Permission::whereName('manage_calendar_view')->first();
    $roles = Role::all();
    foreach ($roles as $role) {
        $role->givePermissionTo($calendarViewPermission);
    }

    return 'Permission assigned successfully.';
});

Route::get('/upgrade-to-v2-1-0', function () {
    $manageStatusPermission = Permission::whereName('manage_status')->first();
    $role = Role::whereName('Admin')->first();
    $role->givePermissionTo($manageStatusPermission);

    return 'Permission assigned successfully.';
});

Route::get('/client-role/upgrade-to-v2-1-0', function () {
    $clientRole = Role::whereName('Client')->first();

    $clients = \App\Models\Client::all();
    foreach ($clients as $client) {
        $client->roles()->sync([$clientRole->id]);
    }

    return 'Client role assigned successfully.';
});

// upgrade v2-3-0
Route::get('/upgrade-to-v2-3-0', function () {
    $softDeletedTags = \App\Models\Tag::onlyTrashed()->get();
    if (! empty($softDeletedTags)) {
        foreach ($softDeletedTags as $tags) {
            $tags->taskTags()->detach();
            $tags->forceDelete();
        }
    }
});

Route::get('/upgrade-to-v3-0-0', function () {
    Artisan::call('db:seed', ['--class' => 'AddExpensePermissionSeeder']);
});

Route::get('/upgrade-to-v3-1-0', function () {
    Artisan::call('db:seed', ['--class' => 'RemoveTaskEntryFromTaskTagTableSeeder']);
});

Route::get('/upgrade-to-v5-0-0', function () {
    Artisan::call('db:seed', ['--class' => 'AddActivityLogPermission']);
    Artisan::call('db:seed', ['--class' => 'AddEventPermissionSeeder']);
});

Route::get('/upgrade-to-v5-1-0', function () {
    Artisan::call('db:seed', ['--class' => 'AddRoleClientPermissionSeeder']);
});

Route::get('/upgrade-to-v5-2-0', function () {
    $userActivityLogIds = ProjectActivity::where('causer_type', User::class)->pluck('causer_id')->toArray();
    $userIds = User::pluck('id')->toArray();
    foreach ($userActivityLogIds as $userActivityLogId) {
        if (! in_array($userActivityLogId, $userIds)) {
            ProjectActivity::whereCauserId($userActivityLogId)->where('causer_type', User::class)->delete();
        }
    }
});

Route::get('/upgrade-to-v8-0-0', function () {
    \Illuminate\Support\Facades\Artisan::call('migrate',
        [
            '--force' => true,
            '--path'  => 'database/migrations/2021_07_12_000000_add_uuid_to_failed_jobs_table.php',
        ]);
    \Illuminate\Support\Facades\Artisan::call('migrate',
        [
            '--force' => true,
            '--path'  => 'database/migrations/2021_07_1_103036_add_conversions_disk_column_in_media_table.php',
        ]);
});

Route::fallback(function () {
    abort(\Symfony\Component\HttpFoundation\Response::HTTP_NOT_FOUND);
});
