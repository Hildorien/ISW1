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

require_once '../Stopwatch.php';
require_once '../CustomerBook.php';

class IdiomTest extends PHPUnit_Framework_TestCase {
	
    protected $customerBook;
    protected $stopwatch;
    protected $measureDurationOf; 
    protected $checkIfEventDurationIsLowerThanXMilliseconds;
    protected $runInvalidEventAndFailIfExceptionIsNotThrown;
    protected $validateExceptionName;
    protected $validateExceptionMessage;
    protected $validateThatCustomerBookHasNotChanged;
    protected $tryInvalidEventAndVerifyExceptionAndCustomerBook;

    public function setUp(){
        $this->customerBook = new CustomerBook();
        $this->stopwatch = new Stopwatch();
        
        $this->measureDurationOf = function ($event) {
            $this->stopwatch->start();
            $event();
            $durationInMilliseconds = $this->stopwatch->stop();
            return $durationInMilliseconds;
        };
        
        $this->checkIfEventDurationIsLowerThanXMilliseconds = function ($event, $X) {
            $eventDurationInMilliseconds = ($this->measureDurationOf)($event); 
            return $eventDurationInMilliseconds < $X;
        };

        $this->runInvalidEventAndFailIfExceptionIsNotThrown = function ($invalidEvent) {
            $invalidEvent();
            $this->fail();
        };

        $this->validateExceptionName = function ($exception, $exceptionName) {
            $this->assertEquals($exceptionName, get_class($exception));
        };

        $this->validateExceptionMessage = function ($exception, $exceptionMessage) {
            $this->assertEquals($exception->getMessage(),$exceptionMessage);            
        };

        $this->validateThatCustomerBookHasNotChanged = function ($customerBookAssertion) {
            $customerBookAssertion();
        };

        $this->tryInvalidEventAndVerifyExceptionAndCustomerBook = function ($invalidEvent, $exceptionName, $exceptionMessage, $customerBookAssertion) {
            try {
                ($this->runInvalidEventAndFailIfExceptionIsNotThrown)($invalidEvent);
            } catch (Exception $exception) {
                ($this->validateExceptionName)($exception, $exceptionName);
                ($this->validateExceptionMessage)($exception, $exceptionMessage);
                ($this->validateThatCustomerBookHasNotChanged)($customerBookAssertion);
            }
        };
    }
    
    public function testAddingCustomerShouldNotTakeMoreThan50Milliseconds(){

        $addCustomerNamedJohnLennon = function() {$this->customerBook->addCustomerNamed('John Lennon');};

        $addCustomerTookLessThan50Milliseconds = ($this->checkIfEventDurationIsLowerThanXMilliseconds)($addCustomerNamedJohnLennon, 50);
        
        $this->assertTrue($addCustomerTookLessThan50Milliseconds);
    }

    public function testRemovingCustomerShouldNotTakeMoreThan100Milliseconds(){
        
        $paulMcCartney = 'Paul McCartney';
        
        $this->customerBook->addCustomerNamed($paulMcCartney);

        $removeCustomerNamedPaulMcCartney = function() {$this->customerBook->removeCustomerNamed('Paul McCartney');};
        
        $removeCustomerTookLessThan100Milliseconds = ($this->checkIfEventDurationIsLowerThanXMilliseconds)($removeCustomerNamedPaulMcCartney, 100);

        $this->assertTrue($removeCustomerTookLessThan100Milliseconds);
    }
	
    public function testCanNotAddACustomerWithEmptyName (){

        $addCustomerWithEmptyName = function () {$this->customerBook->addCustomerNamed("");};
        
        $assertIfCustomerBookIsEmpty = function () {return $this->assertTrue($this->customerBook->isEmpty());};
                
        ($this->tryInvalidEventAndVerifyExceptionAndCustomerBook)($addCustomerWithEmptyName,'RuntimeException', CustomerBook::CUSTOMER_NAME_EMPTY, $assertIfCustomerBookIsEmpty);
    }

    public function testCanNotRemoveNotAddedCustomers (){

        $removeNotAddedCustomer = function () {$this->customerBook->removeCustomerNamed("John Lennon");};
        
        $assertIfNumberOfCustomersIsZero = function () {$this->assertEquals(0,$this->customerBook->numberOfCustomers());};
                
        ($this->tryInvalidEventAndVerifyExceptionAndCustomerBook)($removeNotAddedCustomer,'InvalidArgumentException', CustomerBook::INVALID_CUSTOMER_NAME, $assertIfNumberOfCustomersIsZero);
    }
 
}