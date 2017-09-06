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
class CustomerBook {

    const CUSTOMER_NAME_EMPTY = "Customer name can not be empty";
    const CUSTOMER_ALREADY_EXISTS = "Customer already exists";
    const INVALID_CUSTOMER_NAME = "Invalid customer name";

    private $customerNames = array();

    public function addCustomerNamed($name) {
        if (empty($name)) throw new RuntimeException(self::CUSTOMER_NAME_EMPTY);
        if ($this->containsCustomerNamed($name)) throw new RuntimeException (self::CUSTOMER_ALREADY_EXISTS);

        array_push($this->customerNames,$name);
    }

    public function isEmpty() {
        return empty($this->customerNames);
    }

    public function numberOfCustomers() {
        return count($this->customerNames);
    }

    public function containsCustomerNamed($name) {
        return in_array($name,$this->customerNames);
    }

    public function removeCustomerNamed($name) {
        $key = array_search($name, $this->customerNames);
        if ($key===FALSE) throw new InvalidArgumentException(self::INVALID_CUSTOMER_NAME);

        unset($this->customerNames[$key]);
    }
}

