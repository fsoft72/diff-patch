public static Map<String, Object> diff(Map<String, Object> oldObject, Map<String, Object> newObject) {
    Map<String, Object> diffData = new HashMap<>();
    for (String key : newObject.keySet()) {
        Object oldValue = oldObject.get(key);
        Object newValue = newObject.get(key);
        if (oldValue == null) {
            diffData.put(key, newValue);
        } else if (newValue == null) {
            diffData.put(key, null);
        } else if (newValue instanceof Map) {
            Map<String, Object> subPatch = diff((Map<String, Object>) oldValue, (Map<String, Object>) newValue);
            if (!subPatch.isEmpty()) {
                diffData.put(key, subPatch);
            }
        } else if (!oldValue.equals(newValue)) {
            diffData.put(key, newValue);
        }
    }
    for (String key : oldObject.keySet()) {
        if (!newObject.containsKey(key)) {
            diffData.put(key, null);
        }
    }
    return diffData;
}

private static int getNumber(String key) {
    try {
        return Integer.parseInt(key);
    } catch (NumberFormatException e) {
        return -1;
    }
}

public static Map<String, Object> patch(Map<String, Object> oldObject, Map<String, Object> diffData) {
    Map<String, Object> newObject = new HashMap<>();
    newObject.putAll(oldObject);
    for (String key : diffData.keySet()) {
        Object newValue = diffData.get(key);
        int keyNumber = getNumber(key);
        if (keyNumber >= 0) {
            if (keyNumber >= newObject.size()) {
                newObject.put(Integer.toString(keyNumber), newValue);
            } else {
                Map<String, Object> subObject = (Map<String, Object>) newObject.get(Integer.toString(keyNumber));
                newObject.put(Integer.toString(keyNumber), patch(subObject, (Map<String, Object>) newValue));
            }
        } else {
            if (newValue == null) {
                newObject.remove(key);
            } else if (!newObject.containsKey(key)) {
                newObject.put(key, newValue);
            } else if (newValue instanceof Map) {
                Map<String, Object> subObject = (Map<String, Object>) newObject.get(key);
                newObject.put(key, patch(subObject, (Map<String, Object>) newValue));
            } else {
                newObject.put(key, newValue);
            }
        }
    }
    return newObject;
}