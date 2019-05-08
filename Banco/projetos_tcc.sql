DROP TABLE TAREFA;
DROP TABLE PROJETO;

CREATE TABLE PROJETO (
	COD_PROJETO int AUTO_INCREMENT,
    TITULO varchar(255) NOT NULL,
    DATA_INICIO datetime NOT NULL,
    DATA_ENTREGA datetime NOT NULL,
    FK_USUARIO int NOT NULL,
    PRIMARY KEY (COD_PROJETO),
    FOREIGN KEY (FK_USUARIO) REFERENCES USUARIO(COD_USUARIO)
);

CREATE TABLE TAREFA (
	COD_TAREFA int AUTO_INCREMENT,
    NOME_TAREFA varchar(255) NOT NULL,
    FK_PROJETO int NOT NULL,
    PRIMARY KEY (COD_TAREFA),
    FOREIGN KEY (FK_PROJETO) REFERENCES PROJETO(COD_PROJETO)
);