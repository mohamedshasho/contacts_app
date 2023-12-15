<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Contact;
use App\Http\Requests\ContactRequest;
use App\Http\Resources\ApiResourse;
use App\Http\Resources\ContactResourse;

class ContactController extends Controller
{


    public function index()
    {
        // $contacts = Contact::paginate();
        $contacts = Contact::all();

        return ContactResourse::collection($contacts);
    }


    public function store(ContactRequest $request)
    {
        try {

            $contact = Contact::create($request->all());
            $response = new ApiResourse([
                'status' => true,
                'message' => 'Contact Added Successfully',
                'data' => $contact,
            ]);
            return $response;
        } catch (\Exception $e) {
            // Example error response
            $errorResponse = new ApiResourse([
                'status' => false,
                'message' => 'Error occurred',
                'data' => ['error' => $e->getMessage()],
            ]);

            return $errorResponse;
        }
    }

    public function destroy($id)
    {

        $contact = Contact::find($id);

        if (!$contact) {
            $errorResponse = new ApiResourse([
                'status' => false,
                'message' => 'The contact not found',
                'data' => null,
            ]);
            return $errorResponse;
        }
        try {
            $isDeleted = $contact->delete();
            if ($isDeleted) {
                $response = new ApiResourse([
                    'status' => true,
                    'message' => 'Contact Deleted Successfully',
                    'data' => $contact,
                ]);
                return $response;
            } else {
                $errorResponse = new ApiResourse([
                    'status' => false,
                    'message' => 'something happened, try again',
                    'data' => null,
                ]);
                return $errorResponse;
            }
        } catch (\Exception $e) {
            // Example error response
            $errorResponse = new ApiResourse([
                'status' => false,
                'message' => 'Error occurred',
                'data' => ['error' => $e->getMessage()],
            ]);
            return $errorResponse;
        }
    }

    public function update(ContactRequest $request, $id)
    {

        try {
            $contact = Contact::find($id);

            if (!$contact) {
                $errorResponse = new ApiResourse([
                    'status' => false,
                    'message' => 'The contact not found',
                    'data' => null,
                ]);
                return $errorResponse;
            }

            $contact->update($request->all());
            $response = new ApiResourse([
                'status' => true,
                'message' => 'Contact Updated Successfully',
                'data' => $contact,
            ]);
            return $response;
        } catch (\Exception $e) {
            // Example error response
            $errorResponse = new ApiResourse([
                'status' => false,
                'message' => 'Error occurred',
                'data' => ['error' => $e->getMessage()],
            ]);

            return $errorResponse;
        }
    }
}
