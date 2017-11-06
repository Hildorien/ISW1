!classDefinition: #CartTest category: #'Editorial-TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart anISBN aCatalog anISBNNotIncludedInCatalog aCashier anExpiredCreditCard aCreditCard anotherISBN aSalesBook aStolenCreditCard debitFromClosure aSystemInterface invalidUser anInvalidUser anInvalidPassword aValidUser aValidUserPassword usersAndPasswords anInvalidCartId aCreditCardNumber aCreditCardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'MC 11/6/2017 17:34:18'!
setUp

	anISBN := '123456' .
	anotherISBN := '123457' .
	anISBNNotIncludedInCatalog := '001' .
	
	aCatalog := Dictionary new .
	aCatalog at: anISBN put: 50.00 * peso .
	aCatalog at: anotherISBN put: 60.00 * peso.

	aCart := Cart with: aCatalog .
	
	aCreditCard := CreditCard with: Month current next .
	anExpiredCreditCard := CreditCard with: Month current previous .
	aStolenCreditCard := CreditCard with: Month current next .
	
	aSalesBook := OrderedCollection new .
	
	aCashier := Cashier with: aSalesBook using: self .

	anInvalidUser := 'invalidUser' .
	anInvalidPassword := 'invalidPassword' .
	aValidUser := 'grupo10' .
	aValidUserPassword := 'lapass' .
	
	usersAndPasswords := Dictionary new .
	usersAndPasswords at: aValidUser put: aValidUserPassword .
	
	aSystemInterface := SystemInterface authenticatingWith: usersAndPasswords usingItemsFrom: aCatalog registeringSalesOn: aSalesBook debitingThrough: self .
	
	anInvalidCartId := 'invalidCartId' .
	
	aCreditCardNumber := 1111222233334444 .
	aCreditCardOwner := 'Lionel Messi' .
	
	Sale restartIds .
	
	
	! !


!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 12:23:42'!
test01CartIsEmptyWhenCreated

	self assert: aCart isEmpty! !

!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 15:39:56'!
test02CannotAddToCartAnItemNotIncludedInCatalog
	
	self 
		should: [ aCart add: anISBNNotIncludedInCatalog ]
		raise: Error
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot add an item not included in the catalog' .
			self assert: aCart isEmpty . ]! !

!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 13:30:06'!
test03CartIsNotEmptyAfterAnItemIsAdded

	aCart add: anISBN .
	
	self deny: aCart isEmpty .! !

!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 15:32:28'!
test04CartRemembersAddedItems

	aCart add: anISBN .
	
	self assert: ( aCart includes: anISBN ) .! !

!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 15:33:57'!
test05CartDoesNotIncludeNotAddedItems
		
	self deny: ( aCart includes: anISBN ) .! !

!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 15:16:36'!
test06CartRemembersTheNumberOfUnitsOfEachAddedItem
	
	aCart add: anISBN units: 3 .
	
	self assert: ( aCart includes: anISBN ) .
	self assert: ( aCart unitsOf: anISBN ) equals: 3 .
	! !

!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 15:25:12'!
test07CannotAddNonPositiveNumberOfItemsToCart

	self 
		should: [ aCart add: anISBN units: -1 ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot add a non positive number of items' .
			self assert: aCart isEmpty . ]	! !

!CartTest methodsFor: 'cart tests' stamp: 'MC 10/29/2017 15:40:42'!
test08CannotAddToCartMoreThanOneItemNotIncludedInCatalog
	
	self 
		should: [ aCart add: anISBNNotIncludedInCatalog units: 5 ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot add an item not included in the catalog' .
			self assert: aCart isEmpty . ]	! !


!CartTest methodsFor: 'cashier tests' stamp: 'MC 10/30/2017 21:28:26'!
test09CashierCannotCheckoutEmptyCart

	self 
		should: [ aCashier checkout: aCart with: aCreditCard on: Date today ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot checkout an empty cart' . 
			self assert: aSalesBook isEmpty .]! !

!CartTest methodsFor: 'cashier tests' stamp: 'MC 11/6/2017 01:43:00'!
test10CashierCannotCheckoutCartWithExpiredCreditCard

	aCart add: anISBN .

	self 
		should: [ aCashier checkout: aCart with: anExpiredCreditCard on: Month current ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot checkout with an expired credit card' . 
			self assert: aSalesBook isEmpty .]! !

