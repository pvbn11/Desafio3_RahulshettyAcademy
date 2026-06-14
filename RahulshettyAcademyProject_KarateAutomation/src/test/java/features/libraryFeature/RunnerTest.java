package features.libraryFeature;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.BeforeAll;

class RunnerTest {
    @BeforeAll
    public static void beforeAll() {
        System.setProperty("karate.env", "e2e");
    }

    @Karate.Test
    Karate testUsers() {
        return Karate.run(
        // "classpath:features/libraryFeature/library.feature").relativeTo(getClass());
        "classpath:features/libraryFeature/pruebaIntegralLibrary.feature").relativeTo(getClass());

    }

}
