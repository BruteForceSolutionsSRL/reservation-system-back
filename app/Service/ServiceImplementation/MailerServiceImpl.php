<?php

namespace App\Service\ServiceImplementation;

use App\Mail\NotificationMail;
use App\Service\MailerService;

use Illuminate\Mail\Mailable;

use App\Jobs\MailSenderJob;

use App\Mail\{
    AuthNotificationMailer,
    ClassroomNotificationMailer,
	ReservationNotificationMailer,
	BlockNotificationMailer,
	SpecialReservationNotificationMailer
};

use App\Repositories\{
	ReservationStatusRepository as ReservationStatus,
	NotificationTypeRepository,
	PersonRepository
};

class MailerServiceImpl implements MailerService
{
	private $personRepository;
	public function __construct() {
		$this->personRepository = new PersonRepository();
	}
	/**
	 * Queues a mail to send to all addresses
	 * @param Mailable $mail
	 * @param array $addresses
	 * @return void
	 */
	public function sendMail(Mailable $mail, array $addresses): void
	{
		MailSenderJob::dispatch($addresses, $mail);
	}

	/**
	 * Create a Mailable class with data reservation pending
	 * @param array $data
	 * @return array
	 */
	public function createReservation(array $reservation, int $sender): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
            'title' => 'SOLICITUD DE RESERVA #'.$reservation['reservation_id'].' PENDIENTE',
            'body' => 'Se envio la solicitud #'.$reservation['reservation_id'],
            'type' => NotificationTypeRepository::informative(),
            'sendBy' => $this->personRepository->getPerson($sender)['fullname'],
            'to' => [],
			'sended' => 1,
		];
		$this->getPersonsByReservation($emailData, $reservation);

        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));

		$this->sendMail(
			new ReservationNotificationMailer(
				$emailData,
				ReservationStatus::pending()
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Create a Mailable class with data accepted reservation
	 * @param array $data
	 * @return array
	 */
	public function acceptReservation(array $reservation, int $sender): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
			'title' => 'SOLICITUD DE RESERVA #'.$reservation['reservation_id'].' ACEPTADA',
            'body' => 'Se acepto la solicitud #'.$reservation['reservation_id'],
            'type' => NotificationTypeRepository::accepted(),
            'sendBy' => $this->personRepository->getPerson($sender)['fullname'],
			'sended' => 1,
            'to' => []
		];

		$this->getPersonsByReservation($emailData, $reservation);

        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));

		$this->sendMail(
			new ReservationNotificationMailer(
				$emailData,
				ReservationStatus::accepted()
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Create a Mailable class with data rejected reservation
	 * @param array $data
	 * @return array
	 */
	public function rejectReservation(array $reservation, int $sender, string $message): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
			'title' => 'SOLICITUD DE RESERVA #'.$reservation['reservation_id'].' RECHAZADA',
            'body' => 'Se rechazo la solicitud #'.$reservation['reservation_id'].' '.$message,
            'type' => NotificationTypeRepository::rejected(),
            'sendBy' => $this->personRepository->getPerson($sender)['fullname'],
			'sended' => 1,
            'to' => []
		];

		$this->getPersonsByReservation($emailData, $reservation);

        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));

		$this->sendMail(
			new ReservationNotificationMailer(
				$emailData,
				ReservationStatus::rejected()
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Create a Mailable class with data cancelled reservation
	 * @param array $reservation
	 * @return array
	 */
	public function cancelReservation(array $reservation, int $sender, string $message): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
			'title' => 'SOLICITUD DE RESERVA #'.$reservation['reservation_id'].' CANCELADA',
            'body' => 'Se cancelo la solicitud #'.$reservation['reservation_id'].' '.$message,
            'type' => NotificationTypeRepository::cancelled(),
            'sendBy' => $this->personRepository->getPerson($sender)['fullname'],
			'sended' => 1,
            'to' => []
		];

		$this->getPersonsByReservation($emailData, $reservation);
        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));

		$this->sendMail(
			new ReservationNotificationMailer(
				$emailData,
				ReservationStatus::cancelled()
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Create a Mailable class with data rejected special reservation
	 * @param array $reservation
	 * @return array
	 */
	public function specialRejectReservation(array $reservation, int $sender, string $message): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
			'title' => 'SOLICITUD DE RESERVA ESPECIAL #'.$reservation['reservation_id'].' RECHAZADA',
            'body' => 'Se acepto la solicitud especial #'.$reservation['reservation_id'].' '.$message,
            'type' => NotificationTypeRepository::rejected(),
            'sendBy' => $this->personRepository->getPerson($sender)['fullname'],
			'sended' => 1,
            'to' => []
		];

		$this->getPersonsBySpecialReservation($emailData, $reservation);

        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));

		$this->sendMail(
			new SpecialReservationNotificationMailer(
				$emailData,
				ReservationStatus::rejected()
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Create a Mailable class with data accepted special reservation
	 * @param array $reservation
	 * @return array
	 */
	public function specialAcceptReservation(array $reservation, int $sender): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
			'title' => 'SOLICITUD DE RESERVA ESPECIAL #'.$reservation['reservation_id'].' ACEPTADA',
            'body' => 'Se acepto la solicitud especial #'.$reservation['reservation_id'],
            'type' => NotificationTypeRepository::accepted(),
            'sendBy' => $this->personRepository ->getPerson($sender)['fullname'],
			'sended' => 1,
            'to' => []
		];

		$this->getPersonsBySpecialReservation($emailData, $reservation);

        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));

		$this->sendMail(
			new SpecialReservationNotificationMailer(
				$emailData,
				ReservationStatus::accepted()
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Create a Mailable class with data cancelled special reservation
	 * @param array $reservation
	 * @return array
	 */
	public function specialCancelReservation(array $reservation, int $sender): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
			'title' => 'SOLICITUD DE RESERVA ESPECIAL #'.$reservation['reservation_id'].' CANCELADA',
            'body' => 'Se cancelo la solicitud especial #'.$reservation['reservation_id'],
            'type' => NotificationTypeRepository::cancelled(),
            'sendBy' => $this->personRepository->getPerson($sender)['fullname'],
			'sended' => 1,
            'to' => []
		];

		$this->getPersonsBySpecialReservation($emailData, $reservation);

        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));

		$this->sendMail(
			new SpecialReservationNotificationMailer(
				$emailData,
				ReservationStatus::cancelled()
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Notificate a re-assignation for a single reservation
	 * @param array $data
	 * @return array
	 */
	public function reassingReservation(array $reservation, int $sender): array
	{
		$this->personRepository = new PersonRepository();
		$emailData = [
			'title' => 'CAMBIO DE AMBIENTES PARA LA SOLICITUD DE RESERVA #'.$reservation['reservation_id'],
            'body' => 'Se realizo la reasignacion de ambientes a la solicitud #'.$reservation['reservation_id'].', para mas informacion sobre la razon de cambio contactar con el encargado.',
            'type' => NotificationTypeRepository::warning(),
            'sendBy' => $this->personRepository->getPerson($sender)['fullname'],
            'to' => [],
			'sended' => 1,
		];

		$this->getPersonsByReservation($emailData, $reservation);
        $emailData = array_merge($emailData, $reservation);
		$addresses = $this->getAddresses($emailData['to']);
		$emailData['to'] = array_unique(array_map(
			function ($user)
			{
				return $user['person_id'];
			},
			$emailData['to']
		));
		$this->sendMail(
			new ReservationNotificationMailer(
				$emailData,
				-1
			),
			$addresses
		);
		$emailData['sendBy'] = $sender;
		return $emailData;
	}

	/**
	 * Function to send an email with a link to recover the password to the user
	 * @param array $data
	 * @return array
	 */
	public function sendResetPassword(array $data): array
	{
		$systemId = personRepository::system();
		//$url = route('password.reset', ['token' => $data['token']]);
		$url = env('FRONTEND_URL').$data['token'];
		$emailData = [
			'title' => 'RECUPERACION DE CONTRASEÑA',
            'body' => 'Ingrese al siguiente link, para registrar una nueva contraseña',
			'url' => $url,
            'type' => NotificationTypeRepository::warning(),
            'sendBy' => $this->personRepository->getPerson($systemId)['person_name'],
            'to' => [$data['email']],
			'sended' => 1,
		];
		$this->sendMail(
			new AuthNotificationMailer($emailData),
			$emailData['to']
		);
		return $emailData;
	}

	/**
	 * Create a Mailable class with data
	 * @param array $data
	 * @return void
	 */
	public function sendSimpleEmail($data): void
	{
		$addresses = $this->getAddresses($data['to']);
		$this->sendMail(
			new NotificationMail($data),
			$addresses
		);
	}

	/**
	 * Create a Mailable class with data for creation
	 * @param array $data
	 * @return void
	 */
	public function sendCreationClassroomEmail(array $data): void
	{
		$this->sendMail(
			new ClassroomNotificationMailer($data, 1),
			$this->getAddresses($data['to'])
		);
	}

	/**
	 * Create a Mailable class with data for update
	 * @param array $data
	 * @return void
	 */
	public function sendUpdateClassroomEmail(array $data): void
	{
		$this->sendMail(
			new ClassroomNotificationMailer($data, 3),
			$this->getAddresses($data['to'])
		);
	}

	/**
	 * Create a Mailable class with data for delete
	 * @param array $data
	 * @return void
	 */
	public function sendDeleteClassroomEmail(array $data): void
	{
		$this->sendMail(
			new ClassroomNotificationMailer($data, 2),
			$this->getAddresses($data['to'])
		);
	}

	/**
	 * Create a Mailable class with data for creation
	 * @param array $data
	 * @return void
	 */
	public function sendCreationBlockEmail(array $data): void
	{
		$this->sendMail(
			new BlockNotificationMailer($data, 1),
			$this->getAddresses($data['to'])
		);
	}

	/**
	 * Create a Mailable class with data for update
	 * @param array $data
	 * @return void
	 */
	public function sendUpdateBlockEmail(array $data): void
	{
		$this->sendMail(
			new BlockNotificationMailer($data, 3),
			$this->getAddresses($data['to'])
		);
	}

	/**
	 * Create a Mailable class with data for delete
	 * @param array $data
	 * @return void
	 */
	public function sendDeleteBlockEmail(array $data): void
	{
		$this->sendMail(
			new BlockNotificationMailer($data, 2),
			$this->getAddresses($data['to'])
		);
	}

	/**
	 * Retrieve a persons formatted by single reservation
	 * @param array $emailData
	 * @param array $reservation
	 * @return void
	 */
	private function getPersonsByReservation(array &$emailData, array $reservation): void
	{
		foreach ($reservation['persons'] as $person)
			array_push($emailData['to'], $person);
	}

	/**
	 * Retrieve a persons formatted for special reservations
	 * @param array $emailData
	 * @param array $reservation
	 * @return void
	 */
	private function getPersonsBySpecialReservation(array &$emailData, array $reservation): void
	{
		$this->getPersonsByReservation($emailData, $reservation);
	}

	/**
	 * Retrieve a list of addresses
	 * @param array $data
	 * @return array
	 */
	private function getAddresses($data): array
	{
		$addresses = [];

		for ($i = 0; $i<count($data); $i++){
			array_push($addresses, $data[$i]['email']);
		}

		return array_unique($addresses);
	}
}
