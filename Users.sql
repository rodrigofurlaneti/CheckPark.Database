-- =============================================================================
-- SmartPark — Atualização de Senhas (SHA256 — compatível com UsuarioService.cs)
-- Execute este script no banco para corrigir as senhas
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

UPDATE `Usuario` SET `Senha` = 'e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc7'
WHERE `Login` = 'admin';

UPDATE `Usuario` SET `Senha` = '5835fdd59c0bb08c28567f9c227eccfba161c18ca04c762f5836731aad59817b'
WHERE `Login` = 'c.mendes';

UPDATE `Usuario` SET `Senha` = '16dacb91259be1d555c20bbfe6e7a9181af1d7cee6108796ea056c94b584d598'
WHERE `Login` = 'f.lima';

UPDATE `Usuario` SET `Senha` = '12a2977f9c342665d50c473f400b3f63339cd6eeca31d588c486262871cece60'
WHERE `Login` = 'r.costa';

UPDATE `Usuario` SET `Senha` = '4ca104f06863e4719a25495454cd55b56368d5ebe7ddcb1cdc8e5d017043531a'
WHERE `Login` = 'j.souza';

UPDATE `Usuario` SET `Senha` = '67def2cc22c96e351fce02f4abaec08ad5cef3e8cd864f80cca055c700929285'
WHERE `Login` = 'r.carvalho';

-- Verificar
SELECT `Id`, `Login`, LEFT(`Senha`, 20) AS `HashInicio`, `Ativo` FROM `Usuario`;
