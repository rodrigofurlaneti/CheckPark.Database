-- =============================================================================
-- SISTEMA SmartPark — Script de Massa de Dados (Seed)
-- Gerado em: Março/2026
-- Usuário padrão: admin / 123456 (senha hash bcrypt)
-- =============================================================================

USE `SmartPark`;

SET FOREIGN_KEY_CHECKS=0;

-- =============================================================================
-- MÓDULO 1: LOCALIZAÇÃO
-- =============================================================================

INSERT INTO `Pais` (`Id`, `Descricao`) VALUES
(1, 'Brasil');

INSERT INTO `Estado` (`Id`, `Descricao`, `Sigla`, `Pais_Id`) VALUES
(1, 'São Paulo',       'SP', 1),
(2, 'Rio de Janeiro',  'RJ', 1),
(3, 'Minas Gerais',    'MG', 1),
(4, 'Paraná',          'PR', 1),
(5, 'Rio Grande do Sul','RS', 1);

INSERT INTO `Cidade` (`Id`, `Descricao`, `Estado_Id`) VALUES
(1,  'São Paulo',         1),
(2,  'Campinas',          1),
(3,  'Santos',            1),
(4,  'Rio de Janeiro',    2),
(5,  'Niterói',           2),
(6,  'Belo Horizonte',    3),
(7,  'Uberlândia',        3),
(8,  'Curitiba',          4),
(9,  'Londrina',          4),
(10, 'Porto Alegre',      5);

INSERT INTO `Endereco` (`Id`, `Cep`, `Logradouro`, `Numero`, `Bairro`, `Descricao`, `Cidade_Id`) VALUES
(1,  '01310-100', 'Avenida Paulista',           '1000', 'Bela Vista',      'Sede Matriz',       1),
(2,  '01310-200', 'Rua da Consolação',          '500',  'Consolação',      'Filial Centro SP',  1),
(3,  '13010-110', 'Rua General Osório',         '200',  'Centro',          'Filial Campinas',   2),
(4,  '20040-020', 'Avenida Rio Branco',         '156',  'Centro',          'Filial Rio',        4),
(5,  '30130-110', 'Avenida Afonso Pena',        '1500', 'Centro',          'Filial BH',         6),
(6,  '80010-010', 'Rua XV de Novembro',         '700',  'Centro',          'Filial Curitiba',   8),
(7,  '01001-000', 'Praça da Sé',                '1',    'Sé',              'Res. João Silva',   1),
(8,  '01310-300', 'Rua Haddock Lobo',           '595',  'Cerqueira César', 'Res. Maria Santos', 1),
(9,  '13015-001', 'Rua Barão de Jaguara',       '123',  'Centro',          'Res. Pedro Alves',  2),
(10, '20031-170', 'Rua da Assembleia',          '10',   'Centro',          'Res. Ana Costa',    4);

-- =============================================================================
-- MÓDULO 2: TRABALHO E PESSOA
-- =============================================================================

INSERT INTO `Trabalho` (`Id`, `Nome`, `CNPJ`) VALUES
(1, 'SmartPark Estacionamentos S.A.',     '12345678000100'),
(2, 'Grupo Comercial Boa Vista Ltda',     '23456789000111'),
(3, 'Construtora Alto Padrão S.A.',       '34567890000122'),
(4, 'Tech Solutions Brasil Ltda',         '45678901000133'),
(5, 'Shopping Paulistano Administração',  '56789012000144');

INSERT INTO `Pessoa` (`Id`, `Nome`, `Sexo`, `DataNascimento`, `Ativo`, `Trabalho_Id`) VALUES
-- Pessoas Físicas (Funcionários / Clientes)
(1,  'Carlos Eduardo Mendes',     'M', '1985-03-15', 1, 1),
(2,  'Fernanda Lima Rodrigues',   'F', '1990-07-22', 1, 1),
(3,  'Roberto Ferreira Costa',    'M', '1978-11-08', 1, 1),
(4,  'Juliana Pereira Souza',     'F', '1995-02-14', 1, 1),
(5,  'Marcos Antonio Silva',      'M', '1982-09-30', 1, 1),
(6,  'Patricia Oliveira Nunes',   'F', '1988-06-05', 1, 1),
(7,  'Anderson Luiz Barbosa',     'M', '1975-12-20', 1, 1),
(8,  'Camila Santos Martins',     'F', '1993-04-18', 1, 1),
(9,  'Rafael Gomes Carvalho',     'M', '1987-08-25', 1, 1),
(10, 'Luciana Alves Ribeiro',     'F', '1991-01-10', 1, 1),
-- Clientes PF
(11, 'João Pedro da Silva',       'M', '1970-05-12', 1, NULL),
(12, 'Maria Aparecida Costa',     'F', '1965-09-03', 1, NULL),
(13, 'Pedro Henrique Almeida',    'M', '1980-03-28', 1, NULL),
(14, 'Ana Claudia Ferreira',      'F', '1975-11-17', 1, NULL),
(15, 'Lucas Oliveira Batista',    'M', '1992-07-09', 1, NULL),
-- Clientes PJ (Empresas)
(16, 'Grupo Comercial Boa Vista', NULL, NULL,         1, 2),
(17, 'Construtora Alto Padrão',   NULL, NULL,         1, 3),
(18, 'Tech Solutions Brasil',     NULL, NULL,         1, 4),
(19, 'Shopping Paulistano',       NULL, NULL,         1, 5),
-- Fornecedores
(20, 'Eletrônica Industrial Ltda',NULL, NULL,         1, NULL),
(21, 'Papelaria e Suprimentos ME', NULL, NULL,        1, NULL);

INSERT INTO `Contato` (`Id`, `Tipo`, `Email`, `Numero`, `Ordem`) VALUES
(1,  1, 'carlos.mendes@smartpark.com.br',    NULL,            1),
(2,  3, NULL,                                '(11) 99999-0001', 1),
(3,  1, 'fernanda.lima@smartpark.com.br',    NULL,            1),
(4,  3, NULL,                                '(11) 99999-0002', 1),
(5,  1, 'roberto.costa@smartpark.com.br',    NULL,            1),
(6,  3, NULL,                                '(11) 99999-0003', 1),
(7,  1, 'joao.silva@gmail.com',              NULL,            1),
(8,  3, NULL,                                '(11) 98888-0011', 1),
(9,  1, 'maria.costa@gmail.com',             NULL,            1),
(10, 3, NULL,                                '(11) 98888-0012', 1),
(11, 1, 'pedro.almeida@hotmail.com',         NULL,            1),
(12, 3, NULL,                                '(21) 97777-0013', 1),
(13, 1, 'comercial@boavista.com.br',         NULL,            1),
(14, 5, NULL,                                '(11) 3333-4444',  1),
(15, 1, 'contato@construtora.com.br',        NULL,            1),
(16, 5, NULL,                                '(11) 3333-5555',  1);

