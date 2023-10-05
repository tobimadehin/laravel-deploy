<?php

namespace App\Http\Controllers;

// use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Carbon\Carbon;

class TimezoneController extends Controller
{
    public function getCurrentTime()
    {
        $timezones = [
            'Lagos' => 'Africa/Lagos',
            'Nairobi' => 'Africa/Nairobi',
            'London' => 'Europe/London',
            'Berlin' => 'Europe/Berlin',
            'Mumbai' => 'Asia/Kolkata',
        ];

        $currentTimes = [];

        foreach ($timezones as $city => $timezone) {
            $currentTime = Carbon::now($timezone)->format('h:ia');
            $currentTimes[$city] = $currentTime;
        }

        return response()->json($currentTimes);
    }
}
