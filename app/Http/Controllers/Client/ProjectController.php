<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\AppBaseController;
use App\Models\Project;
use App\Models\ProjectActivity;
use App\Models\Task;
use App\Repositories\ProjectRepository;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Http\Request;
use Illuminate\View\View;

class ProjectController extends AppBaseController
{
    /** @var ProjectRepository */
    private $invoiceRepository;

    public function __construct(ProjectRepository $invoiceRepo)
    {
        $this->invoiceRepository = $invoiceRepo;
    }

    /**
     * @param  Request  $request
     *
     * @return Application|Factory|View
     */
    public function index(Request $request)
    {
        return view('client_panel.projects.index');
    }

    /**
     * @param  Project  $project
     *
     * @return Application|Factory|View
     */
    public function show(Project $project)
    {
        $projectIds = Project::whereClientId(getLoggedInUser()->owner_id)->pluck('id')->toArray();
        if (! in_array($project->id, $projectIds)) {
            return redirect()->back();
        }
        $project = Project::with('users.media')->findOrFail($project->id);
        $completedTasks = $project->tasks->where('status', '=', Task::STATUS_COMPLETED)->count();
        $activities = ProjectActivity::with('createdBy')->where('subject_id', '=',
            $project->id)->orderByDesc('created_at')->get();

        return view('client_panel.projects.show', compact('project', 'completedTasks', 'activities'));
    }
}
