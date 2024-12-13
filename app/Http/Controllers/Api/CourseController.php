<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Course;

class CourseController extends Controller
{
    public function courseList(){
        try{
        $result = Course::select('name', 'thumbnail', 'lesson_num', 'price', 'id')->get();

        return response()->json([
            'code' => 200,
                'msg' => 'My course list is here',
                'data' => $result
        ], 200);
        }catch(\throwable $throw){
            return response()->json([
                'code'=>500,
                'msg'=> 'the Column error',
                'data'=> $throw->getMessage(),
            ],500);
        }
    }

    public function courseDetail(Request $request){
        $id = $request->id;

        try{
        $result = Course::where('id', '=', $id)->select(
            'id',
            'name', 
            'user_token',
            'description',
            'price',
            'lesson_num',
            'video_length',
            'thumbnail', 
            'price',
            'downloadable_res'
           
            )
            ->first();

        return response()->json([
            'code' => 200,
                'msg' => 'My course detail is here',
                'data' => $result
        ], 200);
        }catch(\throwable $throw){
            return response()->json([
                'code'=>500,
                'msg'=> 'the Column error',
                'data'=> $throw->getMessage(),
            ],500);
        }
    }
}
