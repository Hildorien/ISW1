!classDefinition: #ElevatorEmergency category: #'ElevatorConsole-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!


!classDefinition: #ElevatorControllerTest category: #'ElevatorConsole-Ejercicio'!
TestCase subclass: #ElevatorControllerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorControllerTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
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

!ElevatorControllerTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
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

!ElevatorControllerTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
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

!ElevatorControllerTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorControllerTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
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

!ElevatorControllerTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
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


!ElevatorControllerTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
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

!ElevatorControllerTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
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

!ElevatorControllerTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
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

!ElevatorControllerTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
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


!ElevatorControllerTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorControllerTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
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

!ElevatorControllerTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
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

!ElevatorControllerTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
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

!ElevatorControllerTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
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


!ElevatorControllerTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorControllerTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/15/2011 18:05'!
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
	self deny: elevatorController isCabinDoorOpening.
! !

!ElevatorControllerTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
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

!ElevatorControllerTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
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


!ElevatorControllerTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
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

!ElevatorControllerTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
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

!ElevatorControllerTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorControllerTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorControllerTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorControllerTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
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


!classDefinition: #ElevatorControllerViewTest category: #'ElevatorConsole-Ejercicio'!
TestCase subclass: #ElevatorControllerViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorControllerViewTest methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 18:47'!
test01ElevatorControllerConsoleTracksDoorClosingState

	| elevatorController elevatorControllerConsole readStream |
	
	elevatorController := ElevatorController new.
	elevatorControllerConsole := ElevatorControllerConsole of: elevatorController.
		
	elevatorController goUpPushedFromFloor: 1.
				
	readStream := elevatorControllerConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: readStream atEnd! !

!ElevatorControllerViewTest methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 18:49'!
test02ElevatorControllerConsoleTracksCabinState

	| elevatorController elevatorControllerConsole readStream |
	
	elevatorController := ElevatorController new.
	elevatorControllerConsole := ElevatorControllerConsole of: elevatorController.
		
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
					
	readStream := elevatorControllerConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: 'Puerta Cerrada' = readStream nextLine.
	self assert: 'Cabina Moviendose' = readStream nextLine.
	self assert: readStream atEnd
! !

!ElevatorControllerViewTest methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 18:50'!
test03ElevatorControllerConsoleTracksCabinAndDoorStateChanges

	| elevatorController elevatorControllerConsole readStream |
	
	elevatorController := ElevatorController new.
	elevatorControllerConsole := ElevatorControllerConsole of: elevatorController.
		
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.  
					
	readStream := elevatorControllerConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: 'Puerta Cerrada' = readStream nextLine.
	self assert: 'Cabina Moviendose' = readStream nextLine.
	self assert: 'Cabina Detenida' = readStream nextLine.
	self assert: 'Puerta Abriendose' = readStream nextLine.
	self assert: readStream atEnd
! !

!ElevatorControllerViewTest methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 19:00'!
test04ElevatorControllerCanHaveMoreThanOneView
 
	| elevatorController elevatorControllerConsole readStream elevatorControllerStatusView |
	
	elevatorController := ElevatorController new.
	elevatorControllerConsole := ElevatorControllerConsole of: elevatorController.
	elevatorControllerStatusView := ElevatorControllerStatusView of: elevatorController.
		
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.  
					
	readStream := elevatorControllerConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: 'Puerta Cerrada' = readStream nextLine.
	self assert: 'Cabina Moviendose' = readStream nextLine.
	self assert: 'Cabina Detenida' = readStream nextLine.
	self assert: 'Puerta Abriendose' = readStream nextLine.
	self assert: readStream atEnd.

	self assert: 'Stopped' = elevatorControllerStatusView cabinFieldModel.
	self assert: 'Opening' = elevatorControllerStatusView cabinDoorFieldModel! !


!classDefinition: #CabinDoorState category: #'ElevatorConsole-Ejercicio'!
Object subclass: #CabinDoorState
	instanceVariableNames: 'elevatorController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinDoorState methodsFor: 'initialization' stamp: 'HernanWilkinson 7/15/2011 17:41'!
initializeOf: anElevatorController 
	
	elevatorController := anElevatorController ! !


