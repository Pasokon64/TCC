/* datas comemorativas com dia fixo */
INSERT INTO DATAS_COMEMORATIVAS (NOME, TIPO_DATA, DIA, MES) VALUES
	("Ano Novo", 0, 1, 1),
    ("Tiradentes", 0, 21, 4),
    ("Dia do Trabalho", 0, 1, 5),
    ("Dia dos Namorados", 0, 12, 6),
    ("Independência", 0, 7, 9),
    ("Nossa Senhora de Aparecida", 0, 12, 10),
    ("Dia do Professor", 0, 15, 10),
    ("Dia do Servidor Público", 0, 28, 10),
    ("Finados", 0, 2, 11),
    ("Proclamação da República", 0, 15, 11),
    ("Dia da Consciência Negra", 0, 20, 11),
    ("Véspera de Natal", 0, 24, 12),
    ("Natal", 0, 25, 12),
    ("Véspera de Ano Novo", 0, 31, 12);

/* datas comemorativas com dia da semana fixo */
INSERT INTO DATAS_COMEMORATIVAS (NOME, TIPO_DATA, DIA_SEMANA, SEMANA, MES) VALUES
	("Dias das Mães", 1, 0, 2, 5),
	("Dias dos Pais", 1, 0, 2, 8);

/*
 * datas comemorativas móveis (que dependem da páscoa)
 * as datas são calculadas levando em conta os dias antes ou depois da páscoa
 */    
INSERT INTO DATAS_COMEMORATIVAS (NOME, TIPO_DATA, DIA) VALUES
	("Carnaval", 2, -47),
	("Cinzas", 2, -46),
	("Sexta-Feira da Paixão", 2, -2),
	("Domingo de Páscoa", 2, 0),
	("Corpus Christi", 2, 60);
    

