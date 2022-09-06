# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações Gerais

Library    OperatingSystem
Resource    ../base.robot
*** Keywords ***
Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode}
    Log To Console        Status Code Retornado: ${response.status_code}
Validar Razao "${razao}"
    Should Be Equal As Strings   ${response.reason}        ${razao} 
    Log To Console    Razao Retornada: ${response.reason}    
Importar JSON Estatico 
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File      ${EXECDIR}/suporte/fixtures/static/${nome_arquivo} 
    ${data}        Evaluate      json.loads('''${arquivo}''')    json  
    [return]       ${data}


Selecionar Token Invalido
    ${token_auth}             Set Variable        Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImV1c291dmFsaWRvQHFhL  
    Set Global Variable       ${token_auth}

Validar Message "${message}"    
    Should Be Equal As Strings        ${response.json()["message"]}        ${message}
