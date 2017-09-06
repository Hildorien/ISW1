<?php
/*
 * Developed by 10Pines SRL
 * License: 
 * This work is licensed under the 
 * Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ 
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
 * California, 94041, USA.
 *  
 */

require_once '../clases.php';
require_once '../CustomerBook.php';


class IdiomTest extends PHPUnit_Framework_TestCase {
	
    protected $customerBook;
    protected $stopwatch;
    protected $measureDurationOf; 
    protected $checkIfDurationIsLowerThanXMilliseconds;
    protected $measureDurationAndCheckIfIsLowerThanXMilliseconds;

    public function setUp(){
        $this->customerBook = new CustomerBook();
        $this->stopwatch = new Stopwatch();
        
        $this->measureDurationOf = function ($event) {
            $this->stopwatch->start();
            $event();
            $durationInMilliseconds = $this->stopwatch->stop();
            return $durationInMilliseconds;
        };
        
        $this->checkIfDurationIsLowerThanXMilliseconds = function ($durationInMilliseconds, $X) {
            return $durationInMilliseconds < $X;
        };

        $this->measureDurationAndCheckIfIsLowerThanXMilliseconds = function ($event, $X) {
            $durationInMilliseconds = ($this->measureDurationOf)($event);
            $eventTookLessThanXMilliseconds = ($this->checkIfDurationIsLowerThanXMilliseconds)($durationInMilliseconds, $X);
            return $eventTookLessThanXMilliseconds;
        };
    }
    
    public function testAddingCustomerShouldNotTakeMoreThan50Milliseconds(){

        $addCustomerNamedJohnLennon = function() {$this->customerBook->addCustomerNamed('John Lennon');};

        $addCustomerTookLessThan50Milliseconds = ($this->measureDurationAndCheckIfIsLowerThanXMilliseconds)($addCustomerNamedJohnLennon, 50);
        
        $this->assertTrue($addCustomerTookLessThan50Milliseconds);
    }

    public function testRemovingCustomerShouldNotTakeMoreThan100Milliseconds(){
        
        $paulMcCartney = 'Paul McCartney';
        
        $this->customerBook->addCustomerNamed($paulMcCartney);

        $removeCustomerNamedPaulMcCartney = function() {$this->customerBook->removeCustomerNamed('Paul McCartney');};
        
        $removeCustomerTookLessThan100Milliseconds = ($this->measureDurationAndCheckIfIsLowerThanXMilliseconds)($removeCustomerNamedPaulMcCartney, 100);

        $this->assertTrue($removeCustomerTookLessThan100Milliseconds);
    }
	
    public function testCanNotAddACustomerWithEmptyName (){

        try {
            $this->customerBook->addCustomerNamed("");
            $this->fail();
        } catch (RuntimeException $exception) {
            $this->assertEquals($exception->getMessage(),CustomerBook::CUSTOMER_NAME_EMPTY);
            $this->assertTrue($this->customerBook->isEmpty());
        }
    }

    public function testCanNotRemoveNotAddedCustomers (){

        try {
            $this->customerBook->removeCustomerNamed("John Lennon");
            $this->fail();
        } catch (InvalidArgumentException $exception) {
            $this->assertEquals($exception->getMessage(),CustomerBook::INVALID_CUSTOMER_NAME);
            $this->assertEquals(0,$this->customerBook->numberOfCustomers());
        }
    }
 
}