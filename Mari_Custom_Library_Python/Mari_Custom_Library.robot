*** Settings ***
Documentation    Arquivo de Testes para Library PYTHON
Library    ./library_tests.py

*** Test Cases ***
Converter Arquivo JSON Para HASH sha256
  ${json}    gerar hash dict    (conteudo)
  Log To Console    ${json}

        
Quantidade Total Produtos  
  ${Qtd}     Buscar Quantidade Produtos Cadastrados
  Log To Console    ${Qtd}

Quantidade Total Usuarios
  ${QTD}        Buscar Qantidade Usuarios Cadastrados
  Log To Console    ${QTD}




  

