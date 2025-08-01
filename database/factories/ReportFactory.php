<?php

/* @var $factory Factory */

namespace Database\Factories;

use App\Models\Report;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class ReportFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Report::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $user = User::factory()->create();
        $startDate = date('Y-m-d H:i:s', strtotime('-1 day'));
        $endDate = date('Y-m-d H:i:s');

        return [
            'name'       => $this->faker->word,
            'owner_id'   => $user->id,
            'start_date' => $startDate,
            'end_date'   => $endDate,
        ];
    }
}
