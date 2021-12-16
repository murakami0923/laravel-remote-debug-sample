<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class IndexController extends Controller
{
    public function index ()
    {
        $hello = 'Hello,World!';
        $hello_array = [
            'Hello',
            'こんにちは',
            'Bonjour',
        ];

        return view('index', compact('hello', 'hello_array'));
    }
}
