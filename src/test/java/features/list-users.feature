Feature: Listar usuarios

  Background:
    * url baseUrl

  Scenario: Listar usuarios con respuesta JSON válida
    Given path '/usuarios'
    When method get
    Then status 200
    And match response == { quantidade: '#number', usuarios: '#[]' }
    And match response.quantidade == response.usuarios.length
    And match each response.usuarios contains { nome: '#string', email: '#string', password: '#string', administrador: '#string', _id: '#string' }
