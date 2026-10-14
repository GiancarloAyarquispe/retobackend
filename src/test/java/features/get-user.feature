Feature: Consultar usuario por identificador

  Background:
    * url baseUrl
    * def newUser = read('classpath:helpers/user-data.js')

  Scenario: Consultar usuario existente por ID
    * def user = newUser('get')
    Given path '/usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id

    Given path '/usuarios', userId
    When method get
    Then status 200
    And match response contains { nome: '#string', email: '#string', password: '#string', administrador: '#string', _id: '#(userId)' }
    And match response.email == user.email

    Given path '/usuarios', userId
    When method delete
    Then status 200

  Scenario: Informar error al consultar un ID inexistente
    Given path '/usuarios', '0000000000000000'
    When method get
    Then status 400
    And match response == { message: '#string' }