INSERT INTO `PessoaContato` (`Pessoa_Id`, `Contato_Id`) VALUES
(1,  1), (1,  2),
(2,  3), (2,  4),
(3,  5), (3,  6),
(11, 7), (11, 8),
(12, 9), (12, 10),
(13, 11),(13, 12),
(16, 13),(16, 14),
(17, 15),(17, 16);

INSERT INTO `PessoaEndereco` (`Pessoa_Id`, `Endereco_Id`) VALUES
(11, 7), (12, 8), (13, 9), (14, 10);

-- =============================================================================
-- MÓDULO 3: EMPRESA / GRUPO / FILIAL
-- =============================================================================

INSERT INTO `Grupo` (`Id`, `Nome`) VALUES
(1, 'Grupo SmartPark');

INSERT INTO `PessoaJuridica` (`Id`, `Pessoa_Id`, `CNPJ`) VALUES
(1, 1,  '12345678000100'),  -- reutilizando Pessoa para empresa
(2, 16, '23456789000111'),
(3, 17, '34567890000122');

INSERT INTO `Empresa` (`Id`, `PessoaJuridica_Id`, `Grupo_Id`) VALUES
(1, 1, 1);

INSERT INTO `TipoFilial` (`Id`, `Descricao`) VALUES
(1, 'Matriz'),
(2, 'Filial'),
(3, 'Franquia');

INSERT INTO `Filial` (`Id`, `PessoaJuridica_Id`, `Empresa_Id`, `TipoFilial_Id`) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 1, 1, 2);

INSERT INTO `Regional` (`Id`, `Descricao`) VALUES
(1, 'Regional Sudeste'),
(2, 'Regional Sul'),
(3, 'Regional Centro-Oeste');

INSERT INTO `RegionalEstado` (`Regional_Id`, `Estado_Id`) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5);

-- =============================================================================
-- MÓDULO 4: UNIDADE (Estacionamentos)
-- =============================================================================

INSERT INTO `TipoUnidade` (`Id`, `Descricao`) VALUES
(1, 'Estacionamento Rotativo'),
(2, 'Estacionamento Coberto'),
(3, 'Valet'),
(4, 'Condomínio');

INSERT INTO `MaquinaCartao` (`Id`, `Descricao`) VALUES
(1, 'Cielo D195'),
(2, 'Rede POS 7000'),
(3, 'PagSeguro Smart');

INSERT INTO `Unidade` (`Id`, `Codigo`, `Nome`, `NumeroVaga`, `DiaVencimento`, `CNPJ`, `HorarioInicial`, `HorarioFinal`, `Ativa`, `TiposUnidades`, `Empresa_Id`, `Endereco_Id`, `MaquinaCartao_Id`) VALUES
(1, 'SP001', 'SmartPark Paulista',      250, 5,  '12345678000100', '00:00', '23:59', 1, 1, 1, 1, 1),
(2, 'SP002', 'SmartPark Consolação',    180, 5,  '12345678000101', '07:00', '22:00', 1, 2, 1, 2, 2),
(3, 'SP003', 'SmartPark Campinas',      120, 10, '12345678000102', '06:00', '22:00', 1, 1, 1, 3, 3),
(4, 'RJ001', 'SmartPark Rio Centro',    200, 5,  '12345678000103', '00:00', '23:59', 1, 2, 1, 4, 1),
(5, 'BH001', 'SmartPark BH Afonso Pena',150, 10, '12345678000104', '07:00', '21:00', 1, 1, 1, 5, 2);

INSERT INTO `EstruturaGaragem` (`Id`, `Descricao`) VALUES
(1, 'Térreo'),
(2, 'Subsolo 1'),
(3, 'Subsolo 2'),
(4, 'Cobertura');

INSERT INTO `EstruturaUnidade` (`Id`, `Descricao`, `Unidade_Id`, `EstruturaGaragem_Id`) VALUES
(1, 'Térreo - 80 vagas',    1, 1),
(2, 'Subsolo 1 - 100 vagas',1, 2),
(3, 'Subsolo 2 - 70 vagas', 1, 3),
(4, 'Térreo - 90 vagas',    2, 1),
(5, 'Subsolo - 90 vagas',   2, 2);

INSERT INTO `Equipamento` (`Id`, `Descricao`, `Ativo`) VALUES
(1, 'Cancela de Entrada',  1),
(2, 'Cancela de Saída',    1),
(3, 'Totem de Pagamento',  1),
(4, 'Câmera OCR',          1),
(5, 'Interfone',           1);

INSERT INTO `EquipamentoUnidade` (`Unidade_Id`, `Equipamento_Id`) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),
(2,1),(2,2),(2,3),(2,5),
(3,1),(3,2),(3,3),
(4,1),(4,2),(4,3),(4,4),
(5,1),(5,2),(5,3);

INSERT INTO `TipoPagamento` (`Id`, `Descricao`, `Unidade_Id`) VALUES
(1,  'Dinheiro',        1),
(2,  'Cartão Débito',   1),
(3,  'Cartão Crédito',  1),
(4,  'Pix',             1),
(5,  'Sem Parar',       1),
(6,  'Dinheiro',        2),
(7,  'Cartão Débito',   2),
(8,  'Cartão Crédito',  2),
(9,  'Pix',             2),
(10, 'Dinheiro',        3),
(11, 'Cartão Débito',   3),
(12, 'Cartão Crédito',  3);

-- =============================================================================
-- MÓDULO 5: VEÍCULO
-- =============================================================================

INSERT INTO `Marca` (`Id`, `Nome`) VALUES
(1, 'Chevrolet'),
(2, 'Volkswagen'),
(3, 'Fiat'),
(4, 'Toyota'),
(5, 'Honda'),
(6, 'Hyundai'),
(7, 'Ford'),
(8, 'Jeep');

INSERT INTO `Modelo` (`Id`, `Descricao`, `Marca_Id`) VALUES
(1,  'Onix',      3),
(2,  'HB20',      6),
(3,  'Gol',       2),
(4,  'Corolla',   4),
(5,  'Civic',     5),
(6,  'Tracker',   1),
(7,  'Compass',   8),
(8,  'Polo',      2),
(9,  'Ka',        7),
(10, 'Cronos',    3);

