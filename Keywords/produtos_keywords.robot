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
GET Endpoint /produtos por ID
    ${response}    GET On Session    serverest    /produtos/3KGZd5IBb1Rau2L9    expected_status=any
    Log To Console    Resposta: ${response.content}
    Set Global Variable    ${response}
GET Endpoint /produtos sem ID 400
    ${response}    GET On Session    serverest    /produtos/1AnnvaEaDH4P    expected_status=any
    Log To Console    Resposta: ${response.content}
    Set Global Variable    ${response}
POST Endpoint /produtos 400
    &{header}        Create Dictionary    Authorization=${token_auth}       
    &{payload}        Create Dictionary        nome=Prod21    preco=470    descricao=prod22   quantidade=100   
    ${response}    POST On Session    serverest       /produtos        data=&{payload}    headers=${header}    expected_status=any    
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
POST Endpoint /produtos 201
    &{header}        Create Dictionary    Authorization=${token_auth}       
    &{payload}        Create Dictionary        nome=Prod200    preco=470    descricao=prod200   quantidade=100   
    ${response}    POST On Session    serverest       /produtos        data=&{payload}    headers=${header}    expected_status=any    
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
POST Endpoint /produtos 401
    POST Endpoint /login static
    &{header}    Create Dictionary    Authorization=${token_ausente}       
    &{payload}        Create Dictionary        nome=Prod300   preco=470    descricao=prod300   quantidade=100   
    ${response}    POST On Session    serverest       /produtos        data=&{payload}    headers=${token_ausente}                expected_status=any         
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
    Validar Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"
PUT Endpoint /produtos 
    &{header}        Create Dictionary    Authorization=${token_auth}       
    &{payload}        Create Dictionary        nome=Prod4    preco=470    descricao=prod200   quantidade=150   
    ${response}    PUT On Session    serverest       /produtos/3KGZd5IBb1Rau2L9        data=&{payload}    headers=${header}    expected_status=any    
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
    &{header}        Create Dictionary    Authorization=${token_auth}       
    &{payload}        Create Dictionary        nome=Prod23   preco=470    descricao=prod22   quantidade=100   
    ${response}    POST On Session    serverest       /produtos        data=&{payload}    headers=${header}    expected_status=any    
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}
    Validar Ter Criado o Produto
    ${id_produto}        Set Variable        ${response.json()["_id"]} 
    Log To Console       ID Produto: ${id_produto}
    Set Global Variable        ${id_produto}       
Validar Ter Alterado o Produto    

    Should Be Equal        ${response.json()["message"]}        Registro alterado com sucesso
    Should Not Be Empty        ${response.json()["_id"]}   
Apagar Produto                
    ${response}    DELETE On Session    serverest       /produtos/b2tYnEqc8oCPaqkJ           expected_status=any    
    Log To Console        Response:${response.content}   