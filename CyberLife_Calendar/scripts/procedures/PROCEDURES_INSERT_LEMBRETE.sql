DELIMITER // 
DROP PROCEDURE IF EXISTS ADICIONAR_LEMBRETE;
CREATE PROCEDURE ADICIONAR_LEMBRETE (IN LEMBRETE TEXT,IN ATIVO BIT ,IN TIPO_REPETICAO INT,  IN TIPO_RECORRENCIA INT ,IN RECORRENCIA INT,IN USUARIO INT,OUT CODIGO_LEMBRETE INT) 
 BEGIN 	
	   	INSERT INTO LEMBRETE(TITULO,ATIVO,TIPO_RECORRENCIA, TIPO_REPETICAO,RECORRENCIA, FK_USUARIO) VALUES 
			(LEMBRETE, ATIVO, TIPO_RECORRENCIA, TIPO_REPETICAO, RECORRENCIA ,USUARIO);
	   SET CODIGO_LEMBRETE = LAST_INSERT_ID();
     END 
//
DELIMITER //
DROP PROCEDURE IF EXISTS HORARIO_SEM_RECORRENCIA; 
CREATE PROCEDURE HORARIO_SEM_RECORRENCIA (IN DATA_INICIO DATETIME,IN HORARIO_INICIO TIME , IN HORARIO_FIM TIME , IN INTERVALO INT, IN CODIGO_LEMBRETE INT)
BEGIN   
	IF INTERVALO = 0 THEN		
		INSERT INTO HORARIO_LEMBRETE (DATA_LEMBRETE, HL_ATIVO , FK_LEMBRETE) VALUES (DATA_INICIO,TRUE ,CODIGO_LEMBRETE);
	  ELSE 
		INSERT INTO HORARIO_LEMBRETE (DATA_LEMBRETE, HORARIO_INICIO, HORARIO_FIM , HL_INTERVALO_MINUTOS,HL_ATIVO,  FK_LEMBRETE) VALUES (DATA_INICIO, HORARIO_INICIO, HORARIO_FIM,INTERVALO , TRUE , CODIGO_LEMBRETE);
	END IF;
END //

DELIMITER // 
DROP PROCEDURE IF EXISTS RECORRENCIA_SEM_FIM;
CREATE PROCEDURE RECORRENCIA_SEM_FIM (IN DATA_INICIO DATETIME, IN HORARIO_INICIO TIME, HORARIO_FIM TIME ,IN INTERVALO INT, 
IN DIA_SEMANA INT, IN CODIGO_LEMBRETE INT)
BEGIN 
	IF INTERVALO = 0 THEN
		IF DIA_SEMANA > 6 THEN 
			INSERT INTO HORARIO_LEMBRETE (DATA_LEMBRETE, HL_ATIVO, FK_LEMBRETE) VALUES 
			(DATA_INICIO,TRUE,CODIGO_LEMBRETE);
		ELSE 
			INSERT INTO HORARIO_LEMBRETE (DATA_LEMBRETE,HL_SEMANA_DIA, HL_ATIVO, FK_LEMBRETE) VALUES	
				(DATA_INICIO, DIA_SEMANA,TRUE,  CODIGO_LEMBRETE);
		END IF;
	ELSE 
		IF DIA_SEMANA > 6 THEN 
			INSERT INTO HORARIO_LEMBRETE(DATA_LEMBRETE,HORARIO_INICIO, HORARIO_FIM,
			HL_INTERVALO_MINUTOS,HL_ATIVO, FK_LEMBRETE) VALUES 
				(DATA_INICIO, HORARIO_INICIO,HORARIO_FIM, INTERVALO, TRUE , CODIGO_LEMBRETE);
		ELSE 
			INSERT INTO HORARIO_LEMBRETE(DATA_LEMBRETE, HORARIO_INICIO, HORARIO_FIM  ,
				HL_INTERVALO_MINUTOS, HL_SEMANA_DIA, HL_ATIVO,  FK_LEMBRETE) VALUES
					(DATA_INICIO, HORARIO_INICIO, HORARIO_FIM, INTERVALO,DIA_SEMANA,TRUE, CODIGO_LEMBRETE);
		END IF;
	END IF;
