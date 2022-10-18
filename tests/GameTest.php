<?php declare(strict_types=1);

namespace App\Test;

use App\Game;
use PHPUnit\Framework\TestCase;

class GameTest extends TestCase
{
    public function testGutterGame()
    {
        $g = new Game();

        for($i = 0; $i < 20; $i++) {
            $g->roll(0);
        }

        $this->assertEquals(0, $g->score());
    }

    public function testAllOnes()
    {
        $g = new Game();

        for($i = 0; $i < 20; $i++) {
            $g->roll(1);
        }

        $this->assertEquals(20, $g->score());
    }
}