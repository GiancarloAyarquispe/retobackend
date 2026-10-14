Feature: Registrar usuarios

  Background:
    * url baseUrl
    * def newUser = read('classpath:helpers/user-data.js')

  Scenario: Registrar usuario válido y rechazar correo duplicado
    * def user = newUser('create')
    Given path '/usuarios'
    And request user
    When method post
    Then status 201
    And match response == { message: '#string', _id: '#string' }
    * def userId = response._id

    Given path '/usuarios'
    And request user
    When method post
    Then status 400
    And match response.message contains 'email'

    Given path '/usuarios', userId
    When method delete
    Then status 200
    And match response.message == '#string'

  Scenario: Rechazar registro con campos obligatorios vacíos
    Given path '/usuarios'
    And request { nome: '', email: '', password: '', administrador: 'false' }
    When method post
    Then status 400
    And match response contains { nome: '#string', email: '#string', password: '#string' }
