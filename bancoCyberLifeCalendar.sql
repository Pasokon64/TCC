use cyber_life;

DROP TABLE IF EXISTS `HORARIO_LEMBRETE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HORARIO_LEMBRETE` (
  `HL_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `HL_HORARIO_INICIO` datetime DEFAULT NULL,
  `HL_HORARIO_FIM` datetime DEFAULT NULL,
  `HL_DATA_REPETICAO` datetime DEFAULT NULL,
  `HL_INTERVALO_MINUTOS` int(11) DEFAULT NULL,
  `HL_RECORRENCIA` int(11) DEFAULT NULL,
  `HL_SEMANA_DIA` int(11) DEFAULT NULL,
  `HL_QTD_REPETE` int(11) DEFAULT NULL,
  `FK_LEMBRETE` int(11) DEFAULT NULL,
  PRIMARY KEY (`HL_CODIGO`),
  KEY `FK_CODIGO_LEMBRETE` (`FK_LEMBRETE`),
  CONSTRAINT `FK_CODIGO_LEMBRETE` FOREIGN KEY (`FK_LEMBRETE`) REFERENCES `LEMBRETE` (`LCOD_LEMBRETE`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `LEMBRETE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LEMBRETE` (
  `LCOD_LEMBRETE` int(11) NOT NULL AUTO_INCREMENT,
  `LEMBRETE` text,
  `LDIA_TODO` bit(1) DEFAULT NULL,
  `L_STATUS` varchar(20) DEFAULT NULL,
  `LRECORRENCIA_TIPO` int(11) DEFAULT NULL,
  `FK_USUARIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`LCOD_LEMBRETE`),
  KEY `FK_USUARIO` (`FK_USUARIO`),
  CONSTRAINT `FK_USUARIO` FOREIGN KEY (`FK_USUARIO`) REFERENCES `USUARIO` (`UCODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `USUARIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USUARIO` (
  `UCODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `UEMAIL` varchar(255) NOT NULL,
  `UNOME` varchar(255) DEFAULT NULL,
  `USOBRENOME` varchar(255) DEFAULT NULL,
  `USENHA` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UCODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

DELIMITER // 
CREATE PROCEDURE ADICIONAR_LEMBRETE (IN LEMBRETE TEXT, IN DIA_TODO BIT, IN STATUS VARCHAR(20), IN TIPO_RECORRENCIA INT , OUT CODIGO_LEMBRETE INT,IN USUARIO INT) 
 BEGIN 
	 IF DIA_TODO IS NULL THEN 
            SET DIA_TODO = FALSE;
   	END IF; 
       INSERT INTO LEMBRETE (LEMBRETE, LDIA_TODO, L_STATUS, LRECORRENCIA_TIPO ,FK_USUARIO) 
  		 VALUES
          (LEMBRETE, DIA_TODO, STATUS, TIPO_RECORRENCIA ,USUARIO);
         
       SET CODIGO_LEMBRETE = LAST_INSERT_ID();
     END 
//

DELIMITER // 
CREATE PROCEDURE HORARIO_SEM_RECORRENCIA (IN DATA_INICIO DATETIME, IN  DATA_FIM DATETIME,  IN INTERVALO INT, IN CODIGO_LEMBRETE INT)
BEGIN 
	IF INTERVALO = 0 THEN 
	  	INSERT INTO HORARIO_LEMBRETE (HL_HORARIO_INICIO, HL_HORARIO_FIM , FK_LEMBRETE) VALUES (DATA_INICIO,DATA_FIM, CODIGO_LEMBRETE);
	ELSE 
			INSERT INTO HORARIO_LEMBRETE (HL_HORARIO_INICIO, HL_HORARIO_FIM , HL_INTERVALO_MINUTOS, FK_LEMBRETE) VALUES (DATA_INICIO,DATA_FIM,INTERVALO, CODIGO_LEMBRETE);
	END IF;
END //


DELIMITER // 
CREATE PROCEDURE HORARIO_RECORRENCIA_SEM_FIM ( IN DATA_INICIO DATETIME, IN DATA_FIM  DATETIME, IN INTERVALO INT, IN RECORRENCIA INT, IN DIA_SEMANA INT, IN CODIGO_LEMBRETE INT)
BEGIN 
	IF INTERVALO = 0 THEN 
		INSERT INTO HORARIO_LEMBRETE (HL_HORARIO_INICIO, HL_RECORRENCIA, HL_SEMANA_DIA, FK_LEMBRETE) VALUES 
		(DATA_INICIO, RECORRENCIA, DIA_SEMANA,CODIGO_LEMBRETE);
	ELSE 
		INSERT INTO HORARIO_LEMBRETE(HL_HORARIO_INICIO, HL_HORARIO_FIM, HL_INTERVALO_MINUTOS, HL_RECORRENCIA, HL_SEMANA_DIA, FK_LEMBRETE) VALUES
		(DATA_INICIO, DATA_FIM, INTERVALO, RECORRENCIA,DIA_SEMANA,CODIGO_LEMBRETE);
	END IF;
END
//

DELIMITER // 
CREATE PROCEDURE ADICIONAR_USUARIO( IN EMAIL VARCHAR(255), IN NOME VARCHAR(255),             
         IN SOBRENOME VARCHAR(255), IN SENHA VARCHAR(255))
BEGIN                                                                                  
             IF SOBRENOME IS NULL OR SOBRENOME = '' THEN                                      
                INSERT INTO USUARIO (UEMAIL,UNOME, USENHA) VALUES (EMAIL,NOME,SENHA);         
             ELSE                                                                             
                        INSERT INTO USUARIO (UEMAIL,UNOME,USOBRENOME,USENHA) VALUES           
                               (EMAIL,NOME,SOBRENOME,SENHA);                                  
              END IF;                                                                         
END 
//
DELIMITER // 
CREATE PROCEDURE EMAIL_EXISTE(IN EMAIL VARCHAR(255), OUT RESULT BIT)
BEGIN 
     DECLARE NUMERO_REGISTROS INT;  
     SELECT COUNT(0) INTO NUMERO_REGISTROS FROM USUARIO WHERE UEMAIL = EMAIL;        
           
    IF NUMERO_REGISTROS > 0 THEN               
        SET RESULT = 1;        
    ELSE                 
        SET RESULT = 0;        
   END IF;    
END 
//

select * from horario_lembrete;
select * from lembrete;
select * from usuario;