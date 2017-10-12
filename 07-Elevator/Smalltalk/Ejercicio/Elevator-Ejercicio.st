!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #Cabin category: #'Elevator-Ejercicio'!
Object subclass: #Cabin
	instanceVariableNames: 'door floorNumber state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 20:51:51'!
changeFloorNumber

	floorNumber := floorNumber + 1! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:12:55'!
closedDoor

	door close .
	state := state transitionToMoving.! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:03:05'!
closingDoor

	door closing! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 13:43:23'!
closingDoorIfStopped

	state clossingDoorIfStopped: self! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:43:14'!
floorNumber

	^ floorNumber! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:56:25'!
initialize

	door := Door new .
	floorNumber := 0 .
	state := Stopped new .! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:53:38'!
isDoorClosing

	^ door isClosing! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:41:08'!
isDoorOpened

	^ door isOpened! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:52:14'!
isDoorOpening

	^ door isOpening! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:56:53'!
isMoving

	^ state isMoving ! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:57:10'!
isStopped

	^ state isStopped ! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 11:50:36'!
openedDoor

	door opened! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:28:35'!
openedDoorIfStopped

	state openedDoorIfStopped: self! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 11:52:03'!
openingDoor

	door opening! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:28:57'!
openingDoorIfStopped

	state openingDoorIfStopped: self! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:14:27'!
stop

	state := state transitionToStopped .
	door opening .! !


!Cabin methodsFor: 'copying' stamp: 'MC 10/11/2017 18:54:44'!
isDoorClosed
	
	^ door isClosed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cabin class' category: #'Elevator-Ejercicio'!
Cabin class
	instanceVariableNames: ''!

!Cabin class methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:32:56'!
new

	^ super new initialize! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:38:52'!
isMoving
	
	^ false! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:39:03'!
isStopped
	
	^ false! !


!classDefinition: #Moving category: #'Elevator-Ejercicio'!
CabinState subclass: #Moving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Moving methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 13:43:46'!
clossingDoorIfStopped: aCabin 

	"do nothing"! !

!Moving methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:41:09'!
isMoving

	^ true! !

!Moving methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:10:43'!
openedDoorIfStopped: aCabin 
	
	"do nothing"! !

!Moving methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:10:59'!
openingDoorIfStopped: aCabin 
	
	"do nothing"! !

!Moving methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 17:08:45'!
transitionToMoving
	
	^ self! !

!Moving methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:15:07'!
transitionToStopped

	^ Stopped new! !


!classDefinition: #Stopped category: #'Elevator-Ejercicio'!
CabinState subclass: #Stopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Stopped methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 13:49:14'!
clossingDoorIfStopped: aCabin 

	aCabin closingDoor ! !

!Stopped methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:40:23'!
isStopped

	^ true! !

!Stopped methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:09:54'!
openedDoorIfStopped: aCabin 

	aCabin openedDoor! !

!Stopped methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:10:11'!
openingDoorIfStopped: aCabin 

	aCabin openingDoor! !

!Stopped methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:14:00'!
transitionToMoving

	^ Moving new! !


!classDefinition: #Door category: #'Elevator-Ejercicio'!
Object subclass: #Door
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:11:49'!
close

	state := state transitionToClosed! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:03:45'!
closing

	state := state transitionToClosing! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:20:04'!
initialize

	state := Opened new! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:57:33'!
isClosed

	^ state isClosed! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:57:42'!
isClosing

	^ state isClosing! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:43:24'!
isOpened

	^ state isOpened! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:57:56'!
isOpening

	^ state isOpening ! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:04:37'!
opened

	state := state transitionToOpened! !

!Door methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:15:31'!
opening

	state := state transitionToOpening! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Door class' category: #'Elevator-Ejercicio'!
Door class
	instanceVariableNames: ''!

!Door class methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:34:34'!
new 

	^ super new initialize! !


!classDefinition: #DoorState category: #'Elevator-Ejercicio'!
Object subclass: #DoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:42:36'!
closeTransition

	self subclassResponsibility ! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:38:12'!
isClosed

	^ false! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:38:21'!
isClosing

	^ false! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:37:45'!
isOpened

	^ false! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:37:56'!
isOpening

	^ false! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:42:23'!
openTransition

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DoorState class' category: #'Elevator-Ejercicio'!
DoorState class
	instanceVariableNames: ''!

!DoorState class methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 17:07:33'!
desynchronizedDoorSensorErrorDescription

	^ 'Sensor de puerta desincronizado' ! !


!classDefinition: #Closed category: #'Elevator-Ejercicio'!
DoorState subclass: #Closed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Closed methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:41:39'!
isClosed

	^ true! !

!Closed methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 17:11:36'!
transitionToClosed
	
	^ ElevatorEmergency new signal: self class desynchronizedDoorSensorErrorDescription! !

!Closed methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 17:14:13'!
transitionToClosing

	^ self! !

!Closed methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:15:51'!
transitionToOpening

	^ Opening new! !


!classDefinition: #Closing category: #'Elevator-Ejercicio'!
DoorState subclass: #Closing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Closing methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:41:30'!
isClosing

	^ true! !

