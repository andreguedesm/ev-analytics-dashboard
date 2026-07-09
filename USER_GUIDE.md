# USER GUIDE — EV Analytics Dashboard

## 1. Requisitos do Sistema

Antes de começar, certifique-se de que tem:
- Windows 10 ou 11
- Power BI Desktop
- Visual Studio Code (VS Code)
- SQL Server Express
- Extensão "SQL Server (mssql)" no VS Code
- Permissões de administrador no computador

## 2. Instalação do Ambiente

### 2.1 Instalar SQL Server Express
1. Aceda ao site oficial da Microsoft.
2. Descarregue SQL Server Express.
3. Instale com as opções padrão.
4. Confirme que o servidor fica com o nome: localhost\SQLEXPRESS

### 2.2 Instalar SQL Server Management Studio (opcional)
O SSMS facilita a visualização das tabelas e validação dos dados.

### 2.3 Instalar Visual Studio Code
1. Aceda ao site oficial.
2. Instale VS Code com as opções padrão.

### 2.4 Instalar a extensão "SQL Server (mssql)"
1. Abra o VS Code.
2. Vá a Extensions.
3. Procure por: SQL Server (mssql)
4. Instale a extensão.

### 2.5 Criar ligação ao servidor SQL
1. No VS Code, abra a paleta de comandos: Ctrl + Shift + P
2. Escreva: MS SQL: Connect
3. Selecione o servidor: localhost\SQLEXPRESS
4. Utilize Windows Authentication.

### 2.6 Testar a ligação
Crie um ficheiro `.sql` e execute: SELECT @@VERSION;
Se aparecer a versão do SQL Server, a ligação está funcional.

## 3. Preparação da Pasta do Projeto

Crie uma pasta no Windows onde vai colocar os ficheiros do GitHub:
C:\EV_Analytics

Coloque dentro desta pasta:
- trip_reports_raw.csv
- parameters.csv
- CreateCodex.sql
- RefreshData.sql
- EV Insights & Performance Analytics.pbix
- README.md
- USER_GUIDE.md

## 4. Configuração da Base de Dados

### 4.1 Criar a base de dados
Execute: CREATE DATABASE EV_Analytics;

### 4.2 Executar o script inicial (CreateCodex.sql)
1. Abra o ficheiro no VS Code.
2. Ligue-se ao servidor.
3. Selecione a base de dados: EV_Analytics
4. Execute o script.

### 4.3 Validar a criação das tabelas
Execute: 
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_CATALOG = 'EV_Analytics';

## 5. Inserção e Atualização de Dados

### 5.1 Editar trip_reports_raw.csv
- Não alterar nomes das colunas.
- Não adicionar colunas.
- Não deixar campos obrigatórios vazios.
- Guardar como CSV UTF-8.

### 5.2 Editar parameters.csv
- Manter estrutura original.
- Guardar como CSV UTF-8.

### 5.3 Guardar os ficheiros
Guardar sempre em: C:\EV_Analytics

## 6. Atualizar os Dados no SQL Server

### 6.1 Abrir RefreshData.sql
Este script atualiza staging e vistas enriquecidas.

### 6.2 Executar o script
1. Abra o ficheiro.
2. Ligue-se ao servidor.
3. Selecione a base de dados: EV_Analytics
4. Execute.

### 6.3 Validar atualização
Execute: SELECT COUNT(*) FROM trip_reports;

## 7. Atualizar o Dashboard no Power BI

### 7.1 Abrir o ficheiro PBIX
Abra: EV Insights & Performance Analytics.pbix

### 7.2 Verificar ligação ao SQL
O Power BI deve ligar a: 
localhost\SQLEXPRESS
EV_Analytics

### 7.3 Fazer Refresh
No Power BI:
- Home → Refresh

## 8. Arquitetura do Projeto

Excel (raw data)
↓
SQL Server Express (ETL: staging → enriched views)
↓
Power BI Desktop (modeling, DAX, KPIs, dashboard)

## 9. Troubleshooting

### Power BI não atualiza
- Verifique se o SQL Server está ligado.
- Verifique se o servidor é localhost\SQLEXPRESS.
- Execute RefreshData.sql.

### VS Code não liga ao SQL
- Extensão mssql não instalada.
- SQL Server Express não está a correr.
- Firewall bloqueou a porta 1433.

### CSV não carrega
- Colunas alteradas.
- Formato errado.
- Vírgulas sem aspas.

### Tabelas vazias
- RefreshData.sql não foi executado.
- CSVs fora da pasta correta.

## 10. FAQ

### Posso usar outro nome para a base de dados?
Sim, mas terá de alterar o PBIX e os scripts.

### Posso usar outro servidor SQL?
Sim, desde que atualize o PBIX.

### Posso adicionar novas colunas ao CSV?
Não sem alterar os scripts SQL.

### Posso automatizar o refresh?
Sim, com Power Automate ou PowerShell.

## 11. Autor

Projeto criado por André Guedes.