!CabinDoorState methodsFor: 'visitor accepting' stamp: 'HernanWilkinson 7/15/2011 19:01'!
accept: aCabinDoorVisitor

	self subclassResponsibility ! !


!CabinDoorState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:45'!
isClosed

	^ false! !

!CabinDoorState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:45'!
isClosing

	^false! !

!CabinDoorState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:45'!
isOpened 

	^false! !

!CabinDoorState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:46'!
isOpening

	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinDoorState class' category: #'ElevatorConsole-Ejercicio'!
CabinDoorState class
	instanceVariableNames: ''!

!CabinDoorState class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/15/2011 17:41'!
of: anElevatorController 
	
	^ self new initializeOf: anElevatorController   ! !


!classDefinition: #CabinDoorClosedState category: #'ElevatorConsole-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinDoorClosedState methodsFor: 'visitor accepting' stamp: 'MC 10/19/2017 15:39:45'!
accept: aCabinDoorStateVisitor 

	aCabinDoorStateVisitor visitCabinDoorClosed: self! !


!CabinDoorClosedState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:46'!
isClosed

	^ true! !


!classDefinition: #CabinDoorClosingState category: #'ElevatorConsole-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinDoorClosingState methodsFor: 'visitor accepting' stamp: 'MC 10/19/2017 15:48:47'!
accept: aCabinDoorStateVisitor 

	aCabinDoorStateVisitor visitCabinDoorClosing: self! !


!CabinDoorClosingState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 17:55'!
cabinDoorClosedWhenWorkingAndCabinStopped
	
	^ elevatorController cabinDoorClosedWhenWorkingAndCabinStoppedAndCabinDoorStopped ! !


!CabinDoorClosingState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:46'!
isClosing 

	^true! !


!classDefinition: #CabinDoorOpenedState category: #'ElevatorConsole-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpenedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinDoorOpenedState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:43'!
isOpened
	
	^ true! !


!CabinDoorOpenedState methodsFor: 'visitor accepting' stamp: 'MC 10/19/2017 15:49:19'!
accept: aCabinDoorStateVisitor 

	aCabinDoorStateVisitor visitCabinDoorOpened: self! !


!classDefinition: #CabinDoorOpeningState category: #'ElevatorConsole-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpeningState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinDoorOpeningState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 18:17'!
cabinDoorClosedWhenWorkingAndCabinStopped
	
	^elevatorController cabinDoorClosedWhenWorkingAndCabinStoppedAndCabinDoorOpening! !


!CabinDoorOpeningState methodsFor: 'visitor accepting' stamp: 'MC 10/19/2017 15:49:33'!
accept: aCabinDoorStateVisitor 

	aCabinDoorStateVisitor visitCabinDoorOpening: self! !


!CabinDoorOpeningState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:15'!
closeCabinDoorWhenWorkingAndCabinStopped
	
	^elevatorController closeCabinDoorWhenWorkingAndCabinStoppedAndCabinDoorOpening! !


!CabinDoorOpeningState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:46'!
isOpening 

	^ true! !


!classDefinition: #CabinState category: #'ElevatorConsole-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: 'elevatorController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinState methodsFor: 'visitor accepting' stamp: 'HernanWilkinson 7/15/2011 19:01'!
accept: aCabinStateVisitor

	self subclassResponsibility ! !


!CabinState methodsFor: 'initialization' stamp: 'HernanWilkinson 7/15/2011 17:44'!
initializeOf: anElevatorController 
	
	elevatorController := anElevatorController ! !


!CabinState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:46'!
isMoving

	^ false! !

!CabinState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:46'!
isStopped

	^ false! !

!CabinState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:46'!
isWaitingForPeople

	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinState class' category: #'ElevatorConsole-Ejercicio'!
CabinState class
	instanceVariableNames: ''!

!CabinState class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/15/2011 17:44'!
of: anElevatorController 
	
	^self new initializeOf: anElevatorController   ! !


!classDefinition: #CabinMovingState category: #'ElevatorConsole-Ejercicio'!
CabinState subclass: #CabinMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinMovingState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 18:17'!
cabinDoorClosedWhenWorking
	
	^elevatorController cabinDoorClosedWhenWorkingAndCabinMoving! !