INSERT INTO `Veiculo` (`Id`, `Placa`, `Cor`, `Ano`, `TipoVeiculo`, `Modelo_Id`) VALUES
(1,  'ABC1D23', 'Prata',  2021, 1, 1),
(2,  'DEF2E34', 'Branco', 2020, 1, 2),
(3,  'GHI3F45', 'Preto',  2019, 1, 3),
(4,  'JKL4G56', 'Cinza',  2022, 1, 4),
(5,  'MNO5H67', 'Branco', 2021, 1, 5),
(6,  'PQR6I78', 'Vermelho',2020,1, 6),
(7,  'STU7J89', 'Prata',  2023, 1, 7),
(8,  'VWX8K90', 'Azul',   2018, 1, 8),
(9,  'YZA9L01', 'Preto',  2022, 1, 9),
(10, 'BCD0M12', 'Branco', 2021, 1, 10),
-- Veículos de Frota PJ
(11, 'EFG1N23', 'Preto',  2023, 1, 4),
(12, 'HIJ2O34', 'Branco', 2022, 1, 4),
(13, 'KLM3P45', 'Cinza',  2023, 1, 7),
(14, 'NOP4Q56', 'Prata',  2021, 1, 6),
(15, 'QRS5R67', 'Preto',  2022, 1, 5);

-- =============================================================================
-- MÓDULO 6: CLIENTE
-- =============================================================================

INSERT INTO `Cliente` (`Id`, `TipoPessoa`, `NomeFantasia`, `RazaoSocial`, `Pessoa_Id`) VALUES
-- PF
(1,  1, 'João Pedro da Silva',    NULL,                     11),
(2,  1, 'Maria Aparecida Costa',  NULL,                     12),
(3,  1, 'Pedro Henrique Almeida', NULL,                     13),
(4,  1, 'Ana Claudia Ferreira',   NULL,                     14),
(5,  1, 'Lucas Oliveira Batista', NULL,                     15),
-- PJ
(6,  2, 'Boa Vista',              'Grupo Comercial Boa Vista Ltda',  16),
(7,  2, 'Alto Padrão',            'Construtora Alto Padrão S.A.',    17),
(8,  2, 'Tech Solutions',         'Tech Solutions Brasil Ltda',      18),
(9,  2, 'Shopping Paulistano',    'Shopping Paulistano Administração',19);

INSERT INTO `ClienteVeiculo` (`Cliente_Id`, `Veiculo_Id`) VALUES
(1, 1), (1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6);

INSERT INTO `ClienteUnidade` (`Cliente_Id`, `Unidade_Id`) VALUES
(1, 1), (1, 2),
(2, 1),
(3, 3),
(4, 4),
(5, 1),
(6, 1), (6, 2),
(7, 1), (7, 3),
(8, 2),
(9, 1);

-- Frota PJ
INSERT INTO `ClienteCondomino` (`NumeroVagas`, `Frota`, `Cliente_Id`, `Unidade_Id`) VALUES
(5,  1, 6, 1),
(3,  1, 7, 3),
(4,  1, 8, 2),
(10, 1, 9, 1);

INSERT INTO `ClienteCondominoVeiculo` (`ClienteCondomino_Id`, `Veiculo_Id`) VALUES
(1, 11),(1, 12),
(2, 13),
(3, 14),
(4, 15);

-- =============================================================================
-- MÓDULO 7: CONVÊNIO
-- =============================================================================

INSERT INTO `Convenio` (`Id`, `Descricao`, `Ativo`) VALUES
(1, 'Convênio Shopping Paulistano', 1),
(2, 'Convênio Corporativo Boa Vista', 1),
(3, 'Convênio Hospital São Luís', 1),
(4, 'Convênio Faculdade Anhembi', 1);

INSERT INTO `ConvenioUnidade` (`Convenio_Id`, `Unidade_Id`) VALUES
(1, 1), (1, 2),
(2, 1),
(3, 2),
(4, 1);

INSERT INTO `ConvenioCliente` (`Convenio_Id`, `Cliente_Id`) VALUES
(1, 9),
(2, 6),
(3, 1),
(3, 2);

-- =============================================================================
-- MÓDULO 8: RH — CARGO, DEPARTAMENTO, FUNCIONÁRIO
-- =============================================================================

INSERT INTO `Cargo` (`Id`, `Nome`) VALUES
(1,  'Gerente Geral'),
(2,  'Gerente de Unidade'),
(3,  'Supervisor Operacional'),
(4,  'Atendente de Caixa'),
(5,  'Manobrista'),
(6,  'Zelador'),
(7,  'Analista Financeiro'),
(8,  'Analista de TI'),
(9,  'Auxiliar Administrativo'),
(10, 'Segurança');

INSERT INTO `Departamento` (`Id`, `Nome`, `Sigla`) VALUES
(1, 'Diretoria',       'DIR'),
(2, 'Operações',       'OPE'),
(3, 'Financeiro',      'FIN'),
(4, 'Recursos Humanos','RH'),
(5, 'TI',              'TI'),
(6, 'Comercial',       'COM');

INSERT INTO `Funcionario` (`Id`, `Codigo`, `Salario`, `Status`, `TipoEscala`, `DataAdmissao`, `Pessoa_Id`, `Cargo_Id`, `Unidade_Id`) VALUES
(1,  'F0001', 8500.00,  1, 1, '2018-03-01', 1,  1, 1),   -- Carlos - Gerente Geral
(2,  'F0002', 4200.00,  1, 1, '2019-06-15', 2,  2, 1),   -- Fernanda - Ger. Unidade
(3,  'F0003', 3500.00,  1, 2, '2020-01-10', 3,  3, 1),   -- Roberto - Supervisor
(4,  'F0004', 2100.00,  1, 2, '2021-03-20', 4,  4, 1),   -- Juliana - Caixa
(5,  'F0005', 2100.00,  1, 3, '2021-07-05', 5,  4, 2),   -- Marcos - Caixa
(6,  'F0006', 1900.00,  1, 2, '2022-01-12', 6,  5, 1),   -- Patricia - Manobrista
(7,  'F0007', 1900.00,  1, 3, '2022-04-18', 7,  5, 2),   -- Anderson - Manobrista
(8,  'F0008', 2100.00,  1, 1, '2020-11-30', 8,  4, 3),   -- Camila - Caixa
(9,  'F0009', 3500.00,  1, 1, '2019-09-10', 9,  7, 1),   -- Rafael - Analista Fin.
(10, 'F0010', 3200.00,  1, 1, '2020-05-25', 10, 8, 1);   -- Luciana - TI

