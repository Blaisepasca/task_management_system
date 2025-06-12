<?php

namespace App\Repositories;

use App\Models\Setting;
use Illuminate\Support\Arr;
use Spatie\MediaLibrary\Exceptions\FileCannotBeAdded\DiskDoesNotExist;
use Spatie\MediaLibrary\Exceptions\FileCannotBeAdded\FileDoesNotExist;
use Spatie\MediaLibrary\Exceptions\FileCannotBeAdded\FileIsTooBig;

/**
 * Class SettingRepository
 */
class SettingRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        'app_name',
        'app_logo',
    ];

    /**
     * Return searchable fields
     *
     * @return array
     */
    public function getFieldsSearchable()
    {
        return $this->fieldSearchable;
    }

    /**
     * Configure the Model
     **/
    public function model()
    {
        return Setting::class;
    }

    /**
     * @param $groupName
     *
     * @return array
     */
    public function getSyncList($groupName)
    {
        $setting = Setting::where('key', 'company_address')->orwhere('key', 'company_phone')->orwhere('key',
            'company_name')->pluck('value',
            'key')->toArray();
        $groupSetting = Setting::whereGroup(Setting::GROUP_ARRAY[$groupName])->pluck('value', 'key')->toArray();
        $setting = array_merge($groupSetting, $setting);

        return $setting;
    }

    /**
     * @param $input
     *
     * @throws DiskDoesNotExist
     * @throws FileDoesNotExist
     * @throws FileIsTooBig
     */
    public function updateSetting($input)
    {
        $settingInputArray = Arr::except($input, ['_token']);
        foreach ($settingInputArray as $key => $value) {
            /** @var Setting $setting */
            $setting = Setting::where('key', $key)->first();
            if (! $setting) {
                continue;
            }

            if (in_array($key, ['app_logo', 'favicon']) && ! empty($value)) {
                $this->fileUpload($setting, $value);
                continue;
            }

            $setting->update(['value' => $value]);
        }

        return true;
    }

    /**
     * @param  Setting  $setting
     * @param $file
     *
     * @throws DiskDoesNotExist
     * @throws FileDoesNotExist
     * @throws FileIsTooBig
     *
     * @return mixed
     */
    public function fileUpload($setting, $file)
    {
        $setting->clearMediaCollection(Setting::PATH);
        $media = $setting->addMedia($file)->toMediaCollection(Setting::PATH, config('app.media_disc'));

        $setting->update(['value' => $media->getUrl()]);

        return $setting;
    }

    /**
     * @param $input
     *
     * @return bool
     */
    public function updateInvoiceSetting($input)
    {
        $invoiceSettingInputArray = Arr::except($input, ['_token']);
        foreach ($invoiceSettingInputArray as $key => $value) {
            $setting = Setting::where('key', $key)->first();

            if (! $setting) {
                continue;
            }

            $setting->update(['value' => $value]);
        }

        return true;
    }
}