!CabinMovingState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:13'!
closeCabinDoorWhenWorking

	^ elevatorController closeCabinDoorWhenWorkingAndCabinMoving! !


!CabinMovingState methodsFor: 'visitor accepting' stamp: 'MC 10/19/2017 15:49:48'!
accept: aCabinDoorStateVisitor 

	aCabinDoorStateVisitor visitCabinMoving: self! !


!CabinMovingState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:47'!
isMoving

	^true! !


!classDefinition: #CabinStoppedState category: #'ElevatorConsole-Ejercicio'!
CabinState subclass: #CabinStoppedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinStoppedState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:14'!
closeCabinDoorWhenWorking
	
	^elevatorController closeCabinDoorWhenWorkingAndCabinStopped! !


!CabinStoppedState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:43'!
isStopped
	
	^ true! !


!CabinStoppedState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 17:55'!
cabinDoorClosedWhenWorking
	
	^ elevatorController cabinDoorClosedWhenWorkingAndCabinStopped! !

!CabinStoppedState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 18:01'!
cabinDoorOpenedWhenWorking
	
	^elevatorController cabinDoorOpenedWhenWorkingAndCabinStopped! !


!CabinStoppedState methodsFor: 'visitor accepting' stamp: 'MC 10/19/2017 15:50:03'!
accept: aCabinDoorStateVisitor 

	aCabinDoorStateVisitor visitCabinStopped: self! !


!classDefinition: #CabinWaitingForPeopleState category: #'ElevatorConsole-Ejercicio'!
CabinState subclass: #CabinWaitingForPeopleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!CabinWaitingForPeopleState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:11'!
closeCabinDoorWhenWorking
	
	^ elevatorController closeCabinDoorWhenWorkingAndWaitingForPeople! !


!CabinWaitingForPeopleState methodsFor: 'cabin events' stamp: 'HernanWilkinson 7/15/2011 18:08'!
waitForPeopleTimedOutWhenWorking
	
	^elevatorController waitForPeopleTimedOutWhenWorkingAndCabinWaitingForPeople! !


!CabinWaitingForPeopleState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:47'!
isWaitingForPeople 

	^true! !


!CabinWaitingForPeopleState methodsFor: 'visitor accepting' stamp: 'MC 10/19/2017 15:54:29'!
accept: aCabinDoorStateVisitor 

	aCabinDoorStateVisitor visitCabinWaitingForPeople: self! !


!classDefinition: #ElevatorController category: #'ElevatorConsole-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabinState cabinDoorState cabinFloorNumber floorsToGo notifier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorController methodsFor: 'cabin events by state' stamp: 'HernanWilkinson 7/15/2011 18:08'!
waitForPeopleTimedOutWhenWorking
	
	cabinState waitForPeopleTimedOutWhenWorking ! !

!ElevatorController methodsFor: 'cabin events by state' stamp: 'HernanWilkinson 7/15/2011 18:28'!
waitForPeopleTimedOutWhenWorkingAndCabinWaitingForPeople

	self stopCabin.
	self startClosingDoor! !


!ElevatorController methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 17:54'!
cabinDoorClosed
	
	^state cabinDoorClosed ! !

!ElevatorController methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 18:00'!
cabinDoorOpened
	
	^ state cabinDoorOpened ! !


!ElevatorController methodsFor: 'initialization' stamp: 'MC 10/17/2017 23:53:09'!
initialize 

	cabinFloorNumber := 0.
	floorsToGo := SortedCollection new.
	notifier := Notifier new .
	self stopWorking.
	self stopCabin.
	self stopCabinDoorMotorWhenOpened.
	! !


!ElevatorController methodsFor: 'cabin door state' stamp: 'HernanWilkinson 7/15/2011 17:48'!
isCabinDoorClosed
	
	^ cabinDoorState isClosed ! !

!ElevatorController methodsFor: 'cabin door state' stamp: 'HernanWilkinson 7/15/2011 17:48'!
isCabinDoorClosing
	
	^ cabinDoorState isClosing ! !

!ElevatorController methodsFor: 'cabin door state' stamp: 'HernanWilkinson 7/15/2011 17:43'!
isCabinDoorOpened
	
	^ cabinDoorState isOpened! !