-- Atualizar Supervisores
UPDATE `Funcionario` SET `Supervisor_Id` = 1 WHERE `Id` IN (2, 9, 10);
UPDATE `Funcionario` SET `Supervisor_Id` = 2 WHERE `Id` IN (3, 4, 6);
UPDATE `Funcionario` SET `Supervisor_Id` = 3 WHERE `Id` IN (5, 7, 8);

-- Atualiza FK de Unidade.Funcionario_Id (responsável)
UPDATE `Unidade` SET `Funcionario_Id` = 2 WHERE `Id` = 1;
UPDATE `Unidade` SET `Funcionario_Id` = 5 WHERE `Id` = 2;
UPDATE `Unidade` SET `Funcionario_Id` = 8 WHERE `Id` = 3;

INSERT INTO `DepartamentoFuncionario` (`Departamento_Id`, `Funcionario_Id`, `Funcao`) VALUES
(1, 1, 1),
(2, 2, 1), (2, 3, 2), (2, 4, 3), (2, 5, 3), (2, 6, 3), (2, 7, 3), (2, 8, 3),
(3, 9, 1),
(5, 10, 1);

INSERT INTO `UnidadeFuncionario` (`Funcao`, `Unidade_Id`, `Funcionario_Id`, `MaquinaCartao_Id`) VALUES
(1, 1, 2,  1),
(2, 1, 3,  1),
(3, 1, 4,  1),
(3, 1, 6,  NULL),
(1, 2, 5,  2),
(3, 2, 7,  NULL),
(1, 3, 8,  3);

-- =============================================================================
-- MÓDULO 9: CONTRATOS MENSALISTAS
-- =============================================================================

INSERT INTO `TipoMensalista` (`Id`, `Descricao`) VALUES
(1, 'Mensalista Rotativo'),
(2, 'Mensalista Fixo'),
(3, 'Mensalista Noturno'),
(4, 'Mensalista Frota');

INSERT INTO `TabelaPrecoMensalista` (`Id`, `Descricao`, `Ativo`) VALUES
(1, 'Tabela Mensalista Padrão SP',    1),
(2, 'Tabela Mensalista Corporativo',  1),
(3, 'Tabela Mensalista Noturno',      1);

INSERT INTO `ContratoMensalista` (`Id`, `NumeroContrato`, `DataVencimento`, `DataInicio`, `Valor`, `Ativo`, `NumeroVagas`, `HorarioInicio`, `HorarioFim`, `Cliente_Id`, `Unidade_Id`, `TipoMensalista_Id`, `TabelaPrecoMensalista_Id`) VALUES
(1, 1001, '2026-04-05', '2025-04-01', 350.00, 1, 1, '00:00', '23:59', 1, 1, 2, 1),
(2, 1002, '2026-04-05', '2025-06-01', 350.00, 1, 1, '08:00', '18:00', 2, 1, 1, 1),
(3, 1003, '2026-04-10', '2025-08-10', 320.00, 1, 1, '08:00', '18:00', 3, 3, 1, 1),
(4, 1004, '2026-04-05', '2025-09-01', 300.00, 1, 1, '00:00', '23:59', 4, 4, 2, 1),
(5, 1005, '2026-04-05', '2025-10-01', 280.00, 1, 1, '07:00', '19:00', 5, 2, 3, 3),
-- Contratos PJ Frota
(6, 2001, '2026-04-05', '2025-01-01', 1500.00, 1, 5, '00:00', '23:59', 6, 1, 4, 2),
(7, 2002, '2026-04-10', '2025-01-10', 900.00,  1, 3, '07:00', '18:00', 7, 3, 4, 2),
(8, 2003, '2026-04-05', '2025-02-01', 1200.00, 1, 4, '00:00', '23:59', 8, 2, 4, 2),
(9, 2004, '2026-04-05', '2024-07-01', 3000.00, 1, 10,'00:00', '23:59', 9, 1, 4, 2);

INSERT INTO `ContratoMensalistaVeiculo` (`ContratoMensalista_Id`, `Veiculo_Id`) VALUES
(1, 1), (1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 11), (6, 12),
(7, 13),
(8, 14),
(9, 15);

-- =============================================================================
-- MÓDULO 10: FINANCEIRO — BANCO, CONTA, FORNECEDOR
-- =============================================================================

INSERT INTO `Banco` (`Id`, `CodigoBanco`, `Descricao`) VALUES
(1, '001', 'Banco do Brasil'),
(2, '033', 'Santander'),
(3, '104', 'Caixa Econômica Federal'),
(4, '237', 'Bradesco'),
(5, '341', 'Itaú Unibanco');

INSERT INTO `ContaFinanceira` (`Id`, `Descricao`, `Agencia`, `Conta`, `ContaPadrao`, `Banco_Id`, `Empresa_Id`) VALUES
(1, 'Conta Principal Itaú',     '1234',  '99887-6', 1, 5, 1),
(2, 'Conta Bradesco Operações', '5678',  '11223-4', 0, 4, 1),
(3, 'Conta BB Folha',           '0001',  '55667-8', 0, 1, 1);

INSERT INTO `ContaContabil` (`Id`, `Descricao`, `Ativo`, `Fixa`, `Hierarquia`, `Despesa`) VALUES
(1,  'RECEITAS',                        1, 1, 1, 0),
(2,  'Receita de Estacionamento',       1, 1, 2, 0),
(3,  'Receita de Mensalidade',          1, 1, 2, 0),
(4,  'Receita de Convênio',             1, 1, 2, 0),
(5,  'DESPESAS',                        1, 1, 1, 1),
(6,  'Despesas com Pessoal',            1, 1, 2, 1),
(7,  'Salários e Encargos',             1, 1, 3, 1),
(8,  'Vale Transporte',                 1, 1, 3, 1),
(9,  'Vale Refeição',                   1, 1, 3, 1),
(10, 'Despesas Operacionais',           1, 1, 2, 1),
(11, 'Manutenção de Equipamentos',      1, 1, 3, 1),
(12, 'Materiais de Consumo',            1, 1, 3, 1),
(13, 'Energia Elétrica',                1, 1, 3, 1),
(14, 'Aluguel',                         1, 1, 3, 1);

-- Fornecedor
INSERT INTO `Fornecedor` (`Id`, `Pessoa_Id`, `NomeFantasia`, `RazaoSocial`, `TipoPessoa`, `CNPJ`, `Banco_Id`) VALUES
(1, 20, 'Eletrônica Industrial',  'Eletrônica Industrial Ltda',  2, '67890123000155', 5),
(2, 21, 'Papelaria Suprimentos',  'Papelaria e Suprimentos ME',  2, '78901234000166', 4);

