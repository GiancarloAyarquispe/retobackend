Feature: Actualizar usuarios

  Background:
    * url baseUrl
    * def newUser = read('classpath:helpers/user-data.js')

  Scenario: Actualizar un usuario existente y verificar persistencia
    * def user = newUser('update')
    Given path '/usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id
    * def changedUser = { nome: 'QA actualizado', email: '#(user.email)', password: '#(user.password)', administrador: 'false' }

    Given path '/usuarios', userId
    And request changedUser
    When method put
    Then status 200
    And match response == { message: '#string' }

    Given path '/usuarios', userId
    When method get
    Then status 200
    And match response.nome == 'QA actualizado'
    And match response.email == user.email

    Given path '/usuarios', userId
    When method delete
    Then status 200

  Scenario: Rechazar actualización con datos requeridos inválidos
    * def user = newUser('invalid-update')
    Given path '/usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id

    Given path '/usuarios', userId
    And request { nome: '', email: '', password: '', administrador: 'false' }
    When method put
    Then status 400
    And match response contains { nome: '#string', email: '#string', password: '#string' }

    Given path '/usuarios', userId
    When method delete
    Then status 200
