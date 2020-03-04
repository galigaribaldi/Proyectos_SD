--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      UNAM
-- Project :      Bancaria.DM1
-- Author :       galigaribaldi@live.com
--
-- Date Created : Tuesday, March 03, 2020 23:50:12
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: CUENTA_BANCARIA 
--

CREATE TABLE CUENTA_BANCARIA(
    CUENTA_BANCARIA_ID    DECIMAL(40, 0)    NOT NULL,
    FECHA_CONSULTA        VARCHAR(40)       NOT NULL,
    SALDO                 DECIMAL(40, 0)    NOT NULL,
    ESTADO                VARCHAR(40)       NOT NULL,
    FECHA_APERTURA        VARCHAR(40)       NOT NULL,
    PRIMARY KEY (CUENTA_BANCARIA_ID)
)ENGINE=MYISAM
;



-- 
-- TABLE: USUARIO 
--

CREATE TABLE USUARIO(
    USUARIO_ID          DECIMAL(40, 0)    NOT NULL,
    NOMBRE              VARCHAR(40)       NOT NULL,
    APELLIDO_PATERNO    VARCHAR(40)       NOT NULL,
    APELLIDO_MATERNO    VARCHAR(40),
    EDAD                VARCHAR(40)       NOT NULL,
    DIRECCION           VARCHAR(40)       NOT NULL,
    CURP                VARCHAR(40)       NOT NULL,
    TELEFONO            VARCHAR(40)       NOT NULL,
    PRIMARY KEY (USUARIO_ID)
)ENGINE=MYISAM
;



-- 
-- TABLE: USUARIO_CUENTA 
--

CREATE TABLE USUARIO_CUENTA(
    USUARIO_CUENTA_ID    DECIMAL(40, 0)    NOT NULL,
    PRIMARY KEY (USUARIO_CUENTA_ID)
)ENGINE=MYISAM
;