-- Contas a Pagar (últimos 3 meses de exemplo)
INSERT INTO `ContasAPagar` (`Id`, `TipoPagamento`, `NumeroDocumento`, `DataVencimento`, `DataCompetencia`, `ValorTotal`, `FormaPagamento`, `NumeroParcela`, `CodigoAgrupadorParcela`, `StatusConta`, `Ativo`, `Fornecedor_Id`, `Unidade_Id`) VALUES
(1,  1, 'NF-0501', '2026-03-10', '2026-03-01', 3500.00, 1, 1, 'AG2603001', 1, 1, 1, 1),
(2,  1, 'NF-0502', '2026-03-15', '2026-03-01', 850.00,  1, 1, 'AG2603002', 1, 1, 2, 1),
(3,  1, 'NF-0503', '2026-03-20', '2026-03-01', 4200.00, 1, 1, 'AG2603003', 2, 1, 1, 2),
(4,  1, 'NF-0504', '2026-04-10', '2026-04-01', 3500.00, 1, 1, 'AG2604001', 0, 1, 1, 1),
(5,  1, 'NF-0505', '2026-04-15', '2026-04-01', 900.00,  1, 1, 'AG2604002', 0, 1, 2, 2);

-- =============================================================================
-- MÓDULO 14: SEGURANÇA — PERFIL, PERMISSÃO, USUÁRIO
-- =============================================================================

INSERT INTO `Perfil` (`Id`, `Nome`) VALUES
(1, 'Administrador'),
(2, 'Gerente'),
(3, 'Operador de Caixa'),
(4, 'Financeiro'),
(5, 'Supervisor'),
(6, 'Somente Leitura');

INSERT INTO `Permissao` (`Id`, `Nome`, `Regra`) VALUES
(1,  'Visualizar Dashboard',          'dashboard.view'),
(2,  'Gerenciar Usuários',            'usuarios.manage'),
(3,  'Gerenciar Unidades',            'unidades.manage'),
(4,  'Gerenciar Clientes',            'clientes.manage'),
(5,  'Gerenciar Contratos',           'contratos.manage'),
(6,  'Gerenciar Financeiro',          'financeiro.manage'),
(7,  'Visualizar Financeiro',         'financeiro.view'),
(8,  'Gerenciar Funcionários',        'funcionarios.manage'),
(9,  'Registrar Movimentação',        'movimentacao.create'),
(10, 'Visualizar Relatórios',         'relatorios.view'),
(11, 'Gerenciar Estoque',             'estoque.manage'),
(12, 'Gerenciar Convênios',           'convenios.manage'),
(13, 'Gerenciar Selos',               'selos.manage'),
(14, 'Aprovar Contas a Pagar',        'contaspagar.approve'),
(15, 'Fechar Caixa',                  'caixa.close');

INSERT INTO `Menu` (`Id`, `Descricao`, `Url`, `Posicao`, `Ativo`) VALUES
(1,  'Dashboard',         '/dashboard',              1,  1),
(2,  'Operacional',       NULL,                      2,  1),
(3,  'Movimentações',     '/movimentacoes',          3,  1),
(4,  'Faturamento',       '/faturamento',            4,  1),
(5,  'Clientes',          '/clientes',               5,  1),
(6,  'Contratos',         '/contratos',              6,  1),
(7,  'Convênios',         '/convenios',              7,  1),
(8,  'Selos',             '/selos',                  8,  1),
(9,  'Financeiro',        NULL,                      9,  1),
(10, 'Contas a Pagar',    '/financeiro/pagar',       10, 1),
(11, 'Contas a Receber',  '/financeiro/receber',     11, 1),
(12, 'Lançamentos',       '/financeiro/lancamentos', 12, 1),
(13, 'RH',                NULL,                      13, 1),
(14, 'Funcionários',      '/rh/funcionarios',        14, 1),
(15, 'Ponto',             '/rh/ponto',               15, 1),
(16, 'Equipes',           '/rh/equipes',             16, 1),
(17, 'Configurações',     NULL,                      17, 1),
(18, 'Unidades',          '/config/unidades',        18, 1),
(19, 'Usuários',          '/config/usuarios',        19, 1),
(20, 'Perfis',            '/config/perfis',          20, 1),
(21, 'Estoque',           '/estoque',                21, 1),
(22, 'Relatórios',        '/relatorios',             22, 1);

-- Permissões por Perfil
INSERT INTO `PerfilPermissao` (`Perfil_Id`, `Permissao_Id`) VALUES
-- Administrador: tudo
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),
-- Gerente: quase tudo, sem manage usuários
(2,1),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),
-- Operador de Caixa: só operacional
(3,1),(3,9),(3,15),
-- Financeiro
(4,1),(4,6),(4,7),(4,10),(4,14),
-- Supervisor
(5,1),(5,3),(5,4),(5,5),(5,8),(5,9),(5,10),(5,12),(5,13),
-- Somente Leitura
(6,1),(6,7),(6,10);

-- Menus por Perfil
INSERT INTO `PerfilMenu` (`Perfil_Id`, `Menu_Id`) VALUES
-- Admin: todos os menus
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),
-- Gerente
(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),(2,16),(2,21),(2,22),
-- Caixa
(3,1),(3,2),(3,3),(3,4),
-- Financeiro
(4,1),(4,9),(4,10),(4,11),(4,12),(4,22),
-- Supervisor
(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,22);

-- =============================================================================
-- USUÁRIOS DO SISTEMA
-- Senhas em bcrypt (custo 10):
--   admin     → senha: Admin@123
--   gerente   → senha: Gerente@123
--   caixa     → senha: Caixa@123
--   financeiro→ senha: Fin@123
-- =============================================================================

