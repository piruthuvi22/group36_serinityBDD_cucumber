package apitesting.LibMS.stepdefinitions.getBookByIdSteps;

import apitesting.LibMS.utils.APIConfig;
import apitesting.LibMS.utils.AuthenticationUtil;
import apitesting.LibMS.utils.BookUtil;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class GetAllBooksSteps {
    Response response;
    BookUtil bookUtil = new BookUtil();

    @Given("User is logged in")
    public void user_is_logged_in() {
        AuthenticationUtil.loginAsUser();
    }

    @And("The database does not contain any books")
    public void the_database_does_not_contain_any_books() {
        response = given()
                .header("Content-Type", "application/json")
                .get(APIConfig.BASE_URI + "/api/books");
        JsonPath jsonPath = response.jsonPath();

        List<Map<String, Object>> books = jsonPath.getList("$");

        for (Map<String, Object> book : books) {
            given().delete(APIConfig.BASE_URI + "/api/books/" + book.get("id"));
        }
    }

    @When("I ask for all books")
    public void i_ask_for_all_books() {
        response = bookUtil.getAllBooks();
    }

    @Then("I should get empty array with 200 status code")
    public void i_should_get_empty_array_with_200_status() {
        response.then().statusCode(200);
    }
}
