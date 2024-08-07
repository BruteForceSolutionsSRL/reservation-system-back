<?php
namespace App\Service;
interface TeacherSubjectService
{
    function getTeachersBySubjectId(int $universitySubjectID): array; 
    function getSubjectsByTeacherId(int $teacherID): array;
    function saveGroup(array $data): array;
}