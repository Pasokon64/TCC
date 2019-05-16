DELIMITER //
-- DROP FUNCTION IF EXISTS CALCULO_RECORRENCIA;
CREATE FUNCTION CALCULO_RECORRENCIA(DT_INICIO DATETIME, QTD_RECORRENCIAS INT, 
	TIPO_RECORRENCIA INT) RETURNS DATETIME DETERMINISTIC
BEGIN
	DECLARE DATA_RETORNO DATETIME;

	IF TIPO_RECORRENCIA = 0 OR TIPO_RECORRENCIA IS NULL THEN
		SET DATA_RETORNO = DT_INICIO; 
    END IF;
    
    IF TIPO_RECORRENCIA = 1 THEN
		SET DATA_RETORNO = DATE_ADD(DT_INICIO, INTERVAL QTD_RECORRENCIAS DAY);
    END IF;
    
    IF TIPO_RECORRENCIA = 2 THEN
		SET DATA_RETORNO = DATE_ADD(DT_INICIO, INTERVAL QTD_RECORRENCIAS WEEK);
    END IF;
    
    IF TIPO_RECORRENCIA = 3 THEN
		SET DATA_RETORNO = DATE_ADD(DT_INICIO, INTERVAL QTD_RECORRENCIAS MONTH);
    END IF;
    
    IF TIPO_RECORRENCIA = 4 THEN
		SET DATA_RETORNO = DATE_ADD(DT_INICIO, INTERVAL QTD_RECORRENCIAS YEAR);
    END IF;
    
    RETURN DATA_RETORNO;
END
//

DELIMITER //
-- DROP FUNCTION IF EXISTS QTD_RECORRENCIAS;
CREATE FUNCTION QTD_RECORRENCIAS(DT_INICIO DATETIME, DT_ATUAL DATETIME, TIPO_RECORRENCIA INT,
	INTERVALO INT) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE oCOUNT INT DEFAULT 0;
    
    WHILE DT_INICIO <= DT_ATUAL DO
        IF TIPO_RECORRENCIA = 1 THEN
			SET DT_INICIO = DATE_ADD(DT_INICIO, INTERVAL INTERVALO DAY);
		END IF;
		
		IF TIPO_RECORRENCIA = 2 THEN
			SET DT_INICIO = DATE_ADD(DT_INICIO, INTERVAL INTERVALO WEEK);
		END IF;
		
		IF TIPO_RECORRENCIA = 3 THEN
			SET DT_INICIO = DATE_ADD(DT_INICIO, INTERVAL INTERVALO MONTH);
		END IF;
		
		IF TIPO_RECORRENCIA = 4 THEN
			SET DT_INICIO = DATE_ADD(DT_INICIO, INTERVAL INTERVALO YEAR);
		END IF;
        
        SET oCOUNT = oCOUNT + 1;
    END WHILE;
    
    RETURN oCOUNT;
END 
//

DELIMITER //
-- DROP FUNCTION IF EXISTS ULTIMA_RECORRENCIA;
CREATE FUNCTION ULTIMA_RECORRENCIA(TIPO INT, E_CODIGO INT) RETURNS DATETIME DETERMINISTIC
BEGIN
	DECLARE DT_ULTIMA DATETIME;
    
	IF TIPO = 1 THEN
		SELECT MAX(DATA_RECORRENCIA) INTO DT_ULTIMA FROM LEMBRETE_RECORRENCIA WHERE FK_LEMBRETE = E_CODIGO;
    END IF;
    
    IF TIPO = 2 THEN
        SELECT MAX(DATA_INICIO) INTO DT_ULTIMA FROM EVENTO_RECORRENCIA WHERE FK_EVENTO = E_CODIGO;
    END IF;
    
    RETURN DT_ULTIMA;
END
//

DELIMITER //
DROP FUNCTION IF EXISTS CALCULO_HORA_TAREFA;
CREATE FUNCTION CALCULO_HORA_TAREFA(USUARIO INT) RETURNS DATETIME DETERMINISTIC
BEGIN
	
	DECLARE tDataInicio DATETIME;
    DECLARE tDataFim DATETIME;
    DECLARE lErro INT DEFAULT 0;

	DECLARE DATA_INICIAL DATE DEFAULT DATE(NOW());
    DECLARE HORA_MAXIMA TIME DEFAULT '21:00:00'; -- EXEMPLO DE HORA MAXIMA SELECIONADA PELO USUARIO
    DECLARE HORA_MINIMA TIME DEFAULT '19:00:00'; -- EXEMPLO DE HORA MINIMA SELECIONADA PELO USUARIO 
    DECLARE DATA_SELECIONADA DATETIME;
    
	DECLARE DATA_FINAL DATETIME DEFAULT DATE_ADD(NOW(), INTERVAL 7 DAY);

	DECLARE oCompromissos CURSOR FOR SELECT EVENTO_RECORRENCIA.DATA_INICIO, EVENTO_RECORRENCIA.DATA_FIM FROM EVENTO_RECORRENCIA 
	INNER JOIN EVENTO ON FK_EVENTO = COD_EVENTO
    WHERE FK_USUARIO = USUARIO AND EXCLUIDO = 0 AND (EVENTO_RECORRENCIA.DATA_INICIO > DATE(NOW())
    AND EVENTO_RECORRENCIA.DATA_INICIO < DATE(DATA_FINAL))
    AND ((TIME(EVENTO_RECORRENCIA.DATA_INICIO) > '19:00:00' AND TIME(EVENTO_RECORRENCIA.DATA_INICIO) < '21:00:00') 
    OR (TIME(EVENTO_RECORRENCIA.DATA_FIM) < '21:00:00' AND TIME(EVENTO_RECORRENCIA.DATA_FIM) > '19:00:00'))
    ORDER BY EVENTO_RECORRENCIA.DATA_INICIO;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET lErro = 1;
    
    OPEN oCompromissos;
    
    getCompromissos : LOOP
		FETCH oCompromissos INTO tDataInicio, tDataFim;
        IF lErro = 1 THEN
            IF TIMEDIFF(HORA_MAXIMA, HORA_MINIMA) >= '01:00:00' THEN
				SET DATA_SELECIONADA = TIMESTAMP(DATA_INICIAL, HORA_MINIMA);
			ELSE
				SET DATA_SELECIONADA = TIMESTAMP(DATE_ADD(DATA_INICIAL, INTERVAL 1 DAY), '19:00:00');
			END IF;
			LEAVE getCompromissos;
        END IF;

		IF TIMEDIFF(TIME(tDataInicio), HORA_MINIMA) >= '01:00:00' THEN
			SET DATA_SELECIONADA = TIMESTAMP(DATA_INICIAL, HORA_MINIMA);
			LEAVE getCompromissos;
		ELSE
			SET HORA_MINIMA = TIME(tDataFim);
		END IF;
        
        IF TIMEDIFF(HORA_MAXIMA, HORA_MINIMA) < '01:00:00' THEN
			SET HORA_MINIMA = '19:00:00';
			SET DATA_INICIAL = DATE_ADD(DATA_INICIAL, INTERVAL 1 DAY);
		END IF;
        
	END LOOP getCompromissos;

    RETURN DATA_SELECIONADA;
END
//