END
//
DELIMITER // 
DROP PROCEDURE IF EXISTS RECORRENCIA_POR_QTDE_REPETICAO;
CREATE PROCEDURE RECORRENCIA_POR_QTDE_REPETICAO ( IN DATA_INICIO DATETIME, IN HORARIO_INICIO TIME, IN HORARIO_FIM TIME, IN INTERVALO INT, 
IN DIA_SEMANA INT , IN REPETICAO_QTD INT, IN CODIGO_LEMBRETE INT)
BEGIN 
	IF INTERVALO  = 0 THEN
		IF DIA_SEMANA > 6 THEN 
				INSERT INTO HORARIO_LEMBRETE ( DATA_LEMBRETE, HL_QTD_REPETE,HL_ATIVO, FK_LEMBRETE)
				VALUES (DATA_INICIO, REPETICAO_QTD,TRUE, CODIGO_LEMBRETE);				
		ELSE 
				INSERT INTO HORARIO_LEMBRETE (DATA_LEMBRETE, HL_QTD_REPETE, HL_SEMANA_DIA, HL_ATIVO, FK_LEMBRETE) 
				VALUES (DATA_INICIO, REPETICAO_QTD, DIA_SEMANA, TRUE, CODIGO_LEMBRETE);	
		END IF;
	ELSE 
		IF DIA_SEMANA > 6 THEN 
				INSERT INTO HORARIO_LEMBRETE ( DATA_LEMBRETE, HORARIO_INICIO, HORARIO_FIM, HL_QTD_REPETE,HL_ATIVO,  FK_LEMBRETE)
				VALUES ( DATA_INICIO, REPETICAO_QTD, TRUE , CODIGO_LEMBRETE);
		ELSE 
				INSERT INTO HORARIO_LEMBRETE ( DATA_LEMBRETE, HORARIO_INICIO , HORARIO_FIM ,  HL_QTD_REPETE,HL_SEMANA_DIA,HL_ATIVO,  FK_LEMBRETE)
				VALUES ( DATA_INICIO, REPETICAO_QTD, DIA_SEMANA , TRUE , CODIGO_LEMBRETE);
		END IF;
	END IF;
END 
//

 
DELIMITER //
DROP PROCEDURE IF EXISTS RECORRENCIA_DATA_DEFINIDA;
CREATE PROCEDURE RECORRENCIA_DATA_DEFINIDA ( IN DATA_INICIO DATETIME, IN DATA_FINAL DATETIME, IN HORARIO_INICIO TIME,
	IN HORARIO_FINAL TIME, IN INTERVALO INT, IN DIA_SEMANA INT, IN CODIGO_LEMBRETE INT)
BEGIN 
	IF INTERVALO = 0 THEN 
		IF DIA_SEMANA >  6 THEN 
			INSERT INTO HORARIO_LEMBRETE (DATA_LEMBRETE, DATA_FINAL_LEMBRETE, 
			HL_ATIVO, FK_LEMBRETE) 
			VALUES  (DATA_INICIO, DATA_FINAL , TRUE, CODIGO_LEMBRETE) ;
		ELSE 	
			INSERT INTO HORARIO_LEMBRETE ( DATA_LEMBRETE, DATA_FINAL_LEMBRETE,HL_SEMANA_DIA, HL_ATIVO, FK_LEMBRETE) VALUES 
			(DATA_INICIO, DATA_FINAL,DIA_SEMANA,TRUE,  CODIGO_LEMBRETE);
		END IF;
		ELSE 
			IF DIA_SEMANA > 6 THEN 
				INSERT INTO HORARIO_LEMBRETE(DATA_LEMBRETE, DATA_FINAL_LEMBRETE,HORARIO_INICIO, HORARIO_FIM,
				HL_INTERVALO_MINUTOS,HL_ATIVO,  FK_LEMBRETE) VALUES 
				(DATA_INICIO,DATA_FINAL,HORARIO_INICIO,HORARIO_FIM, INTERVALO,TRUE,  CODIGO_LEMBRETE);
			ELSE 
				INSERT INTO HORARIO_LEMBRETE(DATA_LEMBRETE,DATA_FINAL_LEMBRETE, HORARIO_INICIO, HORARIO_FIM  ,
				HL_INTERVALO_MINUTOS, HL_SEMANA_DIA,HL_ATIVO,  FK_LEMBRETE) VALUES
					(DATA_INICIO, DATA_FINAL, HORARIO_INICIO, HORARIO_FIM, INTERVALO,DIA_SEMANA,TRUE, CODIGO_LEMBRETE);
		END IF;
	END IF;
END
//	
	
























		
		
		
		
		
		