!ElevatorController methodsFor: 'cabin door state' stamp: 'HernanWilkinson 7/15/2011 17:47'!
isCabinDoorOpening
	
	^ cabinDoorState isOpening ! !

!ElevatorController methodsFor: 'cabin door state' stamp: 'MC 10/19/2017 15:51:32'!
startClosingDoor
	
	cabinDoorState := CabinDoorClosingState of: self .
	notifier notifyState: cabinDoorState .! !

!ElevatorController methodsFor: 'cabin door state' stamp: 'MC 10/19/2017 15:51:25'!
startOpeningCabinDoor
	
	cabinDoorState := CabinDoorOpeningState of: self .
	notifier notifyState: cabinDoorState .! !

!ElevatorController methodsFor: 'cabin door state' stamp: 'MC 10/19/2017 15:50:59'!
stopCabinDoorMotorWhenClosed
	
	cabinDoorState := CabinDoorClosedState of: self .
	notifier notifyState: cabinDoorState .! !

!ElevatorController methodsFor: 'cabin door state' stamp: 'MC 10/19/2017 15:51:17'!
stopCabinDoorMotorWhenOpened
	
	cabinDoorState := CabinDoorOpenedState of: self .
	notifier notifyState: cabinDoorState .! !


!ElevatorController methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:09'!
closeCabinDoor
	
	^ state closeCabinDoor ! !

!ElevatorController methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 17:50'!
goUpPushedFromFloor: aFloorNumber

	^ state goUpPushedFromFloor: aFloorNumber   ! !

!ElevatorController methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:04'!
openCabinDoor

	^state openCabinDoor ! !


!ElevatorController methodsFor: 'cabin state' stamp: 'HernanWilkinson 7/15/2011 17:43'!
cabinFloorNumber
	
	^ cabinFloorNumber! !

!ElevatorController methodsFor: 'cabin state' stamp: 'HernanWilkinson 7/15/2011 17:48'!
isCabinMoving

	^ cabinState isMoving ! !

!ElevatorController methodsFor: 'cabin state' stamp: 'HernanWilkinson 7/15/2011 17:42'!
isCabinStopped

	^ cabinState isStopped! !

!ElevatorController methodsFor: 'cabin state' stamp: 'HernanWilkinson 7/15/2011 17:48'!
isCabinWaitingForPeople 

	^ cabinState isWaitingForPeople ! !

!ElevatorController methodsFor: 'cabin state' stamp: 'MC 10/19/2017 15:51:51'!
startMovingCabin
	
	cabinState := CabinMovingState of: self .
	notifier notifyState: cabinState .! !

!ElevatorController methodsFor: 'cabin state' stamp: 'MC 10/19/2017 15:51:59'!
stopCabin
	
	cabinState := CabinStoppedState of: self .
	notifier notifyState: cabinState .! !

!ElevatorController methodsFor: 'cabin state' stamp: 'MC 10/19/2017 15:57:17'!
waitForPeopleToCameInsideCabin
	
	cabinState := CabinWaitingForPeopleState of: self .
	notifier notifyState: cabinState .! !


!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:12'!
closeCabinDoorWhenIdle
	
	! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:10'!
closeCabinDoorWhenWorking
	
	^ cabinState closeCabinDoorWhenWorking ! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:13'!
closeCabinDoorWhenWorkingAndCabinMoving
	
	! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:14'!
closeCabinDoorWhenWorkingAndCabinStopped

	^ cabinDoorState closeCabinDoorWhenWorkingAndCabinStopped ! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:15'!
closeCabinDoorWhenWorkingAndCabinStoppedAndCabinDoorOpening
	
	! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:28'!
closeCabinDoorWhenWorkingAndWaitingForPeople
	
	self stopCabin.
	self startClosingDoor! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:29'!
goUpPushedFromFloorWhenIdle: aFloorNumber

		floorsToGo add: aFloorNumber.
		self startWorking.
		self startClosingDoor ! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:06'!
goUpPushedFromFloorWhenWorking: aFloorNumber

	floorsToGo add: aFloorNumber ! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:04'!
openCabinDoorWhenIdle

	! !

!ElevatorController methodsFor: 'button events by state' stamp: 'HernanWilkinson 7/15/2011 18:05'!
openCabinDoorWhenWorking
	! !


