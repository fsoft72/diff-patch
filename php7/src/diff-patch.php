<?php

function diff($oldObject, $newObject) {
    $patch = [];

    foreach ($newObject as $key => $newValue) {
        $oldValue = $oldObject[$key] ?? null;

        if ($oldValue === null) {
            $patch[$key] = $newValue;
        } elseif ($newValue === null) {
            $patch[$key] = null;
        } elseif (is_array($newValue)) {
            $subPatch = diff($oldValue, $newValue);
            if (!empty($subPatch)) {
                $patch[$key] = $subPatch;
            }
        } elseif ($oldValue !== $newValue) {
            $patch[$key] = $newValue;
        }
    }

    foreach ($oldObject as $key => $oldValue) {
        if (!array_key_exists($key, $newObject)) {
            $patch[$key] = null;
        }
    }

    return $patch;
}

// A function that removes null values from an associative multidimensional array
function array_filter_recursive($input) {
    foreach ($input as &$value) {
      if (is_array($value)) {
        $value = array_filter_recursive($value);
      }
    }
    // Return the filtered array, this will remove any elements from the input array that are null or empty
    return array_filter($input);
  }

function patch($oldObject, $diffData) {
    return array_filter_recursive(array_replace_recursive($oldObject, $diffData));
}
