<?php
namespace App\Service\ServiceImplementation; 

use App\Repositories\ConstantRepository;

class ConstantServiceImpl  
{
	private $constantRepository; 

	public function __construct() {
		$this->constantRepository = new ConstantRepository(); 
	}

	/**
	 * Retrieve a status for constant 'AUTOMATIC_RESERVATIONS'
	 * @return array
	 */
	public function getAutomaticReservationConstant(): array
	{
		return [
			'status' => $this->constantRepository->getAutomaticReservation()
		]; 
	}

	/**
	 * Retrieve a status for constant 'MAXIMAL_RESERVATIONS_PER_GROUP'
	 * @return array
	 */
	public function getMaximalReservationPerGroup(): array
	{
		return [
			'status' => $this->constantRepository->getMaximalReservationPerGroup()
		];
	}

	/**
	 * Update constant 'AUTOMATIC_RESERVATIONS'
	 * @return void
	 */
	public function updateAutomaticReservation(): void
	{
		$this->constantRepository->updateAutomaticReservation(); 
	}

	/**
	 * Update constant 'MAXIMAL_RESERVATION_PER_GROUP'
	 * @param array $data
	 * @return void
	 */
	public function updateMaximalReservationPerGroup(array &$data): void
	{
		$this->constantRepository->updateMaximalReservationPerGroup($data);
	}

}