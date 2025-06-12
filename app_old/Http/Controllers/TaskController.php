<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateTaskRequest;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use App\Queries\TaskDataTable;
use App\Repositories\ProjectRepository;
use App\Repositories\TagRepository;
use App\Repositories\TaskRepository;
use App\Repositories\UserRepository;
use DataTables;
use Exception;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Spatie\MediaLibrary\MediaCollections\Models\Media;

/**
 * Class TaskController.
 */
class TaskController extends AppBaseController
{
    /** @var TaskRepository */
    private $taskRepository;

    /** @var UserRepository */
    private $userRepository;

    /** @var ProjectRepository */
    private $projectRepository;

    public $users;

    public function __construct(
        UserRepository $userRepository,
        TaskRepository $taskRepo,
        ProjectRepository $projectRepo
    ) {
        $this->taskRepository = $taskRepo;
        $this->userRepository = $userRepository;
        $this->projectRepository = $projectRepo;
        $projects = Project::with('users')->whereHas('users', function (Builder $query) {
            $query->where('is_active', true)->whereNotNull('email_verified_at');
        })->get();

        $users = [];
        $projects->map(function (Project $record) use (&$users) {
            $users[$record->id] = $record->users->where('is_active', '=', true)->pluck('name', 'id')->toArray();
        });

        $this->users = $users;
    }

    /**
     * Display a listing of the Task.
     *
     * @param Request $request
     *
     * @throws Exception
     *
     * @return Factory|View
     */
    public function index(Request $request)
    {
        if ($request->ajax()) {
            return DataTables::of((new TaskDataTable())->get($request->only([
                'name',
                'filter_project',
                'filter_status',
                'filter_user',
                'due_date_filter',
            ])))->editColumn('title', function (Task $task) {
                return $task->prefix_task_number.' '.$task->title;
            })->filterColumn('title', function (Builder $query, $search) {
                $query->where(function (Builder $query) use ($search) {
                    $query->where('title', 'like', "%$search%")
                        ->orWhereRaw(
                            "concat(ifnull(p.prefix,''),'-',ifnull(tasks.task_number,'')) LIKE ?",
                            ["%$search%"]
                        );
                });
            })
                ->make(true);
        }
        $taskData = $this->taskRepository->getTaskData();
        $taskData['userId'] = getLoggedInUserId();

        return view('tasks.index')->with($taskData);
    }

    /**
     * Store a newly created Task in storage.
     *
     * @param CreateTaskRequest $request
     *
     * @throws Exception
     *
     * @return JsonResponse
     */
    public function store(CreateTaskRequest $request)
    {
        $input = $request->all();
        if (! array_key_exists('assignees', $input)) {
            $input['assignees'] = '';
        }
        $this->taskRepository->store($this->fill($input));

        return $this->sendSuccess('Task created successfully.');
    }

    private function fill($input)
    {
        $input['status'] = (isset($input['status']) && ! empty($input['status'])) ? $input['status'] : Task::$status['STATUS_ACTIVE'];
        $input['description'] = is_null($input['description']) ? '' : $input['description'];

        return $input;
    }

    /**
     * @param  string  $slug
     *
     * @return Application|Factory|RedirectResponse|View
     */
    public function show($slug)
    {
        if (count(explode('-', $slug)) != 2) {
            return redirect()->back();
        }

        $projectPrefix = explode('-', $slug)[0];
        $taskNumber = explode('-', $slug)[1];
        $projects = getLoggedInUser()->projects()->get();
        $data = [];
        foreach ($projects as $project) {
            $tasks = Task::ofProject($project->id)->whereHas('taskAssignee', function (Builder $q) {
                $q->where('user_id', getLoggedInUserId());
            })->pluck('task_number');
            foreach ($tasks as $taskNo) {
                $data[] = $project->prefix.'-'.$taskNo;
            }
        }
        if (! getLoggedInUser()->can('manage_projects')) {
            if (! in_array($slug, $data)) {
                return redirect()->back();
            }
        }
        $task = $this->taskRepository->show($projectPrefix, $taskNumber);
        if (empty($task)) {
            return redirect()->back();
        }

        $taskData = $this->taskRepository->getTaskData();
        $attachmentUrl = url(Task::PATH);

        return view('tasks.show', compact('task', 'attachmentUrl'))->with($taskData);
    }

