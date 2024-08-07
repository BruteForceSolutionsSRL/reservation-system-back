<?php
namespace App\Repositories; 

use App\Models\BlockLog;

class BlockLogRepository
{
	protected $model; 

	private $blockStatusRepository; 

	public function __construct() 
	{
		$this->model = BlockLog::class;
		$this->blockStatusRepository = new BlockStatusRepository();
	}

	public function formatOutput($blockLog) 
	{
		if (!$blockLog) return [];
        return [
            'block_id' => $blockLog->block_id, 
            'name' => $blockLog->name, 
            'maxfloor' => $blockLog->max_floor, 
            'maxclassrooms' => $blockLog->max_classrooms,
			'block_status_name' => $blockLog->block_status_name,
            'block_status_id' => $this->blockStatusRepository->findByName(
            	$blockLog->block_id
            )['id'], 
		];
	}
}