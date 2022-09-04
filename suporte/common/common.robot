# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações Gerais

Library    OperatingSystem
Resource    ../base.robot
*** Keywords ***
Validar Status Code "${statuscode}"
    Should Be Equal As Integers     ${response.status_code}    ${statuscode}
    Log To Console        Status Code Retornado: ${response.status_code}
Validar Razao "${razao}"
    Should Be Equal As Strings   ${response.reason}        ${razao} 
    Log To Console    Razao Retornada: ${response.reason}    
Importar JSON Estatico
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File      ${EXECDIR}/suporte/fixtures/static/${nome_arquivo} 
    ${data}        Evaluate      json.loads('''${arquivo}''')    json  
    [return]       ${data}
Validar Mensagem "${message}"
    Should Be Equal            ${response.json()["message"]}    ${message}

Validar Quantidade Total "${quantidade}"
    Should Be Equal        ${response.json()["quantidade"]}    ${quantidade}
    Log To Console         Quantidade Total: ${response.json()["quantidade"]}

Selecionar Token Invalido
    ${token_auth}             Set Variable        12563737   
    Set Global Variable       ${token_auth}
Validar Ter Alterado o Usuario    
    Should Be Equal        ${response.json()["message"]}        Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]}
Validar Erro "${nome_erro}"   
    IF         "${nome_erro}" == "nome" or "${nome_erro}" == "password" or "${nome_erro}" == "descricao"    
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} não pode ficar em branco 
    ELSE IF    "${nome_erro}" == "email" 
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser um email válido 
    ELSE IF    "${nome_erro}" == "administrador"  
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser 'true' ou 'false' 
    ELSE IF    "${nome_erro}" == "preco" or "${nome_erro}" == "quantidade"   
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser um número 
    END