# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Produtos
Resource        ../suporte/base.robot 

*** Keywords ***
GET Endpoint /produtos
    ${response}                           GET On Session       serverest                 /produtos
    Log To Console                        Response: ${response.content}
    Set Global Variable                             ${response}
GET Endpoint /produtos por ID
    ${response}                           GET On Session       serverest    /produtos/3KGZd5IBb1Rau2L9    expected_status=any
    Log To Console                        Resposta: ${response.content}
    Set Global Variable                             ${response}
GET Endpoint /produtos sem ID 400
    ${response}                          GET On Session       serverest    /produtos/1AnnvaEaDH4P        expected_status=any
    Log To Console                       Resposta: ${response.content}
    Set Global Variable                             ${response}
POST Endpoint /produtos
    &{header}                           Create Dictionary                     Authorization=${token_auth}
    ${response}                         POST On Session      serverest    /produtos    json=&{payload}    headers=${header}    expected_status=any
    Log To Console                                                                 Response: ${response.content}
    Set Global Variable                                                                      ${response}
    IF    "${response.status_code}" == "201"
        ${id_produto}                   Set Variable                                         ${response.json()["_id"]}
        Set Global Variable    ${id_produto}
    END

PUT Endpoint /produtos 
    &{header}                   Create Dictionary                      Authorization=${token_auth}
    ${response}                 PUT On Session         serverest   /produtos/7Np8BNziFpGI29lk    json=&{payload}    headers=${header}    expected_status=any
    Log To Console                              Response: ${response.content}
    Set Global Variable                                   ${response}
    IF    "${response.status_code}" == "201"
        ${id_produto}           Set Variable        ${response.json()["_id"]}
        Set Global Variable                               ${id_produto}
    END
  
DELETE Endpoint /produtos
    ${response}                       DELETE On Session       serverest        /produtos/${id}        json=&{payload}        expected_status=any  
    Log To Console                                                             Resposta: ${response.content}
    Set Global Variable                                                                  ${response}


Dados Produto Estatico "${produto}"
    ${json}    Importar JSON Estatico    json_produtos_ex.json
    ${payload}    Set variable    ${json["${produto}"]}
    Set Global Variable    ${payload}
    Log To Console    Response: ${payload}
Produto ID Em carrinho
    ${id_produto}    Set Variable   Produto ID Em carrinho
    ${id_produto}    Set Variable    BeeJh5lz3k6kSIzA
    Set Global Variable    ${id_produto}
    Set Global Variable    ${id_produto}

  
