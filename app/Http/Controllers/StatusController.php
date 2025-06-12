<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateStatusRequest;
use App\Http\Requests\UpdateStatusRequest;
use App\Models\Status;
use App\Repositories\StatusRepository;
use Exception;
use Illuminate\Contracts\View\Factory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class StatusController extends AppBaseController
{
    /** @var StatusRepository */
    private $statusRepository;

    /**
     * TagController constructor.
     *
     * @param  StatusRepository  $statusRepo
     */
    public function __construct(StatusRepository $statusRepo)
    {
        $this->statusRepository = $statusRepo;
    }

    /**
     * @param Request $request
     *
     * @return Factory|View
     */
    public function index(Request $request)
    {
        return view('status.index');
    }

    /**
     * Store a newly created Status in storage.
     *
     * @param  CreateStatusRequest  $request
     *
     * @return JsonResponse
     */
    public function store(CreateStatusRequest $request)
    {
        $input = $request->all();

        $this->statusRepository->store($input);

        return $this->sendSuccess('Status created successfully.');
    }

    /**
     * Show the form for editing the specified Status.
     *
     * @param  Status  $status
     *
     * @return JsonResponse
     */
    public function edit(Status $status)
    {
        return $this->sendResponse($status, 'Status retrieved successfully.');
    }

    /**
     * Update the specified Status in storage.
     *
     * @param  Status  $status
     * @param  UpdateStatusRequest  $request
     *
     * @return JsonResponse
     */
    public function update(Status $status, UpdateStatusRequest $request)
    {
        $this->statusRepository->update($request->all(), $status->id);

        return $this->sendSuccess('Status updated successfully.');
    }

    /**
     * Remove the specified Status from storage.
     *
     * @param  Status  $status
     *
     * @throws Exception
     *
     * @return JsonResponse
     */
    public function destroy(Status $status)
    {
        $status = $this->statusRepository->deleteStatus($status->id);

        if ($status) {
            return $this->sendSuccess('Status deleted successfully.');
        }

        return $this->sendError('Status can not be deleted.');
    }
}
