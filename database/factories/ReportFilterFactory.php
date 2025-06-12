<?php

/* @var $factory Factory */

namespace Database\Factories;

use App\Models\Report;
use App\Models\ReportFilter;
use Illuminate\Database\Eloquent\Factories\Factory;

class ReportFilterFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = ReportFilter::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $report = Report::factory()->create();

        return [
            'param_id'   => $this->faker->randomDigit,
            'report_id'  => $report->id,
            'param_type' => $this->faker->word,
        ];
    }
}
