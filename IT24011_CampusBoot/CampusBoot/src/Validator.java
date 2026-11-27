import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class Validator {
    public static List<String> validate(Object obj) {
        List<String> errors = new ArrayList<>();
        for (Field field : obj.getClass().getDeclaredFields()) {
            Range range = field.getAnnotation(Range.class);
            if (range == null) {
                continue;
            }
            try {
                field.setAccessible(true);
                int actual = field.getInt(obj);
                if (actual < range.min() || actual > range.max()) {
                    errors.add(field.getName() + " - " + range.message() + " (actual: " + actual + ")");
                }
            } catch (IllegalAccessException | IllegalArgumentException e) {
                System.err.println("[Validator] Cannot check field " + field.getName() + ": " + e.getMessage());
            }
        }
        return errors;
    }
}
