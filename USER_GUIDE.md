USER_GUIDE.md — EV Analytics Dashboard
Manual completo de instalação, configuração e utilização

Este guia foi criado para permitir que qualquer pessoa — mesmo sem experiência prévia com SQL Server, VS Code ou Power BI — consiga instalar, configurar e utilizar o projeto EV Analytics Dashboard do início ao fim.

O objetivo é garantir que o utilizador consegue:

Instalar todos os componentes necessários

Criar o ambiente SQL local

Executar os scripts corretamente

Inserir e atualizar dados

Refrescar o dashboard no Power BI

Resolver erros comuns

1. Requisitos do Sistema
Antes de começar, certifica-te de que tens:

Windows 10 ou 11

Power BI Desktop

Visual Studio Code (VS Code)

SQL Server Express

Extensão “SQL Server (mssql)” no VS Code

Permissões de administrador no computador

2. Instalação do Ambiente
2.1 Instalar SQL Server Express
Acede ao site oficial da Microsoft.

Descarrega SQL Server Express.

Instala com as opções padrão.

Garante que o servidor fica com o nome:

Código
localhost\SQLEXPRESS
2.2 Instalar SQL Server Management Studio (opcional mas recomendado)
Embora o projeto funcione totalmente via VS Code, o SSMS ajuda a visualizar tabelas e validar dados.

2.3 Instalar Visual Studio Code
Acede ao site oficial.

Instala VS Code com as opções padrão.

2.4 Instalar a extensão “SQL Server (mssql)”
Abre o VS Code

Vai a Extensions

Procura por:

Código
SQL Server (mssql)
Instala a extensão.

2.5 Criar ligação ao servidor SQL
No VS Code, abre a paleta de comandos:

Código
Ctrl + Shift + P
Escreve:

Código
MS SQL: Connect
Seleciona o servidor:

Código
localhost\SQLEXPRESS
Autenticação:

Windows Authentication (recomendado)

Ou utilizador sa se configurado

2.6 Testar a ligação
No VS Code, cria um novo ficheiro .sql e escreve:

sql
SELECT @@VERSION;
Executa.
Se aparecer a versão do SQL Server, a ligação está funcional.

3. Preparação da Pasta do Projeto
Cria uma pasta no Windows onde vais colocar os ficheiros do GitHub:

Código
C:\EV_Analytics
Dentro desta pasta, coloca:

trip_reports_raw.csv

parameters.csv

CreateCodex.sql

RefreshData.sql

EV Insights & Performance Analytics.pbix

README.md

USER_GUIDE.md

Não são necessárias subpastas — tudo fica dentro da pasta principal.

4. Configuração da Base de Dados
4.1 Criar a base de dados
No VS Code, cria um ficheiro CreateDatabase.sql com:

sql
CREATE DATABASE EV_Analytics;
Executa o script.

4.2 Executar o script inicial (CreateCodex.sql)
Este script cria:

Tabelas

Índices

Estrutura base do projeto

Passos:

Abre o ficheiro CreateCodex.sql no VS Code

Liga-te ao servidor localhost\SQLEXPRESS

Certifica-te que a base de dados selecionada é:

Código
EV_Analytics
Executa o script

4.3 Validar a criação das tabelas
No VS Code ou SSMS, corre:

sql
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_CATALOG = 'EV_Analytics';
Deves ver as tabelas criadas pelo script.

5. Inserção e Atualização de Dados
5.1 Editar o ficheiro trip_reports_raw.csv
Este ficheiro contém os dados das viagens.

Regras importantes:

Não alterar o nome das colunas

Não adicionar colunas novas

Não deixar células vazias em campos obrigatórios

Guardar sempre como CSV UTF-8

5.2 Editar o ficheiro parameters.csv
Este ficheiro contém parâmetros do veículo:

Capacidade da bateria

Eficiência média

Custos

Etc.

Mesmas regras: não alterar estrutura.

5.3 Guardar os ficheiros
Guarda sempre dentro de:

Código
C:\EV_Analytics
6. Atualizar os Dados no SQL Server
Sempre que inserires novos dados no Excel, tens de atualizar a base de dados.

6.1 Abrir o ficheiro RefreshData.sql
Este script:

Limpa staging

Recarrega dados

Atualiza tabelas enriquecidas

Prepara tudo para o Power BI

6.2 Executar o script
Abre o ficheiro no VS Code

Liga-te ao servidor

Seleciona a base de dados EV_Analytics

Executa

6.3 Validar atualização
Corre:

sql
SELECT COUNT(*) FROM trip_reports;
Se o número de linhas corresponde ao CSV, está tudo atualizado.

7. Atualizar o Dashboard no Power BI
7.1 Abrir o ficheiro PBIX
Abre:

Código
EV Insights & Performance Analytics.pbix
7.2 Verificar ligação ao SQL
Power BI deve estar ligado a:

Código
localhost\SQLEXPRESS
EV_Analytics
7.3 Fazer Refresh
Clica em:

Código
Home → Refresh
O dashboard será atualizado com:

Novos KPIs

Novas viagens

Novas métricas

Novos gráficos

8. Arquitetura do Projeto (Pipeline)
Código
Excel (raw data)
        ↓
SQL Server Express (ETL: staging → enriched views)
        ↓
Power BI Desktop (modeling, DAX, KPIs, dashboard)
9. Troubleshooting (Erros Comuns)
Erro: Power BI não atualiza
Verifica se o SQL Server está ligado

Verifica se o servidor é localhost\SQLEXPRESS

Verifica se o script RefreshData.sql foi corrido

Erro: VS Code não liga ao SQL
Extensão mssql não instalada

SQL Server Express não está a correr

Firewall bloqueou a porta 1433

Erro: CSV não carrega
Colunas alteradas

Formato errado (não UTF-8)

Vírgulas dentro de campos sem aspas

Erro: Tabelas vazias
RefreshData.sql não foi executado

CSVs não estão na pasta correta

10. FAQ
Posso usar outro nome para a base de dados?
Sim, mas tens de alterar o PBIX e os scripts.

Posso usar outro servidor SQL?
Sim, desde que o PBIX seja atualizado.

Posso adicionar novas colunas ao CSV?
Não sem alterar os scripts SQL.

Posso automatizar o refresh?
Sim, com Power Automate ou scripts PowerShell.

11. Autor
Projeto criado por André Guedes  
