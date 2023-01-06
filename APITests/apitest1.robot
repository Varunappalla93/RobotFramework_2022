*** Settings ***
Library     BuiltIn
Library     Collections
Library     RequestsLibrary

*** Variables ***
${base_url}     https://www.rahulshettyacademy.com
${bookid}
${bookname}     RobotFramework

*** Test Cases ***
Dictionary Concepts
    &{data}=    create dictionary   name=varun  age=29  gender=Male
    log to console    ${data}

    dictionary should contain key       ${data}     name
    dictionary should not contain key     ${data}   naam

    log to console      ${data}[gender]  # Male
    # or
    ${value}=   get from dictionary     ${data}     name
    log to console      ${value}   # varun


Add book into library API
    &{req_body}=    create dictionary   name=${bookname}   author=Varun    isbn=33221114   aisle=28764
    ${response}=    POST      ${base_url}/Library/Addbook.php     json=${req_body}       expected_status=200
    log to console  ${response.json()}
#.{'Msg': 'successfully added', 'ID': '3322119128764'}

    dictionary should contain key   ${response.json()}      ID

    ${bookid}=   get from dictionary      ${response.json()}      ID
    set global variable     ${bookid}
    log to console      ${bookid}
    should be equal as strings      successfully added   ${response.json()}[Msg]

    status should be    200     ${response}


get book from library API
    ${get_resp}=    get     ${base_url}/Library/GetBook.php     params=ID=${bookid}     expected_status=200
    log to console  ${get_resp.json()}
#[{'book_name': 'RobotFrameworkCourse', 'isbn': '33221195', 'aisle': '28764', 'author': 'Varun'}]

    ${a}=   get from list      ${get_resp.json()}       0

    log to console  ${a}
#    {'book_name': 'RobotFrameworkCourse', 'isbn': '33221195', 'aisle': '28764', 'author': 'Varun'}

    should be equal as strings  ${bookname}     ${get_resp.json()}[0][book_name]


delete book from library API
       &{deletereq}=    create dictionary       ID= ${bookid}
       ${deleteresp}=     POST     ${base_url}/Library/DeleteBook.php      json= ${deletereq}      expected_status=200
       log to console  ${deleteresp.json()}
       should be equal as strings       book is successfully deleted     ${deleteresp.json()}[msg]