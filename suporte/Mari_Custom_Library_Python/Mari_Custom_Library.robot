*** Settings ***
Documentation    Arquivo de Testes para Library PYTHON
Library    ./library_tests.py

*** Test Cases ***
Converter Arquivo JSON Para HASH sha256
  ${json}    gerar hash dict    (conteudo)
  Log To Console    ${json}



Quantidade Total Usuarios
  ${Qtd}            Buscar Quantidade Usuarios Cadastrado 
  Log To Console    ${Qtd}  



 
  

