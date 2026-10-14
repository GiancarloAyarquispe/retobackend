package pe.qa.serverest;

import com.intuit.karate.junit5.Karate;

class UsersApiTest {

    @Karate.Test
    Karate usersApi() {
        return Karate.run("classpath:features");
    }
}
