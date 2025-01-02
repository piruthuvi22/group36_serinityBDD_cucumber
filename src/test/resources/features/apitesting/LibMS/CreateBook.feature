Feature: Create a book
  As an authenticated user
  I want to add a book to the library
  So that it is stored in the library system

  Scenario: Successfully create a book with a id
    Given the user is authenticated with username "user" and password "password"
    When I send a POST request to "/api/books" with:
      """
      {
        "id": 17,
        "title": "Hello world",
        "author": "Sagini"
      }
      """
    Then I should receive a 201 response code
    And the response should contain the same book details:
      """
      {
        "id": 17,
        "title": "Hello world",
        "author": "Sagini"
      }
      """
  Scenario: Attempt to create book without author
    Given user is logged In
    When the user sends a POST request with author's value as null
    Then response status code should be 400

  Scenario: Attempt to create book without ID
    Given user is logged In
    When the user sends a POST request with id's value as null
    Then response status code should be 201

  Scenario: Attempt to create a book with an empty body
    Given I am logged in as an admin
    When I send a POST request to "/api/books" with:
    """
    {}
    """
    Then I should receive a 400 response code

  Scenario: Create book without title
    Given User is logged in
    When I create a new book request to "/api/books" without title
    """
    {
      "id": 160,
      "author": "Piruthuvi"
    }
    """
    Then Response status code should be 400

  Scenario: Attempt to create a book with the same name but a different author
    Given I am logged in as a user
    And the database already contains a book with ID 1:
      """
      {
        "id": 1,
        "title": "Hello world",
        "author": "Sagini"
      }
      """
    When I send  a POST request to "/api/books" with:
      """
      {
        "id": 1,
        "title": "Hello world",
        "author": "Kelvin"
      }
      """
    Then I should receive  200 response code