/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.5.4-MariaDB : Database - teste_wk
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`teste_wk` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `teste_wk`;

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `codigo` varchar(8) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `clientes` */

insert  into `clientes`(`codigo`,`nome`,`cidade`,`uf`) values 
('01000010','MARIA OLIVEIRA','MANAUS','AM'),
('01000011','JOAO FERNANDES','MANAUS','AM'),
('01000012','ALDO BASILO','MANAUS','AM'),
('01000013','RAIMUNDO FERREIRA','PARINTINS','AM'),
('01000014','PATRICIA CRUZ','FORTALEZA','CE'),
('01000015','PAULA PATRICIA','MANAUS','AM'),
('01000016','INES DA SILVA','SALVADOR','BA'),
('01000017','JOEL SOUZA','RIO DE JANEIRO','RJ'),
('01000018','EDUARDO PAIVA','MANAUS','AM'),
('01000019','EDUARDO MESQUITA','FLORIANOPOLIS','SC'),
('01000020','JOSE ROBERTO','SAO PAULO','SP'),
('01000021','FERNANDO DINIZ','MANAUS','AM'),
('01000022','MARCELO MADUREIRA','PARINTINS','AM'),
('01000023','GEOVANE PINTO','FORTALEZA','CE'),
('01000024','PAULO HENRIQUE','MANAUS','AM'),
('01000025','PEDRO JOSE','SALVADOR','BA'),
('01000026','ANTONIO CALADO','RIO DE JANEIRO','RJ'),
('01000027','MARCIO AMARAL','MANAUS','AM'),
('01000028','MIGUEL JOSIAS','FLORIANOPOLIS','SC'),
('01000029','GABRIEL DINIZ','SAO PAULO','SP');

/*Table structure for table `pedidos` */

DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `numero` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` varchar(8) NOT NULL,
  `valor_total` double(15,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`numero`),
  KEY `fk_pedidos_cliente` (`codigo_cliente`),
  CONSTRAINT `fk_pedidos_cliente` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `pedidos` */

insert  into `pedidos`(`numero`,`data_emissao`,`codigo_cliente`,`valor_total`) values 
(1,'2020-11-05','01000012',0.00),
(2,'2020-11-05','01000012',0.00),
(3,'2020-11-05','01000026',0.00),
(4,'2020-11-05','01000012',0.00),
(5,'2020-11-05','01000012',0.00);

/*Table structure for table `pedidos_produtos` */

DROP TABLE IF EXISTS `pedidos_produtos`;

CREATE TABLE `pedidos_produtos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `numero_pedido` int(10) unsigned NOT NULL,
  `codigo_produto` varchar(8) NOT NULL,
  `quantidade` double(15,3) NOT NULL DEFAULT 0.000,
  `valor_unitario` double(15,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `fk_pedidos_produtos_pedido` (`numero_pedido`),
  KEY `fk_pedidos_produtos_produto` (`codigo_produto`),
  CONSTRAINT `fk_pedidos_produtos_pedido` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos` (`numero`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_produtos_produto` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pedidos_produtos` */

/*Table structure for table `produtos` */

DROP TABLE IF EXISTS `produtos`;

CREATE TABLE `produtos` (
  `codigo` varchar(8) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `preco_venda` double DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `produtos` */

insert  into `produtos`(`codigo`,`descricao`,`preco_venda`) values 
('00000010','CANETA BIC AZUL',3.5),
('00000011','ALCOOL GEL',15.99),
('00000012','ARROZ AGULHINHA',5.4),
('00000013','FEIJAO PRETO',8.6),
('00000014','MACARRAO',3.8),
('00000015','SABAO EM PO',9.65),
('00000016','CONSERVA BOVINA',6.5),
('00000017','LEITE NINHO',16.99),
('00000018','CAFE SANTA CLARA',4.99),
('00000019','FEIJAO CARIOCA',9.9),
('00000020','CANETA BIC PRETA',3.2),
('00000021','MAIZENA',2.99),
('00000022','AMACIANTE OMO',6.8),
('00000023','LAPIS FABER CASTEL',1.6),
('00000024','LAMPADA LED',14.18),
('00000025','LUMINARIA',42.25),
('00000026','SARDINHA GOMES DA COSTA',2.55),
('00000027','PARAFUSADEIRA',180.69),
('00000028','DVD-RW',1.99),
('00000029','ACUCAR',3.4);

/* Trigger structure for table `pedidos_produtos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `pedidos_produtos_aft_ins_row` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `pedidos_produtos_aft_ins_row` AFTER INSERT ON `pedidos_produtos` FOR EACH ROW 
    BEGIN
       UPDATE pedidos
       SET valor_total = valor_total + (NEW.valor_unitario * NEW.quantidade)
       WHERE numero = NEW.numero_pedido;
    END */$$


DELIMITER ;

/* Trigger structure for table `pedidos_produtos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `pedidos_produtos_bef_upd_row` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `pedidos_produtos_bef_upd_row` BEFORE UPDATE ON `pedidos_produtos` FOR EACH ROW 
    BEGIN
       UPDATE pedidos
       SET valor_total = valor_total - (OLD.valor_unitario * OLD.quantidade) - (NEW.valor_unitario * NEW.quantidade)
       WHERE numero = NEW.numero_pedido;
    END */$$


DELIMITER ;

/* Trigger structure for table `pedidos_produtos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `pedidos_produtos_bef_del_row` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `pedidos_produtos_bef_del_row` BEFORE DELETE ON `pedidos_produtos` FOR EACH ROW 
    BEGIN
       UPDATE pedidos
       SET valor_total = valor_total - (OLD.valor_unitario * OLD.quantidade)
       WHERE numero = OLD.numero_pedido;
    END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
