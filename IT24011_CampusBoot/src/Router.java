import java.lang.reflect.Method;

public class Router {
    public static String dispatch(Container c, String path) {
        for (Object bean : c.getBeans().values()) {
            for (Method method : bean.getClass().getDeclaredMethods()) {
                Route route = method.getAnnotation(Route.class);
                if (route == null) {
                    continue;
                }
                // path() is the specified element; value() is the alias for @Route("/x")
                String routePath = route.path().isEmpty() ? route.value() : route.path();
                if (routePath.equals(path)) {
                    try {
                        method.setAccessible(true);
                        return (String) method.invoke(bean);
                    } catch (Exception e) {
                        return "500 Error: " + e.getMessage();
                    }
                }
            }
        }
        return "404 Not Found: " + path;
    }
}
