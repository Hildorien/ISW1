<?php

class Stopwatch {

    protected $timeStart;
    protected $timeStop;  

    public function start() {
        $this->timeStart = round(microtime(true) * 1000);
    }

    public function stop() {
        $this->timeStop = round(microtime(true) * 1000);
        return $this->timeStop - $this->timeStart;
    }
}

?>