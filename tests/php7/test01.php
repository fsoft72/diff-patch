<?php
// Import diff and patch functions from another file
require '../../php7/src/diff-patch.php';

// Define two associative arrays
$a = [
    "a" => 1,
    "b" => 2,
    "c" => [
        "d" => 3,
        "e" => 4,
        "f" => [
            "g" => 5,
            "h" => 6,
        ],
    ],
];

$b = [
    "a" => 1,
    // "b" => 2,    // b is deleted
    "c" => [
        "d" => 9,  // d is changed
        "e" => 4,
        "f" => [
            "g" => 5,
            "h" => 7,  // h is changed
            "i" => 10,  // i is added
        ],
    ],
];

// Diff a and b and create a diffData string
$diffData = diff($a, $b);
$diffData = json_encode($diffData);

// Print diffData in the console
echo "DIFF DATA\n";
echo $diffData;

// Apply diffData to a and create a new string
$patched_a = patch($a, json_decode($diffData, true));
$patched_a = json_encode($patched_a);

// Print patched_a in the console
echo "\n\nPATCHED OBJ\n";
echo $patched_a;

// Check if patched_a is equal to b
echo "\n\nSAME OBJECT: ";
echo $patched_a === json_encode($b) ? 'true' : 'false';
