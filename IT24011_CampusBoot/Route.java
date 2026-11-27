import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * The specification asks for path(), but the starter code writes @Route("/hello").
 * Java only allows that shorthand if the element is named value().
 * So value() is added as a small compatibility alias. Both elements have
 * default "" so that @Route("/hello") and @Route(path = "/hello") both compile.
 * Router uses path() if it is set, otherwise value().
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Route {
    String path() default "";

    // Compatibility alias for the starter code's @Route("/hello")
    String value() default "";
}
