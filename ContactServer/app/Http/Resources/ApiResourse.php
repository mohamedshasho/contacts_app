<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ApiResourse extends JsonResource
{

    public function toArray($request)
    {
        return [
            'status' => $this->resource['status'],
            'message' => $this->resource['message'],
            'data' => $this->resource['data'],
        ];
    }
}
