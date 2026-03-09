-- =============================================================================
-- SISTEMA SmartPark — ERP de Estacionamentos
-- Script MySQL Completo
-- Gerado em: Março/2026
-- =============================================================================

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE DATABASE IF NOT EXISTS `SmartPark`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `SmartPark`;

-- =============================================================================
-- MÓDULO 1: LOCALIZAÇÃO
-- =============================================================================

CREATE TABLE `Pais` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Estado` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  `Sigla`        VARCHAR(2)   NOT NULL,
  `Pais_Id`      INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Estado_Pais` FOREIGN KEY (`Pais_Id`) REFERENCES `Pais` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Cidade` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(150) NOT NULL,
  `Estado_Id`    INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Cidade_Estado` FOREIGN KEY (`Estado_Id`) REFERENCES `Estado` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Endereco` (
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Cep`          VARCHAR(10)   NOT NULL,
  `Logradouro`   VARCHAR(200)  NULL,
  `Numero`       VARCHAR(10)   NULL,
  `Complemento`  VARCHAR(50)   NULL,
  `Bairro`       VARCHAR(100)  NULL,
  `Descricao`    VARCHAR(100)  NULL,
  `Tipo`         VARCHAR(30)   NULL,
  `Latitude`     VARCHAR(30)   NULL,
  `Longitude`    VARCHAR(30)   NULL,
  `Referencia`   VARCHAR(200)  NULL,
  `Cidade_Id`    INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Endereco_Cidade` FOREIGN KEY (`Cidade_Id`) REFERENCES `Cidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 2: IDENTIDADE (Pessoa e herança)
-- =============================================================================

CREATE TABLE `Trabalho` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(200) NULL,
  `CNPJ`         VARCHAR(14)  NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de junção Trabalho <-> Endereco
CREATE TABLE `TrabalhoEndereco` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Trabalho_Id`  INT      NOT NULL,
  `Endereco_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TrabalhoEndereco_Trabalho` FOREIGN KEY (`Trabalho_Id`) REFERENCES `Trabalho` (`Id`),
  CONSTRAINT `fk_TrabalhoEndereco_Endereco` FOREIGN KEY (`Endereco_Id`) REFERENCES `Endereco` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Contato` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- TipoContato: 1=Email, 2=Residencial, 3=Celular, 4=Recado, 5=Comercial, 6=Fax, 7=OutroEmail
  `Tipo`         TINYINT      NOT NULL,
  `Email`        VARCHAR(200) NULL,
  `Numero`       VARCHAR(100) NULL,
  `NomeRecado`   VARCHAR(100) NULL,
  `Ordem`        INT          NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Documento` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- TipoDocumento: 1=RG, 2=CPF, 3=CNPJ, 4=IE, 5=CFM, 6=TituloEleitoral, 7=CTPS, 8=PIS, 9=IM, 10=CNH
  `Tipo`            TINYINT      NOT NULL,
  `Numero`          VARCHAR(30)  NULL,
  `OrgaoExpedidor`  VARCHAR(50)  NULL,
  `DataExpedicao`   DATE         NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Pessoa` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`            VARCHAR(200) NOT NULL,
  `Sexo`            VARCHAR(1)   NULL,
  `DataNascimento`  DATE         NULL,
  `Ativo`           TINYINT(1)   NOT NULL DEFAULT 1,
  `Trabalho_Id`     INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Pessoa_Trabalho` FOREIGN KEY (`Trabalho_Id`) REFERENCES `Trabalho` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PessoaEndereco` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Pessoa_Id`    INT      NOT NULL,
  `Endereco_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PessoaEndereco_Pessoa`   FOREIGN KEY (`Pessoa_Id`)   REFERENCES `Pessoa` (`Id`),
  CONSTRAINT `fk_PessoaEndereco_Endereco` FOREIGN KEY (`Endereco_Id`) REFERENCES `Endereco` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PessoaDocumento` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Pessoa_Id`    INT      NOT NULL,
  `Documento_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PessoaDocumento_Pessoa`    FOREIGN KEY (`Pessoa_Id`)    REFERENCES `Pessoa` (`Id`),
  CONSTRAINT `fk_PessoaDocumento_Documento` FOREIGN KEY (`Documento_Id`) REFERENCES `Documento` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PessoaContato` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Pessoa_Id`    INT      NOT NULL,
  `Contato_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PessoaContato_Pessoa`  FOREIGN KEY (`Pessoa_Id`)  REFERENCES `Pessoa` (`Id`),
  CONSTRAINT `fk_PessoaContato_Contato` FOREIGN KEY (`Contato_Id`) REFERENCES `Contato` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 3: EMPRESA / FILIAL (herança de Pessoa — Table Per Class)
-- Correção: FK explícita Pessoa_Id em vez de depender de convenção implícita
-- =============================================================================

