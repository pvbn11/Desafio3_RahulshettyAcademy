  # Autor: Paolo Neil Valladares Bazalar
    # Repositorio: https://github.com/pvbn11/Desafio3_RahulshettyAcademy
    # Descripción: Suite de automatización para la API de Library de RahulShetty Academy

  Feature: Validación de los endpoint tipo CRUd de Rahulshetty Academy Library
    Background:
      Given url baseUrl
      * def bodyAddBook = read('classpath:body/AddBookBody.json')
      * def bodyErrorAddBook = read('classpath:body/AddBookBodyError500.json')
      * def bodyDeleteBook = read('classpath:body/DeleteBookBody.json')
      * def headerApiLibraryPost = read('classpath:headers/libraryEndpointsHeaderPost.json')
      * def headerApiLibraryGet = read('classpath:headers/libraryEndpointsHeaderGet.json')

    @CP01_AddBook
    Scenario Outline: [SE][PRI][HU-Automate Service Library][Endpoint AddBook] Validate response successful
      Given path '/Library/Addbook.php'
      And headers headerApiLibraryPost
      And request bodyAddBook.name = '<name>'
      And request bodyAddBook.isbn = '<isbn>'
      And request bodyAddBook.aisle = '<aisle>'
      And request bodyAddBook.author = '<author>'
      * def expectedId = bodyAddBook.isbn + bodyAddBook.aisle
      And request bodyAddBook
      When method POST
      Then status 200
      * print response
      * print expectedId
      * match response.Msg == 'successfully added'
      * match response.ID == expectedId
      * match bodyAddBook contains{name: '#string', isbn: '#string', aisle: '#string', author: '#string'}
      * match response contains {ID: '#string', Msg: '#string'}

      Examples:
        | name        | isbn  | aisle | author   |
        | Bolt 2      | 01213 | 1154  | Paolo VB |
        | Huacho Peru | 01214 | 1155  | Neil VB  |


    @CP02_GetBook
    Scenario Outline: [SE][PRI][HU-Automate Service Library][Endpoint GetBook] Validate response successful
      Given path '/Library/GetBook.php'
      And param ID = '<idBook>'
      And headers headerApiLibraryGet
      When method GET
      Then status 200
      * print response
      * match response contains {book_name: '#string', isbn: '#string',aisle: '#string', author: '#string'}

      Examples:
        | idBook    |
        | 012131154 |
        | 012141155 |

    @CP03_DeleteBook_HappyPath
    Scenario Outline: [SE][PRI][HU-Automate Service Library][Endpoint DeleteBook] Validate response successful, request and response structure
      Given path '/Library/DeleteBook.php'
      And headers headerApiLibraryPost
      And request bodyDeleteBook
      And bodyDeleteBook.ID = '<idBook>'
      When method DELETE
      Then status 200
      * print response
      * match response.msg == 'book is successfully deleted'
      * match response contains {msg: '#string'}
      * match bodyDeleteBook contains {ID: '#string'}

      Examples:
        | idBook    |
        | 012131154 |
        | 012141155 |


    @GetBook
    Scenario Outline: [SE][PRI][HU-Automate Service Library][Endpoint GetBook] Validate response successful
      Given path '/Library/GetBook.php'
      And param ID = '<idBook>'
      And headers headerApiLibraryGet
      When method GET
      Then status 404
      * print response
      * match response.msg == 'The book by requested bookid / author name does not exists!'

      Examples:
        | idBook    |
        | 012131154 |
        | 012141155 |