!ElevatorController methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 18:03'!
hasFloorToGo
	
	^ floorsToGo notEmpty ! !


!ElevatorController methodsFor: 'cabin events' stamp: 'HernanWilkinson 7/15/2011 18:34'!
cabinOnFloor: aFloorNumber

	aFloorNumber<cabinFloorNumber ifTrue: [ ElevatorEmergency signal: 'Sensor de cabina desincronizado' ].
	cabinFloorNumber+1 = aFloorNumber ifFalse: [ ElevatorEmergency signal: 'Sensor de cabina desincronizado' ].
		
	cabinFloorNumber := aFloorNumber.
	floorsToGo first = aFloorNumber ifTrue: [ 
		floorsToGo removeFirst.
		self stopCabin.
		self startOpeningCabinDoor ]
! !

!ElevatorController methodsFor: 'cabin events' stamp: 'HernanWilkinson 7/15/2011 18:07'!
waitForPeopleTimedOut
	
	^ state waitForPeopleTimedOut ! !


!ElevatorController methodsFor: 'controller state' stamp: 'HernanWilkinson 7/15/2011 17:42'!
isIdle
	
	^ state isIdle ! !

!ElevatorController methodsFor: 'controller state' stamp: 'HernanWilkinson 7/15/2011 17:48'!
isWorking
	
	^ state isWorking ! !

!ElevatorController methodsFor: 'controller state' stamp: 'HernanWilkinson 7/15/2011 18:29'!
startWorking
	
	state := ElevatorControllerWorkingState of: self! !

!ElevatorController methodsFor: 'controller state' stamp: 'HernanWilkinson 7/15/2011 18:28'!
stopWorking
	
	state := ElevatorControllerIdleState of: self! !


!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 18:16'!
cabinDoorClosedWhenIdle
	
	ElevatorEmergency signal:  'Sensor de puerta desincronizado' ! !

!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 17:54'!
cabinDoorClosedWhenWorking
	
	^ cabinState cabinDoorClosedWhenWorking ! !

!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 18:17'!
cabinDoorClosedWhenWorkingAndCabinMoving
	
	ElevatorEmergency signal:  'Sensor de puerta desincronizado'   ! !

!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 17:55'!
cabinDoorClosedWhenWorkingAndCabinStopped
	
	^ cabinDoorState cabinDoorClosedWhenWorkingAndCabinStopped ! !

!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 18:18'!
cabinDoorClosedWhenWorkingAndCabinStoppedAndCabinDoorOpening
	
	ElevatorEmergency signal:  'Sensor de puerta desincronizado'   ! !

!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 18:27'!
cabinDoorClosedWhenWorkingAndCabinStoppedAndCabinDoorStopped
	
	self stopCabinDoorMotorWhenClosed.
	self startMovingCabin
	! !

!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 18:01'!
cabinDoorOpenedWhenWorking

	^ cabinState cabinDoorOpenedWhenWorking ! !

!ElevatorController methodsFor: 'cabin door events by state' stamp: 'HernanWilkinson 7/15/2011 18:28'!
cabinDoorOpenedWhenWorkingAndCabinStopped

	self stopCabinDoorMotorWhenOpened.
	self hasFloorToGo 
		ifTrue:  [ self waitForPeopleToCameInsideCabin ]
		ifFalse: [ self stopWorking ]! !


!ElevatorController methodsFor: 'as yet unclassified' stamp: 'MC 10/17/2017 17:46:10'!
registerObserver: anObserver

	notifier register: anObserver ! !


!classDefinition: #ElevatorControllerConsole category: #'ElevatorConsole-Ejercicio'!
Object subclass: #ElevatorControllerConsole
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorControllerConsole methodsFor: 'initialization' stamp: 'MC 10/18/2017 00:14:18'!
initializeOf: anElevatorController 
	
	stream := WriteStream on: String new.
	anElevatorController registerObserver: self .
	! !


!ElevatorControllerConsole methodsFor: 'accessing' stamp: 'HernanWilkinson 7/15/2011 18:46'!
consoleReadStream
	
	^ ReadStream on: stream contents ! !


!ElevatorControllerConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:36:23'!
visitCabinDoorClosed: aCabinDoorClosedState 

	stream 
		nextPutAll: 'Puerta Cerrada';
		newLine! !

!ElevatorControllerConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:36:30'!
visitCabinDoorClosing: aCabinDoorClosingState 
	
	stream 
		nextPutAll: 'Puerta Cerrandose';
		newLine! !

!ElevatorControllerConsole methodsFor: 'visiting' stamp: 'MC 10/18/2017 00:19:27'!
visitCabinDoorOpened: aCabinDoorOpenedState 

	stream 
		nextPutAll: 'Puerta Abierta'  ;
		newLine! !

!ElevatorControllerConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:36:34'!
visitCabinDoorOpening: aCabinDoorOpeningState 

	stream 
		nextPutAll: 'Puerta Abriendose'  ;
		newLine! !

!ElevatorControllerConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:36:39'!
visitCabinMoving: aCabinMovingState 
	
	stream 
		nextPutAll: 'Cabina Moviendose'  ;
		newLine! !

!ElevatorControllerConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:36:44'!
visitCabinStopped: aCabinStoppedState 
	
	stream 
		nextPutAll: 'Cabina Detenida' ;
		newLine! !

!ElevatorControllerConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:38:58'!
visitCabinWaitingForPeople: aCabinWaitingForPeopleState 
	
	stream 
		nextPutAll: 'Cabina Esperando Gente' ;
		newLine! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorControllerConsole class' category: #'ElevatorConsole-Ejercicio'!
ElevatorControllerConsole class
	instanceVariableNames: ''!

!ElevatorControllerConsole class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/15/2011 18:39'!
of: anElevatorController 

	^ self new initializeOf: anElevatorController   ! !


!classDefinition: #ElevatorControllerState category: #'ElevatorConsole-Ejercicio'!
Object subclass: #ElevatorControllerState
	instanceVariableNames: 'elevatorController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorControllerState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:47'!
isIdle

	^false! !

!ElevatorControllerState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:47'!
isWorking

	^false! !


!ElevatorControllerState methodsFor: 'initialization' stamp: 'HernanWilkinson 7/15/2011 17:44'!
initializeOf: anElevatorController 
	
	elevatorController := anElevatorController ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorControllerState class' category: #'ElevatorConsole-Ejercicio'!
ElevatorControllerState class
	instanceVariableNames: ''!

!ElevatorControllerState class methodsFor: 'accessing class hierarchy' stamp: 'HernanWilkinson 7/15/2011 17:44'!
of: anElevatorController 
	
	^self new initializeOf: anElevatorController ! !


!classDefinition: #ElevatorControllerIdleState category: #'ElevatorConsole-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerIdleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorControllerIdleState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:12'!
closeCabinDoor
	
	^elevatorController closeCabinDoorWhenIdle! !

!ElevatorControllerIdleState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 17:51'!
goUpPushedFromFloor: aFloorNumber 

	^ elevatorController goUpPushedFromFloorWhenIdle: aFloorNumber ! !

!ElevatorControllerIdleState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:04'!
openCabinDoor
	
	^ elevatorController openCabinDoorWhenIdle! !


!ElevatorControllerIdleState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 18:16'!
cabinDoorClosed
	
	^elevatorController cabinDoorClosedWhenIdle! !


!ElevatorControllerIdleState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:42'!
isIdle
	
	^true! !


!classDefinition: #ElevatorControllerWorkingState category: #'ElevatorConsole-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerWorkingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorControllerWorkingState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 17:54'!
cabinDoorClosed
	
	^ elevatorController cabinDoorClosedWhenWorking! !

!ElevatorControllerWorkingState methodsFor: 'cabin door events' stamp: 'HernanWilkinson 7/15/2011 18:01'!
cabinDoorOpened
	
	^ elevatorController cabinDoorOpenedWhenWorking! !


!ElevatorControllerWorkingState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:09'!
closeCabinDoor
	
	^ elevatorController closeCabinDoorWhenWorking! !

!ElevatorControllerWorkingState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:06'!
goUpPushedFromFloor: aFloorNumber

	^ elevatorController goUpPushedFromFloorWhenWorking: aFloorNumber    ! !

