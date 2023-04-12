#!/usr/bin/env python3

import json

null = None


def _make_deep_patch_list(old_list: list, new_list: list):
    patch = {}

    # expand old_list to the same length of new_list
    old_list = old_list + [null] * (len(new_list) - len(old_list))

    for i in range(0, len(new_list)):
        old_value = old_list[i]
        new_value = new_list[i]

        if old_value is null:
            patch[str(i)] = new_value
        elif new_value is null:
            patch[str(i)] = null
        elif type(new_value) is list:
            sub_patch = _make_deep_patch_list(old_value, new_value)
            if sub_patch:
                patch[str(i)] = sub_patch
        elif type(new_value) is dict:
            sub_patch = _make_deep_patch_dict(old_value, new_value)
            if sub_patch:
                patch[str(i)] = sub_patch
        elif old_value != new_value:
            patch[str(i)] = new_value

    return patch


def _make_deep_patch_dict(old_dict: dict, new_dict: dict):
    patch = {}
    keys = new_dict.keys()

    for key in keys:
        old_value = old_dict.get(key, null)
        new_value = new_dict.get(key, null)

        if old_value is null:
            patch[key] = new_value
        elif new_value is null:
            patch[key] = null
        elif type(new_value) is list:
            sub_patch = _make_deep_patch_list(old_value, new_value)
            if sub_patch:
                patch[key] = sub_patch
        elif type(new_value) is dict:
            sub_patch = _make_deep_patch_dict(old_value, new_value)
            if sub_patch:
                patch[key] = sub_patch
        elif old_value != new_value:
            patch[key] = new_value

    # now scan old_dict keys and delete the ones that are not present in new_dict
    keys = old_dict.keys()
    for key in keys:
        if key not in new_dict:
            patch[key] = null

    return patch


def diff(old_object, new_object):
    """
    diffData = diff(oldObject, newObject)

    creates a patch object that can be used to update the oldObject to the newObject
    the patch object has the same structure as the newObject, but with the following differences:
    fields that are equal in both objects are not present in the patch object
    fields that are different in both objects are present in the patch object, with the newObject value
    fields that are NOT present in the oldObject are present in the patch object
    fields that are NOT present in the newObject are present in the patch object with the value null
    """

    if type(old_object) is dict:
        return _make_deep_patch_dict(old_object, new_object)

    if type(old_object) is list:
        return _make_deep_patch_list(old_object, new_object)


def patch(old_object, diff_data):
    new_object = json.loads(json.dumps(old_object))
    keys = diff_data.keys()

    for key in keys:
        new_value = diff_data[key]
        try:
            key_number = int(key)
        except ValueError:
            key_number = -1

        # this is an array modification
        if key_number >= 0:
            if key_number >= len(new_object):
                new_object.append(new_value)
            else:
                new_object[key_number] = patch(new_object[key_number], new_value)
        else:
            # this is a key/value modification

            if new_value is None:
                del new_object[key]
                continue

            if key not in new_object:
                new_object[key] = new_value
                continue

            if isinstance(new_value, dict):
                new_object[key] = patch(new_object[key], new_value)
            else:
                new_object[key] = new_value

    return new_object
