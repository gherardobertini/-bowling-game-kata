<?php declare(strict_types=1);

namespace App;

class Game
{
    private $rolls = [];
    private $currentRoll = 0;

    public function roll(int $pins): void
    {
        $this->rolls[$this->currentRoll++] = $pins;
    }

    public function score(): int
    {
        $score = 0;
        for ($i = 0; $i < count($this->rolls); $i++) {
            $score += $this->rolls[$i];
        }
        return $score;
    }
}