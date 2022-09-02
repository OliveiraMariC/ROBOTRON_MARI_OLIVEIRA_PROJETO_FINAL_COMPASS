# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Produtos
Resource        ../suporte/base.robot 
*** Keywords ***

*** Keywords ***
GET Endpoint /produtos
    ${response}                           GET On Session                     serverest            /produtos
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
POST Endpoint /produtos
    &{header}        Create Dictionary    Authorization=${token_auth}       
    &{payload}        Create Dictionary        nome=Prod4    preco=470    descricao=prod4   quantidade=100   
    ${response}    POST On Session    serverest       /produtos        data=&{payload}    headers=${header}    expected_status=any    
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
 
DELETE Endpoint /produtos
    &{header}        Create Dictionary    Authorization=${token_auth}         
    ${response}    DELETE On Session    serverest       /produtos/${id_produto}            headers=${header}    expected_status=any    
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response} 
Validar Ter Criado o Produto
    Should Be Equal        ${response.json()["message"]}        Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]}              
Validar Quantidade Produtos
    ${quantidade}    Buscar Quantidade Produtos Cadastrados
    Log to Console    ${quantidade}
Criar Produto e armazenar ID
    POST Endpoint /produtos
    Validar Ter Criado o Produto
    ${id_produto}        Set Variable        ${response.json()["_id"]} 
    Log To Console       ID Produto: ${id_produto}
    Set Global Variable        ${id_produto}    