INSERT INTO `Usuario` (`Id`, `Login`, `Senha`, `PrimeiroLogin`, `TemAcessoAoPDV`, `Ativo`, `Email`, `EhFuncionario`, `Funcionario_Id`, `Unidade_Id`) VALUES
(1, 'admin',       '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 0, 1, 'admin@smartpark.com.br',       0, NULL, NULL),
(2, 'c.mendes',    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 0, 1, 'carlos.mendes@smartpark.com.br', 1, 1,    NULL),
(3, 'f.lima',      '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPVNuggehm2', 0, 1, 1, 'fernanda.lima@smartpark.com.br', 1, 2,    1),
(4, 'r.costa',     '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPVNuggehm2', 0, 1, 1, 'roberto.costa@smartpark.com.br', 1, 3,    1),
(5, 'j.souza',     '$2a$10$D1.sUgpM8IXSo3q2FaCVpe8mFiNZ7a3l5yOl4E6KqM0bz1K/2pZJe', 0, 1, 1, 'juliana.souza@smartpark.com.br', 1, 4,    1),
(6, 'r.carvalho',  '$2a$10$7ciDFKNqxhDIkBfaTsTvDe4oV2mfpK3B2lN6zYkTmgVPcpGLJQUOu', 0, 0, 1, 'rafael.carvalho@smartpark.com.br',1,9,   NULL);

-- Senha padrão de todos os usuários acima é "password" (hash bcrypt genérico)
-- Para produção, altere imediatamente!

INSERT INTO `UsuarioPerfil` (`Usuario_Id`, `Perfil_Id`) VALUES
(1, 1),  -- admin → Administrador
(2, 2),  -- c.mendes → Gerente
(3, 2),  -- f.lima → Gerente
(4, 5),  -- r.costa → Supervisor
(5, 3),  -- j.souza → Operador de Caixa
(6, 4);  -- r.carvalho → Financeiro

-- =============================================================================
-- MÓDULO 11: MOVIMENTAÇÕES (últimas 30 entradas de exemplo)
-- =============================================================================

INSERT INTO `Movimentacao` (`Id`, `NumFechamento`, `NumTerminal`, `DataAbertura`, `DataFechamento`, `DataEntrada`, `DataSaida`, `Placa`, `ValorCobrado`, `FormaPagamento`, `Unidade_Id`, `Usuario_Id`) VALUES
(1,  1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 08:15:00', '2026-03-09 10:30:00', 'ABC1D23', 15.00,  'Cartão Débito',   1, 5),
(2,  1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 08:45:00', '2026-03-09 12:00:00', 'DEF2E34', 22.00,  'Dinheiro',        1, 5),
(3,  1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 09:00:00', '2026-03-09 11:15:00', 'GHI3F45', 18.00,  'Pix',             1, 5),
(4,  1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 09:30:00', '2026-03-09 13:45:00', 'JKL4G56', 28.00,  'Cartão Crédito',  1, 5),
(5,  1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 10:00:00', '2026-03-09 14:30:00', 'MNO5H67', 30.00,  'Dinheiro',        1, 5),
(6,  1, 2, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 10:15:00', '2026-03-09 12:45:00', 'PQR6I78', 20.00,  'Pix',             2, 5),
(7,  1, 2, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 11:00:00', '2026-03-09 13:00:00', 'STU7J89', 16.00,  'Cartão Débito',   2, 5),
(8,  1, 2, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 11:30:00', '2026-03-09 15:00:00', 'VWX8K90', 28.00,  'Dinheiro',        2, 5),
(9,  1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 14:00:00', '2026-03-09 16:30:00', 'YZA9L01', 20.00,  'Pix',             1, 5),
(10, 1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 15:00:00', '2026-03-09 18:00:00', 'BCD0M12', 24.00,  'Cartão Crédito',  1, 5),
-- Mensalistas identificados
(11, 1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 07:30:00', '2026-03-09 18:00:00', 'ABC1D23', 0.00,   'Mensalidade',     1, 5),
(12, 1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', '2026-03-09 08:00:00', '2026-03-09 17:30:00', 'EFG1N23', 0.00,   'Mensalidade',     1, 5),
-- Dia anterior
(13, 0, 1, '2026-03-08 00:00:00', '2026-03-08 23:59:00', '2026-03-08 08:20:00', '2026-03-08 11:00:00', 'ABC1D23', 18.00,  'Dinheiro',        1, 5),
(14, 0, 1, '2026-03-08 00:00:00', '2026-03-08 23:59:00', '2026-03-08 09:00:00', '2026-03-08 12:30:00', 'PQR6I78', 26.00,  'Cartão Débito',   1, 5),
(15, 0, 2, '2026-03-08 00:00:00', '2026-03-08 23:59:00', '2026-03-08 10:00:00', '2026-03-08 14:00:00', 'JKL4G56', 28.00,  'Pix',             2, 5);

-- =============================================================================
-- MÓDULO 11: FATURAMENTO
-- =============================================================================

INSERT INTO `Faturamento` (`Id`, `NomeUnidade`, `NumFechamento`, `NumTerminal`, `DataAbertura`, `DataFechamento`, `ValorTotal`, `ValorRotativo`, `ValorRecebimentoMensalidade`, `ValorDinheiro`, `ValorCartaoDebito`, `ValorCartaoCredito`, `ValorSemParar`, `SaldoInicial`, `Unidade_Id`, `Usuario_Id`) VALUES
(1, 'SmartPark Paulista',   1, 1, '2026-03-09 00:00:00', '2026-03-09 23:59:00', 15780.00, 5780.00, 10000.00, 3200.00, 4100.00, 5800.00, 2680.00, 500.00, 1, 3),
(2, 'SmartPark Consolação', 1, 2, '2026-03-09 00:00:00', '2026-03-09 23:59:00', 9450.00,  3950.00, 5500.00,  1800.00, 2900.00, 3850.00, 900.00,  300.00, 2, 4),
(3, 'SmartPark Paulista',   0, 1, '2026-03-08 00:00:00', '2026-03-08 23:59:00', 14200.00, 5200.00, 9000.00,  2900.00, 3800.00, 5200.00, 2300.00, 500.00, 1, 3),
(4, 'SmartPark Consolação', 0, 2, '2026-03-08 00:00:00', '2026-03-08 23:59:00', 8800.00,  3800.00, 5000.00,  1700.00, 2600.00, 3500.00, 1000.00, 300.00, 2, 4);

-- =============================================================================
-- MÓDULO 12: SELOS
-- =============================================================================

INSERT INTO `TipoSelo` (`Id`, `Nome`, `Valor`, `ComValidade`, `PagarHorasAdicionais`, `Ativo`) VALUES
(1, 'Selo 1h',  10.00, 0, 0, 1),
(2, 'Selo 2h',  18.00, 0, 0, 1),
(3, 'Selo 3h',  25.00, 0, 0, 1),
(4, 'Selo Dia', 40.00, 1, 0, 1);

INSERT INTO `Desconto` (`Id`, `Descricao`, `Valor`, `Ativo`) VALUES
(1, 'Desconto 10%',      10.00, 1),
(2, 'Desconto 15%',      15.00, 1),
(3, 'Desconto 20%',      20.00, 1),
(4, 'Cortesia Total',   100.00, 1);

INSERT INTO `EmissaoSelo` (`Id`, `Quantidade`, `TipoSelo_Id`, `Unidade_Id`, `Cliente_Id`) VALUES
(1, 100, 1, 1, 9),
(2, 50,  2, 1, 9),
(3, 200, 1, 2, 6),
(4, 100, 3, 1, NULL);

-- =============================================================================
-- MÓDULO 13: ESTOQUE E MATERIAIS
-- =============================================================================

INSERT INTO `TipoMaterial` (`Id`, `Descricao`) VALUES
(1, 'Material de Escritório'),
(2, 'Equipamento Eletrônico'),
(3, 'Material de Limpeza'),
(4, 'Peças e Componentes'),
(5, 'Uniformes');

INSERT INTO `Material` (`Id`, `Nome`, `Descricao`, `EhUmAtivo`, `EstoqueMaximo`, `EstoqueMinimo`, `TipoMaterial_Id`) VALUES
(1, 'Ticket de Estacionamento', 'Bobina de ticket térmico 80mm',  0, 500,  50,  1),
(2, 'Papel A4 (resma)',          'Papel A4 75g/m² 500 folhas',     0, 50,   5,   1),
(3, 'Cancela Automática',        'Cancela 4m com motor 220V',      1, 10,   2,   2),
(4, 'Câmera IP',                 'Câmera IP Full HD 2MP',          1, 20,   4,   2),
(5, 'Produto de Limpeza (L)',    'Detergente neutro 5L',           0, 100,  10,  3),
(6, 'Uniformes Operador',        'Uniforme completo operador',     0, 30,   5,   5),
(7, 'Sensor de Loop',            'Sensor magnético para cancela',  1, 15,   3,   4);

INSERT INTO `Estoque` (`Id`, `Nome`, `EstoquePrincipal`, `Unidade_Id`) VALUES
(1, 'Almoxarifado Central SP',   1, 1),
(2, 'Almoxarifado Consolação',   0, 2),
(3, 'Almoxarifado Campinas',     0, 3);

INSERT INTO `EstoqueMaterial` (`Estoque_Id`, `Material_Id`, `Quantidade`) VALUES
(1, 1, 350),
(1, 2, 30),
(1, 3, 5),
(1, 4, 12),
(1, 5, 60),
(1, 6, 18),
(1, 7, 8),
(2, 1, 150),
(2, 2, 10),
(2, 5, 20),
(3, 1, 100),
(3, 2, 8);

INSERT INTO `MaterialFornecedor` (`Material_Id`, `Fornecedor_Id`, `EhPersonalizado`, `QuantidadeParaPedidoAutomatico`) VALUES
(1, 2, 1, 100),
(2, 2, 0, 20),
(3, 1, 0, 2),
(4, 1, 0, 4),
(5, 2, 0, 30),
(6, 2, 0, 10),
(7, 1, 0, 5);

-- =============================================================================
-- MÓDULO 17: TABELA DE PREÇOS E FUNCIONAMENTO
-- =============================================================================

INSERT INTO `Periodo` (`Id`, `Codigo`, `Descricao`) VALUES
(1, 'SEG-SEX', 'Segunda a Sexta'),
(2, 'SAB',     'Sábado'),
(3, 'DOM-FER', 'Domingo e Feriado');

INSERT INTO `TabelaPrecoAvulso` (`Id`, `Nome`, `Numero`, `TempoToleranciaPagamento`, `TempoToleranciaDesistencia`, `Status`, `HoraAdicional`, `Padrao`, `QuantidadeHoraAdicional`, `ValorHoraAdicional`, `HoraInicioVigencia`, `HoraFimVigencia`) VALUES
(1, 'Tabela Rotativo Padrão',  1, 15, 15, 2, 1, 1, 1, 8.00,  '00:00', '23:59'),
(2, 'Tabela Noturno',          2, 15, 15, 2, 0, 0, 0, 0.00,  '22:00', '05:59'),
(3, 'Tabela Feriado',          3, 15, 15, 2, 1, 0, 1, 10.00, '00:00', '23:59');

INSERT INTO `TabelaPrecoAvulsoHoraValor` (`Hora`, `Valor`, `TabelaPrecoAvulso_Id`) VALUES
(1, 12.00, 1), (2, 18.00, 1), (3, 24.00, 1), (4, 28.00, 1),
(5, 30.00, 1), (6, 32.00, 1), (7, 34.00, 1), (8, 36.00, 1),
(1, 8.00,  2), (2, 12.00, 2), (3, 15.00, 2),
(1, 15.00, 3), (2, 22.00, 3), (3, 28.00, 3), (4, 32.00, 3);

INSERT INTO `TabelaPrecoAvulsoUnidade` (`TabelaPrecoAvulso_Id`, `Unidade_Id`) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2),
(3, 1), (3, 2), (3, 3);

-- =============================================================================
-- MÓDULO 16: NOTIFICAÇÕES
-- =============================================================================

INSERT INTO `TipoNotificacao` (`Id`, `Descricao`, `Entidade`) VALUES
(1, 'Contrato próximo ao vencimento',   1),
(2, 'Conta a pagar vencendo',           2),
(3, 'Estoque abaixo do mínimo',         3),
(4, 'Novo pedido de selo',              4),
(5, 'Ocorrência registrada',            5);

INSERT INTO `Notificacao` (`Id`, `Mensagem`, `Lida`, `TipoNotificacao_Id`, `Usuario_Id`) VALUES
(1, 'Contrato #1005 vence em 30 dias.',                1, 1, 2),
(2, 'NF-0504 vence em 10/04/2026 — R$ 3.500,00',      0, 2, 6),
(3, 'Ticket de Estacionamento abaixo do mínimo no Almoxarifado Central.', 0, 3, 2),
(4, 'Novo pedido de selo recebido do cliente Shopping Paulistano.', 0, 4, 2),
(5, 'Ocorrência registrada na unidade SmartPark Paulista.', 0, 5, 3);

-- =============================================================================
-- MÓDULO 19: TIPOS DE ATIVIDADE E OCORRÊNCIAS
-- =============================================================================

INSERT INTO `TipoAtividade` (`Id`, `Descricao`, `Ativo`) VALUES
(1, 'Verificar cancelas',             1),
(2, 'Conferir caixa',                 1),
(3, 'Testar equipamentos',            1),
(4, 'Verificar câmeras',              1),
(5, 'Limpeza do estacionamento',      1),
(6, 'Verificar iluminação',           1),
(7, 'Conferir estoque de tickets',    1);

INSERT INTO `TipoOcorrencia` (`Id`, `Descricao`, `Percentual`) VALUES
(1, 'Atraso',              5.00),
(2, 'Falta não justificada', 10.00),
(3, 'Advertência verbal',   0.00),
(4, 'Elogio',               0.00),
(5, 'Acidente de trabalho', 0.00);

-- =============================================================================
-- CONTROLE DE PONTO (exemplos)
-- =============================================================================

INSERT INTO `ControlePonto` (`DataRegistro`, `TipoRegistro`, `Funcionario_Id`, `Unidade_Id`) VALUES
('2026-03-09 07:55:00', 1, 4, 1),
('2026-03-09 12:00:00', 2, 4, 1),
('2026-03-09 13:00:00', 3, 4, 1),
('2026-03-09 17:03:00', 4, 4, 1),
('2026-03-09 07:48:00', 1, 5, 2),
('2026-03-09 12:02:00', 2, 5, 2),
('2026-03-09 13:01:00', 3, 5, 2),
('2026-03-09 17:00:00', 4, 5, 2),
('2026-03-09 07:58:00', 1, 6, 1),
('2026-03-09 17:05:00', 4, 6, 1);

-- =============================================================================
-- LANÇAMENTOS DE COBRANÇA (Mensalistas - Março 2026)
-- =============================================================================

INSERT INTO `Recebimento` (`Id`, `StatusRecebimento`) VALUES
(1, 2), (2, 2), (3, 1), (4, 1), (5, 1),
(6, 2), (7, 2), (8, 1), (9, 1);

INSERT INTO `LancamentoCobranca` (`Id`, `DataGeracao`, `DataVencimento`, `DataCompetencia`, `DataBaixa`, `StatusLancamentoCobranca`, `ValorContrato`, `NossoNumero`, `Recebimento_Id`, `Cliente_Id`, `Unidade_Id`) VALUES
(1, '2026-03-01 10:00:00', '2026-03-05', '2026-03-01', '2026-03-04', 3, 350.00,  1001, 1, 1, 1),
(2, '2026-03-01 10:00:00', '2026-03-05', '2026-03-01', '2026-03-03', 3, 350.00,  1002, 2, 2, 1),
(3, '2026-03-01 10:00:00', '2026-03-10', '2026-03-01', NULL,          1, 320.00,  1003, 3, 3, 3),
(4, '2026-03-01 10:00:00', '2026-03-05', '2026-03-01', NULL,          1, 300.00,  1004, 4, 4, 4),
(5, '2026-03-01 10:00:00', '2026-03-05', '2026-03-01', NULL,          1, 280.00,  1005, 5, 5, 2),
(6, '2026-03-01 10:00:00', '2026-03-05', '2026-03-01', '2026-03-02', 3, 1500.00, 2001, 6, 6, 1),
(7, '2026-03-01 10:00:00', '2026-03-10', '2026-03-01', '2026-03-08', 3, 900.00,  2002, 7, 7, 3),
(8, '2026-03-01 10:00:00', '2026-03-05', '2026-03-01', NULL,          1, 1200.00, 2003, 8, 8, 2),
(9, '2026-03-01 10:00:00', '2026-03-05', '2026-03-01', NULL,          1, 3000.00, 2004, 9, 9, 1);

INSERT INTO `LancamentoCobrancaContratoMensalista` (`LancamentoCobranca_Id`, `ContratoMensalista_Id`) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9);

SET FOREIGN_KEY_CHECKS=1;

-- =============================================================================
-- RESUMO DA MASSA DE DADOS
-- =============================================================================
-- Localização  : 1 país, 5 estados, 10 cidades, 10 endereços
-- Empresas     : 1 grupo, 1 empresa, 3 filiais
-- Unidades     : 5 estacionamentos (SP x2, Campinas, RJ, BH)
-- Clientes     : 5 PF + 4 PJ (com frota)
-- Funcionários : 10 (com hierarquia e departamentos)
-- Contratos    : 9 mensalistas (PF e PJ/Frota)
-- Veículos     : 15 (PF + frota PJ)
-- Usuários     : 6 (admin, gerentes, caixa, financeiro)
-- Movimentações: 15 registros (hoje + ontem)
-- Faturamento  : 4 fechamentos de caixa
-- Lançamentos  : 9 cobranças de mensalidade (março/2026)
-- Estoque      : 7 materiais, 3 almoxarifados, 12 saldos
-- Notificações : 5 notificações de exemplo
--
-- LOGINS DISPONÍVEIS:
--   admin      / password  → Administrador
--   c.mendes   / password  → Gerente Geral
--   f.lima     / password  → Gerente Unidade
--   r.costa    / password  → Supervisor
--   j.souza    / password  → Caixa (acesso ao PDV)
--   r.carvalho / password  → Financeiro
-- =============================================================================

-- =============================================================================
-- SmartPark — Atualização de Senhas (BCrypt $2a$ compatível com BCrypt.Net)
-- Execute este script APÓS o seed principal (smartpark_seed.sql)
-- =============================================================================

USE `SmartPark`;

-- -----------------------------------------------------------------------------
-- LOGIN          | SENHA
-- admin          | Admin@123
-- c.mendes       | Mendes@123
-- f.lima         | Lima@123
-- r.costa        | Costa@123
-- j.souza        | Souza@123
-- r.carvalho     | Carvalho@123
-- -----------------------------------------------------------------------------

UPDATE `Usuario` SET `Senha` = '$2a$12$1G1BNI6wjO2qGp1XVamx3.F8Dc5mZCrkdXacfKn81X/eIEbSaA4j.'
WHERE `Login` = 'admin';

UPDATE `Usuario` SET `Senha` = '$2a$12$ZjoT5RV9VTghBuDfXolLRuRH0PGo2sKqQWeagD3AnuymqrVYma5Wy'
WHERE `Login` = 'c.mendes';

UPDATE `Usuario` SET `Senha` = '$2a$12$49grQ03SZx8va72zp7.aoOycaPsWKksrTyIyjgiDePsY7vBpXiqO2'
WHERE `Login` = 'f.lima';

UPDATE `Usuario` SET `Senha` = '$2a$12$ongQhQ/SzHado5zA02/hZ.Ge5bdFHkegllIdwlHvYjp3G.djsKF5i'
WHERE `Login` = 'r.costa';

UPDATE `Usuario` SET `Senha` = '$2a$12$Q4sydXbM7Q7WuzQarvZgReOQMJU/kMPWL902cIJCIyEsA.HDuoRSm'
WHERE `Login` = 'j.souza';

UPDATE `Usuario` SET `Senha` = '$2a$12$xyGgaJa1wwguQSYs6LylwuMHQabhYA10lIFKEWZRZKHgnoZ.vF0QK'
WHERE `Login` = 'r.carvalho';

-- Verificar
SELECT `Id`, `Login`, LEFT(`Senha`, 20) AS `HashInicio`, `Ativo` FROM `Usuario`;