!CartTest methodsFor: 'cashier tests' stamp: 'MC 11/6/2017 16:50:03'!
test11CashierCalculatesOrderCostAsTheSumOfTheCostOfItemsAddedToTheCart

	| unitsOfAnISBN unitsOfAnotherISBN sale cartCost |
	unitsOfAnISBN := 3 .
	unitsOfAnotherISBN := 2 .
	aCart add: anISBN units: unitsOfAnISBN .
	aCart add: anotherISBN units: unitsOfAnotherISBN .
	cartCost := ( ( aCatalog at: anISBN ) * unitsOfAnISBN ) + ( ( aCatalog at: anotherISBN ) * unitsOfAnotherISBN ) .	
	sale :=  aCashier checkout: aCart with: aCreditCard on: Month current .

	self assert: cartCost equals: sale totalCost .! !

!CartTest methodsFor: 'cashier tests' stamp: 'MC 11/6/2017 16:41:50'!
test12CheckoutRegistersSaleInSalesBook
	
	| aSale |
	aCart add: anISBN .
	aSale := aCashier checkout: aCart with: aCreditCard on: Month current .
	
	self assert: ( aSalesBook includes: aSale ) .! !

!CartTest methodsFor: 'cashier tests' stamp: 'MC 11/6/2017 01:43:49'!
test13CashierCannotCheckoutWithStolenCreditCard
	
	self configureMerchantProcessorSimulator: [ self error: 'Cannot checkout with a stolen credit card' ] . 
	
	aCart add: anISBN .
	
	self 
		should: [ aCashier checkout: aCart with: aStolenCreditCard on: Month current ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot checkout with a stolen credit card' .
			self assert: aSalesBook isEmpty . ] ! !

!CartTest methodsFor: 'cashier tests' stamp: 'MC 11/6/2017 01:44:06'!
test14CashierCannotCheckoutWithACreditCardWithInsufficientFunds
	
	self configureMerchantProcessorSimulator: [ ^ self error: 'Cannot checkout with a credit card with insufficient funds' ] . 
	
	aCart add: anISBN .
	
	self 
		should: [ aCashier checkout: aCart with: aCreditCard on: Month current ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Cannot checkout with a credit card with insufficient funds' .
			self assert: aSalesBook isEmpty . ] ! !


!CartTest methodsFor: 'merchant processor simulator' stamp: 'MC 11/2/2017 20:49:30'!
configureMerchantProcessorSimulator: aClosure

	debitFromClosure := aClosure ! !

!CartTest methodsFor: 'merchant processor simulator' stamp: 'MC 11/2/2017 20:51:13'!
debit: anAmount from: aCreditCard

	^ debitFromClosure value! !


