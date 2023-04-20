<?php
require_once '../../php7/src/diff-patch.php';

// for all directories in ../data directory, run the test
$dataDir = __DIR__ . '/../data';
$dirs = scandir($dataDir);
$dirs = array_diff($dirs, array('..', '.'));

foreach ($dirs as $dir) {
  // write dir name, but keep the cursor at the same line
  echo "Testing: $dir ... ";

  $file01 = $dataDir . '/' . $dir . '/01.json';
  $file02 = $dataDir . '/' . $dir . '/02.json';

  // read file 01.json and 02.json from the directory
  $obj01 = json_decode(file_get_contents($file01), true);
  $obj02 = json_decode(file_get_contents($file02), true);

  // diff obj01 and obj02 and create a diffData object
  $diffData = diff($obj01, $obj02);

  // apply diffData to obj01 and create a new object
  $patched_obj01 = patch($obj01, $diffData);

  // check if patched_obj01 is equal to obj02
  if (json_encode($patched_obj01) !== json_encode($obj02)) {
    echo "FAILED\n";
  } else {
    echo "OK\n";
  }
}
?>