!ElevatorControllerWorkingState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:05'!
openCabinDoor
	
	^ elevatorController openCabinDoorWhenWorking! !

!ElevatorControllerWorkingState methodsFor: 'button events' stamp: 'HernanWilkinson 7/15/2011 18:07'!
waitForPeopleTimedOut
	
	^elevatorController waitForPeopleTimedOutWhenWorking! !


!ElevatorControllerWorkingState methodsFor: 'testing' stamp: 'HernanWilkinson 7/15/2011 17:47'!
isWorking 

	^true! !


!classDefinition: #ElevatorControllerStatusView category: #'ElevatorConsole-Ejercicio'!
Object subclass: #ElevatorControllerStatusView
	instanceVariableNames: 'cabinDoorFieldModel cabinFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!ElevatorControllerStatusView methodsFor: 'initialization' stamp: 'MC 10/18/2017 00:14:29'!
initializeOf: anElevatorController 

	anElevatorController registerObserver: self
	
	! !


!ElevatorControllerStatusView methodsFor: 'accessing' stamp: 'HernanWilkinson 7/15/2011 19:00'!
cabinDoorFieldModel
	
	^ cabinDoorFieldModel! !

!ElevatorControllerStatusView methodsFor: 'accessing' stamp: 'HernanWilkinson 7/15/2011 19:00'!
cabinFieldModel
	
	^ cabinFieldModel! !


!ElevatorControllerStatusView methodsFor: 'visiting' stamp: 'HernanWilkinson 7/15/2011 18:59'!
visitCabinDoorClosed: aCabinDoorClosedState 

	cabinDoorFieldModel := 'Closed'! !

!ElevatorControllerStatusView methodsFor: 'visiting' stamp: 'HernanWilkinson 7/15/2011 18:59'!
visitCabinDoorClosing: aCabinDoorClosingState 
	
	cabinDoorFieldModel := 'Closing'! !

!ElevatorControllerStatusView methodsFor: 'visiting' stamp: 'MC 10/18/2017 00:19:46'!
visitCabinDoorOpened: aCabinDoorOpenedState 

	cabinDoorFieldModel := 'Opened'! !

!ElevatorControllerStatusView methodsFor: 'visiting' stamp: 'HernanWilkinson 7/15/2011 18:59'!
visitCabinDoorOpening: aCabinDoorOpeningState 

	cabinDoorFieldModel := 'Opening'! !

!ElevatorControllerStatusView methodsFor: 'visiting' stamp: 'HernanWilkinson 7/15/2011 18:59'!
visitCabinMoving: aCabinMovingState 
	
	cabinFieldModel := 'Moving'! !

!ElevatorControllerStatusView methodsFor: 'visiting' stamp: 'HernanWilkinson 7/15/2011 18:59'!
visitCabinStopped: aCabinStoppedState 
	
	cabinFieldModel := 'Stopped'! !

!ElevatorControllerStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:39:17'!
visitCabinWaitingForPeople: aCabinWaitingForPeopleState 
	
	cabinFieldModel := 'Waiting for People'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorControllerStatusView class' category: #'ElevatorConsole-Ejercicio'!
ElevatorControllerStatusView class
	instanceVariableNames: ''!

!ElevatorControllerStatusView class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/15/2011 18:58'!
of: anElevatorController 

	^ self new initializeOf: anElevatorController   ! !


!classDefinition: #Notifier category: #'ElevatorConsole-Ejercicio'!
Object subclass: #Notifier
	instanceVariableNames: 'observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Ejercicio'!

!Notifier methodsFor: 'initialization' stamp: 'MC 10/17/2017 17:40:59'!
initialize
	
	observers := OrderedCollection new! !


!Notifier methodsFor: 'notify' stamp: 'MC 10/19/2017 15:47:40'!
notifyState: aState

	observers do: [ :anObserver | aState accept: anObserver ]! !


!Notifier methodsFor: 'register' stamp: 'MC 10/17/2017 17:43:56'!
register: anObserver

	observers add: anObserver ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Notifier class' category: #'ElevatorConsole-Ejercicio'!
Notifier class
	instanceVariableNames: ''!

!Notifier class methodsFor: 'instance creation' stamp: 'MC 10/17/2017 17:42:20'!
new
	
	^ super new initialize ! !
