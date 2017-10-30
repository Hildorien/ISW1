!classDefinition: #CartTest category: #'Editorial-TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart anISBN aCatalog anISBNNotIncludedInCatalog aCashier emptyCart anExpiredCreditCard aCreditCard anotherISBN'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 12:23:42'!
test01CartIsEmptyWhenCreated

	self assert: aCart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:39:56'!
test02CannotAddToCartAnItemNotIncludedInCatalog
	
	self 
		should: [ aCart add: anISBNNotIncludedInCatalog ]
		raise: Error
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot add an item not included in the catalog' .
			self assert: aCart isEmpty . ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 13:30:06'!
test03CartIsNotEmptyAfterAnItemIsAdded

	aCart add: anISBN .
	
	self deny: aCart isEmpty .! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:32:28'!
test04CartRemembersAddedItems

	aCart add: anISBN .
	
	self assert: ( aCart includes: anISBN ) .! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:33:57'!
test05CartDoesNotIncludeNotAddedItems
		
	self deny: ( aCart includes: anISBN ) .! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:16:36'!
test06CartRemembersTheNumberOfUnitsOfEachAddedItem
	
	aCart add: anISBN units: 3 .
	
	self assert: ( aCart includes: anISBN ) .
	self assert: ( aCart unitsOf: anISBN ) equals: 3 .
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:25:12'!
test07CannotAddNonPositiveNumberOfItemsToCart

	self 
		should: [ aCart add: anISBN units: -1 ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot add a non positive number of items' .
			self assert: aCart isEmpty . ]	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:40:42'!
test08CannotAddToCartMoreThanOneItemNotIncludedInCatalog
	
	self 
		should: [ aCart add: anISBNNotIncludedInCatalog units: 5 ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot add an item not included in the catalog' .
			self assert: aCart isEmpty . ]	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 19:36:45'!
test09CashierCannotCheckoutEmptyCart

	self 
		should: [ aCashier checkout: aCart with: aCreditCard ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot checkout an empty cart' . ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 19:38:14'!
test10CashierCannotCheckoutCartWithExpiredCreditCard

	aCart add: anISBN .

	self 
		should: [ aCashier checkout: aCart with: anExpiredCreditCard ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot checkout with an expired credit card' . ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 22:05:46'!
test11CashierCalculatesOrderCostAsTheSumOfTheCostOfItemsAddedToTheCart

	| orderCost unitsOfAnISBN unitsOfAnotherISBN |
	unitsOfAnISBN := 3 .
	unitsOfAnotherISBN := 2 .
	aCart add: anISBN units: unitsOfAnISBN .
	aCart add: anotherISBN units: unitsOfAnotherISBN .
	orderCost := ( ( aCatalog at: anISBN ) * unitsOfAnISBN ) + ( ( aCatalog at: anotherISBN ) * unitsOfAnotherISBN ) .	

	self assert: orderCost equals: ( aCashier checkout: aCart with: aCreditCard ) .! !


!CartTest methodsFor: 'setup' stamp: 'MC 10/29/2017 21:58:22'!
setUp

	anISBN := '123456' .
	anotherISBN := '123457' .
	anISBNNotIncludedInCatalog := '001' .
	
	aCatalog := Dictionary new .
	aCatalog at: anISBN put: 50.00 .
	aCatalog at: anotherISBN put: 60.00 .

	aCart := Cart with: aCatalog .
	
	aCreditCard := CreditCard with: ( Date year: 2019 month: 10 day: 1 ) .
	anExpiredCreditCard := CreditCard with: ( Date year: 2017 month: 3 day: 1 ) .
	
	aCashier := Cashier with: aCatalog .


	! !


!classDefinition: #Cart category: #'Editorial-TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:44:06'!
add: anItem

	self validateItemInCatalog: anItem .
	items add: anItem .
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:46:57'!
add: anItem units: aQuantity 

	self validateItemInCatalog: anItem .
	aQuantity <= 0 ifTrue: [ ^ self error: self class nonPositiveNumberOfItemsErrorDescription ] .
	items add: anItem withOccurrences: aQuantity .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 21:54:36'!
do: aClosure

	^ items do: aClosure ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 13:39:17'!
includes: anItem

	^ items includes: anItem! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 13:12:16'!
isEmpty

	^ items isEmpty ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:44:58'!
unitsOf: anItem

	^ items occurrencesOf: anItem! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 20:53:36'!
validateItemInCatalog: anItem 

	( catalog includesKey: anItem ) ifFalse: [ ^ self error: self class itemNotIncludedInCatalogErrorDescription ] .
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:44:34'!
with: aCatalog

	items := Bag new .
	catalog := aCatalog .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Editorial-TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:38:42'!
itemNotIncludedInCatalogErrorDescription

	^ 'Cannot add an item not included in the catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 15:28:06'!
nonPositiveNumberOfItemsErrorDescription

	^ 'Cannot add a non positive number of items'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 13:13:15'!
with: aProductCatalog

	^ self new with: aProductCatalog ! !


!classDefinition: #Cashier category: #'Editorial-TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 21:56:43'!
checkout: aCart with: aCreditCard

	| orderCost |
	
	aCart isEmpty ifTrue: [ ^ self error: self class emptyCartErrorDescription ] .
	( Date today < aCreditCard expirationDate ) ifFalse: [ ^ self error: self class expiredCreditCardErrorDescription ] .
	orderCost := 0.00 .
	aCart do: [ :anItem | orderCost := orderCost + catalog at: anItem ] .
	^ orderCost
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 21:57:59'!
with: aCatalog

	catalog := aCatalog ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'Editorial-TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 16:11:08'!
emptyCartErrorDescription

	^ 'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 16:34:54'!
expiredCreditCardErrorDescription

	^ 'Cannot checkout with an expired credit card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 21:57:36'!
with: aCatalog

	^ self new with: aCatalog ! !


!classDefinition: #CreditCard category: #'Editorial-TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 16:38:04'!
expirationDate

	^ expirationDate! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 16:38:56'!
with: anExpirationDate

	expirationDate := anExpirationDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'Editorial-TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 16:39:34'!
with: anExpirationDate

	^ self new with: anExpirationDate ! !
