<?php declare(strict_types=1);

namespace App;

class Game
{
    private $score = 0;

    public function roll(int $pins): void
    {
        $this->score += $pins;
    }

    public function score(): int
    {
        return $this->score;
    }
}