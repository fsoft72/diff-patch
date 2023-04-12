/**
 * diff (oldObject, newObject)
 *
 * creates a diff object that can be used to update the oldObject to the newObject
 *
 * the patch object has the same structure as the newObject, but with the following differences:
 * - fields that are equal in both objects are not present in the patch object
 * - fields that are different in both objects are present in the patch object, with the newObject value
 * - fields that are NOT present in the oldObject are present in the patch object
 * - fields that are NOT present in the newObject are present in the patch object with the value null
 *
 * @param oldObject - the original object
 * @param newObject - the new object
 * @returns the patch object
 */
export const diff = ( oldObject: any, newObject: any ) => {
	var patch: any = {};
	var keys = Object.keys( newObject );

	keys.forEach( ( key ) => {
		var oldValue = oldObject[ key ];
		var newValue = newObject[ key ];

		if ( oldValue === undefined ) {
			patch[ key ] = newValue;
		} else if ( newValue === undefined ) {
			patch[ key ] = null;
		} else if ( typeof newValue === 'object' ) {
			var subPatch = diff( oldValue, newValue );
			if ( Object.keys( subPatch ).length > 0 ) {
				patch[ key ] = subPatch;
			}
		} else if ( oldValue !== newValue ) {
			patch[ key ] = newValue;
		}
	} );

	// now scan oldObject keys and delete the ones that are not present in newObject
	keys = Object.keys( oldObject );
	keys.forEach( ( key ) => {
		if ( newObject[ key ] === undefined ) {
			patch[ key ] = null;
		}
	} );

	return patch;
};

/**
 * patch(oldObject, diffData)
 *
 * applies the `diffData` to the oldObject, and returns the newObject
 *
 * starts from the patch object, and for each field:
 * - if the field is not present in the oldObject, it is added
 * - if the field is present in the oldObject, and it is an object, it is recursively patched
 * - if the field key is a number, it is treated as an array index, and the oldObject is treated as an array
 *
 * @param oldObject - the original object
 * @param diffData - the diff information from the diff function
 * @returns the new object
 */
export const patch = ( oldObject: any, diffData: any ) => {
	var newObject = JSON.parse( JSON.stringify( oldObject ) );
	var keys = Object.keys( diffData );

	keys.forEach( ( key ) => {
		var newValue = diffData[ key ];
		var keyNumber = Number( key );

		// this is an array modification
		if ( keyNumber >= 0 ) {
			if ( keyNumber >= newObject.length ) {
				newObject.push( newValue );
			} else {
				newObject[ keyNumber ] = patch( newObject[ keyNumber ], newValue );
			}
		} else {
			// this is a key/value modification

			if ( newValue === null ) {
				delete newObject[ key ];
				return;
			}

			if ( newObject[ key ] === undefined ) {
				newObject[ key ] = newValue;
				return;
			}

			if ( typeof newValue === 'object' ) {
				newObject[ key ] = patch( newObject[ key ], newValue );
			} else {
				newObject[ key ] = newValue;
			}
		}
	} );
	return newObject;
};