<?php

namespace App\Http\Controllers;

use App\Http\Requests\UpdateSettingRequest;
use App\Models\Setting;
use App\Repositories\SettingRepository;
use Flash;
use Illuminate\Contracts\View\Factory;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Redirector;
use Illuminate\View\View;
use Spatie\MediaLibrary\Exceptions\FileCannotBeAdded\DiskDoesNotExist;
use Spatie\MediaLibrary\Exceptions\FileCannotBeAdded\FileDoesNotExist;
use Spatie\MediaLibrary\Exceptions\FileCannotBeAdded\FileIsTooBig;
use Spatie\MediaLibrary\Exceptions\MediaCannotBeDeleted;

class SettingController extends AppBaseController
{
    /** @var SettingRepository */
    private $settingRepository;

    public function __construct(SettingRepository $settingRepo)
    {
        $this->settingRepository = $settingRepo;
    }

    /**
     * Show the form for editing the specified Setting.
     *
     * @param  Request  $request
     *
     * @return Factory|View
     */
    public function edit(Request $request)
    {
        $groupName = $request->get('group', 'general');
        $settings = $this->settingRepository->getSyncList($groupName);
        $invoiceTemplateArray = Setting::INVOICE__TEMPLATE_ARRAY;
        asort($invoiceTemplateArray);
        $composerFile = file_get_contents('../composer.json');
        $composerData = json_decode($composerFile, true);
        $currentVersion = $composerData['version'];
        
        return view('settings.edit', compact('settings', 'groupName', 'invoiceTemplateArray','currentVersion'));
    }

    /**
     * Update the specified Setting in storage.
     *
     * @param  UpdateSettingRequest  $request
     *
     * @throws DiskDoesNotExist
     *
     * @throws FileDoesNotExist
     *
     * @throws FileIsTooBig
     *
     * @throws MediaCannotBeDeleted
     *
     * @return RedirectResponse|Redirector
     */
    public function update(UpdateSettingRequest $request)
    {
        $this->settingRepository->updateSetting($request->all());

        Flash::success('Setting updated successfully.');

        return redirect(route('settings.edit'));
    }

    /**
     * @param  Request  $request
     *
     * @return RedirectResponse|Redirector
     */
    public function invoiceSettingUpdate(Request $request)
    {
        $this->settingRepository->updateInvoiceSetting($request->all());

        return redirect('settings?group=invoice_template');
    }
}
