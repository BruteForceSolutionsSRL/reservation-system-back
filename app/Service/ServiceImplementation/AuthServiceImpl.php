<?php
namespace App\Service\ServiceImplementation;

use App\Repositories\PersonRepository;
use App\Service\AuthService;

use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\{
    JWTException,
    TokenInvalidException,
    TokenExpiredException
};

use Illuminate\Support\Facades\{
    Auth,
    Validator
};

use Exception;

class AuthServiceImpl implements AuthService
{
    private $notificationService;
    private $mailService;
    private $personRepository;
    private $personService;

    public function __construct()
    {
        $this->notificationService = new NotificationServiceImpl();
        $this->mailService = new MailerServiceImpl();

        $this->personRepository = new PersonRepository();
        $this->personService = new PersonServiceImpl();
    }

    /**
     * Function to register a new user with personal data
     * @param array $data
     * @return array
     */
    public function store(array $data): array
    {
        return $this->personService->store($data);
    }

    /**
     * Function to recover password of an person
     * @param array $data
     * @return array
     */
    public function resetPassword(array $data): array
    {
        $person = $this->personService->getUserByEmail($data['email']);
        $token = JWTAuth::claims(['type' => 'access'])->fromUser($person);
        $data['token'] = $token;
        $this->mailService->sendResetPassword($data);
        return ['message' => 'Se le envio un correo para que pueda recuperar su contraseña'];
    }

    /**
     * Function to change the password of the authenticated person
     * @param array $data
     * @return array
     */
    public function changePassword(array $data): array
    {
        return $this->personRepository->changePassword($data);
    }
}