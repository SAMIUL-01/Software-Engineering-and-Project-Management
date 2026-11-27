import java.lang.reflect.Field;
import java.util.LinkedHashMap;
import java.util.Map;

public class Container {
    private final Map<String, Object> beans = new LinkedHashMap<>();

    public void scan(Class<?>... classes) {
        for (Class<?> cls : classes) {
            Component comp = cls.getAnnotation(Component.class);
            if (comp == null) {
                System.out.println("[Container] Skipped: " + cls.getSimpleName() + " (no @Component)");
                continue;
            }
            String name = comp.value();
            if (name.isEmpty()) {
                String simple = cls.getSimpleName();
                name = Character.toLowerCase(simple.charAt(0)) + simple.substring(1);
            }
            try {
                Object bean = cls.getDeclaredConstructor().newInstance();
                beans.put(name, bean);
                System.out.println("[Container] Registered: " + name + " (" + cls.getSimpleName() + ")");
            } catch (Exception e) {
                System.err.println("[Container] Could not create " + cls.getSimpleName() + ": " + e);
            }
        }
    }

    public void injectValues(Map<String, String> config) {
        for (Object bean : beans.values()) {
            Class<?> cls = bean.getClass();
            for (Field field : cls.getDeclaredFields()) {
                Value val = field.getAnnotation(Value.class);
                if (val == null) {
                    continue;
                }
                String key = val.value();
                String raw = config.get(key);
                if (raw == null) {
                    System.err.println("[Container] Missing config key: " + key);
                    continue;
                }
                try {
                    field.setAccessible(true);
                    Class<?> type = field.getType();
                    if (type == String.class) {
                        field.set(bean, raw);
                    } else if (type == int.class || type == Integer.class) {
                        field.set(bean, Integer.parseInt(raw.trim()));
                    } else {
                        System.err.println("[Container] Unsupported field type for "
                                + field.getName() + ": " + type.getSimpleName());
                        continue;
                    }
                    System.out.println("[Container] Injected: " + key + " -> "
                            + cls.getSimpleName() + "." + field.getName());
                } catch (NumberFormatException e) {
                    System.err.println("[Container] Value for " + key + " is not a valid int: " + raw);
                } catch (IllegalAccessException e) {
                    System.err.println("[Container] Cannot access field " + field.getName());
                }
            }
        }
    }

    public Object getBean(String name) {
        return beans.get(name);
    }

    // Helper so Router can search all beans
    public Map<String, Object> getBeans() {
        return beans;
    }
}