!Closing methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:12:37'!
transitionToClosed

	^ Closed new! !

!Closing methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:05:03'!
transitionToOpened

	^ Opened new! !

!Closing methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:18:03'!
transitionToOpening

	^ Opening new! !


!classDefinition: #Opened category: #'Elevator-Ejercicio'!
DoorState subclass: #Opened
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Opened methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:40:55'!
isOpened

	^ true! !

!Opened methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 17:04:56'!
transitionToClosed

	^ ElevatorEmergency new signal: self class desynchronizedDoorSensorErrorDescription! !

!Opened methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:06:34'!
transitionToClosing

	^ Closing new! !

!Opened methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:18:49'!
transitionToOpened

	^ self! !

!Opened methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:16:51'!
transitionToOpening

	^ self! !


!classDefinition: #Opening category: #'Elevator-Ejercicio'!
DoorState subclass: #Opening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Opening methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:40:34'!
isOpening

	^ true! !

!Opening methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 17:12:38'!
transitionToClosed

	^ ElevatorEmergency new signal: self class desynchronizedDoorSensorErrorDescription! !

!Opening methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 16:41:32'!
transitionToClosing

	^ self! !

!Opening methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:07:05'!
transitionToOpened

	^ Opened new! !

!Opening methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:20:00'!
transitionToOpening

	^ self! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabin floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 20:27:01'!
cabinDoorClosed

	cabin closedDoor ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:29:32'!
cabinDoorOpened

	cabin openedDoorIfStopped .
	( floorsToGo size = 1 ) ifTrue: [ state := state transitionToIdle ] .
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:42:49'!
cabinFloorNumber

	^ cabin floorNumber! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 17:01:16'!
cabinOnFloor: aFloorNumber

	( cabin floorNumber + 1 = aFloorNumber ) ifFalse: [ ^ ElevatorEmergency new signal: self class desynchronizedCabinSensorErrorDescription ] .
	( floorsToGo includes: aFloorNumber ) ifTrue: [ cabin stop ] .
	cabin changeFloorNumber .	 
	 

	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 16:43:44'!
closeCabinDoor

	state closingDoorIfWorkingAndCabinStopped: self
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:09:06'!
closingCabinDoor

	cabin closingDoorIfStopped! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:02:15'!
goUpPushedFromFloor: aFloorNumber 

	floorsToGo add: aFloorNumber .
	state := state transitionToWorking .
	cabin closingDoor .
! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:29:24'!
initialize

	floorsToGo := OrderedCollection new .
	state := Idle new .
	cabin := Cabin new .

	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:54:28'!
isCabinDoorClosed
	
	^ cabin isDoorClosed! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:53:16'!
isCabinDoorClosing

	^ cabin isDoorClosing! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:40:16'!
isCabinDoorOpened

	^ cabin isDoorOpened! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:51:52'!
isCabinDoorOpening

	^ cabin isDoorOpening! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:46:41'!
isCabinMoving

	^ cabin isMoving! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:39:42'!
isCabinStopped

	^ cabin isStopped! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:42:54'!
isCabinWaitingForPeople

	^ self isCabinDoorOpened and: ( floorsToGo isEmpty not )! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:30:05'!
isIdle

	^ state isIdle! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:30:43'!
isWorking
	
	^ state isWorking! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 14:29:52'!
openCabinDoor

	cabin openingDoorIfStopped
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 13:33:34'!
waitForPeopleTimedOut

	cabin closingDoor .
	state := state transitionToWorking .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorController class' category: #'Elevator-Ejercicio'!
ElevatorController class
	instanceVariableNames: ''!

!ElevatorController class methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 16:55:12'!
desynchronizedCabinSensorErrorDescription

	^ 'Sensor de cabina desincronizado'! !

!ElevatorController class methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 18:37:26'!
new 

	^ super new initialize! !


!classDefinition: #ElevatorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:39:20'!
isIdle

	^ false! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:39:34'!
isWorking

	^ false! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:49:17'!
workTransition

	self subclassResponsibility ! !


!classDefinition: #Idle category: #'Elevator-Ejercicio'!
ElevatorState subclass: #Idle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Idle methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 16:45:06'!
closingDoorIfWorkingAndCabinStopped: aCabin

	"do nothing"! !

!Idle methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:39:55'!
isIdle

	^ true! !

!Idle methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:06:03'!
transitionToWorking

	^ Working new! !


!classDefinition: #Working category: #'Elevator-Ejercicio'!
ElevatorState subclass: #Working
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Working methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 16:44:44'!
closingDoorIfWorkingAndCabinStopped: anElevatorController 

	anElevatorController closingCabinDoor ! !

!Working methodsFor: 'as yet unclassified' stamp: 'MC 10/11/2017 19:40:12'!
isWorking

	^ true! !

!Working methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:19:11'!
transitionToIdle

	^ Idle new! !

!Working methodsFor: 'as yet unclassified' stamp: 'MC 10/12/2017 12:02:35'!
transitionToWorking

	^ self! !
