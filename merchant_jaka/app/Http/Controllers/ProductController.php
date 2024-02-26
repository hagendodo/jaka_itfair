<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // Validate the request data
        $request->validate([
            'filename' => 'required|file', // Ensure that 'admission_import' is required and is a file
        ]);

        // Retrieve the file from the request
        $file = $request->file('filename');

        // Extract the filename
        $filename = $file->getClientOriginalName();

        // Read the file content
        $fileContents = file_get_contents($file->getRealPath());

        // Call external API to upload file
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . session('api_token'),
        ])
            ->attach('filename', $fileContents, $filename)
            ->post(env('BASE_URL_API') . "/products", $request->all());

        // Check if the request was successful
        if ($response->successful()) {
            // Process the response
            return $response->json();
        } else {
            // Handle the error
            return redirect()->back()->withInput()->with('error', 'Failed to upload file');
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $request->validate([
            'filename' => 'required|file',
        ]);

        // Retrieve the file from the request
        $file = $request->file('filename');

        // Extract the filename
        $filename = $file->getClientOriginalName();

        // Read the file content
        $fileContents = file_get_contents($file->getRealPath());

        // Call external API to upload file
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . session('api_token'),
        ])
            ->attach('filename', $fileContents, $filename)
            ->put(env('BASE_URL_API') . "/products/{$request->product}", $request->all());

        // Check if resource update was successful
        if ($response->successful()) {
            // Process the response or return success message
            return redirect()->back(); // Example: Returning the updated resource data
        } else {
            // Handle the error
            return redirect()->back()->withErrors(['error' => 'Failed to update resource'], $response->status());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        // Call external API to delete data
        $bearerToken = $request->session()->get('api_token');

        // Call external API to store data with Bearer token in headers
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->delete(env('BASE_URL_API') . "/products/{$request->product}");

        // Check if resource deletion was successful
        if ($response->successful()) {
            // Process the response or return success message
            return redirect()->back();
        } else {
            // Handle the error
            return redirect()->back()->withErrors(['error' => 'Failed to delete resource'], $response->status());
        }
    }
}
