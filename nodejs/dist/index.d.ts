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
export declare const diff: (oldObject: any, newObject: any) => any;
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
export declare const patch: (oldObject: any, diffData: any) => any;
