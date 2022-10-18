<?php declare(strict_types=1);

namespace App\Test;

use App\Game;
use PHPUnit\Framework\TestCase;

class GameTest extends TestCase
{
    private $g;

    public function setUp(): void
    {
        $this->g = new Game();
    }

    public function testGutterGame()
    {
        for($i = 0; $i < 20; $i++) {
            $this->g->roll(0);
        }

        $this->assertEquals(0, $this->g->score());
    }

    public function testAllOnes()
    {
        for($i = 0; $i < 20; $i++) {
            $this->g->roll(1);
        }

        $this->assertEquals(20, $this->g->score());
    }
}