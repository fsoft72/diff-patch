// import diff, patch from '../../nodejs/dist/diff.js';
const { diff, patch } = require( '../../nodejs/dist' );

const a = {
	"a": 1,
	"b": 2,
	"c": {
		"d": 3,
		"e": 4,
		"f": {
			"g": 5,
			"h": 6,
		},
	},
};

const b = {
	"a": 1,
	// "b": 2,    // b is deleted
	"c": {
		"d": 9,  // d is changed
		"e": 4,
		"f": {
			"g": 5,
			"h": 7,  // h is changed
			"i": 10,  // i is added
		},
	},
};

// diff a and b and create a diffData object
const diffData = diff( a, b );

// print diffData in the console
console.log( "DIFF DATA\n", JSON.stringify( diffData, null, 2 ) );

// apply diffData to a and create a new object
const patched_a = patch( a, diffData );

// print patched_a in the console
console.log( "\n\nPATCHED OBJ\n", JSON.stringify( patched_a, null, 2 ) );

// check if patched_a is equal to b
console.log( "\n\nSAME OBJECT: ", JSON.stringify( patched_a ) === JSON.stringify( b ) );
