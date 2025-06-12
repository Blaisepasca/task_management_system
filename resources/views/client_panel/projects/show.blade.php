@extends('client_panel.layouts.app')
@section('title')
    {{ __('messages.project.project_details') }}
@endsection
@section('content')
    <section class="section">
        <div class="section-header">
            <h1>{{ucfirst($project->name)}}'s {{ __('messages.project.project_details') }}</h1>
            <div class="section-header-breadcrumb justify-content-end">
                <a href="{{ route('client.projects.index') }}" class="btn btn-light form-btn ml-3">
                    {{ __('messages.common.back') }}
                </a>
            </div>
        </div>
        <div class="section-body">
            <div class="card">
                @include('client_panel.projects.show_fields')
            </div>
        </div>
    </section>
@endsection
