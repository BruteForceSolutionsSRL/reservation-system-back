<?php
namespace App\Repositories; 

use App\Models\Person;

use Illuminate\Cache\Repository; 

use Illuminate\Support\Facades\DB;

class PersonRepository extends Repository
{
    protected $model; 

    public static function system()
    {
        return Person::where('name', 'SISTEMA')
            ->get()
            ->pop()
            ->id;
    }

    public function __construct()
    {
        $this->model = Person::class;
    }

    /**
     * Store a new person
     * @param array $data
     * @return array
     */
    public function store(array $data): array 
    {
        $person = new $this->model;
        $person->name = $data['name'];
        $person->last_name = $data['last_name']; 
        $person->user_name = $data['user_name']; 
        $person->email = $data['email'];
        $person->password = bcrypt($data['password']);
        $person->save();
        return $this->formatOutput($person);
    }

    /**
     * Retrieve a Person by its ID
     * @param int $personId
     * @return array
     */
    public function getPerson(int $personId): array 
    {
        $person = $this->model::find($personId); 
        if ($person === null) return [];
        return $this->formatOutput($person); 
    }

    /**
     * Retrieve a Person by its email
     * @param string $email
     * @return mixed
     */
    public function getPersonByEmail(string $email) 
    {
        $person = $this->model::firstWhere('email',$email); 
        if ($person === null) return null;
        return $person; 
    }

    /**
     * Retrieve all users
     * @param none
     * @return array
     */
    public function getAllPersons(): array
    {
        return $this->model::where('id', '!=', $this->system())
            ->get()->map(
                function ($person) 
                {
                    return $this->formatOutput($person);
                }
            )->toArray();
    }

    /**
     * Retrieve a list of users based on roles specified
     * @param array $roles
     * @return array
     */
    public function getUsersByRole(array $roles): array 
    {
        return $this->model::whereHas('roles', 
            function ($query) use ($roles) 
            {
                $query->whereIn('roles.id', $roles);
                /* foreach ($roles as $rol)
                    $query->orWhere('roles.id', $rol); */
            }
        )->where('id', '!=', $this->system())
        ->get()->map(
            function ($user) 
            {
                return $this->formatOutput($user);
            }
        )->toArray();
    }

    /**
	 * Retrieve all permissions of a person
	 * @param array $data
	 * @return bool
	 */
	public function havePermission(array $data):bool 
	{
        $permissions = DB::table('permissions')
            ->join('role_permission', 'permissions.id', '=', 'role_permission.permission_id')
            ->join('roles', 'role_permission.role_id', '=', 'roles.id')
            ->join('person_role', 'roles.id', '=', 'person_role.role_id')
            ->join('people', 'person_role.person_id', '=', 'people.id')
            ->where('people.id', $data['person_id'])
            ->whereIn('permissions.name', $data['permissions'])
            ->select('permissions.name')
            ->distinct()
            ->get()
            ->toArray();
        return !empty($permissions);
	}

    /**
	 * Retrieve a list of roles a person has through a person ID
	 * @param int $personId
	 * @return array
	 */
	public function getRoles(int $personId):array 
	{
		$person = $this->model::find($personId); 
        if ($person === null) return [];
        return $person->roles()->pluck('name')->toArray();
	}

    /**
     * Retrieve the person correspond for a single group
     * @param int $teacherSubject
     * @return array
     */
    public function getTeachersBySubjectGroups(array $teacherSubjectIds): array 
    {
        return $this->model::whereHas('teacherSubjects', 
                function ($query) use ($teacherSubjectIds)
                {
                    $query->whereIn('id', $teacherSubjectIds);
                }
            )->get()->map(
                function ($person) use ($teacherSubjectIds)
                {
                    $personFormatted = $this->formatOutput($person);
                    $personFormatted['teacher_subject_ids'] = []; 
                    foreach ($person->teacherSubjects as $teacherSubject) {
                        if (in_array($teacherSubject->id, $teacherSubjectIds)) {
                            array_push($personFormatted['teacher_subject_ids'], $teacherSubject->id);
                        }
                    }
                    return $personFormatted;
                }
            )->toArray();
    }

    /**
     * Update a single information 
     * @param array $data
     * @return array
     */
    public function update(array $data, int $personId): array 
    {
        $person = $this->model::find($personId); 
        if (array_key_exists('user_name', $data)) {
            $person->user_name = $data['user_name'];
        }
        if (array_key_exists('email', $data)) {
            $person->email = $data['email'];
        }
        if (array_key_exists('name', $data)) {
            $person->name = $data['name'];
        }
        if (array_key_exists('last_name', $data)) {
            $person->last_name = $data['last_name'];
        }
        $person->save();

        if (array_key_exists('role_ids', $data)) {
            $person->roles()->sync([]);
            $person->roles()->attach($data['role_ids']);
            $person->save();
        }

        return $this->formatOutput($person);
    }

    /**
     * Update all data of a person by ID
     * @param array $data
     * @return array
     */
    public function changePassword(array $data): array
    {   
        $person = $this->model::find($data['session_id']);

        if (!empty($data['new_password'])) {
            $person->password = bcrypt($data['new_password']);
        }

        $person->save();
        return $this->formatOutput($person);
    }   
    
    /**
     * Transform Person to array
     * @param Person $person
     * @return array
     */
    public function formatOutput($person): array
    {
        return [
            'person_id' => $person->id,
            'user_name' => $person->user_name, 
            'name' => $person->name, 
            'lastname' => $person->last_name, 
            'email' => $person->email, 
            'fullname' => $person->name.' '.$person->last_name,
            'roles' => $this->getRoles($person->id)
        ]; 
    }
}