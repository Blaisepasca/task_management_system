<?php

use App\Models\Tag;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RemoveSoftDeletedTagsFromTagsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $softDeletedTags = Tag::onlyTrashed()->get();
        if (! empty($softDeletedTags)) {
            foreach ($softDeletedTags as $tags) {
                $tags->taskTags()->detach();
                $tags->forceDelete();
            }
        }
    }
}
