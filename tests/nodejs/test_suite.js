const fs = require( 'fs' );
const path = require( 'path' );

// import diff, patch from '../../nodejs/dist/diff.js';
const { diff, patch } = require( '../../nodejs/dist' );

// for all directories in ../data directory, run the test
const dataDir = path.join( __dirname, '../data' );
const dirs = fs.readdirSync( dataDir );

dirs.forEach( dir => {
	// write dir name, but keep the cursor at the same line
	process.stdout.write( `Testing: ${ dir } ... ` );

	const file01 = path.join( dataDir, dir, '01.json' );
	const file02 = path.join( dataDir, dir, '02.json' );

	// read file 01.json and 02.json from the directory
	const obj01 = JSON.parse( fs.readFileSync( file01, 'utf8' ) );
	const obj02 = JSON.parse( fs.readFileSync( file02, 'utf8' ) );

	// diff obj01 and obj02 and create a diffData object
	const diffData = diff( obj01, obj02 );

	// apply diffData to obj01 and create a new object
	const patched_obj01 = patch( obj01, diffData );

	// check if patched_obj01 is equal to obj02
	if ( JSON.stringify( patched_obj01 ) !== JSON.stringify( obj02 ) ) {
		console.log( "FAILED" );
	} else {
		console.log( "OK" );
	}
} );

