*** Settings ***
Documentation    Arquivo de Testes para Library PYTHON
Library    library_tests.py
*** Test Cases ***

*** Keywords ***
Validar Quantidade Usuarios
    ${quantidade}    Buscar Quantidade Usuarios Cadastrado 
    Log To Console        ${quantidade}  
