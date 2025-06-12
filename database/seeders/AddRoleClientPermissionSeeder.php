<?php

namespace Database\Seeders;

use App\Models\Permission;
use App\Models\Role;
use Illuminate\Database\Seeder;

class AddRoleClientPermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $clientRole = Role::whereDisplayName('Client')->first();
        $clientRole->syncPermissions();

        $permission = Permission::create([
            'name'         => 'role_client',
            'display_name' => 'Role Client',
            'description'  => '<p>Able to access Client Panel.</p>',
        ]);

        $clientRole->givePermissionTo($permission);
    }
}
