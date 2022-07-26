/*
	__New( 0-x creation parameters )	;Creating an Object
	__Delete()	;Deleting an Object
	__Get( 1-x keynames )	;Getting a Key that doesn't exist
	__Set( 1-x keynames, setValue )	;Writing a Key that doesn't exist
	__Call( methodName, parameters )	;Calling a Method
	_NewEnum()	;Using the for loop
	__Init()	;Before __New there is
*/

class KeyUnit{
	hookedInput := null
	output := null
	__New(){
	}
	__New(hookedInput,output){
		this.hookedInput := hookedInput
		this.output := output
	}
	


}