<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ContactRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'email' => 'nullable|email',
            'phone' => 'required|integer',
        ];
    }

    public function messages()
    {
        return [
            'email.email' => "The email must be a valid email address.",
            'phone.required' => "The phone number mustn't be empty.",
            'phone.integer' => "The phone number must be an integer.",
        ];
    }

    public function validated($key = null, $default = null)
    {
        return [
            'phone'  =>  $this->phone,
        ];
    }
}
