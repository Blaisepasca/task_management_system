<?php

namespace App\Repositories;

use App\Models\Client;
use App\Models\Department;
use App\Models\Project;
use App\Models\Report;
use App\Models\ReportFilter;
use App\Models\Tag;
use App\Models\TimeEntry;
use App\Models\User;
use Exception;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

/**
 * Class ReportRepository.
 */
class ReportRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = ['name', 'start_date', 'end_date'];

    /**
     * Return searchable fields.
     *
     * @return array
     */
    public function getFieldsSearchable()
    {
        return $this->fieldSearchable;
    }

    /**
     * Configure the Model.
     **/
    public function model()
    {
        return Report::class;
    }

    /**
     * @param array $input
     *
     * @return Report|null
     */
    public function store($input)
    {
        $input['meta'] = $this->prepareReportMeta($input);
        $input = $this->checkReportData($input);

        /** @var Report $report */
        $report = Report::create($input);
        $this->createReportFilter($input, $report);

        return $report->fresh();
    }

    /**
     * @param array $input
     * @param int   $id
     *
     * @throws Exception
     *
     * @return Report
     */
    public function update($input, $id)
    {
        $report = Report::findOrFail($id);
        $input['report_data'] = null;
        $input['meta'] = $this->prepareReportMeta($input);

        $input = $this->checkReportData($input);

        $report->update($input);
        $this->updateReportFilter($input, $report);

        return $report->fresh();
    }

    /**
     * @param  array  $inputData
     *
     * @return array
     */
    public function prepareReportMeta($inputData)
    {
        $departments = ['all_departments' => ! isset($inputData['department_id']) ? true : false];
        $clients = ['all_clients' => ! isset($inputData['client_id']) ? true : false];
        $projects = ['all_projects' => ! isset($inputData['projectIds']) ? true : false];
        $users = ['all_users' => ! isset($inputData['userIds']) ? true : false];

        return array_merge($departments, $clients, $projects, $users);
    }

    /**
     * @param  int  $id
     *
     * @throws Exception
     *
     * @return bool|mixed|null
     */
    public function delete($id)
    {
        $report = Report::findOrFail($id);
        $this->deleteFilter($report->id);
        $report->delete($id);

        return true;
    }

    /**
     * @param array  $input
     * @param Report $report
     *
     * @return array
     */
    public function createReportFilter($input, $report)
    {
        $result = [];
        if (isset($input['projectIds'])) {
            foreach ($input['projectIds'] as $projectId) {
                $result[] = $this->createFilter($report->id, $projectId, Project::class);
                $project = Project::find($projectId);
                activity()
                    ->causedBy(getLoggedInUser())
                    ->withProperties(['modal' => Report::class, 'data' => 'of '.$project->name])
                    ->performedOn($project)
                    ->useLog('Report Created')
                    ->log('Created project report');
            }
        }

        if (isset($input['userIds'])) {
            foreach ($input['userIds'] as $userId) {
                $result[] = $this->createFilter($report->id, $userId, User::class);
            }
        }

        if (isset($input['tagIds'])) {
            foreach ($input['tagIds'] as $tagId) {
                $result[] = $this->createFilter($report->id, $tagId, Tag::class);
            }
        }

        if (isset($input['client_id'])) {
            foreach ($input['client_id'] as $clientId) {
                $result[] = $this->createFilter($report->id, $clientId, Client::class);
            }
        }

        if (isset($input['department_id'])) {
            foreach ($input['department_id'] as $departmentId) {
                $result[] = $this->createFilter($report->id, $departmentId, Department::class);
            }
        }

        return $result;
    }

    /**
     * @param int    $reportId
     * @param int    $paramId
     * @param string $type
     *
     * @return ReportFilter
     */
    private function createFilter($reportId, $paramId, $type)
    {
        $filterInput['report_id'] = $reportId;
        $filterInput['param_id'] = $paramId;
        $filterInput['param_type'] = $type;

        return ReportFilter::create($filterInput);
    }

    /**
     * @param array  $input
     * @param Report $report
     *
     * @throws Exception
     *
     * @return array
     */
    public function updateReportFilter($input, $report)
    {
        $result = [];
        $input['projectIds'] = isset($input['projectIds']) ? $input['projectIds'] : [];
        $input['userIds'] = isset($input['userIds']) ? $input['userIds'] : [];
        $input['tagIds'] = isset($input['tagIds']) ? $input['tagIds'] : [];
        $input['department_id'] = isset($input['department_id']) ? $input['department_id'] : 0;
        $input['client_id'] = isset($input['client_id']) ? $input['client_id'] : 0;
        $deleteOldRecord = ReportFilter::whereReportId($report->id)->delete();

        $projectIds = $this->getProjectIds($report->id);
        $ids = array_diff($input['projectIds'], (array) $projectIds);
        foreach ($ids as $projectId) {
            $result[] = $this->createFilter($report->id, $projectId, Project::class);
        }
        $deleteProjects = array_diff((array) $projectIds, $input['projectIds']);
        if (! empty($deleteProjects)) {
            ReportFilter::ofParamType(Project::class)->whereIn('param_id', $deleteProjects)->delete();
        }

        $userIds = $this->getUserIds($report->id);
        $ids = array_diff($input['userIds'], (array) $userIds);
        foreach ($ids as $userId) {
            $result[] = $this->createFilter($report->id, $userId, User::class);
        }
        $deleteUsers = array_diff((array) $userIds, $input['userIds']);
        if (! empty($deleteUsers)) {
            ReportFilter::ofParamType(User::class)->whereIn('param_id', $deleteUsers)->delete();
        }

        $tagIds = $this->getTagIds($report->id);
        $ids = array_diff($input['tagIds'], (array) $tagIds);
        foreach ($ids as $tagId) {
            $result[] = $this->createFilter($report->id, $tagId, Tag::class);
        }
        $deleteTags = array_diff((array) $tagIds, $input['tagIds']);
        if (! empty($deleteTags)) {
            ReportFilter::ofParamType(Tag::class)->whereIn('param_id', $deleteTags)->delete();
        }

        $clientId = $this->getClientId($report->id);

        if (! empty($clientId)) {
            ReportFilter::ofParamType(Client::class)->whereIn('param_id', $clientId)->delete();
        }

        if (isset($input['client_id'])) {
            foreach ($input['client_id'] as $clientId) {
                $result[] = $this->createFilter($report->id, $clientId, Client::class);
            }
        }

        $departmentId = $this->getDepartmentId($report->id);
        if (isset($input['department_id'])) {
            foreach ($input['department_id'] as $departmentId) {
                $result[] = $this->createFilter($report->id, $departmentId, Department::class);
            }
        }

        return $result;
    }

    /**
     * @param int $reportId
     *
     * @return array
     */
    public function getProjectIds($reportId)
    {
        return ReportFilter::ofParamType(Project::class)->ofReport($reportId)->pluck('param_id')->toArray();
    }

    /**
     * @param int $reportId
     *
     * @return array
     */
    public function getUserIds($reportId)
    {
        return ReportFilter::ofParamType(User::class)->ofReport($reportId)->pluck('param_id')->toArray();
    }

    /**
     * @param int $reportId
     *
     * @return array
     */
    public function getTagIds($reportId)
    {
        return ReportFilter::ofParamType(Tag::class)->ofReport($reportId)->pluck('param_id')->toArray();
    }

    /**
     * @param  int  $reportId
     *
     * @return array
     */
    public function getClientId($reportId)
    {
        $report = ReportFilter::ofParamType(Client::class)->ofReport($reportId)->pluck('param_id')->toArray();
        if (empty($report)) {
            return;
        }

        return $report;
    }

    /**
     * @param  int  $reportId
     *
     * @return array
     */
    public function getDepartmentId($reportId)
    {
        $report = ReportFilter::ofParamType(Department::class)->ofReport($reportId)->pluck('param_id')->toArray();
        if (empty($report)) {
            return;
        }

        return $report;
    }

    /**
     * @param int $reportId
     *
     * @throws Exception
     *
     * @return bool|mixed|null
     */
    public function deleteFilter($reportId)
    {
        return ReportFilter::ofReport($reportId)->delete();
    }

    /**
     * @param Report $report
     *
     * @param null $input
     *
     * @return TimeEntry[]|Builder[]
     */
    public function getReport($report, $input = null)
    {
        $startDate = $report->start_date->startOfDay();
        $endDate = $report->end_date->endOfDay();
        $id = $report->id;

        $query = TimeEntry::with([
            'task.timeEntries', 'user', 'task.project.client.department', 'task.tags',
        ])->whereBetween('time_entries.start_time', [$startDate, $endDate]);

        $projectIds = $this->getProjectIds($id);
        $tagIds = $this->getTagIds($id);
        $userIds = $this->getUserIds($id);
        $clientId = $this->getClientId($id);
        $departmentId = $this->getDepartmentId($id);

        if (empty($id)) {
            $projectIds = isset($input['projectIds']) ? $input['projectIds'] : '';
            $tagIds = isset($input['tagIds']) ? $input['tagIds'] : '';
            $userIds = isset($input['userIds']) ? $input['userIds'] : '';
            $clientId = isset($input['client_id']) ? [$input['client_id']] : [];
            $departmentId = isset($input['department_id']) ? [$input['department_id']] : [];
        }

        if (! Auth::user()->hasRole('Admin')) {
            $userIds = [Auth::id()];
        }

        $query->when(! empty($userIds), function (Builder $q) use ($userIds) {
            $q->whereIn('user_id', $userIds);
        });

        $query->when(! empty($projectIds), function (Builder $q) use ($projectIds) {
            $q->whereHas('task', function (Builder $query) use ($projectIds) {
                $query->whereIn('project_id', $projectIds);
            });
        });

        $query->when(! empty($tagIds), function (Builder $q) use ($tagIds) {
            $q->whereHas('task.tags', function (Builder $query) use ($tagIds) {
                $query->whereIn('tag_id', $tagIds);
            });
        });

        $query->when(! empty($clientId), function (Builder $q) use ($clientId) {
            $q->whereHas('task.project', function (Builder $query) use ($clientId) {
                $query->whereIn('client_id', $clientId);
            });
        });

        $query->when(! empty($departmentId), function (Builder $q) use ($departmentId) {
            $q->whereHas('task.project.client', function (Builder $query) use ($departmentId) {
                $query->whereIn('department_id', $departmentId);
            });
        });

        $entries = $query->get();

        // TODO : NEED TO REFACTOR/OPTIMIZE THIS CODE
        // Prepare report data in proper format
        $result = [];
        /** @var TimeEntry $entry */
        foreach ($entries as $entry) {
            $clientId = $entry->task->project->client_id;
            $deptId = $entry->task->project->client->department_id;
            $project = $entry->task->project;
            $client = $project->client;
            $duration = $entry->duration;
            $department = $project->client->department;

            // prepare department and duration
            $result[$deptId]['name'] = $department->name;
            if (! isset($result[$deptId]['duration'])) {
                $result[$deptId]['duration'] = 0;
                $result[$deptId]['time'] = 0;
            }
            // prepare cost for client
            if (! isset($result[$deptId]['cost'])) {
                $result[$deptId]['cost'] = 0;
            }
            $result[$deptId]['duration'] = $duration + $result[$deptId]['duration'];
            $result[$deptId]['time'] = $this->getDurationTime($result[$deptId]['duration']);

            // prepare client and duration
            $result[$deptId]['clients'][$clientId]['name'] = $client->name;
            if (! isset($result[$deptId]['clients'][$clientId]['duration'])) {
                $result[$deptId]['clients'][$clientId]['duration'] = 0;
                $result[$deptId]['clients'][$clientId]['time'] = 0;
            }
            // prepare cost for client
            if (! isset($result[$deptId]['clients'][$clientId]['cost'])) {
                $result[$deptId]['clients'][$clientId]['cost'] = 0;
            }
            $result[$deptId]['clients'][$clientId]['duration'] = $duration + $result[$deptId]['clients'][$clientId]['duration'];
            $result[$deptId]['clients'][$clientId]['time'] = $this->getDurationTime($result[$deptId]['clients'][$clientId]['duration']);

            // prepare projects and duration
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['name'] = $project->name;
            if (! isset($result[$deptId]['clients'][$clientId]['projects'][$project->id]['duration'])) {
                $result[$deptId]['clients'][$clientId]['projects'][$project->id]['duration'] = 0;
                $result[$deptId]['clients'][$clientId]['projects'][$project->id]['time'] = 0;
            }
            $projectDuration = $result[$deptId]['clients'][$clientId]['projects'][$project->id]['duration'];

            // set default cost for projects
            if (! isset($result[$deptId]['clients'][$clientId]['projects'][$project->id]['cost'])) {
                $result[$deptId]['clients'][$clientId]['projects'][$project->id]['cost'] = 0;
            }
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['duration'] = $duration + $projectDuration;
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['time'] = $this->getDurationTime($duration + $projectDuration);

            // prepare users and duration
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['name'] = $entry->user->name;
            if (! isset($result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['duration'])) {
                $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['duration'] = 0;
            }

            // set default cost for users
            if (! isset($result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['cost'])) {
                $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['cost'] = 0;
            }

            $userDuration = $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['duration'];

            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['duration'] = $duration + $userDuration;
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['time'] = $this->getDurationTime($duration + $userDuration);
            // calculate cost of user
            $userCost = $this->getCosting($duration, $entry->user);
            // calculate cost for client and project with user
            $result[$deptId]['cost'] += $userCost;
            $result[$deptId]['clients'][$clientId]['cost'] += $userCost;
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['cost'] += $userCost;
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['cost'] += $userCost;

            // prepare tasks and duration
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['name'] = $entry->task->title;
            if (! isset($result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['duration'])) {
                $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['duration'] = 0;
                $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['time'] = 0;
            }

            $time = $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['duration'] + $entry->duration;

            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['duration'] = $time;
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['time'] = $this->getDurationTime($time);
            $result[$deptId]['clients'][$clientId]['projects'][$project->id]['users'][$entry->user_id]['tasks'][$entry->task_id]['task_id'] = $entry->task->id;
        }

        return $result;
    }

    /**
     * @param int $minutes
     *
     * @return string
     */
    public function getDurationTime($minutes)
    {
        if ($minutes == 0) {
            return '0 hr';
        }

        if ($minutes < 60) {
            return $minutes.' min';
        }

        $hour = floor($minutes / 60);
        $min = (int) ($minutes - $hour * 60);
        if ($min === 0) {
            return $hour.' hr';
        }

        return $hour.' hr '.$min.' min';
    }

    /**
     * @param $minutes
     * @param User $user
     *
     * @return float|int
     */
    public function getCosting($minutes, $user)
    {
        if (is_null($user->salary)) {
            return 0;
        }

        $perDaySalary = $user->salary / getWorkingDayOfMonth();
        $perHRSalary = $perDaySalary / getWorkingHourOfDay();
        $perMinSalary = $perHRSalary / 60;

        return round($perMinSalary * $minutes, 2);
    }

    /**
     * @param $input
     *
     * @return mixed
     */
    public function checkReportData($input)
    {
        if (! isset($input['department_id'])) {
            $departmentIds = Department::with('client')->pluck('id')->toArray();
            $input['department_id'] = $departmentIds;
        } else {
            $input['department_id'] = [$input['department_id']];
        }

        if (! isset($input['client_id'])) {
            $clientIds = Client::with('department')->whereHas('department', function (Builder $query) use ($input) {
                $query->whereIn('id', $input['department_id']);
            })->pluck('id')->toArray();
            $input['client_id'] = $clientIds;
        } else {
            $input['client_id'] = [$input['client_id']];
        }

        if (! isset($input['projectIds'])) {
            if (Auth::user()->hasRole('Admin')) {
                $projectIds = Project::with('client')->whereHas('client', function (Builder $query) use ($input) {
                    $query->whereIn('id', $input['client_id']);
                })->pluck('id')->toArray();
            } else {
                $projectIds = Auth::user()->projects->pluck('id')->toArray();
            }
            $input['projectIds'] = $projectIds;
        }

        if (! isset($input['userIds']) && Auth::user()->hasRole('Admin') && isset($input['projectIds'])) {
            $userIds = User::with('projects')->whereHas('projects', function (Builder $query) use ($input) {
                $query->whereIn('projects.id', $input['projectIds']);
            })->pluck('id')->toArray();
            $input['userIds'] = $userIds;
        }

        if (! Auth::user()->hasRole('Admin')) {
            $userIds = [Auth::id()];
            $input['userIds'] = $userIds;
        }

        return $input;
    }
}
