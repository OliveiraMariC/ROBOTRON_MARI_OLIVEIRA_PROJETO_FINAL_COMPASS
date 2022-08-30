# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Carrinho
Resource        ../suports/base.robot    



*** Keywords ***
GET Endpoint /carrinhos 
    ${response}                 GET On Session      serverest    /carrinhos
    Log To Console                                  Response:${response}
    Set Global Variable         ${response}
POST Endpoint /carrinhos
    &{payload}                 Create Dictionary        idProduto=                 preco=110        descricao=P9        quantidade=100
    ${response}                POST On Session          serverest       /produtos        data=&{payload}
    Log To Console             Carrinho: ${response.content}
    Set Global Variable                 ${response}   
Criar Carrinho e Armazenar ID
    POST Endpoint /carrinhos
    Validar Ter Criado Carrinho
    ${id_produto}    Set Variable       ${response.json()["_id"]}
    Log To Console          ID Produto: ${id_produto}  
    Set Global Variable                 ${id_produto}

Validar Ter Criado Carrinho
    Should Be Equal                     ${response.json()["message"]}    Cadastro com sucesso
    Should Not Be Empty                 ${response.json()["_id"]}   