    /**
     * Show the form for editing the specified Task.
     *
     * @param Task $task
     *
     * @return JsonResponse
     */
    public function edit(Task $task)
    {
        $task->tags;
        $task->project;
        $task->taskAssignee;
        $task->attachments;

        /** @var TagRepository $tagRepo */
        $tagRepo = app(TagRepository::class);
        $data['tags'] = $tagRepo->getTagList();
        $data['task'] = $task;
        $task->description = htmlspecialchars_decode($task->description);

        return $this->sendResponse($data, 'Task retrieved successfully.');
    }

    /**
     * Update the specified Task in storage.
     *
     * @param  Task  $task
     * @param  Request  $request
     *
     * @throws Exception
     * @return JsonResponse
     */
    public function update(Task $task, Request $request)
    {
        $input = $request->all();

        $task = $this->taskRepository->update($input, $task->id);

        return $this->sendResponse($task, 'Task updated successfully.');
    }

    /**
     * @param $id
     *
     * @return JsonResponse
     */
    public function editKanbanTask($id)
    {
        $task = Task::toBase()->find($id);

        return $this->sendResponse($task, 'Task retrieved successfully.');
    }

    /**
     * @param  Task  $task
     * @param  Request  $request
     *
     * @return JsonResponse
     */
    public function updateKanbanTask(Task $task, Request $request)
    {
        $input = $request->all();

        $task = $this->taskRepository->updateKanbanTask($input, $task->id);

        return $this->sendResponse($task, 'Task updated successfully.');
    }

    /**
     * Remove the specified Task from storage.
     *
     * @param Task $task
     *
     * @throws Exception
     *
     * @return JsonResponse
     */
    public function destroy(Task $task)
    {
        if ($task->timeEntries()->count() > 0) {
            return $this->sendError('Task has one or more time entries.');
        }

        $task->update(['deleted_by' => getLoggedInUserId()]);
        $task->delete();
        $task->tags()->detach();

        return $this->sendSuccess('Task deleted successfully.');
    }

    /**
     * @param Task $task
     *
     * @return JsonResponse
     */
    public function updateStatus(Task $task)
    {
        $this->taskRepository->updateStatus($task->id);

        return $this->sendSuccess('Task status Update successfully.');
    }

    /**
     * @param Task    $task
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function getTaskDetails(Task $task, Request $request)
    {
        $taskDetails = $this->taskRepository->getTaskDetails($task->id, $request->all());

        return $this->sendResponse($taskDetails, 'Task retrieved successfully.');
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function myTasks(Request $request)
    {
        $input = $request->only('project_id');

        $timerDetails = $this->taskRepository->myTasks($input);

        return $this->sendResponse($timerDetails, 'My tasks retrieved successfully.');
    }

    /**
     * @param  Media  $media
     *
     * @return JsonResponse
     */
    public function deleteAttachment(Media $media)
    {
        $media->delete();

        return $this->sendSuccess('File has been deleted successfully.');
    }

    /**
     * @param Task    $task
     * @param Request $request
     *
     * @throws Exception
     *
     * @return JsonResponse
     */
    public function addAttachment(Task $task, Request $request)
    {
        $input = $request->all();

        try {
            $result = $this->taskRepository->uploadFile($task, $input['file']);
        } catch (Exception $e) {
            return $this->sendError($e->getMessage(), $e->getCode());
        }

        return $this->sendResponse($result, 'File has been uploaded successfully.');
    }

    /**
     * @param Task $task
     *
     * @return JsonResponse
     */
    public function getAttachment(Task $task)
    {
        $result = $this->taskRepository->getAttachments($task->id);

        return $this->sendResponse($result, 'Task retrieved successfully.');
    }

    /**
     * @param Task $task
     *
     * @return JsonResponse
     */
    public function getCommentsCount(Task $task)
    {
        return $this->sendResponse($task->comments()->count(), 'Comments count retrieved successfully.');
    }

    /**
     * @param Task $task
     *
     * @return array
     */
    public function getTaskUsers(Task $task)
    {
        return $task->taskAssignee->pluck('name', 'id')->toArray();
    }

