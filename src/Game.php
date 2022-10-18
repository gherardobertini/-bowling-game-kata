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
        $i = 0;
        for ($frame = 0; $frame < 10; $frame++) {
            $score += $this->rolls[$i] + $this->rolls[$i + 1];
            $i += 2;
        }
        return $score;
    }
}