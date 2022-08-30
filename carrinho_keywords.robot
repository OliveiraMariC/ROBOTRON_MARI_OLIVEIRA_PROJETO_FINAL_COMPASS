# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Carrinho
Library    RequestsLibrary
#Sessão para setagem de variáveis para utilização
*** Variables ***

${token_auth}
${id_produto}
${response}

*** Keywords ***
GET Endpoint /carrinhos
    ${response}                 GET On Session      serverest    /carrinhos
    Log To Console                                  Response:${response}
    Set Global Variable         ${response}
GET Endpoint /carrinho/id
    ${response}                 GET On Session      serverest    /carrinhos/${id_carrinho}    expected_status=any
    Log To Console                                  Response:${response}
    Set Global Variable         ${response}    
POST Endpoint /carrinhos
    &{header}                  Create Dictionary        Authorization=${token_auth}
    &{payload}                 Create Dictionary        ID= ${id_produto}                 quantidade=1
    ${response}                POST On Session          serverest       /carrinhos        json=&{payload}        headers=${header}        expected_status=any   
    Log To Console             Produto: ${response.content}
    Set Global Variable                 ${response}
Criar Carrinho e Armazenar ID
    POST Endpoint /carrinhos
    ${id_produto}    Set Variable       ${response.json()["_id"]}
    Log To Console          ID Produto: ${id_produto}  
    Set Global Variable                 ${id_produto}  
DELETE Endpoint /carrinhos/concluir-compra
    &{header}                  Create Dictionary        Authorization=${token_auth}
    ${response}                DELETE On Session        serverest       /carrinhos/concluir-compra                headers=${header}
    Log To Console             Produto: ${response.content}
    Set Global Variable                 ${response}
Validar Ter Criado Carrinho
    Should Be Equal                     ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty                 ${response.json()["_id"]}  