    /**
     * @param Task $task
     *
     * @return JsonResponse
     */
    public function editAssignee(Task $task)
    {
        $projectId = $task->project->id;

        $data['task_assignee'] = $task->taskAssignee->pluck('id')->toArray();

        $data['task'] = $task;
        $data['users'] = isset($this->users[$projectId]) ? $this->users[$projectId] : [];

        return $this->sendResponse($data, 'Task retrieved successfully.');
    }

    /**
     * @param $id
     *
     * @return mixed
     */
    public function downloadAttachment($id)
    {
        $media = Media::findOrFail($id);

        return $media;
    }

    /**
     * @param  Task  $task
     * @param  Request  $request
     */
    public function updateTaskStatus(Task $task, Request $request)
    {
        $taskDetails = $this->taskRepository->updateTaskStatus($task->id, $request->all());
    }

    /**
     * @return Application|Factory|View
     */
    public function getKanbanTasks()
    {
        $data = $this->taskRepository->getLoginUserProjects();

        return view('kanban.index', $data);
    }

    /**
     * @param  Task  $task
     *
     * @return JsonResponse
     */
    public function getKanbanTaskDetails(Task $task)
    {
        $data['taskDetails'] = $this->taskRepository->getKanbanTaskDetails($task->id);
        $data['attachments'] = $this->taskRepository->getAttachments($task->id);

        $projectId = $task->project->id;

        $data['task_assignee'] = $task->taskAssignee->pluck('id')->toArray();
        $data['user'] = isset($this->users[$projectId]) ? $this->users[$projectId] : [];
        $user_Ids = array_diff(array_keys($data['user']), $data['task_assignee']);
        $data['users'] = User::whereIn('id', $user_Ids)->where('is_active', '=', true)->pluck('name', 'id');
        $statusArr = Task::$statusArr;
        asort($statusArr);
        unset($statusArr[Task::$status['STATUS_ALL']]);
        $data['taskStatus'] = $statusArr;
        $data['priority'] = Task::PRIORITY;

        return $this->sendResponse($data, 'Task retrieved successfully.');
    }

    /**
     * @param  Task  $task
     *
     * @param  Request  $request
     *
     * @return JsonResponse
     */
    public function updateKanbanTaskDetails(Task $task, Request $request)
    {
        $input = $request->all();
        $data['task'] = $this->taskRepository->updateKanbanTaskDetails($input, $task->id);

        $projectId = $task->project->id;
        $task_assignee = $task->taskAssignee->pluck('id')->toArray();
        $user = isset($this->users[$projectId]) ? $this->users[$projectId] : [];
        $user_Ids = array_diff(array_keys($user), $task_assignee);
        $data['users'] = User::whereIn('id', $user_Ids)->where('is_active', '=', true)->pluck('name', 'id');

        return $this->sendResponse($data, 'successfully updated');
    }

    /**
     * @param  Task  $task
     *
     * @param  Request  $request
     *
     *
     * @return JsonResponse
     */
    public function addAttachmentTaskDetails(Task $task, Request $request)
    {
        $input = $request->all();
        try {
            $result = $this->taskRepository->uploadAttachments($task, $input);
        } catch (Exception $e) {
            return $this->sendError($e->getMessage(), $e->getCode());
        }

        return $this->sendResponse($result, 'File has been uploaded successfully.');
    }

    /**
     * @param  Project  $project
     *
     * @return JsonResponse
     */
    public function getUserByProject(Project $project)
    {
        $users = $project->users->where('is_active', true)->sortBy('name', SORT_STRING | SORT_FLAG_CASE)->pluck('id',
            'name')->toArray();

        return $this->sendResponse($users, 'Users retrieved successfully');
    }

    /**
     * @param  User  $user
     *
     * @return JsonResponse
     */
    public function getProjectsByUser(User $user)
    {
        if ($user->can('manage_projects')) {
            $projectList = $this->projectRepository->getLoginUserAssignProjectsArr();
        } else {
            $projectList = $user->projects()->where('status', '!=',
                Project::STATUS_FINISHED)->orderBy('name')->get()->pluck('name', 'id')->toArray();
        }

        return $this->sendResponse($projectList, 'Projects Retrieved successfully.');
    }
}
