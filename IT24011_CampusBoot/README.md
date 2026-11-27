# CampusBoot – Mini Spring Boot-Inspired Framework

| | |
|---|---|
| **Student Name** | Samiul Islam |
| **Student ID** | IT24011 |
| **University** | Mawlana Bhashani Science and Technology University (MBSTU) |
| **Department** | Information and Communication Technology (ICT) |
| **Course Title** | SEPM Lab |
| **Course Code** | ICT-3108 |
| **Assignment Topic** | Java Reflection & Custom Annotations |
| **Total Marks** | 10 |

---

## 1. About the Project

CampusBoot is a small framework inspired by Spring Boot. It uses only the Java Standard Library (no external dependencies) and shows how these ideas work internally:

- Custom annotations
- Java Reflection
- IoC Container (bean registration)
- Configuration value injection
- Field validation
- URL routing

## 2. Requirements

- JDK 11 or higher (JDK 17 or 21 also works)
- IntelliJ IDEA (Community or Ultimate)
- No Maven, Gradle or other libraries are needed

## 3. Project Structure

```
CampusBoot/
├── src/
│   ├── Component.java        (annotation – marks a bean class)
│   ├── Value.java            (annotation – config injection)
│   ├── Range.java            (annotation – validation range)
│   ├── Route.java            (annotation – URL path)
│   ├── Container.java        (scan, injectValues, getBean)
│   ├── Validator.java        (validate objects using @Range)
│   ├── Router.java           (dispatch path to @Route method)
│   ├── GradeController.java  (starter code – controller bean)
│   ├── ReportPrinter.java    (starter code – no @Component)
│   ├── Student.java          (starter code – validated object)
│   └── Main.java             (starter code – program entry point)
├── answers.txt               (reflection questions Q1–Q3)
└── README.md
```

All Java files are in the default package.

## 4. Step-by-Step: Run in IntelliJ IDEA

1. Extract `IT24011_CampusBoot.zip`. You will get a folder named `CampusBoot`.
2. Open IntelliJ IDEA.
3. Click **File > New > Project from Existing Sources...**
4. Select the `CampusBoot` folder and click **OK**.
5. Choose **Create project from existing sources** and click **Next** until the project opens.
6. Set the JDK: **File > Project Structure > Project > SDK**, choose JDK 11 or higher, then click **OK**.
7. In the Project panel, right-click the `src` folder and choose **Mark Directory as > Sources Root**. The folder icon turns blue.
8. Open `src/Main.java`.
9. Click the green **Run** button next to `public static void main`, or press **Shift + F10**.
10. The output appears in the **Run** window at the bottom (see Section 6).

If IntelliJ shows "Cannot resolve symbol", check step 7 (Sources Root) and step 6 (JDK) again.

## 5. Step-by-Step: Run from Terminal (optional)

1. Open a terminal and go into the project folder:
   ```
   cd CampusBoot
   ```
2. Create an output folder:
   ```
   mkdir out
   ```
3. Compile all files:
   ```
   javac -d out src/*.java
   ```
   (On Windows PowerShell use: `javac -d out (Get-ChildItem src\*.java).FullName`)
4. Run the program:
   ```
   java -cp out Main
   ```

## 6. Expected Output

```
[Container] Registered: gradeController (GradeController)
[Container] Skipped: ReportPrinter (no @Component)
[Container] Injected: app.name -> GradeController.appName
[Container] Injected: app.passMark -> GradeController.passMark
--- Validation ---
VIOLATION: score - Score must be between 0 and 100 (actual: 120)
OK
VIOLATION: semester - Value out of range (actual: 15)
--- Routing ---
[Router] /hello -> Welcome to CampusBoot
[Router] /status -> Pass mark is 40
[Router] /unknown -> 404 Not Found: /unknown
```

## 7. How Each Part Works

**Part A – Annotations (2 marks)**
`@Component`, `@Value`, `@Range` and `@Route` all use `@Retention(RetentionPolicy.RUNTIME)` so Reflection can read them while the program runs.

**Part B – Container (3 marks)**
- `scan(Class<?>...)` checks for `@Component`, creates the object with its no-argument constructor, and stores it in a `Map<String, Object>`. If the annotation value is empty, the bean name is the simple class name with a lowercase first letter. Classes without `@Component` are skipped.
- `injectValues(Map<String,String>)` finds fields with `@Value`, reads the config key, converts the text to `int` with `Integer.parseInt()` when needed, uses `setAccessible(true)`, and sets the field. Missing keys, bad numbers and unsupported types print a warning to `System.err` and do not crash the program.
- `getBean(String)` returns the bean with that name.

**Part C – Validator (2 marks)**
`Validator.validate(Object)` reads every `@Range` field, checks that the value is between `min` and `max` (inclusive), and returns messages in the format `fieldName - message (actual: value)`. It returns an empty list when everything is valid.

**Part D – Router (2 marks)**
`Router.dispatch(Container, String)` looks through all beans, finds methods with `@Route`, compares the path, and calls the matching method with `Method.invoke()`. If nothing matches it returns `404 Not Found: <path>`.

**Part E – Reflection Questions (1 mark)**
The answers are in `answers.txt`.

## 8. Note About the `@Route` Compatibility Fix

The assignment says `Route` has a `path()` element, but the starter code writes `@Route("/hello")`. Java only allows that short form when the element is named `value()`. This is an inconsistency in the starter code.

To fix it with the smallest change, `Route.java` keeps `path()` and adds a `value()` alias. Both have the default `""`. `Router` uses `path()` if it is set, otherwise it uses `value()`. The starter `GradeController` is unchanged, and both `@Route("/hello")` and `@Route(path = "/hello")` work.

## 9. Extra Helper Method

`Container` has a small extra method `getBeans()` so that `Router` can search all registered beans.

## 10. Testing Done

- Compiled with Java 11 target (`javac --release 11`) with no errors.
- Program output compared line by line with the teacher's sample output: exact match.
- Tested both `@Route("/hello")` and `@Route(path = "/hello")`.
