<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "//www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <link rel="stylesheet" href="{{ asset('favicon.ico') }}">
    <title>{{ __('messages.invoice.invoice_pdf') }}</title>
    <link href="{{ asset('assets/css/bootstrap.min.css') }}" rel="stylesheet" type="text/css"/>
    <link href="{{ asset('assets/style/css/invoice-pdf.css') }}" rel="stylesheet" type="text/css"/>
</head>
<body>
<table width="100%">
    <tr>
        <td class="header-left">
            <div class="main-heading" style="font-size: 40px">REPORT</div>
            <div class="invoice-number font-color-gray">
                #{{ $invoice->name }}</div>
        </td>
        <td class="header-right">
            <div class="logo"><img width="100px"
                                   src="data:image/png,image/jpeg,image/jpg;base64,{{ base64_encode(file_get_contents(getSettings('app_logo')->logo_path)) }}"
                                   alt=""></div>
        </td>
    </tr>
</table>
<br>
<table width="100%">
    <thead>
    <tr>
        <td colspan="2" class="vertical-align-top" width="200px">
            <strong class="from-font-size">From :</strong><br>
            {{ html_entity_decode($setting['app_name']) }}<br>
            {{ html_entity_decode($setting['company_address']) }}<br>
            Mo: {{ $setting['company_phone'] }}
        </td>
        <td colspan="5" class="vertical-align-top">
            <strong class="from-font-size">To :</strong><br>
            <b>Project:</b>
            @foreach($invoice->invoiceProjects as $invoiceProject)
                {{$loop->first ?'': ', '}}
                {{html_entity_decode($invoiceProject->name)}}
            @endforeach<br>
            <b>Client name:</b>
            @foreach($invoice->invoiceClients as $invoiceClient)
                {{$loop->first ? '':', '}}
                {{html_entity_decode($invoiceClient->name)}}
            @endforeach<br>

            @if(count(array_filter($invoice->invoiceClients->pluck('email')->toArray())) > 0)
                <b>Email:</b>
                {{ implode(', ', array_filter($invoice->invoiceClients->pluck('email')->toArray())) }}
            @endif
        </td>
    </tr>
    </thead>
</table>
<br>
<table width="100%">
    <thead class="text-right">
    <tr>
        <td>
            <strong>Report Date:</strong> {{ $invoice->created_at->format('jS M,Y g:i A') }}<br>
            
        </td>
    </tr>
    </thead>
</table>

<table class="w-100">
    <tr class="invoice-items">
        <td colspan="2">
            <table class="d-items-table table-striped table-bordered">
                <thead>
                <tr>
                    <th>#</th>
                    <th>{{ __('messages.time_entry.task') }}</th>
                    <th>{{ __('messages.invoice.hours') }}</th>
                </tr>
                </thead>
                <tbody>
                @if(isset($invoice) && !empty($invoice))
                    @foreach($invoice->invoiceItems as $key => $invoiceItem)
                        <tr>
                            <td>{{ $key + 1 }}</td>
                            <td>{{ html_entity_decode($invoiceItem->item_name) }}</td>
                            <td>{{ $invoiceItem->hours }}</td>
                            
                        </tr>
                    @endforeach
                @endif
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <table class="d-invoice-footer">
                <tr>
                    <td class="font-weight-bold">Total hours:</td>
                    <td>
                         {{ $invoice->total_hour }}
                    </td>
                </tr>
               
            </table>
        </td>
    </tr>
</table>
</body>
</html>