!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/5/2017 20:02:09'!
test15CannotCreateCartWithInvalidUser

	self 
		should: [ aSystemInterface createCartFor: invalidUser withPassword: passwordForAValidUser ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Invalid user' ] ! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/5/2017 20:31:26'!
test16CannotCreateCartWithInvalidPassword

	self 
		should: [ aSystemInterface createCartFor: aValidUser withPassword: anInvalidPassword ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Invalid password' ] ! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/5/2017 20:32:40'!
test17CreateCartWithValidUserAndPasswordDoesNotRaiseErrors

	self 
		shouldnt: [ aSystemInterface createCartFor: aValidUser withPassword: aValidUserPassword ] 
		raise: Error! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/5/2017 20:42:33'!
test18CannotAddItemsToCartWithInvalidCartId

	self 
		should: [ aSystemInterface add: 3 ofItem: anISBN toCartWithId: anInvalidCartId ] 
		raise: Error 
		withExceptionDo: [ :exception | 
			self assert: exception messageText = 'Invalid cart id' ] ! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/5/2017 20:45:20'!
test19AddToCartWithValidCartIdDoesNotRaiseErrors

	| aCartId |
	
	aCartId := aSystemInterface createCartFor: aValidUser withPassword: aValidUserPassword .

	self 
		shouldnt: [ aSystemInterface add: 3 ofItem: anISBN toCartWithId: aCartId ] 
		raise: Error! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 00:38:29'!
test20ListEmptyCartReturnsAnEmptyList

	| aCartId |

	aCartId := aSystemInterface createCartFor: aValidUser withPassword: aValidUserPassword.

	self assert: (aSystemInterface listCartWithId: aCartId) isEmpty.! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 00:37:25'!
test21ListCartIncludesItemsAddedToCartWithTheRightNumberOfEachItem
	| aCartId aCartList unitsOfAnISBN unitsOfAnotherISBN |
	unitsOfAnISBN _ 3.
	unitsOfAnotherISBN _ 5.
	aCartId _ aSystemInterface
		createCartFor: aValidUser
		withPassword: aValidUserPassword.
	aSystemInterface
		add: unitsOfAnISBN
		ofItem: anISBN
		toCartWithId: aCartId.
	aSystemInterface
		add: unitsOfAnotherISBN
		ofItem: anotherISBN
		toCartWithId: aCartId.
	aCartList _ aSystemInterface listCartWithId: aCartId.
	self assert: (aCartList includesKey: anISBN).
	self assert: (aCartList includesKey: anotherISBN).
	self
		assert: (aCartList at: anISBN)
		equals: unitsOfAnISBN.
	self
		assert: (aCartList at: anotherISBN)
		equals: unitsOfAnotherISBN.! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 00:37:25'!
test22ListCartDoesNotIncludeItemsFromOtherCarts
	| aCartId aCartList anotherCartId anotherCartList |
	aCartId _ aSystemInterface
		createCartFor: aValidUser
		withPassword: aValidUserPassword.
	aSystemInterface
		add: 3
		ofItem: anISBN
		toCartWithId: aCartId.
	anotherCartId _ aSystemInterface
		createCartFor: aValidUser
		withPassword: aValidUserPassword.
	aSystemInterface
		add: 5
		ofItem: anotherISBN
		toCartWithId: anotherCartId.
	aCartList _ aSystemInterface listCartWithId: aCartId.
	anotherCartList _ aSystemInterface listCartWithId: anotherCartId.
	self deny: (aCartList includesKey: anotherISBN).
	self deny: (anotherCartList includesKey: anISBN).! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 15:43:02'!
test23CannotListCartWithInvalidCartId
	
	self
		should: [ aSystemInterface listCartWithId: anInvalidCartId ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = 'Invalid cart id' ].! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 15:25:19'!
test24CannotCheckoutAnEmptyCart

	| aCartId |
	aCartId := aSystemInterface createCartFor: aValidUser withPassword: aValidUserPassword.

	self
		should: [ aSystemInterface checkoutCartWithId: aCartId withCreditCardNumber: aCreditCardNumber owner: aCreditCardOwner expiration: Month current next ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = 'Cannot checkout an empty cart' . 
			self assert: ( aSystemInterface listPurchasesOf: aValidUser withPassword: aValidUserPassword ) isEmpty . ].! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 15:25:03'!
test25CannotCheckoutCartWithExpiredCreditCard

	| aCartId |
	aCartId := aSystemInterface createCartFor: aValidUser withPassword: aValidUserPassword.
	aSystemInterface add: 1 ofItem: anISBN toCartWithId: aCartId .

	self
		should: [ aSystemInterface checkoutCartWithId: aCartId withCreditCardNumber: aCreditCardNumber owner: aCreditCardOwner expiration: Month current previous ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = 'Cannot checkout with an expired credit card' .
			self assert: ( aSystemInterface listPurchasesOf: aValidUser withPassword: aValidUserPassword ) isEmpty . ].! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 15:24:37'!
test26CannotCheckoutCartWithAnInvalidCartId

	self
		should: [ aSystemInterface checkoutCartWithId: anInvalidCartId withCreditCardNumber: aCreditCardNumber owner: aCreditCardOwner expiration: Month current previous ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = 'Invalid cart id' .
			self assert: ( aSystemInterface listPurchasesOf: aValidUser withPassword: aValidUserPassword ) isEmpty . ].! !

!CartTest methodsFor: 'system interface tests' stamp: 'MC 11/6/2017 15:24:16'!
test27ListPurchasesIncludesItemsBoughtByUser

	| aCartId purchases unitsOfAnISBN unitsOfAnotherISBN |

	unitsOfAnISBN := 3 .
	unitsOfAnotherISBN := 5 .	
	aCartId := aSystemInterface createCartFor: aValidUser withPassword: aValidUserPassword.
	aSystemInterface add: unitsOfAnISBN ofItem: anISBN toCartWithId: aCartId .
	aSystemInterface add: unitsOfAnotherISBN ofItem: anISBN toCartWithId: aCartId .
	aSystemInterface checkoutCartWithId: aCartId withCreditCardNumber: aCreditCardNumber owner: aCreditCardOwner expiration: Month current next .

	purchases := aSystemInterface listPurchasesOf: aValidUser withPassword: aValidUserPassword .
	
	self assert: ( purchases at: anISBN ) equals: unitsOfAnISBN .
	self assert: ( purchases at: anotherISBN ) equals: unitsOfAnotherISBN .! !


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

!Cart methodsFor: 'as yet unclassified' stamp: 'MC 10/30/2017 21:30:47'!
totalCost

	| totalCost |
	
	totalCost := 0 * peso .
	items do: [ :anItem | totalCost := totalCost + ( catalog at: anItem ) ] .
	
	^ totalCost 
! !

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
	instanceVariableNames: 'salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:29:24'!
checkout: aCart with: aCreditCard on: aDate

	aCart isEmpty ifTrue: [ ^ self error: self class emptyCartErrorDescription ] .
	( aCreditCard hasExpiredOn: aDate ) ifTrue: [ ^ self error: self class expiredCreditCardErrorDescription ] .
		
	merchantProcessor debit: ( aCart totalCost ) from: aCreditCard .

	self registerSaleInSalesBook: aCart .	

	^ salesBook last ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:28:31'!
registerSaleInSalesBook: aCart 

	| sale saleItems |
	
	saleItems := Dictionary new .
	aCart do: [ :anItem | saleItems at: anItem put: ( aCart unitsOf: anItem ) ] .
	sale := Sale ofItems: saleItems withTotalCost: ( aCart totalCost ) . 
	salesBook add: sale .
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'MC 11/2/2017 20:11:31'!
with: aSalesBook using: aMerchantProcessor

	salesBook := aSalesBook .
	merchantProcessor := aMerchantProcessor .! !

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

!Cashier class methodsFor: 'as yet unclassified' stamp: 'MC 11/2/2017 20:12:08'!
with: aSalesBook using: aMerchantProcessor

	^ self new with: aSalesBook using: aMerchantProcessor! !


!classDefinition: #CreditCard category: #'Editorial-TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 01:50:40'!
hasExpiredOn: aMonthOfYear

	^ ( aMonthOfYear start < expirationMonthOfYear start ) not ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 01:32:26'!
with: anExpirationMonthOfYear

	expirationMonthOfYear := anExpirationMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'Editorial-TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MC 10/29/2017 16:39:34'!
with: anExpirationDate

	^ self new with: anExpirationDate ! !


!classDefinition: #Sale category: #'Editorial-TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'items catalog totalCost itemsAndUnits id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!Sale methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:06:00'!
id
	
	^ id! !

!Sale methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:30:29'!
ofItems: saleItemsAndUnits withTotalCost: saleTotalCost 

	totalCost := saleTotalCost .
	itemsAndUnits := saleItemsAndUnits .
	id := self class nextId.! !

!Sale methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 16:52:51'!
totalCost 

	^ totalCost ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'Editorial-TusLibros'!
Sale class
	instanceVariableNames: 'nextId'!

!Sale class methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:31:02'!
nextId

	nextId := nextId + 1 .
	^ nextId - 1! !

!Sale class methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:32:09'!
ofItems: saleItemsAndUnits withTotalCost: saleTotalCost 

	^ self new ofItems: saleItemsAndUnits withTotalCost: saleTotalCost ! !

!Sale class methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:33:37'!
restartIds

	nextId := 1! !


!classDefinition: #SystemInterface category: #'Editorial-TusLibros'!
Object subclass: #SystemInterface
	instanceVariableNames: 'carts catalog usersAndPasswords nextCartId cashier usersSalesBooks salesBook usersSales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Editorial-TusLibros'!

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 16:22:25'!
addTo: aCollectionOfPurchases itemsOf: aSale
	
	aSale itemsAndUnits do: [  ]

	"^ aUsersSalesBook inject: Dictionary new into: [ :purchases :aSale | self addTo: purchases itemsOf: aSale ]"! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/5/2017 20:35:31'!
authenticateUser: aUser withPassword: aPassword 

	( aPassword = ( usersAndPasswords at: aUser ifAbsent: [ ^ self error: self class invalidUserErrorDescription ] ) ) ifFalse: [ ^ self error: self class invalidPasswordErrorDescription ]

! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:20:05'!
authenticatingWith: aDictionaryOfUsersAndPasswords usingItemsFrom: aCatalog registeringSalesOn: aSalesBook debitingThrough: aMerchantProcessor

	carts := Dictionary new .
	nextCartId := 1 .
	catalog := aCatalog .
	usersAndPasswords := aDictionaryOfUsersAndPasswords .
	cashier := Cashier with: aSalesBook using: aMerchantProcessor .
	salesBook := aSalesBook .
	self initializeUsersSales .! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 16:32:11'!
buildPurchasesListFrom: aUsersSalesBook
	
	^ aUsersSalesBook inject: Dictionary new into: [ :purchases :aSale | purchases addAll: ( aSale itemsAndUnits ) ]! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:19:48'!
initializeUsersSales

	usersSales := Dictionary new .
	usersAndPasswords keys do: [ :aUser | usersSales at: aUser put: OrderedCollection new ]! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/5/2017 20:36:49'!
nextCartId

	nextCartId := nextCartId + 1 .
	^ nextCartId - 1! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:22:15'!
purchasesOfUser: aUser
	
	| purchases |
	
	purchases := Dictionary new .
	salesBook do: [ :aSale | ( self saleWithId: ( aSale id ) belongsToUser: aUser ) ifTrue: [ purchases addAll: ( aSale itemsAndUnits ) ] ] .
	
	^ purchases ! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 17:11:09'!
saleWithId: saleId belongsToUser: aUser

	( usersSales at: aUser ) do: [ :aSale | ( aSale id = saleId ) ifTrue: [ ^ true ] ] .
	^ false 
! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/5/2017 20:29:36'!
validateCartId: aCartId

	( carts includesKey: aCartId ) ifFalse: [ ^ self error: self class invalidCartIdErrorDescription]! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 15:31:00'!
validateCreditCardExpiration: anExpirationMonthOfYear

	| aCreditCard |
	
	aCreditCard := CreditCard with: anExpirationMonthOfYear .
	( aCreditCard hasExpiredOn: Month current ) ifTrue: [ ^ self error: 'Cannot checkout with an expired credit card'  ] .	! !

!SystemInterface methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 15:32:50'!
validateIfCartIsEmpty: aCartId

	( ( carts at: aCartId ) isEmpty ) ifTrue: [ ^ self error: 'Cannot checkout an empty cart' ]
	! !


!SystemInterface methodsFor: 'public interface' stamp: 'MC 11/5/2017 20:28:33'!
add: aQuantity ofItem: anItem toCartWithId: aCartId

	self validateCartId: aCartId .
	( carts at: aCartId ) add: anItem units: aQuantity .! !

!SystemInterface methodsFor: 'public interface' stamp: 'MC 11/6/2017 17:24:08'!
checkoutCartWithId: aCartId withCreditCardNumber: aCreditCardNumber owner: ownersName expiration: anExpirationMonthOfYear 

	self validateCartId: aCartId .
	self validateCreditCardExpiration: anExpirationMonthOfYear . 	
	self validateIfCartIsEmpty: aCartId .

	cashier checkout: ( carts at: aCartId ) with: ( CreditCard with: anExpirationMonthOfYear ) on: Month current .! !

!SystemInterface methodsFor: 'public interface' stamp: 'MC 11/5/2017 20:37:51'!
createCartFor: aUser withPassword: aPassword

	| cartId |
	
	self authenticateUser: aUser withPassword: aPassword .
	cartId := self nextCartId .
	carts at: cartId put: ( Cart with: catalog ) .
	
	^ cartId! !

!SystemInterface methodsFor: 'public interface' stamp: 'MC 11/6/2017 14:50:02'!
listCartWithId: aCartId
	
	| cart cartList |

	self validateCartId: aCartId.
	cart := carts at: aCartId.
	cartList := Dictionary new.
	cart do: [ :anItem | cartList at: anItem put: (cart unitsOf: anItem) ].

	^ cartList.! !

!SystemInterface methodsFor: 'public interface' stamp: 'MC 11/6/2017 16:59:24'!
listPurchasesOf: aUser withPassword: aPassword

	^ self purchasesOfUser: aUser .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemInterface class' category: #'Editorial-TusLibros'!
SystemInterface class
	instanceVariableNames: ''!

!SystemInterface class methodsFor: 'as yet unclassified' stamp: 'MC 11/6/2017 15:38:19'!
authenticatingWith: aDictionaryOfUsersAndPasswords usingItemsFrom: aCatalog registeringSalesOn: aSalesBook debitingThrough: aMerchantProcessor

	^ self new authenticatingWith: aDictionaryOfUsersAndPasswords usingItemsFrom: aCatalog registeringSalesOn: aSalesBook debitingThrough: aMerchantProcessor! !

!SystemInterface class methodsFor: 'as yet unclassified' stamp: 'MC 11/5/2017 20:29:56'!
invalidCartIdErrorDescription

	^ 'Invalid cart id'! !

!SystemInterface class methodsFor: 'as yet unclassified' stamp: 'MC 11/5/2017 20:10:10'!
invalidPasswordErrorDescription

	^ 'Invalid password'! !

!SystemInterface class methodsFor: 'as yet unclassified' stamp: 'MC 11/5/2017 20:09:58'!
invalidUserErrorDescription

	^ 'Invalid user'! !
