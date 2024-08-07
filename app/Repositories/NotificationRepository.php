<?php
namespace App\Repositories; 

use App\Models\{
	Notification,
	NotificationPerson
};

use App\Repositories\{
	PersonRepository
};

use Carbon\Carbon;

use Illuminate\Support\Facades\DB;

class NotificationRepository 
{
	protected $model; 

	private $personRepository; 
	private $notificationTypeRepository;

	public function __construct() 
	{
		$this->model = Notification::class;
		
		$this->personRepository = new PersonRepository(); 
		$this->notificationTypeRepository = new NotificationTypeRepository();
	}

	/**
	 * Retrieve a single notification to a user 
	 * @param int $id
	 * @param int $personId
	 * @return array
	 */
	public function getNotification(int $id, int $personId): array 
	{
		$notification = $this->model::find($id); 

		$notificationPerson = NotificationPerson::where('notification_id', $id)
			->where('person_id', $personId)
			->first();
		if (!$notificationPerson) 
			return []; 
		$notificationPerson->readed = 1; 
		$notificationPerson->save();

		return $this->formatOutput($notification);
	}

	/**
	 * Retrieve all notifications inbox by person id
	 * @param int $personId
	 * @return array
	 */
	public function getNotifications(int $personId): array
	{
		return $this->model::whereHas('receptors', 
			function ($query) use ($personId) 
			{
				$query->where('person_notification.person_id', $personId);
			}
		)->get()->map(
			function ($notification) 
			{
				return $this->formatOutput($notification);
			}
		)->toArray();
	}

	/**
	 * Save data for notification file
	 * @param array $data
	 * @return array
	 */
	public function save(array $data): array
	{
		$notification = new Notification(); 
		$notification->title = $data['title']; 
		$notification->description = $data['body'];
		$notification->notification_type_id = $data['type']; 
		$notification->person_id = $data['sendBy'];
		$notification->save(); 
		if (is_array($data['to']))
			$data['to'] = array_unique($data['to']);
		else 
			$data['to'] = array_unique($data['to']->toArray());
		$notification->receptors()->attach($data['to']);
		return $this->formatOutput($notification);
	}

	/**
	 * Update a single notification by its ID
	 * @param array $data
	 * @param int $notificationId
	 * @return array
	 */
	public function update(array $data, int $notificationId): array
	{
		$notification = $this->model::find($notificationId); 
		$notification->title = $data['title']; 
		$notification->description = $data['body'];
		$notification->type = $data['type']; 
		$notification->save();

		return $this->formatOutput($notification);
	} 

	/**
	 * Transform notification to array
	 * @param Notification $notification
	 * @return array
	 */
	private function formatOutput($notification): array 
	{
		if ($notification === null) return [];
		$transmissor = $this->personRepository
			->getPerson($notification->person_id); 
		
		$notificationType = $this->notificationTypeRepository
			->getNotificationType(
				$notification->notification_type_id
			);
		
		$receptors = $notification->receptors;

		$carbon = Carbon::parse($notification->created_at);
        $carbon->setTimeZone('America/New_York');

		$date = $carbon->format('Y-m-d');
		$hour = $carbon->format('H');
		$minutes = $carbon->format('i');

		$result = [
			'notification_id' => $notification->id,
			'title' => $notification->title, 
			'type' => $notificationType['name'], 
			'sendBy' => $transmissor['fullname'], 
			'to' => $receptors->map(
				function ($user) use ($notification)
				{
					$person = DB::table('person_notification')
						->where('notification_id', $notification->id)
						->where('person_id', $user->id)
						->get()
						->first(); 
					
					return array_merge(
						$this->personRepository->formatOutput($user), 
						['readed' => $person->readed]
					);
				}
			), 
			'body' => $notification->description, 
			'hour' => $hour, 
			'minutes' => $minutes,
			'date' => $date,
		];

		$title = $notification->title; 
		$reservationID = '';
		$i = 0; 
		while ($i < strlen($title) && $title[$i]!='#') $i += 1;
		$i+=1;
		while ($i < strlen($title) && $title[$i]>='0' && $title[$i]<='9') {
			$reservationID .= $title[$i]; 
			$i+=1;
		}
		if ($reservationID != '') {
			$pos = strpos($title, 'RESERVA'); 
			if ($pos === false) {
				$pos = strpos($title, 'AMBIENTE'); 
				if ($pos === false) {
					$result['block_id'] = intval($reservationID); 
				} else {
					$result['classroom_id'] = intval($reservationID);
				}
			} else {
				$result['reservation_id'] = intval($reservationID);
			}
		}
		return $result;
	}
}