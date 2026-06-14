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

    @CP01_AddBook_HappyPath
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
      * match response.Msg == 'successfully added'
      * match response.ID == expectedId
      Examples:
        | name         | isbn | aisle | author |
        | El Niagara 2 | 333  | 2512  | PaoloV |
        | El Halcon 3  | 444  | 2312  | NeilV  |

    @CP02_AddBook_TimeResponse
    Scenario: [SE][SEC][HU-Automate Service Library] [Endpoint AddBook] Validate timeResponse < 500 ms
      Given path '/Library/Addbook.php'
      And headers headerApiLibraryPost
      And request bodyAddBook
      When method POST
      Then status 200
      * print response
      * print 'Tiempo real de respuesta del servicio:', responseTime, 'ms'
      * assert responseTime < 500

    @CP03_AddBook_ValidateStructureResponse
    Scenario: [API][SEC][HU-Automate Service Library][Endpoint AddBook] Validate the response successful structure
      Given path '/Library/Addbook.php'
      And headers headerApiLibraryPost
      And request bodyAddBook
      When method POST
      Then status 200
      * print response
      * match response contains {ID: '#string', Msg: '#string'}

    @CP04_AddBook_ValidateStructureRequest
    Scenario: [API][SEC][HU-Automate Service Library][Endpoint AddBook]  Validate the request structure and data type
      Given path '/Library/Addbook.php'
      And headers headerApiLibraryPost
      And request bodyAddBook
      When method POST
      Then status 200
      * print response
      * match bodyAddBook contains{name: '#string', isbn: '#string', aisle: '#string', author: '#string'}
      * print bodyAddBook

    @CP05_AddBook_ValidateResponseStatus500
    Scenario: [API][ERR][HU-Automate Service Library][Endpoint AddBook]  Validate 500 Internal Server Error when aisle is non-numeric for Add new book to the library
      Given path '/Library/Addbook.php'
      And headers headerApiLibraryPost
      And request bodyErrorAddBook
      When method POST
      Then status 500
      * print response
      * match response == {}


    @CP06_GetBook_HappyPath
    Scenario Outline: [SE][PRI][HU-Automate Service Library][Endpoint GetBook] Validate response successful
      Given path '/Library/GetBook.php'
      And param ID = '<idBook>'
      And headers headerApiLibraryGet
      When method GET
      Then status 200
      * print response
      Examples:
        | idBook |
        | bcd222 |




    @CP07_GetBook_TimeResponse
    Scenario Outline: [SE][SEC][HU-Automate Service Library] [Endpoint GetBook] Validate timeResponse < 500 ms
      Given path '/Library/GetBook.php'
      And param ID = '<idBook>'
      And headers headerApiLibraryGet
      When method GET
      Then status 200
      * print 'Tiempo real de respuesta del servicio:', responseTime, 'ms'
      * assert responseTime < 500
      Examples:
        | idBook |
        | bcd222 |

    @CP08_GetBook_ValidateStructureResponse
    Scenario Outline: [SE][PRI][HU-Automate Service Library][Endpoint GetBook] Validate the response successful structure
      Given path '/Library/GetBook.php'
      And param ID = '<idBook>'
      And headers headerApiLibraryGet
      When method GET
      Then status 200
      * print response
      * match response contains {book_name: '#string', isbn: '#string',aisle: '#string', author: '#string'}
      Examples:
        | idBook |
        | bcd222 |

    @CP09_GetBook_ValidateResponseStatus404
    Scenario Outline: [SE][ERR][HU-Automate Service Library][Endpoint GetBook] Validate response error 404 not found
      Given path '/Library/GetBook.php'
      And param ID = '<idBook>'
      And headers headerApiLibraryGet
      When method GET
      Then status 404
      * print response
      * match response.msg == 'The book by requested bookid / author name does not exists!'
      Examples:
        | idBook         |
        | xyzoñoooooosds |

    @CP10_DeleteBook_HappyPath
    Scenario Outline: [SE][PRI][HU-Automate Service Library][Endpoint DeleteBook] Validate response successful, request and response structure
      Given path '/Library/DeleteBook.php'
      And headers headerApiLibraryPost
      And bodyDeleteBook.ID = '<idBook>'
      And request bodyDeleteBook
      When method DELETE
      Then status 200
      * print response
      * match response.msg == 'book is successfully deleted'
      * match response contains {msg: '#string'}
      * match bodyDeleteBook contains {ID: '#string'}
      Examples:
        | idBook  |
        | 3332512 |


    @CP11_DeleteBook_TimeResponse
    Scenario Outline: [SE][SEC][HU-Automate Service Library] [Endpoint DeleteBook] Validate timeResponse < 500 ms
      Given path '/Library/DeleteBook.php'
      And headers headerApiLibraryPost
      And bodyDeleteBook.ID = '<idBook>'
      And request bodyDeleteBook
      When method DELETE
      Then status 200
      * print 'Tiempo real de respuesta del servicio:', responseTime, 'ms'
      * assert responseTime < 500
      Examples:
        | idBook  |
        | 4442312 |


    @CP12_DeleteBook_ValidateResponseStatus404
    Scenario Outline: [SE][ERR][HU-Automate Service Library][Endpoint DeleteBook] Validate response error 404 not found
      Given path '/Library/DeleteBook.php'
      And headers headerApiLibraryPost
      And request bodyDeleteBook
      And bodyDeleteBook.ID = '<idBook>'
      When method DELETE
      Then status 404
      * print response
      * match response.msg == 'Delete Book operation failed, looks like the book doesnt exists'
      Examples:
        | idBook         |
        | a23234xyyyzz87 |
