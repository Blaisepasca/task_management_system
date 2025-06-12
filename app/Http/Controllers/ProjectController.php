<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateProjectRequest;
use App\Http\Requests\UpdateProjectRequest;
use App\Models\Project;
use App\Models\ProjectActivity;
use App\Models\Task;
use App\Models\User;
use App\Queries\ProjectDataTable;
use App\Repositories\ClientRepository;
use App\Repositories\ProjectRepository;
use App\Repositories\TaskRepository;
use App\Repositories\UserRepository;
use DataTables;
use Exception;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

/**
 * Class ProjectController.
 */
class ProjectController extends AppBaseController
{
    /** @var ProjectRepository */
    private $projectRepository;

    /** @var UserRepository */
    private $userRepository;

    /**
     * ProjectController constructor.
     *
     * @param  ProjectRepository  $projectRepo
     * @param  UserRepository  $userRepository
     */
    public function __construct(
        ProjectRepository $projectRepo,
        UserRepository $userRepository
    ) {
        $this->projectRepository = $projectRepo;
        $this->userRepository = $userRepository;
    }

    /**
     * Display a listing of the Project.
     *
     * @param  Request  $request
     * @param  ClientRepository  $clientRepository
     *
     * @throws Exception
     *
     * @return View
     */
    public function index(Request $request, ClientRepository $clientRepository)
    {
        if ($request->ajax()) {
            return Datatables::of(
                (new ProjectDataTable())->get(
                    $request->only('filter_client')
                )
            )->make(true);
        }

        $clients = $clientRepository->getClientList();
        $users = $this->userRepository->getUserList();
        $currencies = Project::CURRENCY;
        $budgetTypes = Project::BUDGET_TYPE;
        $projectStatus = Arr::except(Project::STATUS, Project::STATUS_All);
        if (Auth::user()->hasPermissionTo('manage_projects')) {
            return view('projects.index', compact('clients', 'users', 'currencies', 'budgetTypes', 'projectStatus'));
        }

        return view('my_projects.index', compact('users'));
    }

    /**
     * Store a newly created Project in storage.
     *
     * @param  CreateProjectRequest  $request
     *
     * @return JsonResponse
     */
    public function store(CreateProjectRequest $request)
    {
        $input = $request->all();

        $this->projectRepository->store($input);

        return $this->sendSuccess('Project created successfully.');
    }

    /**
     * @param  Project  $project
     *
     * @param  ClientRepository  $clientRepository
     *
     * @return Application|Factory|View
     */
    public function show(Project $project, ClientRepository $clientRepository)
    {
        $clients = $clientRepository->getClientList();
        $users = $this->userRepository->getUserList();
        $currencies = Project::CURRENCY;
        $budgetTypes = Project::BUDGET_TYPE;
        $projectStatus = Arr::except(Project::STATUS, Project::STATUS_All);
        $openTasks = $project->openTasks->count();
        $project = Project::with('createdUser', 'users.media')->findOrFail($project->id);
        $data = $this->projectRepository->getProjectsDetails($project);
        $taskRepo = app(TaskRepository::class);
        $taskData = $taskRepo->getTaskData();
        $activities = ProjectActivity::with('createdBy')->where('subject_id', '=',
            $project->id)->where('subject_type', '=', Project::class)->orderByDesc('created_at')->get();

        return view('projects.show',
            compact('project', 'clients', 'users', 'currencies', 'budgetTypes', 'projectStatus', 'openTasks',
                'activities',
                'data'))->with($taskData);
    }

    /**
     * Show the form for editing the specified Project.
     *
     * @param  Project  $project
     *
     * @return JsonResponse|RedirectResponse
     */
    public function edit(Project $project)
    {
        $project->users;
        $users = $project->users->pluck('id')->toArray();
        $allUsers = $this->userRepository->getUserList();

        return $this->sendResponse(['project' => $project, 'users' => $users, 'allUsers' => $allUsers], 'Project retrieved successfully.');
    }

    /**
     * Update the specified Client in storage.
     *
     * @param  Project  $project
     * @param  UpdateProjectRequest  $request
     *
     * @return JsonResponse|RedirectResponse
     */
    public function update(Project $project, UpdateProjectRequest $request)
    {
        $input = $request->all();
        $input['price'] = (! empty($input['price']) ? removeCommaFromNumbers($input['price']) : null);
        if ($input['status'] == Project::STATUS_FINISHED) {
            if ($project->tasks()->where('status', '=', Task::$status['STATUS_ACTIVE'])->count() > 0) {
                return $this->sendError('This project has pending tasks.');
            }
        }

        $this->projectRepository->update($input, $project->id);

        return $this->sendSuccess('Project updated successfully.');
    }

    /**
     * Remove the specified Project from storage.
     *
     * @param  Project  $project
     *
     * @throws Exception
     *
     * @return JsonResponse
     */
    public function destroy(Project $project)
    {
        $this->projectRepository->delete($project->id);

        return $this->sendSuccess('Project deleted successfully.');
    }

    /**
     * @return JsonResponse
     */
    public function getMyProjects()
    {
        $projects = $this->projectRepository->getMyProjects();

        return $this->sendResponse($projects, 'Project Retrieved successfully.');
    }

    /**
     * @param  Request  $request
     *
     * @return JsonResponse
     */
    public function users(Request $request)
    {
        $projectIds = $request->get('projectIds', null);

        $projectIdsArr = (! is_null($projectIds)) ? explode(',', $projectIds) : [];
        $users = $this->userRepository->getUserList($projectIdsArr);

        return $this->sendResponse($users, 'Users Retrieved successfully.');
    }

    /**
     * @param  User  $user
     *
     * @return JsonResponse
     */
    public function getProjectsByUser(User $user)
    {
        $projectList = $this->projectRepository->getProjectsByUserId($user->id);

        return $this->sendResponse($projectList, 'Projects Retrieved successfully.');
    }

    /**
     * @return Application|Factory|View
     */
    public function userAssignProjects()
    {
        $users = $this->userRepository->getUserList();

        return view('my_projects.index', compact('users'));
    }

    /**
     * @param  Project  $project
     *
     * @return Application|Factory|RedirectResponse|View
     */
    public function userAssignProjectsShow(Project $project)
    {
        $projectIds = getLoggedInUser()->projects->pluck('id')->toArray();
        if (! in_array($project->id, $projectIds)) {
            return redirect()->back();
        }
        $project = Project::with('users.media')->findOrFail($project->id);
        $data = $this->projectRepository->getAssignProjectDetail($project);
        $taskRepo = app(TaskRepository::class);
        $taskData = $taskRepo->getTaskData();

        return view('my_projects.show', compact('project', 'data'))->with($taskData);
    }
}
