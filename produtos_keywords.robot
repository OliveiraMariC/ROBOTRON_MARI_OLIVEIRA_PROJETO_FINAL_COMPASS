# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Produtos
Library    RequestsLibrary
#Sessão para setagem de variáveis para utilização
*** Variables ***
${response}
${id_produto}
${token_auth} 
*** Keywords ***
GET Endpoint /produtos
    ${response}                 GET On Session      serverest    /produtos
    Log To Console                                  Response:${response}
    Set Global Variable         ${response}
POST Endpoint /produtos
    &{header}                  Create Dictionary        Authorization=${token_auth}
    &{payload}                 Create Dictionary        nome=P9                 preco=110        descricao=P9        quantidade=100
    ${response}                POST On Session          serverest       /produtos        data=&{payload}        headers=${header}
    Log To Console             Produto: ${response.content}
    Set Global Variable                 ${response}
DELETE Endpoint /produtos
    &{header}                  Create Dictionary        Authorization=${token_auth}
    ${response}                DELETE On Session        serverest       /produtos/${id_produto}                headers=${header}
    Log To Console             Produto: ${response.content}
    Set Global Variable                 ${response}
Validar Ter Criado Produto
    Should Be Equal                     ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty                 ${response.json()["_id"]}  
Criar Produto e Armazenar ID
    POST Endpoint /produtos
    Validar Ter Criado Produto
    ${id_produto}    Set Variable       ${response.json()["_id"]}
    Log To Console          ID Produto: ${id_produto}  
    Set Global Variable                 ${id_produto}  