/* inserts de eventos para teste das funções do banco de dados */
DELIMITER //
START TRANSACTION;

	INSERT INTO EVENTO (TITULO, DATA_INICIO, DATA_FIM, DIA_TODO, LOCAL_EVENTO, DESCRICAO,
		TIPO_REPETICAO, TIPO_FIM_REPETICAO, FK_USUARIO) VALUES ('TESTE-1', NOW(), 
        DATE_ADD(NOW(), INTERVAL 30 MINUTE), 1, 'Local teste', 'Descrição...', 0, 0, 1);
        
	INSERT INTO EVENTO_REPETICAO (INTERVALO, DIAS_SEMANA, FK_EVENTO) VALUES (0, '0,0,0,0,0,0,0', LAST_INSERT_ID());
    
    INSERT INTO EVENTO_FIM_REPETICAO (DIA_FIM, QTD_RECORRENCIAS, FK_EVENTO) VALUES (NULL, 
		0, LAST_INSERT_ID());
        
	INSERT INTO EVENTO (TITULO, DATA_INICIO, DATA_FIM, DIA_TODO, LOCAL_EVENTO, DESCRICAO,
		TIPO_REPETICAO, TIPO_FIM_REPETICAO, FK_USUARIO) VALUES ('TESTE-2', NOW(), 
        DATE_ADD(NOW(), INTERVAL 30 MINUTE), 1, 'Local teste', 'Descrição...', 1, 0, 1);
        
	INSERT INTO EVENTO_REPETICAO (INTERVALO, DIAS_SEMANA, FK_EVENTO) VALUES (1, '0,0,0,0,0,0,0', LAST_INSERT_ID());
    
    INSERT INTO EVENTO_FIM_REPETICAO (DIA_FIM, QTD_RECORRENCIAS, FK_EVENTO) VALUES (NULL, 
		0, LAST_INSERT_ID());
        
	INSERT INTO EVENTO (TITULO, DATA_INICIO, DATA_FIM, DIA_TODO, LOCAL_EVENTO, DESCRICAO,
		TIPO_REPETICAO, TIPO_FIM_REPETICAO, FK_USUARIO) VALUES ('TESTE-3', NOW(), 
        DATE_ADD(NOW(), INTERVAL 30 MINUTE), 1, 'Local teste', 'Descrição...', 2, 0, 1);
        
	INSERT INTO EVENTO_REPETICAO (INTERVALO, DIAS_SEMANA, FK_EVENTO) VALUES (1, '1,0,0,0,1,0,0', LAST_INSERT_ID());
    
    INSERT INTO EVENTO_FIM_REPETICAO (DIA_FIM, QTD_RECORRENCIAS, FK_EVENTO) VALUES (NULL, 
		0, LAST_INSERT_ID());
        
	INSERT INTO EVENTO (TITULO, DATA_INICIO, DATA_FIM, DIA_TODO, LOCAL_EVENTO, DESCRICAO,
		TIPO_REPETICAO, TIPO_FIM_REPETICAO, FK_USUARIO) VALUES ('TESTE-4', NOW(), 
        DATE_ADD(NOW(), INTERVAL 30 MINUTE), 1, 'Local teste', 'Descrição...', 3, 0, 1);
        
	INSERT INTO EVENTO_REPETICAO (INTERVALO, DIAS_SEMANA, FK_EVENTO) VALUES (1, '0,0,0,0,0,0,0', LAST_INSERT_ID());
    
    INSERT INTO EVENTO_FIM_REPETICAO (DIA_FIM, QTD_RECORRENCIAS, FK_EVENTO) VALUES (NULL, 
		0, LAST_INSERT_ID());
        
	INSERT INTO EVENTO (TITULO, DATA_INICIO, DATA_FIM, DIA_TODO, LOCAL_EVENTO, DESCRICAO,
		TIPO_REPETICAO, TIPO_FIM_REPETICAO, FK_USUARIO) VALUES ('TESTE-5', NOW(), 
        DATE_ADD(NOW(), INTERVAL 30 MINUTE), 1, 'Local teste', 'Descrição...', 4, 0, 1);
        
	INSERT INTO EVENTO_REPETICAO (INTERVALO, DIAS_SEMANA, FK_EVENTO) VALUES (1, '0,0,0,0,0,0,0', LAST_INSERT_ID());
    
    INSERT INTO EVENTO_FIM_REPETICAO (DIA_FIM, QTD_RECORRENCIAS, FK_EVENTO) VALUES (NULL, 
		0, LAST_INSERT_ID());
        
	INSERT INTO EVENTO (TITULO, DATA_INICIO, DATA_FIM, DIA_TODO, LOCAL_EVENTO, DESCRICAO,
		TIPO_REPETICAO, TIPO_FIM_REPETICAO, FK_USUARIO) VALUES ('TESTE-6', NOW(), 
        DATE_ADD(NOW(), INTERVAL 30 MINUTE), 1, 'Local teste', 'Descrição...', 1, 1, 1);
        
	INSERT INTO EVENTO_REPETICAO (INTERVALO, DIAS_SEMANA, FK_EVENTO) VALUES (1, '0,0,0,0,0,0,0', LAST_INSERT_ID());
		
	INSERT INTO EVENTO_FIM_REPETICAO (DIA_FIM, QTD_RECORRENCIAS, FK_EVENTO) VALUES (DATE_ADD(NOW(), INTERVAL 5 DAY), 
			0, LAST_INSERT_ID());
			
	INSERT INTO EVENTO (TITULO, DATA_INICIO, DATA_FIM, DIA_TODO, LOCAL_EVENTO, DESCRICAO,
			TIPO_REPETICAO, TIPO_FIM_REPETICAO, FK_USUARIO) VALUES ('TESTE-7', NOW(), 
			DATE_ADD(NOW(), INTERVAL 30 MINUTE), 1, 'Local teste', 'Descrição...', 1, 2, 1);
			
	INSERT INTO EVENTO_REPETICAO (INTERVALO, DIAS_SEMANA, FK_EVENTO) VALUES (1, '0,0,0,0,0,0,0', LAST_INSERT_ID());
		
	INSERT INTO EVENTO_FIM_REPETICAO (DIA_FIM, QTD_RECORRENCIAS, FK_EVENTO) VALUES (NULL, 
			8, LAST_INSERT_ID());
COMMIT;
//

DROP TABLE EVENTO_RECORRENCIA;