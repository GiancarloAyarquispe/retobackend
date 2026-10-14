Feature: Eliminar usuarios

  Background:
    * url baseUrl
    * def newUser = read('classpath:helpers/user-data.js')

  Scenario: Eliminar usuario creado por la prueba y confirmar que ya no existe
    * def user = newUser('delete')
    Given path '/usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id

    Given path '/usuarios', userId
    When method delete
    Then status 200
    And match response == { message: '#string' }

    Given path '/usuarios', userId
    When method get
    Then status 400
    And match response.message == 'Usuário não encontrado'

  Scenario: Rechazar eliminación de un ID inexistente
    Given path '/usuarios', '0000000000000000'
    When method delete
    Then status 200
    And match response.message == 'Nenhum registro excluído'
