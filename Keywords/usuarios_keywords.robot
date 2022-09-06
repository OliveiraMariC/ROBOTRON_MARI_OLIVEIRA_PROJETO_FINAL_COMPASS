# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Usuários
Resource    ../suporte/base.robot
*** Keywords ***

################--SIMPLES--#####################
GET Endpoint /usuarios
    ${response}            GET On Session    serverest        /usuarios
    Log To Console                                    ${response}
    Set Global Variable                               ${response}

GET Endpoint /usuarios ID
    ${response}            GET On Session    serverest    /usuarios/pSLqtHmun9aVzbz8   expected_status=any
    Log To Console                           Resposta: ${response.content}
    Set Global Variable                                ${response}
GET Endpoint /usuarios ID 400
    ${response}            GET On Session    serverest    /usuarios/Y1Gzmv6rnzIP86TA    expected_status=any
    Log To Console                           Resposta: ${response.content}
    Set Global Variable                                ${response}
# Manoella Souza ideia lógica booleana para corrigir o status code
POST Endpoint /usuarios
    ${response}            POST On Session     serverest          /usuarios              json=${payload}        expected_status=any
    Log To Console                             Response:${response.content}        
    Set Global Variable                                 ${response}
    IF    "${response.status_code}" == "201"
        ${id}    Set Variable                           ${response.json()["_id"]}
        Set Global Variable                             ${id}
    END
PUT Endpoint /usuarios 
    ${response}            PUT On Session      serverest           /usuarios/${id}       json=&{payload}        expected_status=any
    Log To Console                             Resposta: ${response.content}
    Set Global Variable                                  ${response}
    IF    "${response.status_code}" == "201"
        ${id}    Set Variable                            ${response.json()["_id"]}
        Set Global Variable                              ${id}
    END
DELETE Endpoint /usuarios
    ${response}            DELETE On Session    serverest          /usuarios/${id}        json=&{payload}        expected_status=any  
    Log To Console                              Resposta: ${response.content}
    Set Global Variable                                   ${response}
DELETE Endpoint /usuarios 400
    ${response}            DELETE On Session    serverest           /usuarios/oUb7aGkMtSEPf6BZ                    expected_status=any
    Log To Console                              Resposta: ${response.content}
    Set Global Variable                                   ${response}

Dados Usuario Estatico Email Cadastrado
    ${json}                Importar JSON Estatico        json_usuarios_ex.json
    ${payload}             Set variable                  ${json["user_email_cadastrado"]}
    Set Global Variable                                  ${payload}
    Log To Console                             Response: ${payload}
Dados Usuario Estatico Inexistente
    ${json}                Importar JSON Estatico        json_usuarios_ex.json
    ${payload}             Set variable                  ${json["user_invalido"]}
    Set Global Variable                                  ${payload}
    Log To Console                             Response: ${payload}
Dados Usuario Estatico Sem Senha
    ${json}               Importar JSON Estatico         json_usuarios_ex.json
    ${payload}            Set variable                   ${json["user_sem_senha"]}
    Set Global Variable                                  ${payload}
    Log To Console                             Response: ${payload}
Dados Usuario Estatico Sem Admin
    ${json}              Importar JSON Estatico          json_usuarios_ex.json
    ${payload}           Set variable                    ${json["user_sem_admin"]}
    Set Global Variable                                  ${payload}
    Log To Console                             Response: ${payload}

