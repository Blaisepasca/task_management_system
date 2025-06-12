<?php

/* @var $factory Factory */

namespace Database\Factories;

use App\Models\Client;
use App\Models\Project;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProjectFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Project::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $client = Client::factory()->create();

        return [
            'name'        => $this->faker->name,
            'prefix'      => $this->faker->name,
            'description' => $this->faker->sentence,
            'client_id'   => $client->id,
        ];
    }
}
