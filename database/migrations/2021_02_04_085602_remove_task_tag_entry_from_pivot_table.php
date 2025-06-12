<?php

use App\Models\Task;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class RemoveTaskTagEntryFromPivotTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $taskIds = Task::onlyTrashed()->pluck('id')->toArray();
        foreach ($taskIds as $taskId) {
            DB::table('task_tags')->where('task_id', '=', $taskId)->delete();
        }
    }
}
