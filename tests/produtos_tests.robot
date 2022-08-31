# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation      Arquivo de Testes Endpoint /produtos
Resource    ../Keywords/produtos_keywords.robot
Suite Setup    Criar Sessao
#Sessão para a criação dos cenários
*** Test Cases ***
Selecionar Produto Estatico "${produto}"
    ${json}                               Importar JSON Estatico            json_produtos_ex.json  
    ${payload}                            Set variable                      ${json["${produto}"]}
    Set Global Variable                   ${payload}
    
Selecionar ID Produto Carrinho
    ${id_produto}             Set Variable        BeeJh5lz3k6kSIzA
    Set Global Variable       ${id_produto}

Criar Um Produto e Armazenar ID
    Selecionar Produto Estatico "produto_valido"
    POST Endpoint /produtos 
    Validar Ter Criado o Produto
    ${id_produto}        Set Variable        ${response.json()["_id"]}   
    Log To Console       ID Produto: ${id_produto}
    Set Global Variable    ${id_produto}

Criar Produto Token Invalido
    Selecionar Produto Estatico "produto_invalido" 
    &{header}                 Create Dictionary      Authorization="12563737"                         
    ${response}               POST On Session        serverest        /produtos    json=&{payload}    headers=&{header}    expected_status=401 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint /produtos
    ${response}               GET On Session        serverest        /produtos
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint /produtos/id
    ${response}               GET On Session        serverest        /produtos/${id_produto}    expected_status=any 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

POST Endpoint /produtos 
    &{header}                 Create Dictionary      Authorization=${token_auth}                         
    ${response}               POST On Session        serverest        /produtos    json=&{payload}    headers=&{header}    expected_status=any 
    Log To Console            Response: ${payload}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

DELETE Endpoint /produtos
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    ${response}               DELETE On Session        serverest        /produtos/${id_produto}    headers=&{header}    expected_status=any
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

PUT Endpoint Cadastro /produtos/id
    &{header}              Create Dictionary             Authorization=${token_auth}
    ${response}            PUT On Session                serverest                        /produtos/1562586    json=&{payload}    headers=&{header}    expected_status=any  
    ${id_produto}          Set Variable                  ${response.json()["_id"]}   
    Log To Console         ID Produto: ${id_produto}
    Set Global Variable    ${id_produto} 
    Set Global Variable    ${response}

DELETE Produto Token Invalido
    Selecionar Token Invalido
    DELETE Endpoint /produtos
    Validar Status Code "401"
    Validar Mensagem Token Invalido

DELETE Produto Admin False
    Criar Login Estatico Admin False
    DELETE Endpoint /produtos
    Validar Status Code "403"    
    Validar Mensagem Rota Exclusiva Admin

PUT Endpoint /produtos/id
    &{header}                 Create Dictionary      Authorization=${token_auth}       
    &{payload}                Create Dictionary      nome=Monitor Logitech    preco=650    descricao=Monitor    quantidade=250                  
    ${response}               PUT On Session        serverest        /produtos/${id_produto}     data=&{payload}    headers=&{header}    expected_status=any
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

PUT Endpoint Cadastro Produto Inválido
    Selecionar Produto Estatico "produto_invalido"
    &{header}              Create Dictionary             Authorization=${token_auth}
    ${response}            PUT On Session                serverest                        /produtos/1562586    json=&{payload}    headers=&{header}    expected_status=400 
    Set Global Variable    ${response}
PUT Produto Token Invalido
    Selecionar Token Invalido
    PUT Endpoint /produtos/id
    Validar Status Code "401"
    Validar Mensagem Token Invalido

PUT Produto Admin False
    Criar Login Estatico Admin False
    PUT Endpoint /produtos/id
    Validar Status Code "403"
    Validar Mensagem Rota Exclusiva Admin

Validar Ter Criado o Produto
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 

Validar Nome Produto Cadastrado "${produto}"
    Should Contain          ${response.json()["produtos"][2]["nome"]}    ${produto}
    Log To Console          Produto Cadastrado: ${response.json()["produtos"][2]["nome"]}

Validar Nome Produto Buscado "${produto}"
    Should Contain          ${response.json()["nome"]}    ${produto}
    Log To Console          Produto Buscado: ${response.json()["nome"]}

Criar Produto Dinamico Valido    
    ${payload}                         Criar Dados Produto Valido        
    Set Global Variable                ${payload}
    POST Endpoint /produtos
    Validar Ter Criado o Produto
    ${id_produto}                      Set Variable        ${response.json()["_id"]}   
    Log To Console                     ID Produto: ${id_produto}
    Set Global Variable                ${id_produto}