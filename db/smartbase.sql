/*
Navicat MySQL Data Transfer

Source Server         : fe
Source Server Version : 50560
Source Host           : localhost:3306
Source Database       : smartbase

Target Server Type    : MYSQL
Target Server Version : 50560
File Encoding         : 65001

Date: 2021-05-04 18:59:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_articulo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_articulo`;
CREATE TABLE `tbl_articulo` (
  `id_articulo` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_articulo` char(120) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion_articulo` text COLLATE utf8_spanish_ci,
  `categoria` int(5) DEFAULT NULL,
  `marca` int(5) DEFAULT NULL,
  `unidad` char(3) COLLATE utf8_spanish_ci DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `precio_compra` decimal(10,2) DEFAULT NULL,
  `afectacion` char(2) COLLATE utf8_spanish_ci DEFAULT NULL,
  `stock` decimal(10,2) DEFAULT '0.00',
  `estado` char(1) COLLATE utf8_spanish_ci DEFAULT '1',
  PRIMARY KEY (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_articulo
-- ----------------------------
INSERT INTO `tbl_articulo` VALUES ('1', 'DEMO', 'S/D', '1', '1', '1', '5.20', '4.80', '10', '4.00', '1');
INSERT INTO `tbl_articulo` VALUES ('2', 'PRODUCTO DEMO ACTUALIZADO', 'ESTA ES UNA DEMO', '3', '2', '1', '7.00', '5.00', '10', '8.00', '1');
INSERT INTO `tbl_articulo` VALUES ('3', 'PRUEBA 2', '-', '4', '2', '3', '7.00', '5.00', '20', '9.00', '1');
INSERT INTO `tbl_articulo` VALUES ('4', 'DEMO3', '-', '3', '3', '3', '15.00', '10.00', '11', '0.00', '1');

-- ----------------------------
-- Table structure for tbl_categorias
-- ----------------------------
DROP TABLE IF EXISTS `tbl_categorias`;
CREATE TABLE `tbl_categorias` (
  `id_categoria` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` char(50) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `estado` char(1) COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_categorias
-- ----------------------------
INSERT INTO `tbl_categorias` VALUES ('1', 'COCA COLA1', '1');
INSERT INTO `tbl_categorias` VALUES ('2', 'DULCES AMARGO2', '1');
INSERT INTO `tbl_categorias` VALUES ('3', 'CHOCOLATE BLANCO', '1');
INSERT INTO `tbl_categorias` VALUES ('4', 'NUEVA CAT', '1');

-- ----------------------------
-- Table structure for tbl_compras_cab
-- ----------------------------
DROP TABLE IF EXISTS `tbl_compras_cab`;
CREATE TABLE `tbl_compras_cab` (
  `id_compra` int(5) NOT NULL AUTO_INCREMENT,
  `fecha_compra` date DEFAULT NULL,
  `persona` int(5) DEFAULT NULL,
  `tipo_doc` char(2) COLLATE utf8_spanish_ci DEFAULT NULL,
  `serie_doc` char(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numero_doc` int(8) unsigned zerofill DEFAULT NULL,
  `op_gravadas` decimal(10,2) DEFAULT '0.00',
  `op_igv` decimal(10,2) DEFAULT '0.00',
  `total_compra` decimal(10,2) DEFAULT '0.00',
  `estado` char(1) COLLATE utf8_spanish_ci DEFAULT '1',
  PRIMARY KEY (`id_compra`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_compras_cab
-- ----------------------------
INSERT INTO `tbl_compras_cab` VALUES ('5', '2021-05-20', '2', '01', 'F001', '00254785', '33.73', '6.07', '39.80', '1');
INSERT INTO `tbl_compras_cab` VALUES ('6', '2021-05-03', '7', '01', 'F001', '00012345', '54.58', '9.82', '64.40', '1');

-- ----------------------------
-- Table structure for tbl_compras_det
-- ----------------------------
DROP TABLE IF EXISTS `tbl_compras_det`;
CREATE TABLE `tbl_compras_det` (
  `id_detalle_compra` int(5) NOT NULL AUTO_INCREMENT,
  `id_compra` int(5) DEFAULT NULL,
  `item` int(5) DEFAULT NULL,
  `id_articulo` int(5) DEFAULT NULL,
  `cantidad` decimal(10,2) NOT NULL DEFAULT '0.00',
  `precio_compra` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_detalle_compra`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_compras_det
-- ----------------------------
INSERT INTO `tbl_compras_det` VALUES ('6', '5', '1', '3', '3.00', '5.00');
INSERT INTO `tbl_compras_det` VALUES ('7', '5', '2', '2', '4.00', '5.00');
INSERT INTO `tbl_compras_det` VALUES ('8', '5', '3', '1', '1.00', '4.80');
INSERT INTO `tbl_compras_det` VALUES ('9', '6', '1', '1', '3.00', '4.80');
INSERT INTO `tbl_compras_det` VALUES ('10', '6', '2', '2', '4.00', '5.00');
INSERT INTO `tbl_compras_det` VALUES ('11', '6', '3', '3', '6.00', '5.00');

-- ----------------------------
-- Table structure for tbl_marcas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_marcas`;
CREATE TABLE `tbl_marcas` (
  `id_marca` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_marca` char(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8_spanish_ci DEFAULT '1',
  PRIMARY KEY (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_marcas
-- ----------------------------
INSERT INTO `tbl_marcas` VALUES ('1', 'COCA COLAD1', '1');
INSERT INTO `tbl_marcas` VALUES ('2', 'INKA COLA', '1');
INSERT INTO `tbl_marcas` VALUES ('3', 'FANTA', '1');
INSERT INTO `tbl_marcas` VALUES ('4', 'DUMBO', '1');

-- ----------------------------
-- Table structure for tbl_persona
-- ----------------------------
DROP TABLE IF EXISTS `tbl_persona`;
CREATE TABLE `tbl_persona` (
  `id_persona` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_persona` char(100) COLLATE utf8_spanish_ci NOT NULL,
  `direccion_persona` char(100) COLLATE utf8_spanish_ci NOT NULL,
  `distrito` char(50) COLLATE utf8_spanish_ci NOT NULL,
  `provincia` char(50) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` char(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_doc` char(1) COLLATE utf8_spanish_ci NOT NULL,
  `num_doc` char(11) COLLATE utf8_spanish_ci NOT NULL,
  `correo` char(60) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_persona`),
  KEY `ruc` (`num_doc`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_persona
-- ----------------------------
INSERT INTO `tbl_persona` VALUES ('1', 'PENTARAMA SA', 'AV JOSE PARDO 121', 'MIRAFLORES', 'LIMA', 'LIMA', '6', '20510360932', 'jmvalverdec@gmail.com');
INSERT INTO `tbl_persona` VALUES ('2', 'PENTARAMA EL PACIFICO S.A.', 'AV. JOSE PARDO NRO. 121 LIMA LIMA MIRAFLORES', 'MIRAFLORES', 'LIMA', 'LIMA', '6', '20548960771', 'jmvalverdec@gmail.com');
INSERT INTO `tbl_persona` VALUES ('3', 'PENTARAMA INVESTMENT S.A.', 'JR. ALFONSO UGARTE NRO. 1360 URB. LOS JARDINES SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20494168651', 'contabilidad@pentarama.com');
INSERT INTO `tbl_persona` VALUES ('4', 'PENTARAMA INVERSIONES S.A.', 'AV. JOSE PARDO NRO. 121 LIMA LIMA MIRAFLORES', 'MIRAFLORES', 'LIMA', 'LIMA', '6', '20548961158', 'contabilidad@pentarama.com');
INSERT INTO `tbl_persona` VALUES ('5', 'TRANSPACIFIC INVESTMENT SRL', 'CAL. C MZA. B-1 LOTE. 9 URB. RIO MAR LORETO MAYNAS BELEN', 'BELEN', 'MAYNAS', 'LORETO', '6', '20493223641', 'jmvalverdec@gmail.com');
INSERT INTO `tbl_persona` VALUES ('6', 'CASTILLO GALVEZ OMAR DAYGORO', '-', 'LIMA', 'LIMA', 'LIMA', '1', '44284097', 'elpoton@gmail.com');
INSERT INTO `tbl_persona` VALUES ('7', 'MACHE CONSTRUCTORES S.A.C.', 'CAL. DANIEL HERNANDEZ NRO. 712 LIMA LIMA PUEBLO LIBRE', 'PUEBLO LIBRE', 'LIMA', 'LIMA', '6', '20509505731', 'demo@gmail.com');

-- ----------------------------
-- Table structure for tbl_personal
-- ----------------------------
DROP TABLE IF EXISTS `tbl_personal`;
CREATE TABLE `tbl_personal` (
  `id_personal` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_personal` char(30) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `apellido_personal` char(30) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_personal`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_personal
-- ----------------------------
INSERT INTO `tbl_personal` VALUES ('1', 'JUAN', 'VALVERDE');

-- ----------------------------
-- Table structure for tbl_series
-- ----------------------------
DROP TABLE IF EXISTS `tbl_series`;
CREATE TABLE `tbl_series` (
  `id_serie` int(5) NOT NULL AUTO_INCREMENT,
  `id_tipo_cpe` int(5) DEFAULT NULL,
  `serie_cpe` char(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numero_cpe` int(8) unsigned zerofill DEFAULT NULL,
  `id_usuario` int(5) DEFAULT NULL,
  PRIMARY KEY (`id_serie`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_series
-- ----------------------------
INSERT INTO `tbl_series` VALUES ('1', '1', 'F001', '00000001', '1');
INSERT INTO `tbl_series` VALUES ('2', '2', 'B001', '00000001', '1');
INSERT INTO `tbl_series` VALUES ('3', '3', 'F001', '00000001', '1');
INSERT INTO `tbl_series` VALUES ('4', '3', 'B001', '00000001', '1');
INSERT INTO `tbl_series` VALUES ('5', '4', 'F001', '00000001', '1');
INSERT INTO `tbl_series` VALUES ('6', '4', 'F001', '00000001', '1');
INSERT INTO `tbl_series` VALUES ('7', '9', 'NV01', '00000001', '1');

-- ----------------------------
-- Table structure for tbl_tipo_afectacion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_afectacion`;
CREATE TABLE `tbl_tipo_afectacion` (
  `id_tipo_afectacion` int(5) NOT NULL,
  `descripcion_tipo_afectacion` char(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_tipo_afectacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_tipo_afectacion
-- ----------------------------
INSERT INTO `tbl_tipo_afectacion` VALUES ('10', 'GRAVADO - OPERACION ONEROSA');
INSERT INTO `tbl_tipo_afectacion` VALUES ('11', 'GRAVADO - RETIRO POR PREMIO');
INSERT INTO `tbl_tipo_afectacion` VALUES ('17', 'GRAVADO - IVAP');
INSERT INTO `tbl_tipo_afectacion` VALUES ('20', 'EXONERADO - OPERACION ONEROSA');
INSERT INTO `tbl_tipo_afectacion` VALUES ('30', 'INAFECTO - OPERACION ONEROSA');
INSERT INTO `tbl_tipo_afectacion` VALUES ('40', 'EXPORTACION');

-- ----------------------------
-- Table structure for tbl_tipo_cpe
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_cpe`;
CREATE TABLE `tbl_tipo_cpe` (
  `id_cpe` int(5) NOT NULL AUTO_INCREMENT,
  `codigo_cpe` char(2) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre_cpe` char(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fe_cpe` char(1) COLLATE utf8_spanish_ci DEFAULT '0',
  PRIMARY KEY (`id_cpe`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_tipo_cpe
-- ----------------------------
INSERT INTO `tbl_tipo_cpe` VALUES ('1', '01', 'FACTURA', '1');
INSERT INTO `tbl_tipo_cpe` VALUES ('2', '03', 'BOLETA DE VENTA', '1');
INSERT INTO `tbl_tipo_cpe` VALUES ('3', '07', 'NOTA DE CREDITO', '1');
INSERT INTO `tbl_tipo_cpe` VALUES ('4', '08', 'NOTA DE DEBITO', '1');
INSERT INTO `tbl_tipo_cpe` VALUES ('5', '09', 'GUIA DE REMISION', '0');
INSERT INTO `tbl_tipo_cpe` VALUES ('6', '12', 'TICKET DE MAQUINA REGISTRADORA', '0');
INSERT INTO `tbl_tipo_cpe` VALUES ('7', '13', 'DOCUMENTO EMITIDO POR LOS BANCOS', '0');
INSERT INTO `tbl_tipo_cpe` VALUES ('8', '14', 'RECIBO DE SERVICIOS PUBLICOS', '0');
INSERT INTO `tbl_tipo_cpe` VALUES ('9', '99', 'NOTA DE VENTA', '1');

-- ----------------------------
-- Table structure for tbl_tipo_tributo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_tributo`;
CREATE TABLE `tbl_tipo_tributo` (
  `id_tipo_tributo` int(5) NOT NULL AUTO_INCREMENT,
  `codigo_tipo_tributo` char(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  `decripcion_tributo` char(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre_codigo` char(3) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_tipo_tributo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_tipo_tributo
-- ----------------------------
INSERT INTO `tbl_tipo_tributo` VALUES ('1', '1000', 'IGV IMPUESTO GENERAL A LAS VENTAS', 'VAT');
INSERT INTO `tbl_tipo_tributo` VALUES ('2', '2000', 'ISC IMPUESTO SELECTIVO AL CONSUMO', 'EXC');
INSERT INTO `tbl_tipo_tributo` VALUES ('3', '9995', 'EXPORTACION', 'FRE');
INSERT INTO `tbl_tipo_tributo` VALUES ('4', '9996', 'GRATUITO', 'FRE');
INSERT INTO `tbl_tipo_tributo` VALUES ('5', '9997', 'EXONERADO', 'VAT');
INSERT INTO `tbl_tipo_tributo` VALUES ('6', '9998', 'INAFECTO', 'FRE');
INSERT INTO `tbl_tipo_tributo` VALUES ('7', '9999', 'OTROS CONCEPTOS DE PAGO', 'OTH');

-- ----------------------------
-- Table structure for tbl_unidad
-- ----------------------------
DROP TABLE IF EXISTS `tbl_unidad`;
CREATE TABLE `tbl_unidad` (
  `id_unidad` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_unidad` char(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_unidad` char(3) COLLATE utf8_spanish_ci DEFAULT NULL,
  `factor` decimal(10,2) DEFAULT NULL,
  `estado` char(1) COLLATE utf8_spanish_ci DEFAULT '1',
  PRIMARY KEY (`id_unidad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_unidad
-- ----------------------------
INSERT INTO `tbl_unidad` VALUES ('1', 'UNIDAD X3', 'NIU', '3.00', '0');
INSERT INTO `tbl_unidad` VALUES ('2', 'PAQUETE X3', 'PQT', '3.00', '1');
INSERT INTO `tbl_unidad` VALUES ('3', 'CAJA X 4', 'CAJ', '4.00', '1');
INSERT INTO `tbl_unidad` VALUES ('4', 'DEMO X3.5', 'NIU', '3.50', '1');
INSERT INTO `tbl_unidad` VALUES ('5', 'CAJA X 4', 'CAJ', '4.00', '1');

-- ----------------------------
-- Table structure for tbl_usuarios
-- ----------------------------
DROP TABLE IF EXISTS `tbl_usuarios`;
CREATE TABLE `tbl_usuarios` (
  `id_usuario` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` char(8) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `clave_usuario` char(255) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `id_personal` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records of tbl_usuarios
-- ----------------------------
INSERT INTO `tbl_usuarios` VALUES ('1', 'JUAN', 'SEBAS', '1');

-- ----------------------------
-- View structure for vw_tbl_articulo
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_articulo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tbl_articulo` AS select `a`.`id_articulo` AS `codigo`,`a`.`nombre_articulo` AS `nombre`,`a`.`descripcion_articulo` AS `descripcion`,`c`.`nombre_categoria` AS `categoria`,`m`.`nombre_marca` AS `marca`,`u`.`codigo_unidad` AS `unidad`,`a`.`precio_compra` AS `precio_compra`,`a`.`precio_venta` AS `precio_venta`,`f`.`descripcion_tipo_afectacion` AS `afectacion`,if((`a`.`estado` = '1'),'ACTIVO','INACTIVO') AS `estado` from ((((`tbl_articulo` `a` left join `tbl_categorias` `c` on((`a`.`categoria` = `c`.`id_categoria`))) left join `tbl_marcas` `m` on((`a`.`marca` = `m`.`id_marca`))) left join `tbl_unidad` `u` on((`a`.`unidad` = `u`.`id_unidad`))) left join `tbl_tipo_afectacion` `f` on((`a`.`afectacion` = `f`.`id_tipo_afectacion`))) ;

-- ----------------------------
-- View structure for vw_tbl_categorias
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_categorias`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tbl_categorias` AS select `tbl_categorias`.`id_categoria` AS `codigo`,`tbl_categorias`.`nombre_categoria` AS `nombre`,if((`tbl_categorias`.`estado` = '1'),'ACTIVO','INACTIVO') AS `estado` from `tbl_categorias` ;

-- ----------------------------
-- View structure for vw_tbl_compras_cab
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_compras_cab`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tbl_compras_cab` AS select `cc`.`id_compra` AS `codigo`,`cc`.`fecha_compra` AS `fecha_compra`,`p`.`nombre_persona` AS `razon_social`,`p`.`num_doc` AS `ruc`,concat(`cc`.`tipo_doc`,'-',`cc`.`serie_doc`,'-',`cc`.`numero_doc`) AS `documento`,`cc`.`op_gravadas` AS `sub_total`,`cc`.`op_igv` AS `igv`,`cc`.`total_compra` AS `total_compra`,if((`cc`.`estado` = '1'),'ACTIVO','INACTIVO') AS `estado` from ((`tbl_compras_cab` `cc` left join `tbl_persona` `p` on((`cc`.`persona` = `p`.`id_persona`))) left join `tbl_tipo_cpe` `tc` on((`cc`.`tipo_doc` = `tc`.`codigo_cpe`))) ;

-- ----------------------------
-- View structure for vw_tbl_marcas
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_marcas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tbl_marcas` AS select `tbl_marcas`.`id_marca` AS `codigo`,`tbl_marcas`.`nombre_marca` AS `nombre`,if((`tbl_marcas`.`estado` = '1'),'ACTIVO','INACTIVO') AS `estado` from `tbl_marcas` ;

-- ----------------------------
-- View structure for vw_tbl_unidad
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_unidad`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tbl_unidad` AS select `tbl_unidad`.`id_unidad` AS `id_unidad`,`tbl_unidad`.`nombre_unidad` AS `nombre_unidad`,`tbl_unidad`.`codigo_unidad` AS `codigo_unidad`,`tbl_unidad`.`factor` AS `factor`,if((`tbl_unidad`.`estado` = '1'),'ACTIVO','INACTIVO') AS `estado` from `tbl_unidad` ;

-- ----------------------------
-- View structure for vw_tbl_usuario
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_usuario`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tbl_usuario` AS select `u`.`nombre_usuario` AS `usuario`,`u`.`clave_usuario` AS `clave`,`p`.`id_personal` AS `cod_personal`,concat(`p`.`nombre_personal`,' ',`p`.`apellido_personal`) AS `personal` from (`tbl_usuarios` `u` join `tbl_personal` `p` on((`u`.`id_personal` = `p`.`id_personal`))) ;