CREATE TABLE `Grupo` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- PessoaJuridica é uma herança intermediária de Pessoa
CREATE TABLE `PessoaJuridica` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Pessoa_Id`    INT          NOT NULL,  -- FK explícita (corrige herança implícita do legado)
  `CNPJ`         VARCHAR(14)  NULL,      -- Separado (corrige CPFCNPJ genérico do legado)
  `CPF`          VARCHAR(11)  NULL,
  `IE`           VARCHAR(30)  NULL,
  `IM`           VARCHAR(30)  NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PessoaJuridica_Pessoa` FOREIGN KEY (`Pessoa_Id`) REFERENCES `Pessoa` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Empresa` (
  `Id`                INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PessoaJuridica_Id` INT      NOT NULL,
  `Grupo_Id`          INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Empresa_PessoaJuridica` FOREIGN KEY (`PessoaJuridica_Id`) REFERENCES `PessoaJuridica` (`Id`),
  CONSTRAINT `fk_Empresa_Grupo`          FOREIGN KEY (`Grupo_Id`)          REFERENCES `Grupo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EmpresaContato` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Empresa_Id`   INT      NOT NULL,
  `Contato_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EmpresaContato_Empresa` FOREIGN KEY (`Empresa_Id`) REFERENCES `Empresa` (`Id`),
  CONSTRAINT `fk_EmpresaContato_Contato` FOREIGN KEY (`Contato_Id`) REFERENCES `Contato` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TipoFilial` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Filial` (
  `Id`                INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PessoaJuridica_Id` INT      NOT NULL,
  `Empresa_Id`        INT      NOT NULL,
  `TipoFilial_Id`     INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Filial_PessoaJuridica` FOREIGN KEY (`PessoaJuridica_Id`) REFERENCES `PessoaJuridica` (`Id`),
  CONSTRAINT `fk_Filial_Empresa`        FOREIGN KEY (`Empresa_Id`)        REFERENCES `Empresa` (`Id`),
  CONSTRAINT `fk_Filial_TipoFilial`     FOREIGN KEY (`TipoFilial_Id`)     REFERENCES `TipoFilial` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `FilialContato` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Filial_Id`    INT      NOT NULL,
  `Contato_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_FilialContato_Filial`  FOREIGN KEY (`Filial_Id`)  REFERENCES `Filial` (`Id`),
  CONSTRAINT `fk_FilialContato_Contato` FOREIGN KEY (`Contato_Id`) REFERENCES `Contato` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Regional` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RegionalEstado` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Regional_Id`  INT      NOT NULL,
  `Estado_Id`    INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_RegionalEstado_Regional` FOREIGN KEY (`Regional_Id`) REFERENCES `Regional` (`Id`),
  CONSTRAINT `fk_RegionalEstado_Estado`   FOREIGN KEY (`Estado_Id`)   REFERENCES `Estado` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 4: UNIDADE (Estacionamento)
-- =============================================================================

CREATE TABLE `TipoUnidade` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `MaquinaCartao` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NULL,
  `CNPJ_Id`      INT          NULL,  -- FK para Empresa (corrige References para CNPJ)
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CheckListAtividade` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`       VARCHAR(200) NOT NULL,
  `Usuario`         INT          NULL,
  `Ativo`           TINYINT(1)   NOT NULL DEFAULT 1,
  `Funcionario_Id`  INT          NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Unidade` (
  `Id`                   INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Codigo`               VARCHAR(20)  NULL,
  `Nome`                 VARCHAR(200) NOT NULL,
  `NumeroVaga`           INT          NOT NULL DEFAULT 0,
  `DiaVencimento`        INT          NOT NULL DEFAULT 1,
  `CNPJ`                 VARCHAR(14)  NULL,   -- Corrige: era CPFCNPJ genérico no legado
  `CCM`                  VARCHAR(30)  NULL,
  `HorarioInicial`       VARCHAR(10)  NULL,
  `HorarioFinal`         VARCHAR(10)  NULL,
  `Ativa`                TINYINT(1)   NOT NULL DEFAULT 1,
  -- TiposUnidades: enum armazenado como INT
  `TiposUnidades`        INT          NOT NULL DEFAULT 0,
  `Empresa_Id`           INT          NULL,
  `Endereco_Id`          INT          NULL,
  `MaquinaCartao_Id`     INT          NULL,
  `Funcionario_Id`       INT          NULL,   -- Responsavel
  `CheckListAtividade_Id` INT         NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Unidade_Empresa`           FOREIGN KEY (`Empresa_Id`)           REFERENCES `Empresa` (`Id`),
  CONSTRAINT `fk_Unidade_Endereco`          FOREIGN KEY (`Endereco_Id`)          REFERENCES `Endereco` (`Id`),
  CONSTRAINT `fk_Unidade_MaquinaCartao`     FOREIGN KEY (`MaquinaCartao_Id`)     REFERENCES `MaquinaCartao` (`Id`),
  CONSTRAINT `fk_Unidade_CheckListAtividade` FOREIGN KEY (`CheckListAtividade_Id`) REFERENCES `CheckListAtividade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Atualiza FK de CheckListAtividade -> Funcionario (criado depois)
-- (ver ALTER TABLE na seção de RH)

CREATE TABLE `EstruturaGaragem` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EstruturaUnidade` (
  `Id`               INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`        VARCHAR(200) NULL,
  `Unidade_Id`       INT          NOT NULL,
  `EstruturaGaragem_Id` INT       NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EstruturaUnidade_Unidade`        FOREIGN KEY (`Unidade_Id`)       REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_EstruturaUnidade_EstruturaGaragem` FOREIGN KEY (`EstruturaGaragem_Id`) REFERENCES `EstruturaGaragem` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Equipamento` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200) NOT NULL,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EquipamentoUnidade` (
  `Id`             INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Unidade_Id`     INT      NOT NULL,
  `Equipamento_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EquipamentoUnidade_Unidade`     FOREIGN KEY (`Unidade_Id`)     REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_EquipamentoUnidade_Equipamento` FOREIGN KEY (`Equipamento_Id`) REFERENCES `Equipamento` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TipoPagamento` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  `Unidade_Id`   INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TipoPagamento_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 5: VEÍCULO
-- =============================================================================

CREATE TABLE `Marca` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Modelo` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  `Marca_Id`     INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Modelo_Marca` FOREIGN KEY (`Marca_Id`) REFERENCES `Marca` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Veiculo` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Placa`        VARCHAR(10)  NOT NULL,
  `Cor`          VARCHAR(50)  NULL,
  `Ano`          INT          NULL,
  -- TipoVeiculo: enum INT
  `TipoVeiculo`  INT          NOT NULL DEFAULT 0,
  `Modelo_Id`    INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Veiculo_Modelo` FOREIGN KEY (`Modelo_Id`) REFERENCES `Modelo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 6: CLIENTE
-- =============================================================================

CREATE TABLE `Cliente` (
  `Id`                     INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IdSoftpark`             INT          NULL,
  -- TipoPessoa: enum INT (Fisica=1, Juridica=2)
  `TipoPessoa`             TINYINT      NOT NULL DEFAULT 1,
  `NomeFantasia`           VARCHAR(200) NULL,
  `RazaoSocial`            VARCHAR(200) NULL,
  `ExigeNotaFiscal`        TINYINT(1)   NOT NULL DEFAULT 0,
  `NotaFiscalSemDesconto`  TINYINT(1)   NOT NULL DEFAULT 0,
  `NomeConvenio`           VARCHAR(200) NULL,
  `Observacao`             TEXT         NULL,
  `Pessoa_Id`              INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Cliente_Pessoa` FOREIGN KEY (`Pessoa_Id`) REFERENCES `Pessoa` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ClienteVeiculo` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Cliente_Id`   INT      NOT NULL,
  `Veiculo_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ClienteVeiculo_Cliente` FOREIGN KEY (`Cliente_Id`) REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_ClienteVeiculo_Veiculo` FOREIGN KEY (`Veiculo_Id`) REFERENCES `Veiculo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Correção: legado tinha ClienteUnidade E ClienteUnidades (duplicata) — unificado aqui
CREATE TABLE `ClienteUnidade` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Cliente_Id`   INT      NOT NULL,
  `Unidade_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ClienteUnidade_Cliente`  FOREIGN KEY (`Cliente_Id`)  REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_ClienteUnidade_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ClienteCondomino` (
  `Id`               INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NumeroVagas`      INT          NOT NULL DEFAULT 0,
  `Frota`            TINYINT(1)   NOT NULL DEFAULT 0,
  `Cliente_Id`       INT          NULL,
  `Unidade_Id`       INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ClienteCondomino_Cliente`  FOREIGN KEY (`Cliente_Id`)  REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_ClienteCondomino_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ClienteCondominoVeiculo` (
  `Id`                  INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ClienteCondomino_Id` INT      NOT NULL,
  `Veiculo_Id`          INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ClienteCondominoVeiculo_ClienteCondomino` FOREIGN KEY (`ClienteCondomino_Id`) REFERENCES `ClienteCondomino` (`Id`),
  CONSTRAINT `fk_ClienteCondominoVeiculo_Veiculo`          FOREIGN KEY (`Veiculo_Id`)          REFERENCES `Veiculo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContaCorrenteCliente` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Cliente_Id`   INT      NOT NULL UNIQUE,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContaCorrenteCliente_Cliente` FOREIGN KEY (`Cliente_Id`) REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContaCorrenteClienteDetalhe` (
  `Id`                       INT            NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataCompetencia`          DATE           NOT NULL,
  `Valor`                    DECIMAL(10,2)  NOT NULL,
  -- TipoOperacaoContaCorrente: enum INT
  `TipoOperacaoContaCorrente` INT           NOT NULL,
  `ContaCorrenteCliente_Id`  INT            NOT NULL,
  `ContratoMensalista_Id`    INT            NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContaCorrenteClienteDetalhe_ContaCorrenteCliente` FOREIGN KEY (`ContaCorrenteCliente_Id`) REFERENCES `ContaCorrenteCliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 7: CONVÊNIO
-- Correção: legado tinha Convenio E ConvenioUnidade E ConvenioUnidades (triplicata)
-- =============================================================================

CREATE TABLE `Convenio` (  -- Corrige: legado "Convenios" (plural)
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200) NOT NULL,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ConvenioUnidade` (  -- Unificado (corrige duplicata do legado)
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Convenio_Id`  INT      NOT NULL,
  `Unidade_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ConvenioUnidade_Convenio` FOREIGN KEY (`Convenio_Id`) REFERENCES `Convenio` (`Id`),
  CONSTRAINT `fk_ConvenioUnidade_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ConvenioCliente` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Convenio_Id`  INT      NOT NULL,
  `Cliente_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ConvenioCliente_Convenio` FOREIGN KEY (`Convenio_Id`) REFERENCES `Convenio` (`Id`),
  CONSTRAINT `fk_ConvenioCliente_Cliente`  FOREIGN KEY (`Cliente_Id`)  REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 8: RH — Cargo, Departamento, Funcionário
-- =============================================================================

CREATE TABLE `Cargo` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Departamento` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(100) NOT NULL,
  `Sigla`        VARCHAR(10)  NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Funcionario` (
  `Id`             INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Codigo`         VARCHAR(20)   NULL,
  `Salario`        DECIMAL(10,2) NULL,
  `ImagemCaminho`  VARCHAR(500)  NULL,  -- Corrige: era varbinary(max) no legado
  -- StatusFuncionario: enum INT
  `Status`         INT           NULL,
  -- TipoEscalaFuncionario: enum INT
  `TipoEscala`     INT           NOT NULL DEFAULT 0,
  `DataAdmissao`   DATE          NULL,
  `Pessoa_Id`      INT           NOT NULL,
  `Cargo_Id`       INT           NULL,
  `Unidade_Id`     INT           NULL,
  `Supervisor_Id`  INT           NULL,  -- auto-referência
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Funcionario_Pessoa`     FOREIGN KEY (`Pessoa_Id`)    REFERENCES `Pessoa` (`Id`),
  CONSTRAINT `fk_Funcionario_Cargo`      FOREIGN KEY (`Cargo_Id`)     REFERENCES `Cargo` (`Id`),
  CONSTRAINT `fk_Funcionario_Unidade`    FOREIGN KEY (`Unidade_Id`)   REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_Funcionario_Supervisor` FOREIGN KEY (`Supervisor_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Adiciona FK de Unidade.Funcionario_Id agora que Funcionario existe
ALTER TABLE `Unidade` ADD CONSTRAINT `fk_Unidade_Funcionario`
  FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`);

ALTER TABLE `CheckListAtividade` ADD CONSTRAINT `fk_CheckListAtividade_Funcionario`
  FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`);

CREATE TABLE `DepartamentoFuncionario` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Departamento_Id` INT      NOT NULL,
  `Funcionario_Id`  INT      NOT NULL,
  -- Funcao: enum INT (Responsavel, etc.)
  `Funcao`          INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_DepartamentoFuncionario_Departamento` FOREIGN KEY (`Departamento_Id`) REFERENCES `Departamento` (`Id`),
  CONSTRAINT `fk_DepartamentoFuncionario_Funcionario`  FOREIGN KEY (`Funcionario_Id`)  REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `UnidadeFuncionario` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- Funcao: enum INT
  `Funcao`           INT      NOT NULL,
  `Unidade_Id`       INT      NOT NULL,
  `Funcionario_Id`   INT      NOT NULL,
  `MaquinaCartao_Id` INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_UnidadeFuncionario_Unidade`       FOREIGN KEY (`Unidade_Id`)       REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_UnidadeFuncionario_Funcionario`   FOREIGN KEY (`Funcionario_Id`)   REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `fk_UnidadeFuncionario_MaquinaCartao` FOREIGN KEY (`MaquinaCartao_Id`) REFERENCES `MaquinaCartao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ItemFuncionario` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Funcionario_Id`  INT          NOT NULL UNIQUE,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ItemFuncionario_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ItemFuncionarioDetalhe` (
  `Id`                  INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`        DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valor`               DECIMAL(10,2) NOT NULL,
  `ItemFuncionario_Id`  INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ItemFuncionarioDetalhe_ItemFuncionario` FOREIGN KEY (`ItemFuncionario_Id`) REFERENCES `ItemFuncionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `BeneficioFuncionario` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Funcionario_Id`  INT      NOT NULL UNIQUE,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_BeneficioFuncionario_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TipoBeneficio` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `BeneficioFuncionarioDetalhe` (
  `Id`                     INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`           DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valor`                  DECIMAL(10,2) NOT NULL,
  `BeneficioFuncionario_Id` INT          NOT NULL,
  `TipoBeneficio_Id`       INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_BeneficioFuncionarioDetalhe_BeneficioFuncionario` FOREIGN KEY (`BeneficioFuncionario_Id`) REFERENCES `BeneficioFuncionario` (`Id`),
  CONSTRAINT `fk_BeneficioFuncionarioDetalhe_TipoBeneficio`        FOREIGN KEY (`TipoBeneficio_Id`)        REFERENCES `TipoBeneficio` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ControleFerias` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataInicio`      DATE     NOT NULL,
  `DataFim`         DATE     NOT NULL,
  `Funcionario_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ControleFerias_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ControlePonto` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataRegistro`    DATETIME NOT NULL,
  `TipoRegistro`   INT      NOT NULL,
  `Funcionario_Id`  INT      NOT NULL,
  `Unidade_Id`      INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ControlePonto_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `fk_ControlePonto_Unidade`     FOREIGN KEY (`Unidade_Id`)     REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CalendarioRH` (
  `Id`            INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Data`          DATE         NOT NULL,
  `Descricao`     VARCHAR(200) NULL,
  `DataFixa`      TINYINT(1)   NOT NULL DEFAULT 0,
  `TodasUnidade`  TINYINT(1)   NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CalendarioRHUnidade` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CalendarioRH_Id` INT      NOT NULL,
  `Unidade_Id`      INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_CalendarioRHUnidade_CalendarioRH` FOREIGN KEY (`CalendarioRH_Id`) REFERENCES `CalendarioRH` (`Id`),
  CONSTRAINT `fk_CalendarioRHUnidade_Unidade`       FOREIGN KEY (`Unidade_Id`)       REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PlanoCarreira` (
  `Id`              INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`       VARCHAR(200)  NULL,
  `Funcionario_Id`  INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PlanoCarreira_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 9: CONTRATOS
-- =============================================================================

CREATE TABLE `TipoMensalista` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoMensalista` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200) NOT NULL,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContratoMensalista` (
  `Id`                       INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NumeroContrato`           INT           NOT NULL,
  `DataVencimento`           DATE          NOT NULL,
  `DataInicio`               DATE          NOT NULL,
  `DataFim`                  DATE          NULL,
  `Valor`                    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Ativo`                    TINYINT(1)    NOT NULL DEFAULT 1,
  `NumeroVagas`              INT           NOT NULL DEFAULT 1,
  `Frota`                    TINYINT(1)    NOT NULL DEFAULT 0,
  `HorarioInicio`            VARCHAR(10)   NULL,
  `HorarioFim`               VARCHAR(10)   NULL,
  `Observacao`               TEXT          NULL,
  `Cliente_Id`               INT           NOT NULL,
  `Unidade_Id`               INT           NOT NULL,
  `TipoMensalista_Id`        INT           NOT NULL,
  `TabelaPrecoMensalista_Id` INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContratoMensalista_Cliente`               FOREIGN KEY (`Cliente_Id`)               REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_ContratoMensalista_Unidade`               FOREIGN KEY (`Unidade_Id`)               REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_ContratoMensalista_TipoMensalista`        FOREIGN KEY (`TipoMensalista_Id`)        REFERENCES `TipoMensalista` (`Id`),
  CONSTRAINT `fk_ContratoMensalista_TabelaPrecoMensalista` FOREIGN KEY (`TabelaPrecoMensalista_Id`) REFERENCES `TabelaPrecoMensalista` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContratoMensalistaVeiculo` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ContratoMensalista_Id` INT      NOT NULL,
  `Veiculo_Id`            INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContratoMensalistaVeiculo_ContratoMensalista` FOREIGN KEY (`ContratoMensalista_Id`) REFERENCES `ContratoMensalista` (`Id`),
  CONSTRAINT `fk_ContratoMensalistaVeiculo_Veiculo`            FOREIGN KEY (`Veiculo_Id`)            REFERENCES `Veiculo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Correção: era "ContratoMensalistaNotificao" no legado (typo crítico)
CREATE TABLE `ContratoMensalistaNotificacao` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ContratoMensalista_Id` INT      NOT NULL,
  `Notificacao_Id`        INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContratoMensalistaNotificacao_ContratoMensalista` FOREIGN KEY (`ContratoMensalista_Id`) REFERENCES `ContratoMensalista` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContratoUnidade` (
  `Id`                    INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TipoContrato`          INT           NULL,
  `NumeroContrato`        VARCHAR(50)   NULL,
  `DiaVencimento`         INT           NOT NULL,
  `InformarVencimentoDias` INT          NULL,
  `Valor`                 DECIMAL(10,2) NOT NULL,
  `TipoValor`             INT           NULL,
  `InicioContrato`        DATE          NOT NULL,
  `FinalContrato`         DATE          NOT NULL,
  `ExistiraReajuste`      TINYINT(1)    NULL,
  `IndiceReajuste`        DECIMAL(5,2)  NULL,
  `Ativo`                 TINYINT(1)    NOT NULL DEFAULT 1,
  `Unidade_Id`            INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContratoUnidade_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 10: FINANCEIRO — Banco, Conta, Fornecedor
-- =============================================================================

CREATE TABLE `Banco` (
  `Id`            INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CodigoBanco`   VARCHAR(10)  NOT NULL,
  `Descricao`     VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContaFinanceira` (
  `Id`                  INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`           VARCHAR(200) NOT NULL,
  `Agencia`             VARCHAR(10)  NULL,
  `DigitoAgencia`       VARCHAR(2)   NULL,
  `Conta`               VARCHAR(20)  NULL,
  `DigitoConta`         VARCHAR(2)   NULL,
  `CPF`                 VARCHAR(11)  NULL,  -- Corrige: era Cpf.Column("CPFCNPJ") no legado
  `CNPJ`                VARCHAR(14)  NULL,  -- Separado (corrige mistura do legado)
  `Convenio`            VARCHAR(20)  NULL,
  `Carteira`            VARCHAR(10)  NULL,
  `CodigoTransmissao`   VARCHAR(30)  NULL,
  `ContaPadrao`         TINYINT(1)   NOT NULL DEFAULT 0,
  `ConvenioPagamento`   VARCHAR(20)  NULL,
  `Banco_Id`            INT          NULL,
  `Empresa_Id`          INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContaFinanceira_Banco`   FOREIGN KEY (`Banco_Id`)   REFERENCES `Banco` (`Id`),
  CONSTRAINT `fk_ContaFinanceira_Empresa` FOREIGN KEY (`Empresa_Id`) REFERENCES `Empresa` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Fornecedor herda de Pessoa (Table Per Class)
CREATE TABLE `Fornecedor` (
  `Id`                      INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Pessoa_Id`               INT          NOT NULL,  -- FK explícita (corrige SubclassMap do legado)
  `NomeFantasia`            VARCHAR(200) NULL,
  `RazaoSocial`             VARCHAR(200) NULL,
  -- TipoPessoa: enum INT
  `TipoPessoa`              TINYINT      NOT NULL DEFAULT 1,
  `ReceberCotacaoPorEmail`  TINYINT(1)   NOT NULL DEFAULT 0,
  `CPF`                     VARCHAR(11)  NULL,   -- Corrige: era CPFCNPJ genérico
  `CNPJ`                    VARCHAR(14)  NULL,   -- Separado
  `Beneficiario`            VARCHAR(200) NULL,
  `Agencia`                 VARCHAR(10)  NULL,
  `DigitoAgencia`           VARCHAR(2)   NULL,
  `Conta`                   VARCHAR(20)  NULL,
  `DigitoConta`             VARCHAR(2)   NULL,
  `Banco_Id`                INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Fornecedor_Pessoa` FOREIGN KEY (`Pessoa_Id`) REFERENCES `Pessoa` (`Id`),
  CONSTRAINT `fk_Fornecedor_Banco`  FOREIGN KEY (`Banco_Id`)  REFERENCES `Banco` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContaContabil` (
  `Id`                INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`         VARCHAR(200) NOT NULL,
  `Ativo`             TINYINT(1)   NOT NULL DEFAULT 1,
  `Fixa`              TINYINT(1)   NOT NULL DEFAULT 1,
  -- Hierarquia: enum INT
  `Hierarquia`        INT          NOT NULL,
  `Despesa`           TINYINT(1)   NULL,
  `ContaContabilPai_Id` INT        NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContaContabil_ContaContabilPai` FOREIGN KEY (`ContaContabilPai_Id`) REFERENCES `ContaContabil` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContasAPagar` (
  `Id`                      INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`            DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- TipoContaPagamento: enum INT
  `TipoPagamento`           INT           NULL,
  -- TipoDocumentoConta: enum INT
  `TipoDocumentoConta`      INT           NULL,
  `NumeroDocumento`         VARCHAR(50)   NULL,
  `DataVencimento`          DATE          NOT NULL,
  `DataCompetencia`         DATE          NULL,
  `DataPagamento`           DATE          NULL,
  `ValorTotal`              DECIMAL(10,2) NOT NULL,
  -- FormaPagamento: enum INT
  `FormaPagamento`          INT           NOT NULL,
  `NumeroParcela`           INT           NOT NULL DEFAULT 1,
  `Observacoes`             VARCHAR(500)  NULL,
  `PodePagarEmEspecie`      TINYINT(1)    NOT NULL DEFAULT 0,
  `ValorSolicitado`         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Ignorado`                TINYINT(1)    NOT NULL DEFAULT 0,
  -- StatusContasAPagar: enum INT
  `StatusConta`             INT           NOT NULL,
  `Ativo`                   TINYINT(1)    NOT NULL DEFAULT 1,
  `CodigoAgrupadorParcela`  VARCHAR(14)   NOT NULL,
  `NumeroRecibo`            VARCHAR(40)   NULL,
  `PossueCnab`              TINYINT(1)    NOT NULL DEFAULT 0,
  -- TipoJurosContaPagar: enum INT
  `TipoJuros`               INT           NOT NULL DEFAULT 0,
  `ValorJuros`              DECIMAL(10,2) NULL,
  -- TipoMultaContaPagar: enum INT
  `TipoMulta`               INT           NOT NULL DEFAULT 0,
  `ValorMulta`              DECIMAL(10,2) NULL,
  `CodigoDeBarras`          VARCHAR(100)  NULL,
  `Contribuinte`            VARCHAR(50)   NULL,
  `ContaFinanceira_Id`      INT           NULL,
  `Departamento_Id`         INT           NULL,
  `Fornecedor_Id`           INT           NULL,
  `Unidade_Id`              INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContasAPagar_ContaFinanceira` FOREIGN KEY (`ContaFinanceira_Id`) REFERENCES `ContaFinanceira` (`Id`),
  CONSTRAINT `fk_ContasAPagar_Departamento`    FOREIGN KEY (`Departamento_Id`)    REFERENCES `Departamento` (`Id`),
  CONSTRAINT `fk_ContasAPagar_Fornecedor`      FOREIGN KEY (`Fornecedor_Id`)      REFERENCES `Fornecedor` (`Id`),
  CONSTRAINT `fk_ContasAPagar_Unidade`         FOREIGN KEY (`Unidade_Id`)         REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContasAPagarItem` (
  `Id`               INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valor`            DECIMAL(10,2) NOT NULL,
  `ContasAPagar_Id`  INT           NOT NULL,
  `ContaContabil_Id` INT           NULL,
  `Unidade_Id`       INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContasAPagarItem_ContasAPagar`  FOREIGN KEY (`ContasAPagar_Id`)  REFERENCES `ContasAPagar` (`Id`),
  CONSTRAINT `fk_ContasAPagarItem_ContaContabil` FOREIGN KEY (`ContaContabil_Id`) REFERENCES `ContaContabil` (`Id`),
  CONSTRAINT `fk_ContasAPagarItem_Unidade`       FOREIGN KEY (`Unidade_Id`)       REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Correção: KeyColumn("Id") no legado — aqui FK correta para ContratoUnidade
CREATE TABLE `ContratoUnidadeContasAPagar` (
  `Id`                INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ContratoUnidade_Id` INT     NOT NULL,   -- Corrige: era KeyColumn("Id") no legado!
  `ContaAPagar_Id`    INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContratoUnidadeContasAPagar_ContratoUnidade` FOREIGN KEY (`ContratoUnidade_Id`) REFERENCES `ContratoUnidade` (`Id`),
  CONSTRAINT `fk_ContratoUnidadeContasAPagar_ContasAPagar`    FOREIGN KEY (`ContaAPagar_Id`)     REFERENCES `ContasAPagar` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Cheque` (
  `Id`                INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Numero`            VARCHAR(20)   NOT NULL,
  `Emitente`          VARCHAR(200)  NOT NULL,
  `Agencia`           VARCHAR(10)   NOT NULL,
  `DigitoAgencia`     VARCHAR(2)    NULL,
  `Conta`             VARCHAR(20)   NOT NULL,
  `DigitoConta`       VARCHAR(2)    NOT NULL,
  `CPF`               VARCHAR(11)   NULL,  -- Corrige: era CPFCNPJ genérico
  `CNPJ`              VARCHAR(14)   NULL,  -- Separado
  `DataDevolucao`     DATE          NULL,
  `MotivoDevolucao`   VARCHAR(200)  NULL,
  `DataProtesto`      DATE          NULL,
  `CartorioProtestado` VARCHAR(100) NULL,
  -- StatusCheque: enum INT
  `StatusCheque`      INT           NULL,
  `Valor`             DECIMAL(10,2) NOT NULL,
  `ContaFinanceira_Id` INT          NULL,
  `Banco_Id`          INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Cheque_ContaFinanceira` FOREIGN KEY (`ContaFinanceira_Id`) REFERENCES `ContaFinanceira` (`Id`),
  CONSTRAINT `fk_Cheque_Banco`           FOREIGN KEY (`Banco_Id`)           REFERENCES `Banco` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ChequeEmitido` (
  `Id`              INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Numero`          VARCHAR(20)   NOT NULL,
  `Emitente`        VARCHAR(200)  NOT NULL,
  `Agencia`         VARCHAR(10)   NULL,
  `DigitoAgencia`   VARCHAR(2)    NULL,
  `Conta`           VARCHAR(20)   NULL,
  `DigitoConta`     VARCHAR(2)    NULL,
  `CPF`             VARCHAR(11)   NULL,  -- Corrige: era Cpf.Column("CPFCNPJ")
  `CNPJ`            VARCHAR(14)   NULL,  -- Separado
  `DataEmissao`     DATE          NULL,
  `Valor`           DECIMAL(10,2) NOT NULL,
  `Banco_Id`        INT           NULL,
  `Fornecedor_Id`   INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ChequeEmitido_Banco`      FOREIGN KEY (`Banco_Id`)      REFERENCES `Banco` (`Id`),
  CONSTRAINT `fk_ChequeEmitido_Fornecedor` FOREIGN KEY (`Fornecedor_Id`) REFERENCES `Fornecedor` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ChequeEmitidoContaPagar` (
  `Id`                INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ChequeEmitido_Id`  INT      NOT NULL,
  `ContaPagar_Id`     INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ChequeEmitidoContaPagar_ChequeEmitido` FOREIGN KEY (`ChequeEmitido_Id`) REFERENCES `ChequeEmitido` (`Id`),
  CONSTRAINT `fk_ChequeEmitidoContaPagar_ContasAPagar`  FOREIGN KEY (`ContaPagar_Id`)    REFERENCES `ContasAPagar` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ChequeRecebido` (
  `Id`               INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Numero`           VARCHAR(20)   NOT NULL,
  `Emitente`         VARCHAR(200)  NOT NULL,
  `Agencia`          VARCHAR(10)   NOT NULL,
  `DigitoAgencia`    VARCHAR(2)    NULL,
  `Conta`            VARCHAR(20)   NOT NULL,
  `DigitoConta`      VARCHAR(2)    NOT NULL,
  `CPF`              VARCHAR(11)   NULL,  -- Corrige: era Cpf.Column("CPFCNPJ")
  `CNPJ`             VARCHAR(14)   NULL,
  `DataDeposito`     DATE          NULL,
  `DataProtesto`     DATE          NULL,
  `DataDevolucao`    DATE          NULL,
  `CartorioProtestado` VARCHAR(100) NULL,
  `StatusCheque`     INT           NULL,
  `Valor`            DECIMAL(10,2) NOT NULL,
  `Banco_Id`         INT           NULL,
  `Cliente_Id`       INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ChequeRecebido_Banco`   FOREIGN KEY (`Banco_Id`)   REFERENCES `Banco` (`Id`),
  CONSTRAINT `fk_ChequeRecebido_Cliente` FOREIGN KEY (`Cliente_Id`) REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 11: OPERAÇÃO — Movimentação, Faturamento, Recebimento, Pagamento
-- =============================================================================

CREATE TABLE `Recebimento` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- StatusRecebimento: enum INT
  `StatusRecebimento` INT     NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Pagamento` (
  `Id`                    INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NossoNumero`           INT           NOT NULL DEFAULT 0,
  `DataPagamento`         DATETIME      NOT NULL,
  `ValorPago`             DECIMAL(10,2) NOT NULL,
  -- TipoDescontoAcrescimo: enum INT
  `TipoDescontoAcrescimo` INT           NULL,
  `ValorDivergente`       DECIMAL(10,2) NULL,
  `Justificativa`         TEXT          NULL,  -- Corrige: era varbinary(max)
  -- FormaPagamento: enum INT
  `FormaPagamento`        INT           NOT NULL,
  `NumeroRecibo`          VARCHAR(50)   NULL,
  `StatusPagamento`       TINYINT(1)    NOT NULL DEFAULT 0,
  -- StatusEmissao: enum INT
  `StatusEmissao`         INT           NOT NULL DEFAULT 0,
  `DataEnvio`             DATETIME      NULL,
  `PagamentoMensalistaId` INT           NULL,
  `Recebimento_Id`        INT           NOT NULL,
  `Unidade_Id`            INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Pagamento_Recebimento` FOREIGN KEY (`Recebimento_Id`) REFERENCES `Recebimento` (`Id`),
  CONSTRAINT `fk_Pagamento_Unidade`     FOREIGN KEY (`Unidade_Id`)     REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `LancamentoCobranca` (
  `Id`                       INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataGeracao`              DATETIME      NOT NULL,
  `DataVencimento`           DATE          NOT NULL,
  `DataCompetencia`          DATE          NULL,
  `DataBaixa`                DATE          NULL,
  -- StatusLancamentoCobranca: enum INT
  `StatusLancamentoCobranca` INT           NOT NULL,
  `ValorContrato`            DECIMAL(10,2) NOT NULL,
  `PossueCnab`               TINYINT(1)    NOT NULL DEFAULT 0,
  -- TipoValor: enum INT
  `TipoValorMulta`           INT           NULL,
  `ValorMulta`               DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `TipoValorJuros`           INT           NULL,
  `ValorJuros`               DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `CiaSeguro`                VARCHAR(100)  NULL,
  `NossoNumero`              INT           NOT NULL DEFAULT 0,
  `Observacao`               TEXT          NULL,
  -- TipoServico: enum INT
  `TipoServico`              INT           NULL,
  -- TipoOcorrenciaRetorno: enum INT
  `TipoOcorrenciaRetorno`    INT           NULL,
  `Recebimento_Id`           INT           NULL,
  `ContaFinanceira_Id`       INT           NULL,
  `Cliente_Id`               INT           NULL,
  `Unidade_Id`               INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_LancamentoCobranca_Recebimento`     FOREIGN KEY (`Recebimento_Id`)     REFERENCES `Recebimento` (`Id`),
  CONSTRAINT `fk_LancamentoCobranca_ContaFinanceira` FOREIGN KEY (`ContaFinanceira_Id`) REFERENCES `ContaFinanceira` (`Id`),
  CONSTRAINT `fk_LancamentoCobranca_Cliente`         FOREIGN KEY (`Cliente_Id`)         REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_LancamentoCobranca_Unidade`         FOREIGN KEY (`Unidade_Id`)         REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- FK circular resolvida com ALTER TABLE
ALTER TABLE `ContaCorrenteClienteDetalhe` ADD CONSTRAINT
  `fk_ContaCorrenteClienteDetalhe_ContratoMensalista`
  FOREIGN KEY (`ContratoMensalista_Id`) REFERENCES `ContratoMensalista` (`Id`);

CREATE TABLE `LancamentoCobrancaContratoMensalista` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LancamentoCobranca_Id` INT      NOT NULL,
  `ContratoMensalista_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_LancCobrContrato_LancCobranca`     FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`),
  CONSTRAINT `fk_LancCobrContrato_ContratoMensalista` FOREIGN KEY (`ContratoMensalista_Id`) REFERENCES `ContratoMensalista` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Movimentacao` (
  `Id`               INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IdSoftpark`       INT           NULL,
  `NumFechamento`    INT           NOT NULL DEFAULT 0,
  `NumTerminal`      INT           NOT NULL DEFAULT 0,
  `DataAbertura`     DATETIME      NOT NULL,
  `DataFechamento`   DATETIME      NOT NULL,
  `Ticket`           VARCHAR(50)   NULL,
  `Placa`            VARCHAR(10)   NULL,
  `DataEntrada`      DATETIME      NOT NULL,
  `DataSaida`        DATETIME      NOT NULL,
  `ValorCobrado`     DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DescontoUtilizado` VARCHAR(100) NULL,
  `ValorDesconto`    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `TipoCliente`      VARCHAR(50)   NULL,
  `NumeroContrato`   VARCHAR(50)   NULL,
  `VagaIsenta`       TINYINT(1)    NOT NULL DEFAULT 0,
  `Cpf`              VARCHAR(11)   NULL,
  `Rps`              VARCHAR(50)   NULL,
  `FormaPagamento`   VARCHAR(50)   NULL,
  `Unidade_Id`       INT           NULL,
  `Usuario_Id`       INT           NULL,
  `Cliente_Id`       INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Movimentacao_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_Movimentacao_Cliente` FOREIGN KEY (`Cliente_Id`) REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Faturamento` (
  `Id`                           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`                 DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IdSoftpark`                   INT           NULL,
  `NomeUnidade`                  VARCHAR(200)  NULL,
  `NumFechamento`                INT           NOT NULL DEFAULT 0,
  `NumTerminal`                  INT           NOT NULL DEFAULT 0,
  `DataAbertura`                 DATETIME      NOT NULL,
  `DataFechamento`               DATETIME      NOT NULL,
  `TicketInicial`                VARCHAR(50)   NULL,
  `TicketFinal`                  VARCHAR(50)   NULL,
  `PatioAtual`                   VARCHAR(50)   NULL,
  `ValorTotal`                   DECIMAL(10,2) NULL,
  `ValorRotativo`                DECIMAL(10,2) NULL,
  `ValorRecebimentoMensalidade`  DECIMAL(10,2) NULL,
  `ValorDinheiro`                DECIMAL(10,2) NULL,
  `ValorCartaoDebito`            DECIMAL(10,2) NULL,
  `ValorCartaoCredito`           DECIMAL(10,2) NULL,
  `ValorSemParar`                DECIMAL(10,2) NULL,
  `ValorSeloDesconto`            DECIMAL(10,2) NULL,
  `SaldoInicial`                 DECIMAL(10,2) NULL,
  `ValorSangria`                 DECIMAL(10,2) NULL,
  `Unidade_Id`                   INT           NULL,
  `Usuario_Id`                   INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Faturamento_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 12: SELO / DESCONTO
-- =============================================================================

CREATE TABLE `TipoSelo` (
  `Id`                  INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`        DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`                VARCHAR(100)  NOT NULL,
  `Valor`               DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `ComValidade`         TINYINT(1)    NOT NULL DEFAULT 0,
  `PagarHorasAdicionais` TINYINT(1)  NOT NULL DEFAULT 0,
  `Ativo`               TINYINT(1)   NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EmissaoSelo` (
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Quantidade`   INT           NOT NULL DEFAULT 0,
  `TipoSelo_Id`  INT           NOT NULL,
  `Unidade_Id`   INT           NULL,
  `Cliente_Id`   INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EmissaoSelo_TipoSelo` FOREIGN KEY (`TipoSelo_Id`) REFERENCES `TipoSelo` (`Id`),
  CONSTRAINT `fk_EmissaoSelo_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_EmissaoSelo_Cliente`  FOREIGN KEY (`Cliente_Id`)  REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Selo` (
  `Id`             INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Sequencial`     INT           NOT NULL DEFAULT 0,
  `Validade`       DATE          NULL,
  `Valor`          DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `EmissaoSelo_Id` INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Selo_EmissaoSelo` FOREIGN KEY (`EmissaoSelo_Id`) REFERENCES `EmissaoSelo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `SeloCliente` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Cliente_Id`   INT      NOT NULL,
  `Selo_Id`      INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_SeloCliente_Cliente` FOREIGN KEY (`Cliente_Id`) REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_SeloCliente_Selo`    FOREIGN KEY (`Selo_Id`)    REFERENCES `Selo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `MovimentacaoSelo` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Movimentacao_Id`  INT      NOT NULL,
  `Selo_Id`          INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_MovimentacaoSelo_Movimentacao` FOREIGN KEY (`Movimentacao_Id`) REFERENCES `Movimentacao` (`Id`),
  CONSTRAINT `fk_MovimentacaoSelo_Selo`         FOREIGN KEY (`Selo_Id`)         REFERENCES `Selo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Desconto` (
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200)  NOT NULL,
  `Valor`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Ativo`        TINYINT(1)    NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PedidoSelo` (
  `Id`               INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Quantidade`       INT           NOT NULL DEFAULT 0,
  -- StatusPedidoSelo: enum INT
  `StatusPedido`     INT           NOT NULL,
  -- TipoPedidoSelo: enum INT
  `TipoPedidoSelo`   INT           NULL,
  `DiasVencimento`   INT           NOT NULL DEFAULT 0,
  `DataVencimento`   DATE          NOT NULL,
  `ValidadePedido`   DATE          NOT NULL,
  -- TipoPagamentoSelo: enum INT
  `TiposPagamento`   INT           NULL,
  `Cliente_Id`       INT           NULL,
  `Convenio_Id`      INT           NULL,
  `Unidade_Id`       INT           NULL,
  `TipoSelo_Id`      INT           NULL,
  `Desconto_Id`      INT           NULL,
  `EmissaoSelo_Id`   INT           NULL,
  `Usuario_Id`       INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PedidoSelo_Cliente`     FOREIGN KEY (`Cliente_Id`)     REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_PedidoSelo_Convenio`    FOREIGN KEY (`Convenio_Id`)    REFERENCES `Convenio` (`Id`),
  CONSTRAINT `fk_PedidoSelo_Unidade`     FOREIGN KEY (`Unidade_Id`)     REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_PedidoSelo_TipoSelo`    FOREIGN KEY (`TipoSelo_Id`)    REFERENCES `TipoSelo` (`Id`),
  CONSTRAINT `fk_PedidoSelo_Desconto`    FOREIGN KEY (`Desconto_Id`)    REFERENCES `Desconto` (`Id`),
  CONSTRAINT `fk_PedidoSelo_EmissaoSelo` FOREIGN KEY (`EmissaoSelo_Id`) REFERENCES `EmissaoSelo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 13: ESTOQUE E COMPRAS
-- =============================================================================

CREATE TABLE `TipoMaterial` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Material` (
  `Id`               INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`             VARCHAR(200) NOT NULL,
  `Descricao`        TEXT         NULL,
  `Altura`           VARCHAR(20)  NULL,
  `Largura`          VARCHAR(20)  NULL,
  `Profundidade`     VARCHAR(20)  NULL,
  `Comprimento`      VARCHAR(20)  NULL,
  `EAN`              VARCHAR(30)  NULL,
  `ImagemCaminho`    VARCHAR(500) NULL,  -- Corrige: era byte[] (varbinary) no legado
  `EhUmAtivo`        TINYINT(1)   NOT NULL DEFAULT 0,
  `EstoqueMaximo`    INT          NOT NULL DEFAULT 0,
  `EstoqueMinimo`    INT          NOT NULL DEFAULT 0,
  `TipoMaterial_Id`  INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Material_TipoMaterial` FOREIGN KEY (`TipoMaterial_Id`) REFERENCES `TipoMaterial` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Estoque` (
  `Id`               INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`             VARCHAR(200) NOT NULL,
  `Cep`              VARCHAR(10)  NULL,
  `Logradouro`       VARCHAR(200) NULL,
  `Numero`           VARCHAR(10)  NULL,
  `Complemento`      VARCHAR(50)  NULL,
  `Bairro`           VARCHAR(100) NULL,
  -- TipoEndereco: enum INT
  `Tipo`             INT          NULL,
  `CidadeNome`       VARCHAR(100) NULL,
  `UF`               VARCHAR(2)   NULL,
  `EstoquePrincipal` TINYINT(1)   NOT NULL DEFAULT 0,
  `Unidade_Id`       INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Estoque_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EstoqueMaterial` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Quantidade`   INT      NOT NULL DEFAULT 0,
  `Estoque_Id`   INT      NOT NULL,
  `Material_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EstoqueMaterial_Estoque`  FOREIGN KEY (`Estoque_Id`)  REFERENCES `Estoque` (`Id`),
  CONSTRAINT `fk_EstoqueMaterial_Material` FOREIGN KEY (`Material_Id`) REFERENCES `Material` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `MaterialFornecedor` (
  `Id`                          INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`                DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `EhPersonalizado`             TINYINT(1)    NOT NULL DEFAULT 0,
  `QuantidadeParaPedidoAutomatico` INT        NOT NULL DEFAULT 0,
  `Material_Id`                 INT           NOT NULL,
  `Fornecedor_Id`               INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_MaterialFornecedor_Material`   FOREIGN KEY (`Material_Id`)   REFERENCES `Material` (`Id`),
  CONSTRAINT `fk_MaterialFornecedor_Fornecedor` FOREIGN KEY (`Fornecedor_Id`) REFERENCES `Fornecedor` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 14: SEGURANÇA — Usuário, Perfil, Permissão
-- =============================================================================

CREATE TABLE `Usuario` (
  `Id`               INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Login`            VARCHAR(100) NOT NULL UNIQUE,
  `Senha`            VARCHAR(255) NOT NULL,
  `ImagemCaminho`    VARCHAR(500) NULL,   -- Corrige: era byte[] (varbinary) no legado
  `PrimeiroLogin`    TINYINT(1)   NOT NULL DEFAULT 1,
  `TemAcessoAoPDV`   TINYINT(1)   NOT NULL DEFAULT 0,
  `OperadorPerfil`   VARCHAR(50)  NULL,
  `Ativo`            TINYINT(1)   NOT NULL DEFAULT 1,
  `Email`            VARCHAR(200) NULL,
  `EhFuncionario`    TINYINT(1)   NOT NULL DEFAULT 0,
  `Funcionario_Id`   INT          NULL,
  `Unidade_Id`       INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Usuario_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `fk_Usuario_Unidade`     FOREIGN KEY (`Unidade_Id`)     REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Adiciona FK de Movimentacao e Faturamento -> Usuario
ALTER TABLE `Movimentacao` ADD CONSTRAINT `fk_Movimentacao_Usuario`
  FOREIGN KEY (`Usuario_Id`) REFERENCES `Usuario` (`Id`);
ALTER TABLE `Faturamento` ADD CONSTRAINT `fk_Faturamento_Usuario`
  FOREIGN KEY (`Usuario_Id`) REFERENCES `Usuario` (`Id`);

CREATE TABLE `Menu` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200) NOT NULL,
  `Url`          VARCHAR(500) NULL,
  `Posicao`      INT          NOT NULL DEFAULT 0,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  `MenuPai_Id`   INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Menu_MenuPai` FOREIGN KEY (`MenuPai_Id`) REFERENCES `Menu` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Permissao` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(200) NOT NULL,
  `Regra`        VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Perfil` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PerfilMenu` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Perfil_Id`    INT      NOT NULL,
  `Menu_Id`      INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PerfilMenu_Perfil` FOREIGN KEY (`Perfil_Id`) REFERENCES `Perfil` (`Id`),
  CONSTRAINT `fk_PerfilMenu_Menu`   FOREIGN KEY (`Menu_Id`)   REFERENCES `Menu` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PerfilPermissao` (
  `Id`             INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Perfil_Id`      INT      NOT NULL,
  `Permissao_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PerfilPermissao_Perfil`    FOREIGN KEY (`Perfil_Id`)    REFERENCES `Perfil` (`Id`),
  CONSTRAINT `fk_PerfilPermissao_Permissao` FOREIGN KEY (`Permissao_Id`) REFERENCES `Permissao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `UsuarioPerfil` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Usuario_Id`   INT      NOT NULL,
  `Perfil_Id`    INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_UsuarioPerfil_Usuario` FOREIGN KEY (`Usuario_Id`) REFERENCES `Usuario` (`Id`),
  CONSTRAINT `fk_UsuarioPerfil_Perfil`  FOREIGN KEY (`Perfil_Id`)  REFERENCES `Perfil` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Token` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valor`        VARCHAR(500) NOT NULL,
  `Expiracao`    DATETIME     NOT NULL,
  `Usuario_Id`   INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Token_Usuario` FOREIGN KEY (`Usuario_Id`) REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 15: AUDITORIA E LOG
-- =============================================================================

CREATE TABLE `Audit` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Data`            DATETIME     NOT NULL,
  `Entidade`        VARCHAR(100) NOT NULL,
  `Atributo`        VARCHAR(100) NOT NULL,
  `CodigoEntidade`  INT          NOT NULL,
  `ValorAntigo`     TEXT         NOT NULL,
  `ValorNovo`       TEXT         NOT NULL,
  `UsuarioId`       INT          NOT NULL,
  `UsuarioNome`     VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `idx_Audit_Entidade`      (`Entidade`),
  INDEX `idx_Audit_CodigoEntidade` (`CodigoEntidade`),
  INDEX `idx_Audit_Data`          (`Data`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Log` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Date`         DATETIME     NOT NULL,
  `Thread`       VARCHAR(255) NOT NULL,
  `Level`        VARCHAR(50)  NOT NULL,
  `Logger`       VARCHAR(255) NOT NULL,
  `Message`      VARCHAR(4000) NOT NULL,
  `Exception`    VARCHAR(2000) NULL,
  PRIMARY KEY (`Id`),
  INDEX `idx_Log_Level` (`Level`),
  INDEX `idx_Log_Date`  (`Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 16: NOTIFICAÇÃO
-- =============================================================================

CREATE TABLE `TipoNotificacao` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200) NOT NULL,
  -- Entidades: enum INT
  `Entidade`     INT          NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Notificacao` (
  `Id`                INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Mensagem`          TEXT         NULL,
  `Lida`              TINYINT(1)   NOT NULL DEFAULT 0,
  `TipoNotificacao_Id` INT         NULL,
  `Usuario_Id`        INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Notificacao_TipoNotificacao` FOREIGN KEY (`TipoNotificacao_Id`) REFERENCES `TipoNotificacao` (`Id`),
  CONSTRAINT `fk_Notificacao_Usuario`         FOREIGN KEY (`Usuario_Id`)         REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContaPagarNotificacao` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ContasAPagar_Id`  INT      NOT NULL,
  `Notificacao_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ContaPagarNotificacao_ContasAPagar` FOREIGN KEY (`ContasAPagar_Id`) REFERENCES `ContasAPagar` (`Id`),
  CONSTRAINT `fk_ContaPagarNotificacao_Notificacao`  FOREIGN KEY (`Notificacao_Id`)  REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- RESTAURAR CONFIGURAÇÕES
-- =============================================================================

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- =============================================================================
-- RESUMO DO SCRIPT
-- =============================================================================
-- Tabelas criadas: ~85 tabelas (módulos Core, Financeiro e Operacional)
-- Correções aplicadas:
--   [1] FK padrão único: NomeDaTabela_Id em TODAS as FKs
--   [2] Nomes singulares: Aluguel, Colaborador, Convenio, Mensalista, etc.
--   [3] Typo corrigido: ContratoMensalistaNotificacao (era "Notificao")
--   [4] CNPJ/CPF separados em colunas distintas (era CPFCNPJ genérico)
--   [5] Imagens: VARCHAR(500) para caminho de arquivo (era varbinary(max))
--   [6] ContratoUnidadeContasAPagar: FK ContratoUnidade_Id (era KeyColumn("Id"))
--   [7] Herança: FKs explícitas documentadas (Pessoa_Id, PessoaJuridica_Id)
--   [8] ClienteUnidade unificada (era ClienteUnidade + ClienteUnidades duplicados)
--   [9] ConvenioUnidade unificada (era Convenio + ConvenioUnidade + ConvenioUnidades)
-- =============================================================================

-- =============================================================================
-- MÓDULO 17: TABELAS DE PREÇO E HORÁRIO
-- =============================================================================

CREATE TABLE `Funcionamento` (  -- Corrige: legado "Funcionamentos" (plural)
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`            VARCHAR(200) NULL,
  `CodFuncionamento` INT         NULL,
  `DataInicio`      DATETIME     NULL,
  `DataFim`         DATETIME     NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `HorarioPreco` (  -- Corrige: legado "HorariosPrecos" (plural)
  `Id`               INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Horario`          VARCHAR(10)   NULL,
  `Valor`            DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Funcionamento_Id` INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_HorarioPreco_Funcionamento` FOREIGN KEY (`Funcionamento_Id`) REFERENCES `Funcionamento` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Periodo` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Codigo`       VARCHAR(20)  NULL,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PeriodoHorario` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TipoHorario`  INT          NOT NULL DEFAULT 0,
  `Periodo`      VARCHAR(50)  NULL,
  `Inicio`       VARCHAR(10)  NULL,
  `Fim`          VARCHAR(10)  NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `HorarioUnidade` (
  `Id`             INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`           VARCHAR(200) NOT NULL,
  `Fixo`           TINYINT(1)   NOT NULL DEFAULT 0,
  `DataValidade`   DATE         NOT NULL,
  -- TipoHorario: enum INT
  `TipoHorario`    INT          NOT NULL DEFAULT 0,
  `Feriados`       TINYINT(1)   NOT NULL DEFAULT 0,
  -- StatusHorario: enum INT
  `Status`         INT          NOT NULL DEFAULT 0,
  `Unidade_Id`     INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_HorarioUnidade_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `HorarioUnidadePeriodoHorario` (
  `Id`                INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `HorarioUnidade_Id` INT      NOT NULL,
  `PeriodoHorario_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_HorarioUnidadePeriodoHorario_HorarioUnidade`  FOREIGN KEY (`HorarioUnidade_Id`) REFERENCES `HorarioUnidade` (`Id`),
  CONSTRAINT `fk_HorarioUnidadePeriodoHorario_PeriodoHorario`  FOREIGN KEY (`PeriodoHorario_Id`) REFERENCES `PeriodoHorario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PrecoStatus` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Preco` (  -- Corrige: legado "Precos" (plural)
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`            VARCHAR(200) NOT NULL,
  `TempoTolerancia` INT          NOT NULL DEFAULT 0,
  `NomeUsuario`     VARCHAR(200) NULL,
  `Ativo`           TINYINT(1)   NOT NULL DEFAULT 1,
  `PrecoStatus_Id`  INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Preco_PrecoStatus` FOREIGN KEY (`PrecoStatus_Id`) REFERENCES `PrecoStatus` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PrecoFuncionamento` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Preco_Id`         INT      NOT NULL,
  `Funcionamento_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PrecoFuncionamento_Preco`        FOREIGN KEY (`Preco_Id`)        REFERENCES `Preco` (`Id`),
  CONSTRAINT `fk_PrecoFuncionamento_Funcionamento` FOREIGN KEY (`Funcionamento_Id`) REFERENCES `Funcionamento` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPreco` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Codigo`       VARCHAR(20)  NULL,
  `Descricao`    VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoAvulso` (
  `Id`                         INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`               DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`                       VARCHAR(200)  NOT NULL,
  `Numero`                     INT           NOT NULL DEFAULT 0,
  `TempoToleranciaPagamento`   INT           NOT NULL DEFAULT 0,
  `TempoToleranciaDesistencia` INT           NOT NULL DEFAULT 0,
  -- StatusSolicitacao: enum INT
  `Status`                     INT           NOT NULL DEFAULT 0,
  `HoraAdicional`              TINYINT(1)    NOT NULL DEFAULT 0,
  `Padrao`                     TINYINT(1)    NOT NULL DEFAULT 0,
  `QuantidadeHoraAdicional`    INT           NOT NULL DEFAULT 0,
  `ValorHoraAdicional`         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DescricaoHoraValor`         VARCHAR(200)  NULL,
  `HoraInicioVigencia`         VARCHAR(10)   NULL,
  `HoraFimVigencia`            VARCHAR(10)   NULL,
  `Usuario_Id`                 INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulso_Usuario` FOREIGN KEY (`Usuario_Id`) REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoAvulsoPeriodo` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TabelaPrecoAvulso_Id`  INT      NOT NULL,
  `Periodo_Id`            INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulsoPeriodo_TabelaPrecoAvulso` FOREIGN KEY (`TabelaPrecoAvulso_Id`) REFERENCES `TabelaPrecoAvulso` (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulsoPeriodo_Periodo`           FOREIGN KEY (`Periodo_Id`)           REFERENCES `Periodo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoAvulsoHoraValor` (
  `Id`                   INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Hora`                 INT           NOT NULL DEFAULT 0,
  `Valor`                DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `TabelaPrecoAvulso_Id` INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulsoHoraValor_TabelaPrecoAvulso` FOREIGN KEY (`TabelaPrecoAvulso_Id`) REFERENCES `TabelaPrecoAvulso` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoAvulsoUnidade` (
  `Id`                   INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TabelaPrecoAvulso_Id` INT      NOT NULL,
  `Unidade_Id`           INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulsoUnidade_TabelaPrecoAvulso` FOREIGN KEY (`TabelaPrecoAvulso_Id`) REFERENCES `TabelaPrecoAvulso` (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulsoUnidade_Unidade`           FOREIGN KEY (`Unidade_Id`)           REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoAvulsoNotificacao` (
  `Id`                   INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TabelaPrecoAvulso_Id` INT      NOT NULL,
  `Notificacao_Id`       INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulsoNotificacao_TabelaPrecoAvulso` FOREIGN KEY (`TabelaPrecoAvulso_Id`) REFERENCES `TabelaPrecoAvulso` (`Id`),
  CONSTRAINT `fk_TabelaPrecoAvulsoNotificacao_Notificacao`       FOREIGN KEY (`Notificacao_Id`)       REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoMensalistaUnidade` (
  `Id`                       INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `HorarioInicio`            VARCHAR(10)   NULL,
  `HorarioFim`               VARCHAR(10)   NULL,
  `HoraAdicional`            TINYINT(1)    NOT NULL DEFAULT 0,
  `QuantidadeHoras`          INT           NOT NULL DEFAULT 0,
  `ValorQuantidade`          DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DiasParaCorte`            INT           NOT NULL DEFAULT 0,
  `TabelaPrecoMensalista_Id` INT           NOT NULL,
  `Unidade_Id`               INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TabelaPrecoMensalistaUnidade_TabelaPrecoMensalista` FOREIGN KEY (`TabelaPrecoMensalista_Id`) REFERENCES `TabelaPrecoMensalista` (`Id`),
  CONSTRAINT `fk_TabelaPrecoMensalistaUnidade_Unidade`               FOREIGN KEY (`Unidade_Id`)               REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TabelaPrecoMensalistaNotificacao` (
  `Id`                       INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TabelaPrecoMensalista_Id` INT      NOT NULL,
  `Notificacao_Id`           INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_TabelaPrecoMensalistaNotificacao_TabelaPrecoMensalista` FOREIGN KEY (`TabelaPrecoMensalista_Id`) REFERENCES `TabelaPrecoMensalista` (`Id`),
  CONSTRAINT `fk_TabelaPrecoMensalistaNotificacao_Notificacao`           FOREIGN KEY (`Notificacao_Id`)           REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PrecoParametroSelo` (
  `Id`                       INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DescontoTabelaPreco`      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DescontoMaximoValor`      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DescontoCustoTabelaPreco` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Unidade_Id`               INT           NULL,
  `TipoSelo_Id`              INT           NULL,
  `Perfil_Id`                INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PrecoParametroSelo_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_PrecoParametroSelo_TipoSelo` FOREIGN KEY (`TipoSelo_Id`) REFERENCES `TipoSelo` (`Id`),
  CONSTRAINT `fk_PrecoParametroSelo_Perfil`   FOREIGN KEY (`Perfil_Id`)   REFERENCES `Perfil` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 18: EQUIPES E COLABORADORES
-- =============================================================================

CREATE TABLE `TipoEquipe` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Equipe` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`             VARCHAR(200) NOT NULL,
  `Datafim`          DATE     NOT NULL,
  `Ativo`            TINYINT(1) NOT NULL DEFAULT 1,
  -- TipoHorario: enum INT
  `TipoHorario`      INT      NULL,
  `Unidade_Id`       INT      NOT NULL,
  `TipoEquipe_Id`    INT      NULL,
  `Funcionamento_Id` INT      NULL,
  `Encarregado_Id`   INT      NULL,
  `Supervisor_Id`    INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Equipe_Unidade`       FOREIGN KEY (`Unidade_Id`)       REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_Equipe_TipoEquipe`    FOREIGN KEY (`TipoEquipe_Id`)    REFERENCES `TipoEquipe` (`Id`),
  CONSTRAINT `fk_Equipe_Funcionamento` FOREIGN KEY (`Funcionamento_Id`) REFERENCES `Funcionamento` (`Id`),
  CONSTRAINT `fk_Equipe_Encarregado`   FOREIGN KEY (`Encarregado_Id`)   REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `fk_Equipe_Supervisor`    FOREIGN KEY (`Supervisor_Id`)    REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Colaborador` (  -- Corrige: legado "Colaboradores" (plural)
  `Id`                 INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Funcionario_Id`     INT      NOT NULL,  -- NomeColaborador no legado
  `PeriodoHorario_Id`  INT      NULL,      -- Turno
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Colaborador_Funcionario`    FOREIGN KEY (`Funcionario_Id`)    REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `fk_Colaborador_PeriodoHorario` FOREIGN KEY (`PeriodoHorario_Id`) REFERENCES `PeriodoHorario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EquipeColaborador` (
  `Id`             INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Equipe_Id`      INT      NOT NULL,
  `Colaborador_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EquipeColaborador_Equipe`      FOREIGN KEY (`Equipe_Id`)      REFERENCES `Equipe` (`Id`),
  CONSTRAINT `fk_EquipeColaborador_Colaborador` FOREIGN KEY (`Colaborador_Id`) REFERENCES `Colaborador` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroEquipe` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  -- StatusSolicitacao: enum INT
  `Status`       INT          NOT NULL DEFAULT 0,
  `Usuario`      VARCHAR(200) NULL,
  `Equipe_Id`    INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroEquipe_Equipe` FOREIGN KEY (`Equipe_Id`) REFERENCES `Equipe` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `HorarioParametroEquipe` (
  `Id`                 INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DiaSemana`          INT      NULL,
  `HoraInicio`         VARCHAR(10) NULL,
  `HoraFim`            VARCHAR(10) NULL,
  `ParametroEquipe_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_HorarioParametroEquipe_ParametroEquipe` FOREIGN KEY (`ParametroEquipe_Id`) REFERENCES `ParametroEquipe` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroEquipeNotificacao` (
  `Id`                 INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ParametroEquipe_Id` INT      NOT NULL,
  `Notificacao_Id`     INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroEquipeNotificacao_ParametroEquipe` FOREIGN KEY (`ParametroEquipe_Id`) REFERENCES `ParametroEquipe` (`Id`),
  CONSTRAINT `fk_ParametroEquipeNotificacao_Notificacao`     FOREIGN KEY (`Notificacao_Id`)     REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 19: CHECKLIST, OCORRÊNCIA, VAGAS
-- =============================================================================

CREATE TABLE `TipoAtividade` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200) NOT NULL,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  `Usuario`      VARCHAR(200) NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CheckListAtividadeTipoAtividade` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CheckListAtividade_Id` INT      NOT NULL,
  `TipoAtividade_Id`      INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_CheckListAtividadeTipoAtividade_CheckListAtividade` FOREIGN KEY (`CheckListAtividade_Id`) REFERENCES `CheckListAtividade` (`Id`),
  CONSTRAINT `fk_CheckListAtividadeTipoAtividade_TipoAtividade`      FOREIGN KEY (`TipoAtividade_Id`)      REFERENCES `TipoAtividade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CheckListEstruturaUnidade` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- EstruturaGaragem: enum INT
  `EstruturaGaragem` INT      NOT NULL DEFAULT 0,
  `Quantidade`       INT      NOT NULL DEFAULT 0,
  `Ativo`            TINYINT(1) NOT NULL DEFAULT 1,
  `Unidade_Id`       INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_CheckListEstruturaUnidade_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `UnidadeCheckListAtividade` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- StatusCheckList: enum INT (1=Aberto, 2=Finalizado)
  `StatusCheckList`       INT      NOT NULL DEFAULT 1,
  `Unidade_Id`            INT      NOT NULL,
  `CheckListAtividade_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_UnidadeCheckListAtividade_Unidade`          FOREIGN KEY (`Unidade_Id`)          REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_UnidadeCheckListAtividade_CheckListAtividade` FOREIGN KEY (`CheckListAtividade_Id`) REFERENCES `CheckListAtividade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `UnidadeCheckListAtividadeTipoAtividade` (
  `Id`                          INT        NOT NULL AUTO_INCREMENT,
  `DataInsercao`                DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Selecionado`                 TINYINT(1) NOT NULL DEFAULT 0,
  `Unidade_Id`                  INT        NOT NULL,
  `TipoAtividade_Id`            INT        NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_UnidadeCheckListTipoAtividade_Unidade`      FOREIGN KEY (`Unidade_Id`)      REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_UnidadeCheckListTipoAtividade_TipoAtividade` FOREIGN KEY (`TipoAtividade_Id`) REFERENCES `TipoAtividade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TipoOcorrencia` (
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200)  NOT NULL,
  `Percentual`   DECIMAL(5,2)  NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `OcorrenciaFuncionario` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Funcionario_Id`        INT      NOT NULL UNIQUE,
  `UsuarioResponsavel_Id` INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_OcorrenciaFuncionario_Funcionario`        FOREIGN KEY (`Funcionario_Id`)        REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `fk_OcorrenciaFuncionario_UsuarioResponsavel` FOREIGN KEY (`UsuarioResponsavel_Id`) REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `OcorrenciaFuncionarioDetalhe` (
  `Id`                       INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Observacao`               TEXT     NULL,
  `OcorrenciaFuncionario_Id` INT      NOT NULL,
  `TipoOcorrencia_Id`        INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_OcorrenciaFuncionarioDetalhe_OcorrenciaFuncionario` FOREIGN KEY (`OcorrenciaFuncionario_Id`) REFERENCES `OcorrenciaFuncionario` (`Id`),
  CONSTRAINT `fk_OcorrenciaFuncionarioDetalhe_TipoOcorrencia`        FOREIGN KEY (`TipoOcorrencia_Id`)        REFERENCES `TipoOcorrencia` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `OcorrenciaCliente` (
  `Id`                    INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NumeroProtocolo`       VARCHAR(50)  NULL,
  `DataCompetencia`       DATE         NOT NULL,
  `DataOcorrencia`        DATETIME     NOT NULL,
  `Descricao`             TEXT         NULL,
  `Solucao`               TEXT         NULL,
  -- Enums: TipoNatureza, TipoOrigem, TipoPrioridade, StatusOcorrencia (INT)
  `Natureza`              INT          NULL,
  `Origem`                INT          NULL,
  `Prioridade`            INT          NULL,
  `StatusOcorrencia`      INT          NULL,
  `Unidade_Id`            INT          NULL,
  `Veiculo_Id`            INT          NULL,
  `FuncionarioAtribuido_Id` INT        NULL,
  `Cliente_Id`            INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_OcorrenciaCliente_Unidade`             FOREIGN KEY (`Unidade_Id`)              REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_OcorrenciaCliente_Veiculo`             FOREIGN KEY (`Veiculo_Id`)              REFERENCES `Veiculo` (`Id`),
  CONSTRAINT `fk_OcorrenciaCliente_Funcionario`         FOREIGN KEY (`FuncionarioAtribuido_Id`) REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `fk_OcorrenciaCliente_Cliente`             FOREIGN KEY (`Cliente_Id`)             REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `VagaCortesia` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Cliente_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_VagaCortesia_Cliente` FOREIGN KEY (`Cliente_Id`) REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `VagaCortesiaVigencia` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataInicio`      DATETIME     NOT NULL,
  `DataFim`         DATETIME     NOT NULL,
  `HorarioInicio`   VARCHAR(10)  NULL,
  `HorarioFim`      VARCHAR(10)  NULL,
  `VagaCortesia_Id` INT          NOT NULL,
  `Unidade_Id`      INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_VagaCortesiaVigencia_VagaCortesia` FOREIGN KEY (`VagaCortesia_Id`) REFERENCES `VagaCortesia` (`Id`),
  CONSTRAINT `fk_VagaCortesiaVigencia_Unidade`       FOREIGN KEY (`Unidade_Id`)      REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `UnidadeCondomino` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NumeroVagas`           INT      NOT NULL DEFAULT 0,
  `NumeroVagasRestantes`  INT      NOT NULL DEFAULT 0,
  `Unidade_Id`            INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_UnidadeCondomino_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 20: FÉRIAS DE CLIENTE, BLOQUEIO, CONSOLIDAÇÃO
-- =============================================================================

CREATE TABLE `FeriasCliente` (
  `Id`                        INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`              DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataInicio`                DATE          NOT NULL,
  `DataFim`                   DATE          NOT NULL,
  `InutilizarTodasVagas`      TINYINT(1)    NOT NULL DEFAULT 0,
  `TotalVagas`                INT           NOT NULL DEFAULT 0,
  `ValorFeriasCalculada`      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `ValorFeriasCalculadaAnterior` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `ContratoMensalista_Id`     INT           NOT NULL,
  `Cliente_Id`                INT           NOT NULL,
  `UsuarioCadastro_Id`        INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_FeriasCliente_ContratoMensalista` FOREIGN KEY (`ContratoMensalista_Id`) REFERENCES `ContratoMensalista` (`Id`),
  CONSTRAINT `fk_FeriasCliente_Cliente`            FOREIGN KEY (`Cliente_Id`)            REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_FeriasCliente_Usuario`            FOREIGN KEY (`UsuarioCadastro_Id`)    REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `FeriasClienteDetalhe` (
  `Id`                          INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`                DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataInicio`                  DATE          NOT NULL,
  `DataFim`                     DATE          NOT NULL,
  `ValorFeriasCalculada`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `ValorFeriasCalculadaAnterior` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `FeriasCliente_Id`            INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_FeriasClienteDetalhe_FeriasCliente` FOREIGN KEY (`FeriasCliente_Id`) REFERENCES `FeriasCliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `BloqueioReferencia` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataMesAnoReferencia`  DATE     NOT NULL,
  `Ativo`                 TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ConsolidaFaturamento` (
  `Id`                  INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`        DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FaturamentoMes`      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `FaturamentoCartao`   DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Diferenca`           DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `FaturamentoFinal`    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ConsolidaDespesa` (
  `Id`                   INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DespesaTotal`         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DespesaFixa`          DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DespesaEscolhida`     DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DespesaEscolhidaFixa` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DespesaValorFinal`    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ConsolidaAjusteFinalFaturamento` (
  `Id`                    INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AjusteFinalFaturamento` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DespesaFinal`          DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Diferenca`             DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `FaturamentoFinal`      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ConsolidaAjusteFaturamento` (
  `Id`                               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`                     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Mes`                              INT      NOT NULL,
  `Ano`                              INT      NOT NULL,
  `Unidade_Id`                       INT      NULL,
  `Empresa_Id`                       INT      NULL,
  `ConsolidaFaturamento_Id`          INT      NULL,
  `ConsolidaDespesa_Id`              INT      NULL,
  `ConsolidaAjusteFinalFaturamento_Id` INT    NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ConsolidaAjusteFaturamento_Unidade`                      FOREIGN KEY (`Unidade_Id`)                       REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_ConsolidaAjusteFaturamento_Empresa`                      FOREIGN KEY (`Empresa_Id`)                       REFERENCES `Empresa` (`Id`),
  CONSTRAINT `fk_ConsolidaAjusteFaturamento_ConsolidaFaturamento`         FOREIGN KEY (`ConsolidaFaturamento_Id`)          REFERENCES `ConsolidaFaturamento` (`Id`),
  CONSTRAINT `fk_ConsolidaAjusteFaturamento_ConsolidaDespesa`             FOREIGN KEY (`ConsolidaDespesa_Id`)              REFERENCES `ConsolidaDespesa` (`Id`),
  CONSTRAINT `fk_ConsolidaAjusteFaturamento_ConsolidaAjusteFinalFaturamento` FOREIGN KEY (`ConsolidaAjusteFinalFaturamento_Id`) REFERENCES `ConsolidaAjusteFinalFaturamento` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 21: CNAB, PAGAMENTO MENSALIDADE, NEGOCIAÇÃO
-- =============================================================================

CREATE TABLE `LeituraCNAB` (
  `Id`                 INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NomeArquivo`        VARCHAR(300)  NOT NULL,
  `CodigoBanco`        VARCHAR(10)   NULL,
  `Agencia`            VARCHAR(10)   NULL,
  `Conta`              VARCHAR(20)   NULL,
  `DACConta`           VARCHAR(5)    NULL,
  `NumeroCNAB`         VARCHAR(20)   NULL,
  `ValorTotal`         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `DataGeracao`        DATE          NOT NULL,
  `DataCredito`        DATE          NOT NULL,
  `ArquivoCaminho`     VARCHAR(500)  NULL,   -- Corrige: era byte[] no legado
  `ContaFinanceira_Id` INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_LeituraCNAB_ContaFinanceira` FOREIGN KEY (`ContaFinanceira_Id`) REFERENCES `ContaFinanceira` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `LeituraCNABLancamentoCobranca` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LeituraCNAB_Id`        INT      NOT NULL,
  `LancamentoCobranca_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_LeituraCNABLancamentoCobranca_LeituraCNAB`        FOREIGN KEY (`LeituraCNAB_Id`)        REFERENCES `LeituraCNAB` (`Id`),
  CONSTRAINT `fk_LeituraCNABLancamentoCobranca_LancamentoCobranca` FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `OcorrenciaRetornoCNAB` (
  `Id`                    INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Codigo`                VARCHAR(10)  NOT NULL,
  `Descricao`             VARCHAR(200) NOT NULL,
  `LancamentoCobranca_Id` INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_OcorrenciaRetornoCNAB_LancamentoCobranca` FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ChequeRecebidoLancamentoCobranca` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ChequeRecebido_Id`     INT      NOT NULL,
  `LancamentoCobranca_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ChequeRecebidoLancamentoCobranca_ChequeRecebido`     FOREIGN KEY (`ChequeRecebido_Id`)     REFERENCES `ChequeRecebido` (`Id`),
  CONSTRAINT `fk_ChequeRecebidoLancamentoCobranca_LancamentoCobranca` FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- LancamentoCobrancaPedidoSelo é herança de LancamentoCobranca
CREATE TABLE `LancamentoCobrancaPedidoSelo` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LancamentoCobranca_Id` INT      NOT NULL,
  `PedidoSelo_Id`         INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_LancamentoCobrancaPedidoSelo_LancamentoCobranca` FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`),
  CONSTRAINT `fk_LancamentoCobrancaPedidoSelo_PedidoSelo`         FOREIGN KEY (`PedidoSelo_Id`)         REFERENCES `PedidoSelo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `LancamentoCobrancaNotificacao` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LancamentoCobranca_Id` INT      NOT NULL,
  `Notificacao_Id`        INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_LancamentoCobrancaNotificacao_LancamentoCobranca` FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`),
  CONSTRAINT `fk_LancamentoCobrancaNotificacao_Notificacao`        FOREIGN KEY (`Notificacao_Id`)        REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PagamentoMensalidade` (
  `Id`                    INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataPagamento`         DATE          NOT NULL,
  `Valor`                 DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `LancamentoCobranca_Id` INT           NULL,
  `Unidade_Id`            INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PagamentoMensalidade_LancamentoCobranca` FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`),
  CONSTRAINT `fk_PagamentoMensalidade_Unidade`            FOREIGN KEY (`Unidade_Id`)            REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ImportacaoPagamento` (
  `Id`            INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Arquivo`       VARCHAR(500) NOT NULL,
  `Lote`          INT          NOT NULL DEFAULT 0,
  `DataPagamento` DATE         NOT NULL,
  `Cedente`       VARCHAR(200) NULL,
  `Usuario_Id`    INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ImportacaoPagamento_Usuario` FOREIGN KEY (`Usuario_Id`) REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `LimiteDesconto` (
  `Id`                    INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- TipoServico: enum INT
  `TipoServico`           INT           NOT NULL,
  -- TipoValor: enum INT
  `TipoValor`             INT           NOT NULL,
  `Valor`                 DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `ParametroNegociacao_Id` INT          NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroNegociacao` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Unidade_Id`   INT      NULL,
  `Perfil_Id`    INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroNegociacao_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_ParametroNegociacao_Perfil`  FOREIGN KEY (`Perfil_Id`)  REFERENCES `Perfil` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `LimiteDesconto` ADD CONSTRAINT `fk_LimiteDesconto_ParametroNegociacao`
  FOREIGN KEY (`ParametroNegociacao_Id`) REFERENCES `ParametroNegociacao` (`Id`);

-- =============================================================================
-- MÓDULO 22: PARÂMETROS GERAIS
-- =============================================================================

CREATE TABLE `ParametroBoletoBancario` (
  `Id`                    INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- TipoServico: enum INT
  `TipoServico`           INT           NOT NULL DEFAULT 0,
  `DiasAntesVencimento`   INT           NOT NULL DEFAULT 0,
  `ValorDesconto`         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Unidade_Id`            INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroBoletoBancario_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroBoletoBancarioDescritivo` (
  `Id`                       INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`                VARCHAR(500) NOT NULL,
  `ParametroBoletoBancario_Id` INT        NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroBoletoBancarioDescritivo_ParametroBoletoBancario`
    FOREIGN KEY (`ParametroBoletoBancario_Id`) REFERENCES `ParametroBoletoBancario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroFaturamento` (
  `Id`                INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`         VARCHAR(200)  NULL,
  `Agencia`           VARCHAR(10)   NULL,
  `DigitoAgencia`     VARCHAR(2)    NULL,
  `Conta`             VARCHAR(20)   NULL,
  `DigitoConta`       VARCHAR(2)    NULL,
  `SaldoInicial`      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Convenio`          VARCHAR(20)   NULL,
  `Carteira`          VARCHAR(10)   NULL,
  `CodigoTransmissao` VARCHAR(30)   NULL,
  `Empresa_Id`        INT           NULL,
  `Banco_Id`          INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroFaturamento_Empresa` FOREIGN KEY (`Empresa_Id`) REFERENCES `Empresa` (`Id`),
  CONSTRAINT `fk_ParametroFaturamento_Banco`   FOREIGN KEY (`Banco_Id`)   REFERENCES `Banco` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroNotificacao` (
  `Id`                 INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TipoNotificacao_Id` INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroNotificacao_TipoNotificacao` FOREIGN KEY (`TipoNotificacao_Id`) REFERENCES `TipoNotificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroNotificacaoUsuario` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ParametroNotificacao_Id` INT    NOT NULL,
  `Usuario_Id`            INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroNotificacaoUsuario_ParametroNotificacao` FOREIGN KEY (`ParametroNotificacao_Id`) REFERENCES `ParametroNotificacao` (`Id`),
  CONSTRAINT `fk_ParametroNotificacaoUsuario_Usuario`              FOREIGN KEY (`Usuario_Id`)              REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ParametroNumeroNotaFiscal` (
  `Id`           INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Numero`       INT      NOT NULL DEFAULT 0,
  `Serie`        VARCHAR(10) NULL,
  `Unidade_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_ParametroNumeroNotaFiscal_Unidade` FOREIGN KEY (`Unidade_Id`) REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CanaisComunicacao` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- TipoComunicacao: enum INT
  `TipoComunicacao` INT      NOT NULL,
  -- CanalComunicacao: enum INT
  `CanalComunicacao` INT     NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 23: LOCAÇÃO, ACORDO, RETIRADA DE COFRE
-- =============================================================================

CREATE TABLE `TipoLocacao` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Aluguel` (  -- Corrige: legado "Alugueis" (plural)
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(100)  NOT NULL,
  `Valor`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Mensalista` (  -- Corrige: legado "Mensalistas" (plural)
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200)  NOT NULL,
  `Valor`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PedidoLocacao` (
  `Id`                       INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`             DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valor`                    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `ValorTotal`               DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `PossuiFiador`             TINYINT(1)    NOT NULL DEFAULT 0,
  `NomeFiador`               VARCHAR(200)  NULL,
  `FormaGarantia`            VARCHAR(100)  NULL,
  `DataReajuste`             DATE          NULL,
  -- TipoReajuste, PrazoReajuste: enum INT
  `TipoReajuste`             INT           NULL,
  `ValorReajuste`            DECIMAL(10,2) NULL,
  `PrazoReajuste`            INT           NULL,
  -- FormaPagamento: enum INT
  `FormaPagamento`           INT           NULL,
  `DataPrimeiroPagamento`    DATE          NULL,
  `ValorPrimeiroPagamento`   DECIMAL(10,2) NULL,
  `DataDemaisPagamentos`     DATE          NULL,
  `CicloPagamentos`          INT           NULL,
  `DataVigenciaInicio`       DATE          NULL,
  `Unidade_Id`               INT           NULL,
  `Cliente_Id`               INT           NULL,
  `TipoLocacao_Id`           INT           NULL,
  `Desconto_Id`              INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PedidoLocacao_Unidade`     FOREIGN KEY (`Unidade_Id`)     REFERENCES `Unidade` (`Id`),
  CONSTRAINT `fk_PedidoLocacao_Cliente`     FOREIGN KEY (`Cliente_Id`)     REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_PedidoLocacao_TipoLocacao` FOREIGN KEY (`TipoLocacao_Id`) REFERENCES `TipoLocacao` (`Id`),
  CONSTRAINT `fk_PedidoLocacao_Desconto`    FOREIGN KEY (`Desconto_Id`)    REFERENCES `Desconto` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PedidoLocacaoNotificacao` (
  `Id`               INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PedidoLocacao_Id` INT      NOT NULL,
  `Notificacao_Id`   INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PedidoLocacaoNotificacao_PedidoLocacao` FOREIGN KEY (`PedidoLocacao_Id`) REFERENCES `PedidoLocacao` (`Id`),
  CONSTRAINT `fk_PedidoLocacaoNotificacao_Notificacao`   FOREIGN KEY (`Notificacao_Id`)   REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PedidoLocacaoLancamentoCobranca` (
  `Id`                    INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PedidoLocacao_Id`      INT      NOT NULL,
  `LancamentoCobranca_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PedidoLocacaoLancamentoCobranca_PedidoLocacao`      FOREIGN KEY (`PedidoLocacao_Id`)      REFERENCES `PedidoLocacao` (`Id`),
  CONSTRAINT `fk_PedidoLocacaoLancamentoCobranca_LancamentoCobranca` FOREIGN KEY (`LancamentoCobranca_Id`) REFERENCES `LancamentoCobranca` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Acordo` (
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    VARCHAR(200)  NULL,
  `Valor`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Cliente_Id`   INT           NULL,
  `Unidade_Id`   INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Acordo_Cliente`  FOREIGN KEY (`Cliente_Id`)  REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_Acordo_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `AcordoParcela` (
  `Id`              INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Numero`          INT           NOT NULL DEFAULT 1,
  `DataVencimento`  DATE          NOT NULL,
  `Valor`           DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Pago`            TINYINT(1)    NOT NULL DEFAULT 0,
  `Acordo_Id`       INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_AcordoParcela_Acordo` FOREIGN KEY (`Acordo_Id`) REFERENCES `Acordo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RetiradaCofre` (
  `Id`                  INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`        DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Observacoes`         TEXT          NULL,
  -- StatusRetiradaCofre: enum INT
  `StatusRetiradaCofre` INT           NOT NULL DEFAULT 0,
  `ContasAPagar_Id`     INT           NULL,
  `Usuario_Id`          INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_RetiradaCofre_ContasAPagar` FOREIGN KEY (`ContasAPagar_Id`) REFERENCES `ContasAPagar` (`Id`),
  CONSTRAINT `fk_RetiradaCofre_Usuario`      FOREIGN KEY (`Usuario_Id`)      REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RetiradaCofreNotificacao` (
  `Id`                INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RetiradaCofre_Id`  INT      NOT NULL,
  `Notificacao_Id`    INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_RetiradaCofreNotificacao_RetiradaCofre` FOREIGN KEY (`RetiradaCofre_Id`) REFERENCES `RetiradaCofre` (`Id`),
  CONSTRAINT `fk_RetiradaCofreNotificacao_Notificacao`   FOREIGN KEY (`Notificacao_Id`)   REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 24: PEDIDO DE SELO — Histórico, Email, Notificação
-- =============================================================================

CREATE TABLE `PedidoSeloHistorico` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`       TEXT         NULL,
  -- StatusPedidoSelo: enum INT
  `Status`          INT          NOT NULL DEFAULT 0,
  `PedidoSelo_Id`   INT          NOT NULL,
  `Usuario_Id`      INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PedidoSeloHistorico_PedidoSelo` FOREIGN KEY (`PedidoSelo_Id`) REFERENCES `PedidoSelo` (`Id`),
  CONSTRAINT `fk_PedidoSeloHistorico_Usuario`     FOREIGN KEY (`Usuario_Id`)   REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PedidoSeloEmail` (
  `Id`              INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Email`           VARCHAR(200) NOT NULL,
  `PedidoSelo_Id`   INT          NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PedidoSeloEmail_PedidoSelo` FOREIGN KEY (`PedidoSelo_Id`) REFERENCES `PedidoSelo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PedidoSeloNotificacao` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PedidoSelo_Id`   INT      NOT NULL,
  `Notificacao_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_PedidoSeloNotificacao_PedidoSelo`  FOREIGN KEY (`PedidoSelo_Id`)  REFERENCES `PedidoSelo` (`Id`),
  CONSTRAINT `fk_PedidoSeloNotificacao_Notificacao`  FOREIGN KEY (`Notificacao_Id`) REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `NotificacaoAvisoPedidoSelo` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PedidoSelo_Id`   INT      NOT NULL,
  `Notificacao_Id`  INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_NotificacaoAvisoPedidoSelo_PedidoSelo` FOREIGN KEY (`PedidoSelo_Id`) REFERENCES `PedidoSelo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `NegociacaoSeloDescontoNotificacao` (
  `Id`             INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Desconto_Id`    INT      NULL,
  `Notificacao_Id` INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_NegociacaoSeloDescontoNotificacao_Desconto`    FOREIGN KEY (`Desconto_Id`)    REFERENCES `Desconto` (`Id`),
  CONSTRAINT `fk_NegociacaoSeloDescontoNotificacao_Notificacao` FOREIGN KEY (`Notificacao_Id`) REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `NotificacaoDesbloqueioReferencia` (
  `Id`                   INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BloqueioReferencia_Id` INT     NOT NULL,
  `Notificacao_Id`        INT     NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_NotificacaoDesbloqueioReferencia_BloqueioReferencia` FOREIGN KEY (`BloqueioReferencia_Id`) REFERENCES `BloqueioReferencia` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 25: ESTOQUE MANUAL E COMPRAS
-- =============================================================================

CREATE TABLE `EstoqueManual` (
  `Id`               INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NumeroNFPedido`   VARCHAR(50)   NULL,
  `Quantidade`       INT           NOT NULL DEFAULT 0,
  `Preco`            DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `ValorTotal`       DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Motivo`           TEXT          NULL,
  -- AcaoEstoqueManual: enum INT
  `Acao`             INT           NOT NULL DEFAULT 0,
  `Estoque_Id`       INT           NULL,
  `Material_Id`      INT           NULL,
  `Unidade_Id`       INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EstoqueManual_Estoque`  FOREIGN KEY (`Estoque_Id`)  REFERENCES `Estoque` (`Id`),
  CONSTRAINT `fk_EstoqueManual_Material` FOREIGN KEY (`Material_Id`) REFERENCES `Material` (`Id`),
  CONSTRAINT `fk_EstoqueManual_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EstoqueManualItem` (
  `Id`                INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Quantidade`        INT      NOT NULL DEFAULT 0,
  `EstoqueManual_Id`  INT      NOT NULL,
  `Material_Id`       INT      NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_EstoqueManualItem_EstoqueManual` FOREIGN KEY (`EstoqueManual_Id`) REFERENCES `EstoqueManual` (`Id`),
  CONSTRAINT `fk_EstoqueManualItem_Material`       FOREIGN KEY (`Material_Id`)      REFERENCES `Material` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `MaterialHistorico` (
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Quantidade`   INT           NOT NULL DEFAULT 0,
  `Preco`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Operacao`     INT           NULL,
  `Material_Id`  INT           NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_MaterialHistorico_Material` FOREIGN KEY (`Material_Id`) REFERENCES `Material` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `MaterialNotificacao` (
  `Id`             INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Material_Id`    INT      NOT NULL,
  `Notificacao_Id` INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_MaterialNotificacao_Material`    FOREIGN KEY (`Material_Id`)    REFERENCES `Material` (`Id`),
  CONSTRAINT `fk_MaterialNotificacao_Notificacao` FOREIGN KEY (`Notificacao_Id`) REFERENCES `Notificacao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 26: DOCUMENTOS, ARQUIVOS, OFICINA, PROPOSTA
-- =============================================================================

CREATE TABLE `Arquivo` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(300) NOT NULL,
  `Endereco`     VARCHAR(500) NOT NULL,
  -- TipoArquivo: enum INT
  `Tipo`         INT          NOT NULL DEFAULT 0,
  `Ativo`        TINYINT(1)   NOT NULL DEFAULT 1,
  `Usuario_Id`   INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Arquivo_Usuario` FOREIGN KEY (`Usuario_Id`) REFERENCES `Usuario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Proposta` (
  `Id`           INT           NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descricao`    TEXT          NULL,
  `Valor`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `Ativo`        TINYINT(1)    NOT NULL DEFAULT 1,
  `Cliente_Id`   INT           NULL,
  `Unidade_Id`   INT           NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Proposta_Cliente`  FOREIGN KEY (`Cliente_Id`)  REFERENCES `Cliente` (`Id`),
  CONSTRAINT `fk_Proposta_Unidade`  FOREIGN KEY (`Unidade_Id`)  REFERENCES `Unidade` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Oficina` (
  `Id`                    INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao`          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NomeFantasia`          VARCHAR(200) NULL,
  `RazaoSocial`           VARCHAR(200) NULL,
  -- TipoPessoa: enum INT
  `TipoPessoa`            TINYINT      NOT NULL DEFAULT 1,
  `IndicadaPeloCliente`   TINYINT(1)   NOT NULL DEFAULT 0,
  `NomeCliente`           VARCHAR(200) NULL,
  `Pessoa_Id`             INT          NULL,
  `CelularCliente_Id`     INT          NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Oficina_Pessoa`   FOREIGN KEY (`Pessoa_Id`)         REFERENCES `Pessoa` (`Id`),
  CONSTRAINT `fk_Oficina_Contato`  FOREIGN KEY (`CelularCliente_Id`) REFERENCES `Contato` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PecaServico` (
  `Id`           INT          NOT NULL AUTO_INCREMENT,
  `DataInsercao` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome`         VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MÓDULO 27: INTERVALOS DE FUNCIONÁRIO (Escala)
-- =============================================================================

CREATE TABLE `FuncionarioIntervaloDozeTrintaSeis` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataInicial`     DATETIME NOT NULL,
  `DataFinal`       DATETIME NOT NULL,
  `Funcionario_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_FuncionarioInterval12x36_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `FuncionarioIntervaloCompensacao` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataInicial`     DATETIME NOT NULL,
  `DataFinal`       DATETIME NOT NULL,
  `Funcionario_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_FuncionarioIntervaloCompensacao_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `FuncionarioIntervaloNoturno` (
  `Id`              INT      NOT NULL AUTO_INCREMENT,
  `DataInsercao`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataInicial`     DATETIME NOT NULL,
  `DataFinal`       DATETIME NOT NULL,
  `Funcionario_Id`  INT      NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_FuncionarioIntervaloNoturno_Funcionario` FOREIGN KEY (`Funcionario_Id`) REFERENCES `Funcionario` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- ÍNDICES DE PERFORMANCE (campos frequentemente usados em WHERE/JOIN)
-- =============================================================================

CREATE INDEX `idx_ContratoMensalista_Cliente`  ON `ContratoMensalista` (`Cliente_Id`);
CREATE INDEX `idx_ContratoMensalista_Unidade`  ON `ContratoMensalista` (`Unidade_Id`);
CREATE INDEX `idx_ContratoMensalista_Ativo`    ON `ContratoMensalista` (`Ativo`);
CREATE INDEX `idx_LancamentoCobranca_Status`   ON `LancamentoCobranca` (`StatusLancamentoCobranca`);
CREATE INDEX `idx_LancamentoCobranca_Vencimento` ON `LancamentoCobranca` (`DataVencimento`);
CREATE INDEX `idx_LancamentoCobranca_Cliente`  ON `LancamentoCobranca` (`Cliente_Id`);
CREATE INDEX `idx_Movimentacao_DataEntrada`    ON `Movimentacao` (`DataEntrada`);
CREATE INDEX `idx_Movimentacao_Placa`          ON `Movimentacao` (`Placa`);
CREATE INDEX `idx_Movimentacao_Unidade`        ON `Movimentacao` (`Unidade_Id`);
CREATE INDEX `idx_ContasAPagar_Vencimento`     ON `ContasAPagar` (`DataVencimento`);
CREATE INDEX `idx_ContasAPagar_Status`         ON `ContasAPagar` (`StatusConta`);
CREATE INDEX `idx_Funcionario_Unidade`         ON `Funcionario` (`Unidade_Id`);
CREATE INDEX `idx_Veiculo_Placa`               ON `Veiculo` (`Placa`);
CREATE INDEX `idx_Pessoa_Nome`                 ON `Pessoa` (`Nome`);
CREATE INDEX `idx_Cliente_TipoPessoa`          ON `Cliente` (`TipoPessoa`);
CREATE INDEX `idx_PedidoSelo_Status`           ON `PedidoSelo` (`StatusPedido`);
CREATE INDEX `idx_Faturamento_DataFechamento`  ON `Faturamento` (`DataFechamento`);
CREATE INDEX `idx_Faturamento_Unidade`         ON `Faturamento` (`Unidade_Id`);
