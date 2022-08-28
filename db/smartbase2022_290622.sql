/*
 Navicat Premium Data Transfer

 Source Server         : facturalo
 Source Server Type    : MySQL
 Source Server Version : 50560
 Source Host           : localhost:3306
 Source Schema         : smartbase2022

 Target Server Type    : MySQL
 Target Server Version : 50560
 File Encoding         : 65001

 Date: 29/06/2022 17:21:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_almacen
-- ----------------------------
DROP TABLE IF EXISTS `tbl_almacen`;
CREATE TABLE `tbl_almacen`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(30) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `direccion` char(60) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `empresa` int(5) NOT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_almacen
-- ----------------------------
INSERT INTO `tbl_almacen` VALUES (8, 'ALMACEN PRINCIPAL', 'AV. JOSE PARDO NRO. 121 LIMA LIMA MIRAFLORES', 1, '1');

-- ----------------------------
-- Table structure for tbl_categorias
-- ----------------------------
DROP TABLE IF EXISTS `tbl_categorias`;
CREATE TABLE `tbl_categorias`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  `empresa` int(5) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_categorias
-- ----------------------------
INSERT INTO `tbl_categorias` VALUES (2, 'CHOCOLATES', '0', 1);
INSERT INTO `tbl_categorias` VALUES (3, 'GASESOSAS', '1', 1);

-- ----------------------------
-- Table structure for tbl_clase_cuenta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clase_cuenta`;
CREATE TABLE `tbl_clase_cuenta`  (
  `codigo` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `descripcion` char(30) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_clase_cuenta
-- ----------------------------
INSERT INTO `tbl_clase_cuenta` VALUES ('01', 'INVENTARIO');
INSERT INTO `tbl_clase_cuenta` VALUES ('02', 'MAYOR');
INSERT INTO `tbl_clase_cuenta` VALUES ('03', 'FUNCION');
INSERT INTO `tbl_clase_cuenta` VALUES ('04', 'NATURALEZA');
INSERT INTO `tbl_clase_cuenta` VALUES ('05', 'FUNCION Y NATURALEZA');

-- ----------------------------
-- Table structure for tbl_compra_cab
-- ----------------------------
DROP TABLE IF EXISTS `tbl_compra_cab`;
CREATE TABLE `tbl_compra_cab`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempresa` int(5) NULL DEFAULT NULL,
  `tipocomp` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serie` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `correlativo` int(8) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `fecha_emision` date NULL DEFAULT NULL,
  `fecha_vencimiento` date NULL DEFAULT NULL,
  `orden_compra` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `condicion_venta` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cuotas_credito` int(5) NULL DEFAULT 0,
  `codmoneda` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'PEN',
  `op_gravadas` decimal(11, 5) NULL DEFAULT NULL,
  `op_exoneradas` decimal(11, 5) NULL DEFAULT NULL,
  `op_inafectas` decimal(11, 5) NULL DEFAULT NULL,
  `igv` decimal(11, 5) NULL DEFAULT NULL,
  `total` decimal(11, 5) NULL DEFAULT NULL,
  `codcliente` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `feestado` int(1) NOT NULL DEFAULT 0,
  `fecodigoerror` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `femensajesunat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `nombrexml` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `xmlbase64` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cdrbase64` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `hash` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `tipocomp_ref` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serie_ref` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `correlativo_ref` int(8) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `cod_motivo` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `des_motivo` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '1',
  `vendedor` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tipcomp`(`tipocomp`) USING BTREE,
  INDEX `fk_moneda`(`codmoneda`) USING BTREE,
  INDEX `fk_cliente`(`codcliente`) USING BTREE,
  INDEX `fk_emisor`(`idempresa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_compra_cab
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_compra_det
-- ----------------------------
DROP TABLE IF EXISTS `tbl_compra_det`;
CREATE TABLE `tbl_compra_det`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idventa` int(11) NULL DEFAULT NULL,
  `item` int(11) NULL DEFAULT NULL,
  `idproducto` int(11) NULL DEFAULT NULL,
  `cantidad` decimal(11, 2) NULL DEFAULT NULL,
  `valor_unitario` decimal(11, 5) NULL DEFAULT NULL,
  `precio_unitario` decimal(11, 5) NULL DEFAULT NULL,
  `igv` decimal(11, 5) NULL DEFAULT NULL,
  `porcentaje_igv` decimal(11, 2) NULL DEFAULT NULL,
  `valor_total` decimal(11, 5) NULL DEFAULT NULL,
  `importe_total` decimal(11, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_venta`(`idventa`) USING BTREE,
  INDEX `fk_producto`(`idproducto`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_compra_det
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_contribuyente
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contribuyente`;
CREATE TABLE `tbl_contribuyente`  (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_persona` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `direccion_persona` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `distrito` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `provincia` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `departamento` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `tipo_doc` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `num_doc` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `correo` char(60) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '',
  `empresa` int(5) NOT NULL,
  `servidor_cpe` varchar(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `envio_automatico` varchar(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `envio_resumen` varchar(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `clave` char(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_persona`) USING BTREE,
  INDEX `ruc`(`num_doc`) USING BTREE,
  INDEX `fk_contribuyente_empresa`(`empresa`) USING BTREE,
  CONSTRAINT `fk_contribuyente_empresa` FOREIGN KEY (`empresa`) REFERENCES `tbl_empresas` (`id_empresa`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_contribuyente
-- ----------------------------
INSERT INTO `tbl_contribuyente` VALUES (44, 'CLIENTE FINAL', 'TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '0', '99999999', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'ef775988943825d2871e1cfa75473ec0');
INSERT INTO `tbl_contribuyente` VALUES (45, 'VALVERDE CASTILLO JUAN MIGUEL', '-', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '1', '44168916', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'b6c1cb9bed46384ac9e1dbd30239522b');
INSERT INTO `tbl_contribuyente` VALUES (46, 'PENTARAMA INVESTMENT S.A.', 'JR. ALFONSO UGARTE NRO. 1360 URB. LOS JARDINES SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20494168651', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'd91462f76215d3335cf07e8ce32eee38');
INSERT INTO `tbl_contribuyente` VALUES (47, 'GRUPO SELVA S.A.C.', 'JR. TAHUANTINSUYO NRO. 330 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20531420285', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '5a6f1dfd0227b83ce2ee3afea184324f');
INSERT INTO `tbl_contribuyente` VALUES (48, 'CENTRO ESTETICO INTERNACIONAL LARIOS S.A.C', 'JR. JOSE OLAYA NRO. 510 DPTO. 201 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20450315941', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '09ae1f461d3145f0506f575cfe949383');
INSERT INTO `tbl_contribuyente` VALUES (49, 'ECO CLEAN EMPRESA INDIVIDUAL DE RESPONSABILIDAD LIMITADA', 'AV. CIRCUNVALACION NRO. 2128 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20600680570', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'a9382c05af19d387cb7b302602c2f71a');
INSERT INTO `tbl_contribuyente` VALUES (50, 'LA FINCA REGIONAL S.A.C.', 'JR. ALFONSO UGARTE NRO. C9 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20607393711', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '197f4b3cbf407418224d47a079a1fa4a');
INSERT INTO `tbl_contribuyente` VALUES (51, 'CARDENAS SILVA MARIA MARCELINA', 'JR MAYNAS 171', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '10008415981', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'd1309d742085f59641e502838949ebcc');
INSERT INTO `tbl_contribuyente` VALUES (52, 'TAYTAMAKI CERRO ESCALERA SOCIEDAD ANONIMA CERRADA', 'JR. SAN PABLO DE LA CRUZ NRO. 248 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20606500662', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '731ef89ffae12fdbe41d755fff81c041');
INSERT INTO `tbl_contribuyente` VALUES (53, 'ACADEMIAS PREPA S.A.C.', 'JR. PROGRESO NRO. 174 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20450409414', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '69f3adcbacb0bd32e71094b5d3fbc9a6');
INSERT INTO `tbl_contribuyente` VALUES (54, 'COLUGNA TANANTA PALOMA CELESTE', 'JR MIGUEL GRAU 1023', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '10404317780', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '9c7e18334af5ae9a2f9617a9e9d8017d');
INSERT INTO `tbl_contribuyente` VALUES (55, 'CORPORACION YANIS SERVICE S.A.C.', 'JR. JORGE CHAVEZ NRO. 1002 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20608860909', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '2acadcb6b3c0c56ba2005f37244d71fa');
INSERT INTO `tbl_contribuyente` VALUES (56, 'COOPERATIVA AGROINDUSTRIAL DEL PALMITO APROPAL LTDA.', 'AV. LA MARGINAL NRO. 177 BAR. SAN MARTIN -CPM.ALIANZA SAN MARTIN LAMAS CAYNARACHI', 'CAYNARACHI', 'LAMAS', 'SAN MARTIN', '6', '20450105113', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'c4d22153665238d195607a25e8ca19b9');
INSERT INTO `tbl_contribuyente` VALUES (57, 'COOPERATIVA DE SERVICIOS MULTIPLES CULTURAL IMPORT LIMITADA', 'CAL. ATLANTIDA NRO. 1019 LORETO MAYNAS IQUITOS', 'IQUITOS', 'MAYNAS', 'LORETO', '6', '20600258991', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '96c20b5f340fb13a8c0051bc81337cf5');
INSERT INTO `tbl_contribuyente` VALUES (58, 'ABAD POZO LUIS ALBERTO', 'JR ULISES REATEGUI 178', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '10094505017', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '95c714af832926aec19c42e9889f80c4');
INSERT INTO `tbl_contribuyente` VALUES (59, 'RAMIREZ FLORES LINA AMALIA', 'JR LOS PINOS 653', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '10010780956', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'b514d4169365746a508d8b286367ec66');
INSERT INTO `tbl_contribuyente` VALUES (60, 'EMERGTICS S.A.C.', 'JR LOS ALAMOS CDRA. 3 LT 9 SECTOR SANANGUILLO', 'LA BANDA DE SHILCAYO', 'SAN MARTIN', 'SAN MARTIN', '6', '20600528263', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'be63f1bedcf1a068adb65319632b16e1');
INSERT INTO `tbl_contribuyente` VALUES (61, 'MOTORS SHOW TARAPOTO S.A.C.', 'JR. JIMENEZ PIMENTEL NRO. 1245 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20450435920', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '17e8775946896e8ef60053279f0391cf');
INSERT INTO `tbl_contribuyente` VALUES (62, 'PENTARAMA INVERSIONES TURISTICAS S.A', 'JR. ALFONSO UGARTE NRO. 1360 URB. LOS JARDINES SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20494191637', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '065cdc41b322e195616aa998c4ae56aa');
INSERT INTO `tbl_contribuyente` VALUES (63, 'BUSINESS BEA-FLOWER SOCIEDAD ANONIMA CERRADA - BUSINESS BEA-FLOWER S.A.C.', 'JR. ALONSO DE ALVARADO NRO. 284 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20600108892', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'c1e9d13fe9401f3ff37c3d01b5611a0a');
INSERT INTO `tbl_contribuyente` VALUES (64, 'CORPORACION CAYMAN S.A.C.', 'JR. JIMENEZ PIMENTEL NRO. 822', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20493190611', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '0241af47589d1fbb27700aeec6c9c510');
INSERT INTO `tbl_contribuyente` VALUES (65, 'MOREY REATEGUI VIOLETA', 'JR RAMON CASTILLA 546', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '1', '01117739', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'd37287c8353d4c4dd78fdf3a6f1ce98e');
INSERT INTO `tbl_contribuyente` VALUES (66, 'TERRONES DIAZ MERCEDES DEL CARMEN', '-', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '1', '01117210', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '4a62eae239ffea7167f77a81fc05f551');
INSERT INTO `tbl_contribuyente` VALUES (67, 'CAJA MUNICIPAL DE AHORRO Y CREDITO DE PAITA S.A.', 'JR. PLAZA DE ARMAS NRO. 176 INT. 178 RES. CENTRO DE LA CIUDAD PIURA PAITA PAITA', 'PAITA', 'PAITA', 'PIURA', '6', '20102361939', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'd5c1edd70fabd1f628a4cb78fccaf1c1');
INSERT INTO `tbl_contribuyente` VALUES (68, 'HOSTAL SANTA MÓNICA E.I.R.L.', 'JR. ALFONSO UGARTE NRO. 566 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20602902821', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '00d289874a6ce285fb00f86175046ccf');
INSERT INTO `tbl_contribuyente` VALUES (69, 'CORPORACION HOTELERA DEL ORIENTE S.A.C.', 'JR. MOYOBAMBA NRO. 173 SAN MARTIN SAN MARTIN TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '20404344707', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '185de7686b5520f6c77a9ef16f45a3c4');
INSERT INTO `tbl_contribuyente` VALUES (70, 'GRUPO EMPRESARIAL MARCORP S.A.C.', 'AV. PERU NRO. 581 SAN MARTIN SAN MARTIN MORALES', 'MORALES', 'SAN MARTIN', 'SAN MARTIN', '6', '20606084456', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '503869e7eac4e1fc4334ac01ad49665a');
INSERT INTO `tbl_contribuyente` VALUES (71, 'DIAZ TARRILLO IRVING ALEXIS', 'JR.MANCO CAPAC  472  TARAPOTO', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '6', '10762972218', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'ce20d9827c00924500679516d387c87f');
INSERT INTO `tbl_contribuyente` VALUES (72, 'DELUXE TARAPOTO S.A.C.', 'CAR. FERNANDO BELAUNDE TERRY KM. 5.5 SAN MARTIN SAN MARTIN MORALES', 'MORALES', 'SAN MARTIN', 'SAN MARTIN', '6', '20600716167', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, '1cf4c8f380cd79fc30c1590fb6c2801f');

-- ----------------------------
-- Table structure for tbl_cta_cobrar
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cta_cobrar`;
CREATE TABLE `tbl_cta_cobrar`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `tipo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `persona` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `tipo_doc` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `ser_doc` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `num_doc` char(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `monto` decimal(10, 5) NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT NULL,
  `forma_pago` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `empresa` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 497 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_cta_cobrar
-- ----------------------------
INSERT INTO `tbl_cta_cobrar` VALUES (114, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (115, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (116, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (117, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (118, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (119, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (120, '1', '20548960771', '01', 'F001', '00000001', 2.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (121, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (122, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (123, '1', '20548960771', '01', 'F001', '00000001', 3.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (124, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (125, '1', '20548960771', '01', 'F001', '00000001', 1.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (126, '1', '20548960771', '01', 'F001', '00000001', 1.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (127, '2', '20548960771', '07', 'FC01', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (128, '2', '20548960771', '07', 'FC01', '00000002', 20.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (129, '1', '20548960771', '03', 'B001', '00000001', 40.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (130, '1', '20494168651', '01', 'F001', '00000002', 15.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (131, '1', '20548960771', '01', 'F001', '00000003', 100.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (132, '1', '20548960771', '01', 'F001', '00000004', 10.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (133, '1', '20494168651', '01', 'F001', '00000005', 20.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (134, '1', '20548960771', '01', 'F001', '00000006', 20.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (135, '1', '20548960771', '01', 'F001', '00000007', 20.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (136, '1', '20548961158', '01', 'F001', '00000008', 25.00000, '2022-01-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (137, '1', '20603446748', '01', 'F001', '00000009', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (138, '1', '20603446748', '01', 'F001', '00000009', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (139, '1', '20603446748', '01', 'F001', '00000009', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (140, '1', '20603446748', '01', 'F001', '00000009', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (141, '1', '20603446748', '01', 'F001', '00000009', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (142, '1', '20603446748', '01', 'F001', '00000009', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (143, '1', '20603446748', '01', 'F001', '00000009', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (144, '1', '20603446748', '01', 'F001', '00000010', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (145, '1', '20603446748', '01', 'F001', '00000011', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (146, '1', '20603446748', '01', 'F001', '00000012', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (147, '1', '20603446748', '01', 'F001', '00000013', 1.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (148, '1', '20603446748', '01', 'F001', '00000014', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (149, '1', '20603446748', '01', 'F001', '00000015', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (150, '1', '20603446748', '01', 'F001', '00000016', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (151, '1', '20603446748', '01', 'F001', '00000017', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (152, '1', '20603446748', '01', 'F001', '00000017', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (153, '1', '20603446748', '01', 'F001', '00000018', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (154, '1', '20603446748', '01', 'F001', '00000019', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (155, '1', '20603446748', '01', 'F001', '00000020', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (156, '1', '20603446748', '01', 'F001', '00000021', 20.00000, '2022-01-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (157, '1', '20603446748', '01', 'F001', '00000022', 20.00000, '2022-01-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (158, '1', '20603446748', '01', 'F001', '00000023', 20.00000, '2022-01-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (159, '2', '20603446748', '07', 'FC01', '00000003', 20.00000, '2022-01-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (160, '1', '20548960771', '01', 'F001', '00000024', 200.00000, '2022-01-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (161, '1', '20548960771', '01', 'F001', '00000025', 20.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (162, '1', '20548960771', '01', 'F001', '00000026', 100.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (163, '1', '20548960771', '01', 'F001', '00000027', 100.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (164, '1', '20548960771', '01', 'F001', '00000028', 100.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (165, '1', '20548960771', '01', 'F001', '00000029', 100.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (166, '1', '20548960771', '01', 'F001', '00000030', 100.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (167, '1', '20548960771', '01', 'F001', '00000031', 100.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (168, '1', '44168916', '03', 'B001', '00000002', 20.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (169, '1', '44168916', '03', 'B001', '00000002', 20.00000, '2022-01-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (170, '1', '20548960771', '01', 'F001', '00000032', 21.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (171, '1', '20494168651', '01', 'F001', '00000033', 21.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (172, '1', '20548960771', '01', 'F001', '00000034', 21.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (173, '1', '20494168651', '01', 'F001', '00000035', 20.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (174, '1', '20548960771', '01', 'F001', '00000036', 1.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (175, '1', '20548960771', '01', 'F001', '00000037', 21.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (176, '1', '20494168651', '01', 'F001', '00000038', 21.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (177, '2', '20603446748', '07', 'FC01', '00000004', 20.00000, '2022-01-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (178, '2', '20603446748', '07', 'FC01', '00000005', 1.00000, '2022-02-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (179, '2', '20603446748', '07', 'FC01', '00000006', 1.00000, '2022-02-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (180, '2', '20603446748', '07', 'FC01', '00000007', 1.00000, '2022-02-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (181, '2', '20603446748', '07', 'FC01', '00000008', 1.00000, '2022-02-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (182, '1', '20494168651', '01', 'F001', '00000039', 4.00000, '2022-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (183, '1', '20494168651', '03', 'B001', '00000003', 23.00000, '2022-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (184, '1', '20494168651', '03', 'B001', '00000004', 41.00000, '2022-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (185, '1', '20494168651', '01', 'B001', '00000005', 100.00000, '2022-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (186, '1', '20494168651', '01', 'F001', '00000040', 100.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (187, '1', '20548960771', '01', 'F001', '00000041', 10.50000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (188, '1', '20494168651', '01', 'F001', '00000042', 40.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (189, '1', '20548960771', '01', 'F001', '00000043', 40.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (190, '1', '44168916', '01', 'F001', '00000044', 2.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (191, '1', '20494168651', '01', 'B001', '00000006', 38.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (192, '1', '20494168651', '01', 'F001', '00000045', 20.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (193, '1', '20494168651', '01', 'F001', '00000046', 20.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (194, '1', '44168916', '03', 'B001', '00000007', 20.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (195, '1', '44168916', '03', 'B001', '00000008', 1.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (196, '1', '44168916', '03', 'B001', '00000009', 1.90000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (197, '1', '44168916', '01', 'F001', '00000047', 1.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (198, '1', '44168916', '01', 'F001', '00000047', 1.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (199, '1', '44168916', '03', 'B001', '00000010', 1.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (200, '1', '44168916', '03', 'B001', '00000011', 20.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (201, '1', '44168916', '03', 'B001', '00000011', 20.00000, '2022-03-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (202, '1', '20603446748', '01', 'F001', '00000048', 1.90000, '2022-03-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (203, '1', '20494168651', '01', 'F001', '00000049', 40.00000, '2022-03-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (204, '1', '20494168651', '01', 'F001', '00000050', 13.20000, '2022-03-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (205, '1', '20494168651', '01', 'F001', '00000001', 1.00000, '2022-04-01', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (206, '2', '20494168651', '07', 'FC01', '00000001', 1.00000, '2022-04-01', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (207, '1', '20531420285', '01', 'F001', '00000002', 111.00000, '2022-04-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (208, '1', '20450315941', '01', 'F001', '00000003', 24.00000, '2022-04-09', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (209, '1', '20600680570', '01', 'F001', '00000004', 70.00000, '2022-04-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (210, '1', '20531420285', '01', 'F001', '00000005', 136.00000, '2022-04-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (211, '1', '20531420285', '01', 'F001', '00000005', 136.00000, '2022-04-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (212, '1', '20531420285', '01', 'F001', '00000006', 118.00000, '2022-04-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (213, '1', '20607393711', '01', 'F001', '00000007', 82.00000, '2022-04-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (214, '2', '20531420285', '07', 'FC01', '00000002', 136.00000, '2022-04-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (215, '1', '10008415981', '01', 'F001', '00000008', 60.90000, '2022-04-19', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (216, '1', '20606500662', '01', 'F001', '00000009', 36.00000, '2022-04-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (217, '1', '20450409414', '01', 'F001', '00000010', 57.96000, '2022-04-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (218, '1', '10404317780', '01', 'F001', '00000011', 68.58000, '2022-04-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (219, '1', '20608860909', '01', 'F001', '00000012', 88.05000, '2022-04-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (220, '2', '20608860909', '07', 'FC01', '00000003', 88.05000, '2022-04-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (221, '1', '20608860909', '01', 'F001', '00000013', 88.00000, '2022-04-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (222, '1', '20531420285', '01', 'F001', '00000014', 93.00000, '2022-04-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (223, '1', '20450105113', '01', 'F001', '00000015', 377.25000, '2022-04-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (224, '1', '20600258991', '01', 'F001', '00000016', 1091.75000, '2022-05-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (225, '1', '10094505017', '01', 'F001', '00000017', 38.50000, '2022-05-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (226, '1', '10010780956', '01', 'F001', '00000018', 123.00000, '2022-05-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (227, '1', '20600680570', '01', 'F001', '00000019', 47.00000, '2022-05-12', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (228, '1', '20600528263', '01', 'F001', '00000020', 76.00000, '2022-05-12', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (229, '1', '20531420285', '01', 'F001', '00000021', 136.00000, '2022-05-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (230, '1', '20450435920', '01', 'F001', '00000022', 75.97000, '2022-05-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (231, '1', '10010780956', '01', 'F001', '00000023', 58.00000, '2022-05-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (232, '1', '99999999', '03', 'B001', '00000001', 14.00000, '2022-06-02', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (233, '1', '99999999', '03', 'B001', '00000002', 15.50000, '2022-06-02', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (234, '1', '99999999', '03', 'B002', '00000001', 54.00000, '2022-06-02', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (235, '1', '99999999', '01', 'F001', '00000024', 4.50000, '2022-06-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (236, '1', '99999999', '03', 'B001', '00000003', 16.00000, '2022-06-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (237, '1', '99999999', '03', 'B001', '00000004', 237.00000, '2022-06-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (238, '2', '99999999', '07', 'FC01', '00000004', 4.50000, '2022-06-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (239, '1', '20531420285', '01', 'F001', '00000025', 77.00000, '2022-06-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (240, '1', '99999999', '03', 'B001', '00000005', 178.00000, '2022-06-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (241, '1', '99999999', '03', 'B001', '00000006', 68.30000, '2022-06-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (242, '1', '99999999', '03', 'B001', '00000007', 3.20000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (243, '1', '99999999', '03', 'B001', '00000008', 4.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (244, '1', '10010780956', '01', 'F001', '00000026', 24.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (245, '1', '99999999', '03', 'B001', '00000009', 8.80000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (246, '1', '99999999', '03', 'B001', '00000010', 31.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (247, '1', '20600108892', '01', 'F001', '00000027', 141.59000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (248, '1', '99999999', '03', 'B001', '00000011', 37.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (249, '1', '99999999', '03', 'B001', '00000012', 5.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (250, '1', '99999999', '03', 'B001', '00000013', 2.70000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (251, '1', '99999999', '03', 'B001', '00000014', 30.98000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (252, '1', '99999999', '03', 'B001', '00000015', 6.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (253, '1', '99999999', '03', 'B001', '00000016', 4.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (254, '1', '99999999', '03', 'B001', '00000017', 2.80000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (255, '1', '99999999', '03', 'B001', '00000018', 76.00000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (256, '1', '99999999', '03', 'B001', '00000019', 248.50000, '2022-06-04', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (257, '1', '99999999', '03', 'B001', '00000020', 95.00000, '2022-06-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (258, '1', '99999999', '03', 'B001', '00000021', 15.00000, '2022-06-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (259, '1', '99999999', '03', 'B001', '00000022', 15.52000, '2022-06-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (260, '1', '99999999', '03', 'B002', '00000002', 49.00000, '2022-06-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (261, '1', '99999999', '03', 'B002', '00000003', 54.50000, '2022-06-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (262, '1', '99999999', '03', 'B002', '00000004', 32.00000, '2022-06-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (263, '1', '99999999', '03', 'B002', '00000005', 53.28000, '2022-06-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (264, '1', '99999999', '03', 'B001', '00000023', 24.30000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (265, '1', '99999999', '03', 'B001', '00000024', 152.50000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (266, '1', '99999999', '03', 'B001', '00000025', 10.95000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (267, '1', '99999999', '03', 'B001', '00000026', 32.50000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (268, '1', '99999999', '03', 'B001', '00000027', 41.19000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (269, '1', '20600108892', '01', 'F001', '00000028', 29.00000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (270, '1', '99999999', '03', 'B002', '00000006', 32.00000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (271, '1', '99999999', '03', 'B002', '00000007', 211.00000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (272, '1', '99999999', '03', 'B002', '00000008', 362.54000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (273, '1', '99999999', '03', 'B002', '00000009', 345.00000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (274, '1', '99999999', '03', 'B002', '00000010', 22.00000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (275, '1', '99999999', '03', 'B002', '00000011', 77.10000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (276, '1', '99999999', '03', 'B002', '00000012', 31.00000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (277, '1', '99999999', '03', 'B002', '00000013', 6.40000, '2022-06-07', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (278, '1', '99999999', '03', 'B001', '00000028', 85.50000, '2022-06-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (279, '1', '20493190611', '01', 'F001', '00000029', 85.00000, '2022-06-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (280, '1', '99999999', '03', 'B001', '00000029', 35.00000, '2022-06-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (281, '1', '99999999', '03', 'B001', '00000030', 12.00000, '2022-06-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (282, '1', '99999999', '03', 'B001', '00000031', 40.50000, '2022-06-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (283, '1', '99999999', '03', 'B002', '00000014', 180.45000, '2022-06-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (284, '1', '99999999', '03', 'B002', '00000015', 73.97000, '2022-06-08', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (285, '1', '99999999', '03', 'B002', '00000016', 24.30000, '2022-06-09', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (286, '1', '99999999', '03', 'B002', '00000017', 27.50000, '2022-06-09', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (287, '1', '99999999', '03', 'B002', '00000018', 22.00000, '2022-06-09', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (288, '1', '99999999', '03', 'B002', '00000019', 17.50000, '2022-06-09', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (289, '1', '01117739', '03', 'B001', '00000032', 246.62000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (290, '1', '20531420285', '01', 'F001', '00000030', 61.00000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (291, '1', '20600680570', '01', 'F001', '00000031', 26.00000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (292, '1', '99999999', '03', 'B002', '00000020', 13.00000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (293, '1', '99999999', '03', 'B002', '00000021', 36.90000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (294, '1', '99999999', '03', 'B002', '00000022', 39.20000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (295, '1', '01117210', '03', 'B002', '00000023', 77.50000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (296, '1', '99999999', '03', 'B002', '00000024', 127.90000, '2022-06-10', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (297, '1', '99999999', '03', 'B001', '00000033', 31.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (298, '1', '99999999', '03', 'B001', '00000034', 16.50000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (299, '1', '99999999', '03', 'B001', '00000035', 43.50000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (300, '1', '99999999', '03', 'B001', '00000036', 10.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (301, '1', '99999999', '03', 'B001', '00000037', 31.50000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (302, '1', '99999999', '03', 'B002', '00000025', 31.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (303, '1', '99999999', '03', 'B002', '00000025', 31.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (304, '1', '99999999', '03', 'B002', '00000025', 31.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (305, '1', '99999999', '03', 'B002', '00000026', 172.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (306, '1', '99999999', '03', 'B002', '00000027', 47.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (307, '1', '99999999', '03', 'B002', '00000028', 32.50000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (308, '1', '99999999', '03', 'B002', '00000029', 21.75000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (309, '1', '99999999', '03', 'B002', '00000030', 49.00000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (310, '1', '99999999', '03', 'B002', '00000031', 210.77000, '2022-06-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (311, '1', '20102361939', '01', 'F001', '00000032', 100.00000, '2022-06-12', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (312, '1', '10010780956', '01', 'F001', '00000033', 44.00000, '2022-06-12', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (313, '1', '99999999', '03', 'B001', '00000038', 25.50000, '2022-06-12', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (314, '1', '99999999', '03', 'B001', '00000039', 31.50000, '2022-06-12', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (315, '1', '20602902821', '01', 'F001', '00000034', 92.99000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (316, '1', '20602902821', '01', 'F001', '00000035', 9.50000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (317, '1', '99999999', '03', 'B001', '00000040', 50.00000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (318, '1', '20600528263', '01', 'F001', '00000036', 76.00000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (319, '1', '99999999', '03', 'B002', '00000032', 51.50000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (320, '1', '99999999', '03', 'B002', '00000033', 83.04000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (321, '1', '99999999', '03', 'B002', '00000034', 571.90000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (322, '1', '99999999', '03', 'B002', '00000035', 109.50000, '2022-06-13', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (323, '1', '99999999', '03', 'B001', '00000041', 5.63000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (324, '1', '99999999', '03', 'B001', '00000042', 21.00000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (325, '1', '99999999', '03', 'B001', '00000043', 7.00000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (326, '1', '99999999', '03', 'B001', '00000044', 33.05000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (327, '1', '99999999', '03', 'B001', '00000045', 45.00000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (328, '1', '99999999', '03', 'B001', '00000046', 29.00000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (329, '1', '99999999', '03', 'B002', '00000036', 41.00000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (330, '1', '99999999', '03', 'B002', '00000037', 81.03000, '2022-06-14', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (331, '1', '99999999', '03', 'B001', '00000047', 12.00000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (332, '1', '99999999', '03', 'B001', '00000048', 49.20000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (333, '1', '99999999', '03', 'B001', '00000049', 42.00000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (334, '1', '99999999', '03', 'B001', '00000050', 135.75000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (335, '1', '99999999', '03', 'B001', '00000051', 14.90000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (336, '1', '99999999', '03', 'B001', '00000052', 78.00000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (337, '1', '99999999', '03', 'B001', '00000053', 28.00000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (338, '1', '99999999', '03', 'B001', '00000054', 5.50000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (339, '1', '99999999', '03', 'B001', '00000055', 3.50000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (340, '1', '99999999', '03', 'B001', '00000056', 383.47000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (341, '1', '99999999', '03', 'B001', '00000057', 51.00000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (342, '1', '99999999', '03', 'B001', '00000058', 54.00000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (343, '1', '99999999', '03', 'B002', '00000038', 53.00000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (344, '1', '99999999', '03', 'B002', '00000039', 31.50000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (345, '1', '99999999', '03', 'B002', '00000040', 28.20000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (346, '1', '99999999', '03', 'B002', '00000041', 60.17000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (347, '1', '99999999', '03', 'B002', '00000042', 21.50000, '2022-06-15', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (348, '1', '99999999', '03', 'B001', '00000059', 17.00000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (349, '1', '99999999', '03', 'B001', '00000060', 41.00000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (350, '1', '99999999', '03', 'B001', '00000061', 28.50000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (351, '1', '99999999', '03', 'B001', '00000062', 48.20000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (352, '1', '99999999', '03', 'B001', '00000063', 33.00000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (353, '1', '99999999', '03', 'B001', '00000064', 15.50000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (354, '1', '99999999', '03', 'B001', '00000065', 28.50000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (355, '1', '99999999', '03', 'B001', '00000066', 22.00000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (356, '1', '99999999', '03', 'B002', '00000043', 22.30000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (357, '1', '99999999', '03', 'B002', '00000044', 29.45000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (358, '1', '99999999', '03', 'B002', '00000045', 84.50000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (359, '1', '99999999', '03', 'B002', '00000046', 75.12000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (360, '1', '99999999', '03', 'B002', '00000047', 31.00000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (361, '1', '99999999', '03', 'B002', '00000048', 112.00000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (362, '1', '99999999', '03', 'B002', '00000049', 20.00000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (363, '1', '99999999', '03', 'B002', '00000050', 13.63000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (364, '1', '99999999', '03', 'B001', '00000067', 58.50000, '2022-06-16', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (365, '1', '99999999', '03', 'B001', '00000068', 20.50000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (366, '1', '99999999', '03', 'B001', '00000069', 28.60000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (367, '1', '99999999', '03', 'B001', '00000070', 20.00000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (368, '1', '20531420285', '01', 'F001', '00000037', 79.00000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (369, '1', '99999999', '03', 'B001', '00000071', 72.50000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (370, '1', '99999999', '03', 'B001', '00000072', 50.30000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (371, '1', '99999999', '03', 'B001', '00000073', 9.00000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (372, '1', '99999999', '03', 'B001', '00000074', 8.60000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (373, '1', '99999999', '03', 'B002', '00000051', 11.72000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (374, '1', '99999999', '03', 'B002', '00000052', 6.50000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (375, '1', '99999999', '03', 'B002', '00000053', 25.30000, '2022-06-17', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (376, '1', '99999999', '03', 'B001', '00000075', 62.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (377, '1', '99999999', '03', 'B001', '00000076', 22.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (378, '1', '99999999', '03', 'B002', '00000054', 30.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (379, '1', '99999999', '03', 'B002', '00000055', 23.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (380, '1', '20404344707', '01', 'F002', '00000001', 85.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (381, '1', '99999999', '03', 'B002', '00000056', 28.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (382, '1', '99999999', '03', 'B002', '00000057', 145.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (383, '1', '99999999', '03', 'B002', '00000058', 150.25000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (384, '1', '99999999', '03', 'B002', '00000059', 55.64000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (385, '1', '99999999', '03', 'B002', '00000059', 55.64000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (386, '1', '99999999', '03', 'B002', '00000060', 9.20000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (387, '1', '99999999', '03', 'B002', '00000061', 88.00000, '2022-06-18', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (388, '1', '99999999', '03', 'B001', '00000077', 20.00000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (389, '1', '10010780956', '01', 'F001', '00000038', 34.00000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (390, '1', '99999999', '03', 'B001', '00000078', 4.30000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (391, '1', '99999999', '03', 'B001', '00000079', 308.98000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (392, '1', '99999999', '03', 'B001', '00000080', 46.85000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (393, '1', '99999999', '03', 'B002', '00000062', 29.00000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (394, '1', '99999999', '03', 'B002', '00000063', 41.75000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (395, '1', '99999999', '03', 'B002', '00000064', 21.25000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (396, '1', '99999999', '03', 'B002', '00000065', 30.70000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (397, '1', '99999999', '03', 'B002', '00000066', 24.00000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (398, '1', '99999999', '03', 'B002', '00000067', 36.75000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (399, '1', '99999999', '03', 'B002', '00000068', 30.50000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (400, '1', '99999999', '03', 'B002', '00000069', 18.41000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (401, '1', '20606084456', '01', 'F002', '00000002', 21.50000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (402, '1', '99999999', '03', 'B002', '00000070', 28.50000, '2022-06-20', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (403, '1', '99999999', '03', 'B001', '00000081', 25.50000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (404, '1', '99999999', '03', 'B002', '00000071', 31.65000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (405, '1', '99999999', '03', 'B002', '00000072', 15.50000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (406, '1', '99999999', '03', 'B002', '00000073', 45.55000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (407, '1', '99999999', '03', 'B002', '00000074', 30.41000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (408, '1', '99999999', '03', 'B002', '00000075', 28.00000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (409, '1', '99999999', '03', 'B002', '00000076', 82.50000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (410, '1', '99999999', '03', 'B002', '00000077', 34.00000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (411, '1', '99999999', '03', 'B002', '00000078', 23.80000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (412, '1', '99999999', '03', 'B002', '00000079', 83.00000, '2022-06-21', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (413, '1', '99999999', '03', 'B001', '00000082', 20.00000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (414, '1', '99999999', '03', 'B001', '00000083', 26.50000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (415, '1', '99999999', '03', 'B001', '00000084', 41.50000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (416, '1', '99999999', '03', 'B001', '00000085', 20.80000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (417, '1', '99999999', '03', 'B001', '00000086', 20.00000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (418, '1', '20600680570', '01', 'F001', '00000039', 41.50000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (419, '1', '99999999', '03', 'B001', '00000087', 150.00000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (420, '1', '99999999', '03', 'B001', '00000088', 148.20000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (421, '1', '99999999', '03', 'B002', '00000080', 75.00000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (422, '1', '99999999', '03', 'B002', '00000081', 7.50000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (423, '1', '99999999', '03', 'B002', '00000082', 82.13000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (424, '1', '99999999', '03', 'B002', '00000083', 29.30000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (425, '1', '99999999', '03', 'B002', '00000084', 23.80000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (426, '1', '99999999', '03', 'B002', '00000085', 42.00000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (427, '1', '99999999', '03', 'B002', '00000086', 23.51000, '2022-06-22', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (428, '1', '99999999', '03', 'B002', '00000087', 22.00000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (429, '1', '99999999', '03', 'B002', '00000088', 18.60000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (430, '1', '99999999', '03', 'B002', '00000089', 22.20000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (431, '1', '99999999', '03', 'B002', '00000090', 18.50000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (432, '1', '99999999', '03', 'B002', '00000091', 21.80000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (433, '1', '99999999', '03', 'B002', '00000092', 10.50000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (434, '1', '99999999', '03', 'B002', '00000093', 74.63000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (435, '1', '99999999', '03', 'B002', '00000094', 15.50000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (436, '1', '99999999', '03', 'B002', '00000095', 22.00000, '2022-06-23', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (437, '1', '20531420285', '01', 'F001', '00000040', 18.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (438, '1', '10010780956', '01', 'F001', '00000041', 36.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (439, '1', '99999999', '03', 'B001', '00000089', 48.25000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (440, '1', '99999999', '03', 'B001', '00000090', 108.01000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (441, '1', '99999999', '03', 'B001', '00000091', 268.47000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (442, '1', '99999999', '03', 'B001', '00000092', 39.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (443, '1', '99999999', '03', 'B002', '00000096', 44.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (444, '1', '99999999', '03', 'B002', '00000097', 85.40000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (445, '1', '99999999', '03', 'B002', '00000098', 27.90000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (446, '1', '99999999', '03', 'B002', '00000099', 20.60000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (447, '1', '99999999', '03', 'B002', '00000100', 76.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (448, '1', '99999999', '03', 'B002', '00000101', 14.50000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (449, '1', '99999999', '03', 'B002', '00000102', 60.50000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (450, '1', '10762972218', '01', 'F002', '00000003', 26.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (451, '1', '99999999', '03', 'B002', '00000103', 19.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (452, '1', '99999999', '03', 'B002', '00000104', 69.90000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (453, '1', '99999999', '03', 'B002', '00000105', 18.00000, '2022-06-25', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (454, '1', '99999999', '03', 'B001', '00000093', 46.00000, '2022-06-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (455, '1', '99999999', '03', 'B001', '00000094', 15.20000, '2022-06-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (456, '1', '99999999', '03', 'B001', '00000095', 132.75000, '2022-06-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (457, '1', '99999999', '03', 'B001', '00000096', 30.00000, '2022-06-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (458, '1', '99999999', '03', 'B001', '00000097', 93.40000, '2022-06-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (459, '1', '99999999', '03', 'B001', '00000098', 178.00000, '2022-06-26', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (460, '1', '99999999', '03', 'B001', '00000099', 20.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (461, '1', '99999999', '03', 'B001', '00000100', 144.50000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (462, '1', '20600716167', '01', 'F001', '00000042', 80.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (463, '1', '99999999', '03', 'B001', '00000101', 76.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (464, '1', '99999999', '03', 'B001', '00000102', 145.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (465, '1', '99999999', '03', 'B001', '00000103', 75.30000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (466, '1', '99999999', '03', 'B001', '00000104', 521.95000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (467, '1', '99999999', '03', 'B001', '00000105', 23.42000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (468, '1', '99999999', '03', 'B002', '00000106', 20.50000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (469, '1', '99999999', '03', 'B002', '00000107', 85.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (470, '1', '99999999', '03', 'B002', '00000108', 39.50000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (471, '1', '20404344707', '01', 'F002', '00000004', 46.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (472, '1', '99999999', '03', 'B002', '00000109', 32.01000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (473, '1', '99999999', '03', 'B002', '00000110', 34.20000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (474, '1', '99999999', '03', 'B002', '00000111', 53.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (475, '1', '99999999', '03', 'B002', '00000112', 34.50000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (476, '1', '99999999', '03', 'B002', '00000113', 27.00000, '2022-06-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (477, '1', '99999999', '03', 'B001', '00000106', 56.60000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (478, '1', '99999999', '03', 'B001', '00000107', 28.00000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (479, '1', '99999999', '03', 'B001', '00000108', 21.50000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (480, '1', '99999999', '03', 'B002', '00000114', 26.45000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (481, '1', '99999999', '03', 'B002', '00000115', 17.00000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (482, '1', '99999999', '03', 'B002', '00000116', 10.00000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (483, '1', '99999999', '03', 'B002', '00000117', 38.50000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (484, '1', '99999999', '03', 'B002', '00000118', 72.00000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (485, '1', '99999999', '03', 'B002', '00000119', 145.00000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (486, '1', '99999999', '03', 'B002', '00000120', 79.53000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (487, '1', '99999999', '03', 'B002', '00000121', 104.50000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (488, '1', '99999999', '03', 'B002', '00000122', 211.50000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (489, '1', '99999999', '03', 'B002', '00000123', 9.75000, '2022-06-28', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (490, '1', '99999999', '03', 'B001', '00000109', 34.50000, '2022-06-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (491, '1', '99999999', '03', 'B002', '00000124', 15.00000, '2022-06-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (492, '1', '99999999', '03', 'B002', '00000125', 94.90000, '2022-06-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (493, '1', '99999999', '03', 'B002', '00000126', 27.00000, '2022-06-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (494, '1', '99999999', '03', 'B002', '00000127', 75.00000, '2022-06-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (495, '1', '99999999', '03', 'B002', '00000128', 43.00000, '2022-06-29', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (496, '1', '99999999', '03', 'B002', '00000129', 21.00000, '2022-06-29', NULL, 1);

-- ----------------------------
-- Table structure for tbl_cta_pagar
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cta_pagar`;
CREATE TABLE `tbl_cta_pagar`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `tipo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `persona` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `tipo_doc` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `ser_doc` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `num_doc` char(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `monto` decimal(10, 5) NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT NULL,
  `forma_pago` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `empresa` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_cta_pagar
-- ----------------------------
INSERT INTO `tbl_cta_pagar` VALUES (114, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (115, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (116, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (117, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (118, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (119, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (120, '1', '20548960771', '01', 'F001', '00000001', 2.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (121, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (122, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (123, '1', '20548960771', '01', 'F001', '00000001', 3.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (124, '1', '20548960771', '01', 'F001', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (125, '1', '20548960771', '01', 'F001', '00000001', 1.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (126, '1', '20548960771', '01', 'F001', '00000001', 1.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (127, '2', '20548960771', '07', 'FC01', '00000001', 10.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (128, '2', '20548960771', '07', 'FC01', '00000002', 20.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (129, '1', '20548960771', '03', 'B001', '00000001', 40.00000, '2022-01-18', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (130, '1', '20494168651', '01', 'F001', '00000002', 15.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (131, '1', '20548960771', '01', 'F001', '00000003', 100.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (132, '1', '20548960771', '01', 'F001', '00000004', 10.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (133, '1', '20494168651', '01', 'F001', '00000005', 20.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (134, '1', '20548960771', '01', 'F001', '00000006', 20.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (135, '1', '20548960771', '01', 'F001', '00000007', 20.00000, '2022-01-19', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (136, '1', '20548960771', '01', 'F001', '123', 200.00000, '2022-01-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (137, '1', '20548960771', '01', 'F001', '123', 100.00000, '2022-01-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (138, '1', '20494168651', '01', 'F001', '2355', 100.00000, '2022-01-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (139, '1', '20494168651', '01', 'F001', '2', 60.00000, '2022-02-05', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (140, '1', '20494168651', '01', 'F001', '2345', 21.00000, '2022-03-15', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (141, '1', '20494168651', '01', 'F001', '5', 21.00000, '2022-03-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (142, '1', '20494168651', '01', 'F001', '12345', 21.00000, '2022-03-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (143, '1', '44168916', '01', 'F001', '223', 21.00000, '2022-03-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (144, '1', '20494168651', '01', 'F001', '852', 19.20000, '2022-03-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (145, '1', '20494168651', '01', 'F001', '5888', 19.20000, '2022-03-20', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (146, '1', '44168916', '01', 'FA25', '1245', 4.00000, '2022-03-27', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (147, '1', '20494168651', '01', 'F005', '545', 80.00000, '2022-03-27', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (148, '1', '20494168651', '01', 'F001', '4520', 115.00000, '2022-03-29', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (149, '1', '20548960771', '01', 'FA25', '1234566', 3.50000, '2022-03-29', NULL, 1);

-- ----------------------------
-- Table structure for tbl_documento_identidad
-- ----------------------------
DROP TABLE IF EXISTS `tbl_documento_identidad`;
CREATE TABLE `tbl_documento_identidad`  (
  `id_tdi` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descruipcion_tdi` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tdi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_documento_identidad
-- ----------------------------
INSERT INTO `tbl_documento_identidad` VALUES ('0', 'OTROS TIPOS DE DOCUMENTOS');
INSERT INTO `tbl_documento_identidad` VALUES ('1', 'DOCUMENTO NACIONAL DE IDENTIDAD (DNI)');
INSERT INTO `tbl_documento_identidad` VALUES ('4', 'CARNET DE EXTRANJERIA');
INSERT INTO `tbl_documento_identidad` VALUES ('6', 'REGISTRO ÚNICO DE CONTRIBUYENTES');
INSERT INTO `tbl_documento_identidad` VALUES ('7', 'PASAPORTE');

-- ----------------------------
-- Table structure for tbl_empresas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_empresas`;
CREATE TABLE `tbl_empresas`  (
  `id_empresa` int(5) NOT NULL AUTO_INCREMENT,
  `ruc` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `razon_social` char(150) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `direccion` char(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `distrito` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `provincia` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `departamento` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `ubigeo` char(6) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `correo` char(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `usuario_sol` char(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `clave_sol` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `certificado` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `clave_certificado` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cta_igv_venta` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cta_igv_compra` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cta_pagar_soles` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cta_pagar_dolar` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cta_cobrar_soles` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cta_cobrar_dolar` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `origen_venta` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `origen_cobranzas` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `origen_compra` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `origen_pagos` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `por_igv` decimal(10, 2) NOT NULL DEFAULT 18.00,
  `cta_detracciones` char(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `fecha_inicio` date NULL DEFAULT NULL,
  `fecha_vencimiento` date NULL DEFAULT NULL,
  `logo` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `servidor_cpe` int(1) NOT NULL DEFAULT 1,
  `envio_automatico` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT 'NO',
  `envio_resumen` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`id_empresa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_empresas
-- ----------------------------
INSERT INTO `tbl_empresas` VALUES (1, '10452424423', 'COMERCIAL MATHIAS', 'JR. TAHUANTINSUYO 367 BAR. COMERCIO', 'TARAPOTO', 'TARAPOTO', 'SAN MARTIN', '221101', 'carito131214@gmail.com', 'FACTURA1', 'A12345678a', '10452424423.pfx', 'Ajjm2123', '40111', '40111', '42121', '42122', '12121', '12122', '02', '03', '01', '04', 18.00, '12345', '2021-12-29', '2022-09-08', 'Logo.png', 1, 'SI', 'NO');

-- ----------------------------
-- Table structure for tbl_error
-- ----------------------------
DROP TABLE IF EXISTS `tbl_error`;
CREATE TABLE `tbl_error`  (
  `cod` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre` char(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_error
-- ----------------------------
INSERT INTO `tbl_error` VALUES ('0100', 'El sistema no puede responder su solicitud. Intente nuevamente o comuníquese con su Administrador', '1');
INSERT INTO `tbl_error` VALUES ('0101', 'El encabezado de seguridad es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('0102', 'Usuario o contraseña incorrectos', '1');
INSERT INTO `tbl_error` VALUES ('0103', 'El Usuario ingresado no existe', '1');
INSERT INTO `tbl_error` VALUES ('0104', 'La Clave ingresada es incorrecta', '1');
INSERT INTO `tbl_error` VALUES ('0105', 'El Usuario no está activo', '1');
INSERT INTO `tbl_error` VALUES ('0106', 'El Usuario no es válido', '1');
INSERT INTO `tbl_error` VALUES ('0109', 'El sistema no puede responder su solicitud. (El servicio de autenticación no está disponible)', '1');
INSERT INTO `tbl_error` VALUES ('0110', 'No se pudo obtener la informacion del tipo de usuario', '1');
INSERT INTO `tbl_error` VALUES ('0111', 'No tiene el perfil para enviar comprobantes electronicos', '1');
INSERT INTO `tbl_error` VALUES ('0112', 'El usuario debe ser secundario', '1');
INSERT INTO `tbl_error` VALUES ('0113', 'El usuario no esta afiliado a Factura Electronica', '1');
INSERT INTO `tbl_error` VALUES ('0125', 'No se pudo obtener la constancia', '1');
INSERT INTO `tbl_error` VALUES ('0126', 'El ticket no le pertenece al usuario', '1');
INSERT INTO `tbl_error` VALUES ('0127', 'El ticket no existe', '1');
INSERT INTO `tbl_error` VALUES ('0130', 'El sistema no puede responder su solicitud. (No se pudo obtener el ticket de proceso)', '1');
INSERT INTO `tbl_error` VALUES ('0131', 'El sistema no puede responder su solicitud. (No se pudo grabar el archivo en el directorio)', '1');
INSERT INTO `tbl_error` VALUES ('0132', 'El sistema no puede responder su solicitud. (No se pudo grabar escribir en el archivo zip)', '1');
INSERT INTO `tbl_error` VALUES ('0133', 'El sistema no puede responder su solicitud. (No se pudo grabar la entrada del log)', '1');
INSERT INTO `tbl_error` VALUES ('0134', 'El sistema no puede responder su solicitud. (No se pudo grabar en el storage)', '1');
INSERT INTO `tbl_error` VALUES ('0135', 'El sistema no puede responder su solicitud. (No se pudo encolar el pedido)', '1');
INSERT INTO `tbl_error` VALUES ('0136', 'El sistema no puede responder su solicitud. (No se pudo recibir una respuesta del batch)', '1');
INSERT INTO `tbl_error` VALUES ('0137', 'El sistema no puede responder su solicitud. (Se obtuvo una respuesta nula)', '1');
INSERT INTO `tbl_error` VALUES ('0138', 'El sistema no puede responder su solicitud. (Error en Base de Datos)', '1');
INSERT INTO `tbl_error` VALUES ('0151', 'El nombre del archivo ZIP es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('0152', 'No se puede enviar por este método un archivo de resumen', '1');
INSERT INTO `tbl_error` VALUES ('0153', 'No se puede enviar por este método un archivo por lotes', '1');
INSERT INTO `tbl_error` VALUES ('0154', 'El RUC del archivo no corresponde al RUC del usuario o el proveedor no esta autorizado a enviar comprobantes del contribuyente', '1');
INSERT INTO `tbl_error` VALUES ('0155', 'El archivo ZIP esta vacio', '1');
INSERT INTO `tbl_error` VALUES ('0156', 'El archivo ZIP esta corrupto', '1');
INSERT INTO `tbl_error` VALUES ('0157', 'El archivo ZIP no contiene comprobantes', '1');
INSERT INTO `tbl_error` VALUES ('0158', 'El archivo ZIP contiene demasiados comprobantes para este tipo de envío', '1');
INSERT INTO `tbl_error` VALUES ('0159', 'El nombre del archivo XML es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('0160', 'El archivo XML esta vacio', '1');
INSERT INTO `tbl_error` VALUES ('0161', 'El nombre del archivo XML no coincide con el nombre del archivo ZIP', '1');
INSERT INTO `tbl_error` VALUES ('0200', 'No se pudo procesar su solicitud. (Ocurrio un error en el batch)', '1');
INSERT INTO `tbl_error` VALUES ('0201', 'No se pudo procesar su solicitud. (Llego un requerimiento nulo al batch)', '1');
INSERT INTO `tbl_error` VALUES ('0202', 'No se pudo procesar su solicitud. (No llego información del archivo ZIP)', '1');
INSERT INTO `tbl_error` VALUES ('0203', 'No se pudo procesar su solicitud. (No se encontro archivos en la informacion del archivo ZIP)', '1');
INSERT INTO `tbl_error` VALUES ('0204', 'No se pudo procesar su solicitud. (Este tipo de requerimiento solo acepta 1 archivo)', '1');
INSERT INTO `tbl_error` VALUES ('0250', 'No se pudo procesar su solicitud. (Ocurrio un error desconocido al hacer unzip)', '1');
INSERT INTO `tbl_error` VALUES ('0251', 'No se pudo procesar su solicitud. (No se pudo crear un directorio para el unzip)', '1');
INSERT INTO `tbl_error` VALUES ('0252', 'No se pudo procesar su solicitud. (No se encontro archivos dentro del zip)', '1');
INSERT INTO `tbl_error` VALUES ('0253', 'No se pudo procesar su solicitud. (No se pudo comprimir la constancia)', '1');
INSERT INTO `tbl_error` VALUES ('0300', 'No se encontró la raíz documento xml', '1');
INSERT INTO `tbl_error` VALUES ('0301', 'Elemento raiz del xml no esta definido', '1');
INSERT INTO `tbl_error` VALUES ('0302', 'Codigo del tipo de comprobante no registrado', '1');
INSERT INTO `tbl_error` VALUES ('0303', 'No existe el directorio de schemas', '1');
INSERT INTO `tbl_error` VALUES ('0304', 'No existe el archivo de schema', '1');
INSERT INTO `tbl_error` VALUES ('0305', 'El sistema no puede procesar el archivo xml', '1');
INSERT INTO `tbl_error` VALUES ('0306', 'No se puede leer (parsear) el archivo XML', '1');
INSERT INTO `tbl_error` VALUES ('0307', 'No se pudo recuperar la constancia', '1');
INSERT INTO `tbl_error` VALUES ('0400', 'No tiene permiso para enviar casos de pruebas', '1');
INSERT INTO `tbl_error` VALUES ('0401', 'El caso de prueba no existe', '1');
INSERT INTO `tbl_error` VALUES ('0402', 'La numeracion o nombre del documento ya ha sido enviado anteriormente', '1');
INSERT INTO `tbl_error` VALUES ('0403', 'El documento afectado por la nota no existe', '1');
INSERT INTO `tbl_error` VALUES ('0404', 'El documento afectado por la nota se encuentra rechazado', '1');
INSERT INTO `tbl_error` VALUES ('1001', 'ID - El dato SERIE-CORRELATIVO no cumple con el formato de acuerdo al tipo de comprobante', '1');
INSERT INTO `tbl_error` VALUES ('1002', 'El XML no contiene informacion en el tag ID', '1');
INSERT INTO `tbl_error` VALUES ('1003', 'InvoiceTypeCode - El valor del tipo de documento es invalido o no coincide con el nombre del archivo', '1');
INSERT INTO `tbl_error` VALUES ('1004', 'El XML no contiene el tag o no existe informacion de InvoiceTypeCode', '1');
INSERT INTO `tbl_error` VALUES ('1005', 'CustomerAssignedAccountID -  El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('1006', 'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('1007', 'AdditionalAccountID -  El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('1008', 'El XML no contiene el tag o no existe informacion de tipo de documento de identidad del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('1009', 'IssueDate - El dato ingresado  no cumple con el patron YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('1010', 'El XML no contiene el tag IssueDate', '1');
INSERT INTO `tbl_error` VALUES ('1011', 'IssueDate- El dato ingresado no es valido', '1');
INSERT INTO `tbl_error` VALUES ('1012', 'ID - El dato ingresado no cumple con el patron SERIE-CORRELATIVO', '1');
INSERT INTO `tbl_error` VALUES ('1013', 'El XML no contiene informacion en el tag ID', '1');
INSERT INTO `tbl_error` VALUES ('1014', 'CustomerAssignedAccountID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('1015', 'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('1016', 'AdditionalAccountID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('1017', 'El XML no contiene el tag AdditionalAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('1018', 'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('1019', 'El XML no contiene el tag IssueDate', '1');
INSERT INTO `tbl_error` VALUES ('1020', 'IssueDate- El dato ingresado no es valido', '1');
INSERT INTO `tbl_error` VALUES ('1021', 'Error en la validacion de la nota de credito', '1');
INSERT INTO `tbl_error` VALUES ('1022', 'La serie o numero del documento modificado por la Nota Electrónica no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('1023', 'No se ha especificado el tipo de documento modificado por la Nota electronica', '1');
INSERT INTO `tbl_error` VALUES ('1024', 'CustomerAssignedAccountID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('1025', 'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('1026', 'AdditionalAccountID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('1027', 'El XML no contiene el tag AdditionalAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('1028', 'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('1029', 'El XML no contiene el tag IssueDate', '1');
INSERT INTO `tbl_error` VALUES ('1030', 'IssueDate- El dato ingresado no es valido', '1');
INSERT INTO `tbl_error` VALUES ('1031', 'Error en la validacion de la nota de debito', '1');
INSERT INTO `tbl_error` VALUES ('1032', 'El comprobante ya está informado y se encuentra con estado anulado o rechazado', '1');
INSERT INTO `tbl_error` VALUES ('1033', 'El comprobante fue registrado previamente con otros datos', '1');
INSERT INTO `tbl_error` VALUES ('1034', 'Número de RUC del nombre del archivo no coincide con el consignado en el contenido del archivo XML', '1');
INSERT INTO `tbl_error` VALUES ('1035', 'Numero de Serie del nombre del archivo no coincide con el consignado en el contenido del archivo XML', '1');
INSERT INTO `tbl_error` VALUES ('1036', 'Número de documento en el nombre del archivo no coincide con el consignado en el contenido del XML', '1');
INSERT INTO `tbl_error` VALUES ('1037', 'El XML no contiene el tag o no existe informacion de RegistrationName del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('1038', 'RegistrationName - El nombre o razon social del emisor no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('1039', 'Solo se pueden recibir notas electronicas que modifican facturas', '1');
INSERT INTO `tbl_error` VALUES ('1040', 'El tipo de documento modificado por la nota electronica no es valido', '1');
INSERT INTO `tbl_error` VALUES ('1041', 'cac:PrepaidPayment/cbc:ID - El tag no contiene el atributo @SchemaID. que indica el tipo de documento que realiza el anticipo', '1');
INSERT INTO `tbl_error` VALUES ('1042', 'cac:PrepaidPayment/cbc:InstructionID - El tag no contiene el atributo @SchemaID. Que indica el tipo de documento del emisor del documento del anticipo.', '1');
INSERT INTO `tbl_error` VALUES ('1043', 'cac:OriginatorDocumentReference/cbc:ID - El tag no contiene el atributo @SchemaID. Que indica el tipo de documento del originador del documento electrónico.', '1');
INSERT INTO `tbl_error` VALUES ('1044', 'cac:PrepaidPayment/cbc:InstructionID - El dato ingresado no cumple con el estándar.', '1');
INSERT INTO `tbl_error` VALUES ('1045', 'cac:OriginatorDocumentReference/cbc:ID - El dato ingresado no cumple con el estándar.', '1');
INSERT INTO `tbl_error` VALUES ('1046', 'cbc:Amount - El dato ingresado no cumple con el estándar.', '1');
INSERT INTO `tbl_error` VALUES ('1047', 'cbc:Quantity - El dato ingresado no cumple con el estándar.', '1');
INSERT INTO `tbl_error` VALUES ('1048', 'El XML no contiene el tag o no existe información de PrepaidAmount para un documento con anticipo.', '1');
INSERT INTO `tbl_error` VALUES ('1049', 'ID - Serie y Número del archivo no coincide con el consignado en el contenido del XML.', '1');
INSERT INTO `tbl_error` VALUES ('1050', 'El XML no contiene informacion en el tag DespatchAdviceTypeCode.', '1');
INSERT INTO `tbl_error` VALUES ('1051', 'DespatchAdviceTypeCode - El valor del tipo de guía es inválido.', '1');
INSERT INTO `tbl_error` VALUES ('1052', 'DespatchAdviceTypeCode - No coincide con el consignado en el contenido del XML.', '1');
INSERT INTO `tbl_error` VALUES ('1053', 'cac:OrderReference - El XML no contiene informacion en serie y numero dado de baja (cbc:ID).', '1');
INSERT INTO `tbl_error` VALUES ('1054', 'cac:OrderReference - El valor en numero de documento no cumple con un formato valido (SERIE-NUMERO).', '1');
INSERT INTO `tbl_error` VALUES ('1055', 'cac:OrderReference - Numero de serie del documento no cumple con un formato valido (EG01 ó TXXX).', '1');
INSERT INTO `tbl_error` VALUES ('1056', 'cac:OrderReference - El XML no contiene informacion en el código de tipo de documento (cbc:OrderTypeCode).', '1');
INSERT INTO `tbl_error` VALUES ('1057', 'cac:AdditionalDocumentReference - El XML no contiene el tag o no existe información en el numero de documento adicional (cbc:ID).', '1');
INSERT INTO `tbl_error` VALUES ('1058', 'cac:AdditionalDocumentReference - El XML no contiene el tag o no existe información en el tipo de documento adicional (cbc:DocumentTypeCode).', '1');
INSERT INTO `tbl_error` VALUES ('1059', 'El XML no contiene firma digital.', '1');
INSERT INTO `tbl_error` VALUES ('1060', 'cac:Shipment - El XML no contiene el tag o no existe informacion del numero de RUC del Remitente (cac:).', '1');
INSERT INTO `tbl_error` VALUES ('1061', 'El numero de RUC del Remitente no existe.', '1');
INSERT INTO `tbl_error` VALUES ('1062', 'El XML no contiene el atributo o no existe informacion del motivo de traslado.', '1');
INSERT INTO `tbl_error` VALUES ('1063', 'El valor ingresado como motivo de traslado no es valido.', '1');
INSERT INTO `tbl_error` VALUES ('1064', 'El XML no contiene el atributo o no existe informacion en el tag cac:DespatchLine de bienes a transportar.', '1');
INSERT INTO `tbl_error` VALUES ('1065', 'El XML no contiene el atributo o no existe informacion en modalidad de transporte.', '1');
INSERT INTO `tbl_error` VALUES ('1066', 'El XML no contiene el atributo o no existe informacion de datos del transportista.', '1');
INSERT INTO `tbl_error` VALUES ('1067', 'El XML no contiene el atributo o no existe información de vehiculos.', '1');
INSERT INTO `tbl_error` VALUES ('1068', 'El XML no contiene el atributo o no existe información de conductores.', '1');
INSERT INTO `tbl_error` VALUES ('1069', 'El XML no contiene el atributo o no existe información de la fecha de inicio de traslado o fecha de entrega del bien al transportista.', '1');
INSERT INTO `tbl_error` VALUES ('1070', 'El valor ingresado  como fecha de inicio o fecha de entrega al transportista no cumple con el estandar (YYYY-MM-DD).', '1');
INSERT INTO `tbl_error` VALUES ('1071', 'El valor ingresado  como fecha de inicio o fecha de entrega al transportista no es valido.', '1');
INSERT INTO `tbl_error` VALUES ('1072', 'Starttime - El dato ingresado  no cumple con el patron HH:mm:ss.SZ.', '1');
INSERT INTO `tbl_error` VALUES ('1073', 'StartTime - El dato ingresado no es valido.', '1');
INSERT INTO `tbl_error` VALUES ('1074', 'cac:Shipment - El XML no contiene o no existe información en punto de llegada (cac:DeliveryAddress).', '1');
INSERT INTO `tbl_error` VALUES ('1075', 'cac:Shipment - El XML no contiene o no existe información en punto de partida (cac:OriginAddress).', '1');
INSERT INTO `tbl_error` VALUES ('1076', 'El XML no contiene el atributo o no existe información de sustento de traslado de mercaderias para el tipo de operación.', '1');
INSERT INTO `tbl_error` VALUES ('1077', 'El XML contiene el tag de sustento de traslado de mercaderias que no corresponde al tipo de operación.', '1');
INSERT INTO `tbl_error` VALUES ('2010', 'El contribuyente no esta activo', '1');
INSERT INTO `tbl_error` VALUES ('2011', 'El contribuyente no esta habido', '1');
INSERT INTO `tbl_error` VALUES ('2012', 'El contribuyente no está autorizado a emitir comprobantes electrónicos', '1');
INSERT INTO `tbl_error` VALUES ('2013', 'El contribuyente no cumple con tipo de empresa o tributos requeridos', '1');
INSERT INTO `tbl_error` VALUES ('2014', 'El XML no contiene el tag o no existe informacion del numero de documento de identidad del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2015', 'El XML no contiene el tag o no existe informacion de AdditionalAccountID del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2016', 'El dato ingresado  en el tipo de documento de identidad del receptor no cumple con el estandar o no esta permitido.', '1');
INSERT INTO `tbl_error` VALUES ('2017', 'El numero de documento de identidad del recepetor debe ser  RUC', '1');
INSERT INTO `tbl_error` VALUES ('2018', 'El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2019', 'El XML no contiene el tag o no existe informacion del nombre o razon social del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2020', 'El nombre o razon social del emisor no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2021', 'El XML no contiene el tag o no existe informacion de RegistrationName del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2022', 'RegistrationName -  El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2023', 'El Numero de orden del item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2024', 'El XML no contiene el tag InvoicedQuantity en el detalle de los Items o es cero (0)', '1');
INSERT INTO `tbl_error` VALUES ('2025', 'InvoicedQuantity El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2026', 'El XML no contiene el tag cac:Item/cbc:Description en el detalle de los Items', '1');
INSERT INTO `tbl_error` VALUES ('2027', 'El XML no contiene el tag o no existe informacion de cac:Item/cbc:Description del item', '1');
INSERT INTO `tbl_error` VALUES ('2028', 'Debe existir el tag cac:AlternativeConditionPrice/cbc:PriceAmount', '1');
INSERT INTO `tbl_error` VALUES ('2029', 'PriceTypeCode El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2030', 'El XML no contiene el tag cbc:PriceTypeCode', '1');
INSERT INTO `tbl_error` VALUES ('2031', 'LineExtensionAmount El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2032', 'El XML no contiene el tag LineExtensionAmount en el detalle de los Items', '1');
INSERT INTO `tbl_error` VALUES ('2033', 'El dato ingresado en TaxAmount de la linea no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2034', 'TaxAmount es obligatorio', '1');
INSERT INTO `tbl_error` VALUES ('2035', 'cac:TaxCategory/cac:TaxScheme/cbc:ID El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2036', 'El codigo del tributo es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2037', 'El XML no contiene el tag cac:TaxCategory/cac:TaxScheme/cbc:ID del Item', '1');
INSERT INTO `tbl_error` VALUES ('2038', 'cac:TaxScheme/cbc:Name del item - No existe el tag o el dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2039', 'El XML no contiene el tag cac:TaxCategory/cac:TaxScheme/cbc:Name del Item', '1');
INSERT INTO `tbl_error` VALUES ('2040', 'El tipo de afectacion del IGV es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2041', 'El sistema de calculo del ISC es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2042', 'Debe indicar el IGV. Es un campo obligatorio', '1');
INSERT INTO `tbl_error` VALUES ('2043', 'El dato ingresado en PayableAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2044', 'PayableAmount es obligatorio', '1');
INSERT INTO `tbl_error` VALUES ('2045', 'El valor ingresado en AdditionalMonetaryTotal/cbc:ID es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2046', 'AdditionalMonetaryTotal/cbc:ID debe tener valor', '1');
INSERT INTO `tbl_error` VALUES ('2047', 'Es obligatorio al menos un AdditionalMonetaryTotal con codigo 1001, 1002, 1003 o 3001', '1');
INSERT INTO `tbl_error` VALUES ('2048', 'El dato ingresado en TaxAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2049', 'TaxAmount es obligatorio', '1');
INSERT INTO `tbl_error` VALUES ('2050', 'TaxScheme ID - No existe el tag o el dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2051', 'El codigo del tributo es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2052', 'El XML no contiene el tag TaxScheme ID de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2053', 'TaxScheme Name - No existe el tag o el dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2054', 'El XML no contiene el tag TaxScheme Name de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2055', 'TaxScheme TaxTypeCode - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2056', 'El XML no contiene el tag TaxScheme TaxTypeCode de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2057', 'El Name o TaxTypeCode debe corresponder con el Id para el IGV', '1');
INSERT INTO `tbl_error` VALUES ('2058', 'El Name o TaxTypeCode debe corresponder con el Id para el ISC', '1');
INSERT INTO `tbl_error` VALUES ('2059', 'El dato ingresado en TaxSubtotal/cbc:TaxAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2060', 'TaxSubtotal/cbc:TaxAmount es obligatorio', '1');
INSERT INTO `tbl_error` VALUES ('2061', 'El tag global cac:TaxTotal/cbc:TaxAmount debe tener el mismo valor que cac:TaxTotal/cac:Subtotal/cbc:TaxAmount', '1');
INSERT INTO `tbl_error` VALUES ('2062', 'El dato ingresado en PayableAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2063', 'El XML no contiene el tag PayableAmount', '1');
INSERT INTO `tbl_error` VALUES ('2064', 'El dato ingresado en ChargeTotalAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2065', 'El dato ingresado en el campo Total Descuentos no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2066', 'Debe indicar una descripcion para el tag sac:AdditionalProperty/cbc:Value', '1');
INSERT INTO `tbl_error` VALUES ('2067', 'cac:Price/cbc:PriceAmount - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2068', 'El XML no contiene el tag cac:Price/cbc:PriceAmount en el detalle de los Items', '1');
INSERT INTO `tbl_error` VALUES ('2069', 'DocumentCurrencyCode - El dato ingresado no cumple con la estructura', '1');
INSERT INTO `tbl_error` VALUES ('2070', 'El XML no contiene el tag o no existe informacion de DocumentCurrencyCode', '1');
INSERT INTO `tbl_error` VALUES ('2071', 'La moneda debe ser la misma en todo el documento. Salvo las percepciones que sólo son en moneda nacional', '1');
INSERT INTO `tbl_error` VALUES ('2072', 'CustomizationID - La versión del documento no es la correcta', '1');
INSERT INTO `tbl_error` VALUES ('2073', 'El XML no existe informacion de CustomizationID', '1');
INSERT INTO `tbl_error` VALUES ('2074', 'UBLVersionID - La versión del UBL no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2075', 'El XML no contiene el tag o no existe informacion de UBLVersionID', '1');
INSERT INTO `tbl_error` VALUES ('2076', 'cac:Signature/cbc:ID - Falta el identificador de la firma', '1');
INSERT INTO `tbl_error` VALUES ('2077', 'El tag cac:Signature/cbc:ID debe contener informacion', '1');
INSERT INTO `tbl_error` VALUES ('2078', 'cac:Signature/cac:SignatoryParty/cac:PartyIdentification/cbc:ID - Debe ser igual al RUC del emisor', '1');
INSERT INTO `tbl_error` VALUES ('2079', 'El XML no contiene el tag cac:Signature/cac:SignatoryParty/cac:PartyIdentification/cbc:ID', '1');
INSERT INTO `tbl_error` VALUES ('2080', 'cac:Signature/cac:SignatoryParty/cac:PartyName/cbc:Name - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2081', 'El XML no contiene el tag cac:Signature/cac:SignatoryParty/cac:PartyName/cbc:Name', '1');
INSERT INTO `tbl_error` VALUES ('2082', 'cac:Signature/cac:DigitalSignatureAttachment/cac:ExternalReference/cbc:URI - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2083', 'El XML no contiene el tag cac:Signature/cac:DigitalSignatureAttachment/cac:ExternalReference/cbc:URI', '1');
INSERT INTO `tbl_error` VALUES ('2084', 'ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/ds:Signature/@Id - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2085', 'El XML no contiene el tag ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/ds:Signature/@Id', '1');
INSERT INTO `tbl_error` VALUES ('2086', 'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:CanonicalizationMethod/@Algorithm - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2087', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:CanonicalizationMethod/@Algorithm', '1');
INSERT INTO `tbl_error` VALUES ('2088', 'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:SignatureMethod/@Algorithm - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2089', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:SignatureMethod/@Algorithm', '1');
INSERT INTO `tbl_error` VALUES ('2090', 'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/@URI - Debe estar vacio para id', '1');
INSERT INTO `tbl_error` VALUES ('2091', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/@URI', '1');
INSERT INTO `tbl_error` VALUES ('2092', 'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/.../ds:Transform@Algorithm - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2093', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:Transform@Algorithm', '1');
INSERT INTO `tbl_error` VALUES ('2094', 'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestMethod/@Algorithm - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2095', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestMethod/@Algorithm', '1');
INSERT INTO `tbl_error` VALUES ('2096', 'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestValue - No  cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2097', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestValue', '1');
INSERT INTO `tbl_error` VALUES ('2098', 'ext:UBLExtensions/.../ds:Signature/ds:SignatureValue - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2099', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignatureValue', '1');
INSERT INTO `tbl_error` VALUES ('2100', 'ext:UBLExtensions/.../ds:Signature/ds:KeyInfo/ds:X509Data/ds:X509Certificate - No cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2101', 'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:KeyInfo/ds:X509Data/ds:X509Certificate', '1');
INSERT INTO `tbl_error` VALUES ('2102', 'Error al procesar la factura', '1');
INSERT INTO `tbl_error` VALUES ('2103', 'La serie ingresada no es válida', '1');
INSERT INTO `tbl_error` VALUES ('2104', 'Numero de RUC del emisor no existe', '1');
INSERT INTO `tbl_error` VALUES ('2105', 'Factura a dar de baja no se encuentra registrada en SUNAT', '1');
INSERT INTO `tbl_error` VALUES ('2106', 'Factura a dar de baja ya se encuentra en estado de baja', '1');
INSERT INTO `tbl_error` VALUES ('2107', 'Numero de RUC SOL no coincide con RUC emisor', '1');
INSERT INTO `tbl_error` VALUES ('2108', 'Presentacion fuera de fecha', '1');
INSERT INTO `tbl_error` VALUES ('2109', 'El comprobante fue registrado previamente con otros datos', '1');
INSERT INTO `tbl_error` VALUES ('2110', 'UBLVersionID - La versión del UBL no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2111', 'El XML no contiene el tag o no existe informacion de UBLVersionID', '1');
INSERT INTO `tbl_error` VALUES ('2112', 'CustomizationID - La version del documento no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2113', 'El XML no contiene el tag o no existe informacion de CustomizationID', '1');
INSERT INTO `tbl_error` VALUES ('2114', 'DocumentCurrencyCode -  El dato ingresado no cumple con la estructura', '1');
INSERT INTO `tbl_error` VALUES ('2115', 'El XML no contiene el tag o no existe informacion de DocumentCurrencyCode', '1');
INSERT INTO `tbl_error` VALUES ('2116', 'El tipo de documento modificado por la Nota de credito debe ser factura electronica o ticket', '1');
INSERT INTO `tbl_error` VALUES ('2117', 'La serie o numero del documento modificado por la Nota de Credito no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2118', 'Debe indicar las facturas relacionadas a la Nota de Credito', '1');
INSERT INTO `tbl_error` VALUES ('2119', 'El documento modificado en la Nota de credito no esta registrada.', '1');
INSERT INTO `tbl_error` VALUES ('2120', 'El documento modificado en la Nota de credito se encuentra de baja', '1');
INSERT INTO `tbl_error` VALUES ('2121', 'El documento modificado en la Nota de credito esta registrada como rechazada', '1');
INSERT INTO `tbl_error` VALUES ('2122', 'El tag cac:LegalMonetaryTotal/cbc:PayableAmount debe tener informacion valida', '1');
INSERT INTO `tbl_error` VALUES ('2123', 'RegistrationName -  El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2124', 'El XML no contiene el tag RegistrationName del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2125', 'ReferenceID -  El dato ingresado debe indicar SERIE-CORRELATIVO del documento al que se relaciona la Nota', '1');
INSERT INTO `tbl_error` VALUES ('2126', 'El XML no contiene informacion en el tag ReferenceID del documento al que se relaciona la nota', '1');
INSERT INTO `tbl_error` VALUES ('2127', 'ResponseCode -  El dato ingresado no cumple  con  la  estructura', '1');
INSERT INTO `tbl_error` VALUES ('2128', 'El XML no contiene el tag o no existe informacion de ResponseCode', '1');
INSERT INTO `tbl_error` VALUES ('2129', 'AdditionalAccountID -  El dato ingresado  en el tipo de documento de identidad del receptor no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2130', 'El XML no contiene el tag o no existe informacion de AdditionalAccountID del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2131', 'CustomerAssignedAccountID - El numero de documento de identidad del receptor debe ser RUC', '1');
INSERT INTO `tbl_error` VALUES ('2132', 'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2133', 'RegistrationName -  El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2134', 'El XML no contiene el tag o no existe informacion de RegistrationName del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2135', 'cac:DiscrepancyResponse/cbc:Description - El dato ingresado no cumple con la estructura', '1');
INSERT INTO `tbl_error` VALUES ('2136', 'El XML no contiene el tag o no existe informacion de cac:DiscrepancyResponse/cbc:Description', '1');
INSERT INTO `tbl_error` VALUES ('2137', 'El Numero de orden del item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2138', 'CreditedQuantity/@unitCode - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2139', 'CreditedQuantity - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2140', 'El PriceTypeCode debe tener el valor 01', '1');
INSERT INTO `tbl_error` VALUES ('2141', 'cac:TaxCategory/cac:TaxScheme/cbc:ID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2142', 'El codigo del tributo es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2143', 'cac:TaxScheme/cbc:Name del item - No existe el tag o el dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2144', 'cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2145', 'El tipo de afectacion del IGV es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2146', 'El Nombre Internacional debe ser VAT', '1');
INSERT INTO `tbl_error` VALUES ('2147', 'El sistema de calculo del ISC es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2148', 'El Nombre Internacional debe ser EXC', '1');
INSERT INTO `tbl_error` VALUES ('2149', 'El dato ingresado en PayableAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2150', 'El valor ingresado en AdditionalMonetaryTotal/cbc:ID es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2151', 'AdditionalMonetaryTotal/cbc:ID debe tener valor', '1');
INSERT INTO `tbl_error` VALUES ('2152', 'Es obligatorio al menos un AdditionalInformation', '1');
INSERT INTO `tbl_error` VALUES ('2153', 'Error al procesar la Nota de Credito', '1');
INSERT INTO `tbl_error` VALUES ('2154', 'TaxAmount - El dato ingresado en impuestos globales no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2155', 'El XML no contiene el tag TaxAmount de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2156', 'TaxScheme ID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2157', 'El codigo del tributo es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2158', 'El XML no contiene el tag o no existe informacion de TaxScheme ID de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2159', 'TaxScheme Name - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2160', 'El XML no contiene el tag o no existe informacion de TaxScheme Name de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2161', 'CustomizationID - La version del documento no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2162', 'El XML no contiene el tag o no existe informacion de CustomizationID', '1');
INSERT INTO `tbl_error` VALUES ('2163', 'UBLVersionID - La versión del UBL no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2164', 'El XML no contiene el tag o no existe informacion de UBLVersionID', '1');
INSERT INTO `tbl_error` VALUES ('2165', 'Error al procesar la Nota de Debito', '1');
INSERT INTO `tbl_error` VALUES ('2166', 'RegistrationName - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2167', 'El XML no contiene el tag RegistrationName del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2168', 'DocumentCurrencyCode -  El dato ingresado no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2169', 'El XML no contiene el tag o no existe informacion de DocumentCurrencyCode', '1');
INSERT INTO `tbl_error` VALUES ('2170', 'ReferenceID - El dato ingresado debe indicar SERIE-CORRELATIVO del documento al que se relaciona la Nota', '1');
INSERT INTO `tbl_error` VALUES ('2171', 'El XML no contiene informacion en el tag ReferenceID del documento al que se relaciona la nota', '1');
INSERT INTO `tbl_error` VALUES ('2172', 'ResponseCode - El dato ingresado no cumple con la estructura', '1');
INSERT INTO `tbl_error` VALUES ('2173', 'El XML no contiene el tag o no existe informacion de ResponseCode', '1');
INSERT INTO `tbl_error` VALUES ('2174', 'cac:DiscrepancyResponse/cbc:Description - El dato ingresado no cumple con la estructura', '1');
INSERT INTO `tbl_error` VALUES ('2175', 'El XML no contiene el tag o no existe informacion de cac:DiscrepancyResponse/cbc:Description', '1');
INSERT INTO `tbl_error` VALUES ('2176', 'AdditionalAccountID -  El dato ingresado  en el tipo de documento de identidad del receptor no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2177', 'El XML no contiene el tag o no existe informacion de AdditionalAccountID del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2178', 'CustomerAssignedAccountID - El numero de documento de identidad del receptor debe ser RUC.', '1');
INSERT INTO `tbl_error` VALUES ('2179', 'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2180', 'RegistrationName - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2181', 'El XML no contiene el tag o no existe informacion de RegistrationName del receptor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2182', 'TaxScheme ID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2183', 'El codigo del tributo es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2184', 'El XML no contiene el tag o no existe informacion de TaxScheme ID de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2185', 'TaxScheme Name - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2186', 'El XML no contiene el tag o no existe informacion de TaxScheme Name de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2187', 'El Numero de orden del item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2188', 'DebitedQuantity/@unitCode El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2189', 'DebitedQuantity El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2190', 'El XML no contiene el tag Price/cbc:PriceAmount en el detalle de los Items', '1');
INSERT INTO `tbl_error` VALUES ('2191', 'El XML no contiene el tag Price/cbc:LineExtensionAmount en el detalle de los Items', '1');
INSERT INTO `tbl_error` VALUES ('2192', 'EL PriceTypeCode debe tener el valor 01', '1');
INSERT INTO `tbl_error` VALUES ('2193', 'cac:TaxCategory/cac:TaxScheme/cbc:ID El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2194', 'El codigo del tributo es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2195', 'cac:TaxScheme/cbc:Name del item - No existe el tag o el dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2196', 'cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2197', 'El tipo de afectacion del IGV es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2198', 'El Nombre Internacional debe ser VAT', '1');
INSERT INTO `tbl_error` VALUES ('2199', 'El sistema de calculo del ISC es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2200', 'El Nombre Internacional debe ser EXC', '1');
INSERT INTO `tbl_error` VALUES ('2201', 'El tag cac:RequestedMonetaryTotal/cbc:PayableAmount debe tener informacion valida', '1');
INSERT INTO `tbl_error` VALUES ('2202', 'TaxAmount - El dato ingresado en impuestos globales no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2203', 'El XML no contiene el tag TaxAmount de impuestos globales', '1');
INSERT INTO `tbl_error` VALUES ('2204', 'El tipo de documento modificado por la Nota de Debito debe ser factura electronica o ticket', '1');
INSERT INTO `tbl_error` VALUES ('2205', 'La serie o numero del documento modificado por la Nota de Debito no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2206', 'Debe indicar los documentos afectados por la Nota de Debito', '1');
INSERT INTO `tbl_error` VALUES ('2207', 'La factura relacionada en la nota de debito se encuentra de baja', '1');
INSERT INTO `tbl_error` VALUES ('2208', 'La factura relacionada en la nota de debito esta registrada como rechazada', '1');
INSERT INTO `tbl_error` VALUES ('2209', 'La factura relacionada en la Nota de debito no esta registrada', '1');
INSERT INTO `tbl_error` VALUES ('2210', 'El dato ingresado no cumple con el formato RC-fecha-correlativo', '1');
INSERT INTO `tbl_error` VALUES ('2211', 'El XML no contiene el tag ID', '1');
INSERT INTO `tbl_error` VALUES ('2212', 'UBLVersionID - La versión del UBL del resumen de boletas no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2213', 'El XML no contiene el tag UBLVersionID', '1');
INSERT INTO `tbl_error` VALUES ('2214', 'CustomizationID - La versión del resumen de boletas no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2215', 'El XML no contiene el tag CustomizationID', '1');
INSERT INTO `tbl_error` VALUES ('2216', 'CustomerAssignedAccountID -  El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2217', 'El XML no contiene el tag CustomerAssignedAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2218', 'AdditionalAccountID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2219', 'El XML no contiene el tag AdditionalAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2220', 'El ID debe coincidir con el nombre del archivo', '1');
INSERT INTO `tbl_error` VALUES ('2221', 'El RUC debe coincidir con el RUC del nombre del archivo', '1');
INSERT INTO `tbl_error` VALUES ('2222', 'El contribuyente no está autorizado a emitir comprobantes electronicos', '1');
INSERT INTO `tbl_error` VALUES ('2223', 'El archivo ya fue presentado anteriormente', '1');
INSERT INTO `tbl_error` VALUES ('2224', 'Numero de RUC SOL no coincide con RUC emisor', '1');
INSERT INTO `tbl_error` VALUES ('2225', 'Numero de RUC del emisor no existe', '1');
INSERT INTO `tbl_error` VALUES ('2226', 'El contribuyente no esta activo', '1');
INSERT INTO `tbl_error` VALUES ('2227', 'El contribuyente no cumple con tipo de empresa o tributos requeridos', '1');
INSERT INTO `tbl_error` VALUES ('2228', 'RegistrationName - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2229', 'El XML no contiene el tag RegistrationName del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2230', 'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('2231', 'El XML no contiene el tag IssueDate', '1');
INSERT INTO `tbl_error` VALUES ('2232', 'IssueDate- El dato ingresado no es valido', '1');
INSERT INTO `tbl_error` VALUES ('2233', 'ReferenceDate - El dato ingresado no cumple con el patron YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('2234', 'El XML no contiene el tag ReferenceDate', '1');
INSERT INTO `tbl_error` VALUES ('2235', 'ReferenceDate- El dato ingresado no es valido', '1');
INSERT INTO `tbl_error` VALUES ('2236', 'La fecha del IssueDate no debe ser mayor al Today', '1');
INSERT INTO `tbl_error` VALUES ('2237', 'La fecha del ReferenceDate no debe ser mayor al Today', '1');
INSERT INTO `tbl_error` VALUES ('2238', 'LineID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2239', 'LineID - El dato ingresado debe ser correlativo mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2240', 'El XML no contiene el tag LineID de SummaryDocumentsLine', '1');
INSERT INTO `tbl_error` VALUES ('2241', 'DocumentTypeCode - El valor del tipo de documento es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2242', 'El XML no contiene el tag DocumentTypeCode', '1');
INSERT INTO `tbl_error` VALUES ('2243', 'El dato ingresado  no cumple con el patron SERIE', '1');
INSERT INTO `tbl_error` VALUES ('2244', 'El XML no contiene el tag DocumentSerialID', '1');
INSERT INTO `tbl_error` VALUES ('2245', 'El dato ingresado en StartDocumentNumberID debe ser numerico', '1');
INSERT INTO `tbl_error` VALUES ('2246', 'El XML no contiene el tag StartDocumentNumberID', '1');
INSERT INTO `tbl_error` VALUES ('2247', 'El dato ingresado en sac:EndDocumentNumberID debe ser numerico', '1');
INSERT INTO `tbl_error` VALUES ('2248', 'El XML no contiene el tag sac:EndDocumentNumberID', '1');
INSERT INTO `tbl_error` VALUES ('2249', 'Los rangos deben ser mayores a cero', '1');
INSERT INTO `tbl_error` VALUES ('2250', 'En el rango de comprobantes, el EndDocumentNumberID debe ser mayor o igual al StartInvoiceNumberID', '1');
INSERT INTO `tbl_error` VALUES ('2251', 'El dato ingresado en TotalAmount debe ser numerico mayor o igual a cero', '1');
INSERT INTO `tbl_error` VALUES ('2252', 'El XML no contiene el tag TotalAmount', '1');
INSERT INTO `tbl_error` VALUES ('2253', 'El dato ingresado en TotalAmount debe ser numerico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2254', 'PaidAmount - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2255', 'El XML no contiene el tag PaidAmount', '1');
INSERT INTO `tbl_error` VALUES ('2256', 'InstructionID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2257', 'El XML no contiene el tag InstructionID', '1');
INSERT INTO `tbl_error` VALUES ('2258', 'Debe indicar Referencia de Importes asociados a las boletas de venta', '1');
INSERT INTO `tbl_error` VALUES ('2259', 'Debe indicar 3 Referencias de Importes asociados a las boletas de venta', '1');
INSERT INTO `tbl_error` VALUES ('2260', 'PaidAmount - El dato ingresado debe ser mayor o igual a 0.00', '1');
INSERT INTO `tbl_error` VALUES ('2261', 'cbc:Amount - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2262', 'El XML no contiene el tag cbc:Amount', '1');
INSERT INTO `tbl_error` VALUES ('2263', 'ChargeIndicator - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2264', 'El XML no contiene el tag ChargeIndicator', '1');
INSERT INTO `tbl_error` VALUES ('2265', 'Debe indicar Información acerca del Importe Total de Otros Cargos', '1');
INSERT INTO `tbl_error` VALUES ('2266', 'Debe indicar cargos mayores o iguales a cero', '1');
INSERT INTO `tbl_error` VALUES ('2267', 'TaxScheme ID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2268', 'El codigo del tributo es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2269', 'El XML no contiene el tag TaxScheme ID de Información acerca del importe total de un tipo particular de impuesto', '1');
INSERT INTO `tbl_error` VALUES ('2270', 'TaxScheme Name - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2271', 'El XML no contiene el tag TaxScheme Name de impuesto', '1');
INSERT INTO `tbl_error` VALUES ('2272', 'TaxScheme TaxTypeCode - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2273', 'TaxAmount - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2274', 'El XML no contiene el tag TaxAmount', '1');
INSERT INTO `tbl_error` VALUES ('2275', 'Si el codigo de tributo es 2000, el nombre del tributo debe ser ISC', '1');
INSERT INTO `tbl_error` VALUES ('2276', 'Si el codigo de tributo es 1000, el nombre del tributo debe ser IGV', '1');
INSERT INTO `tbl_error` VALUES ('2277', 'No se ha consignado ninguna informacion del importe total de tributos', '1');
INSERT INTO `tbl_error` VALUES ('2278', 'Debe indicar Información acerca del importe total de IGV', '1');
INSERT INTO `tbl_error` VALUES ('2279', 'Debe indicar Items de consolidado de documentos', '1');
INSERT INTO `tbl_error` VALUES ('2280', 'Existen problemas con la informacion del resumen de comprobantes', '1');
INSERT INTO `tbl_error` VALUES ('2281', 'Error en la validacion de los rangos de los comprobantes', '1');
INSERT INTO `tbl_error` VALUES ('2282', 'Existe documento ya informado anteriormente', '1');
INSERT INTO `tbl_error` VALUES ('2283', 'El dato ingresado no cumple con el formato RA-fecha-correlativo', '1');
INSERT INTO `tbl_error` VALUES ('2284', 'El tag ID esta vacío', '1');
INSERT INTO `tbl_error` VALUES ('2285', 'El ID debe coincidir  con el nombre del archivo', '1');
INSERT INTO `tbl_error` VALUES ('2286', 'El RUC debe coincidir con el RUC del nombre del archivo', '1');
INSERT INTO `tbl_error` VALUES ('2287', 'AdditionalAccountID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2288', 'El XML no contiene el tag AdditionalAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2289', 'CustomerAssignedAccountID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2290', 'El XML no contiene el tag CustomerAssignedAccountID del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2291', 'El contribuyente no esta autorizado a emitir comprobantes electronicos', '1');
INSERT INTO `tbl_error` VALUES ('2292', 'Numero de RUC SOL no coincide con RUC emisor', '1');
INSERT INTO `tbl_error` VALUES ('2293', 'Numero de RUC del emisor no existe', '1');
INSERT INTO `tbl_error` VALUES ('2294', 'El contribuyente no esta activo', '1');
INSERT INTO `tbl_error` VALUES ('2295', 'El contribuyente no cumple con tipo de empresa o tributos requeridos', '1');
INSERT INTO `tbl_error` VALUES ('2296', 'RegistrationName - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2297', 'El XML no contiene el tag RegistrationName del emisor del documento', '1');
INSERT INTO `tbl_error` VALUES ('2298', 'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('2299', 'El XML no contiene el tag IssueDate', '1');
INSERT INTO `tbl_error` VALUES ('2300', 'IssueDate - El dato ingresado no es valido', '1');
INSERT INTO `tbl_error` VALUES ('2301', 'La fecha del IssueDate no debe ser mayor al Today', '1');
INSERT INTO `tbl_error` VALUES ('2302', 'ReferenceDate - El dato ingresado no cumple con el patron YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('2303', 'El XML no contiene el tag ReferenceDate', '1');
INSERT INTO `tbl_error` VALUES ('2304', 'ReferenceDate - El dato ingresado no es valido', '1');
INSERT INTO `tbl_error` VALUES ('2305', 'LineID - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2306', 'LineID - El dato ingresado debe ser correlativo mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2307', 'El tag LineID de VoidedDocumentsLine esta vacío', '1');
INSERT INTO `tbl_error` VALUES ('2308', 'DocumentTypeCode - El valor del tipo de documento es invalido', '1');
INSERT INTO `tbl_error` VALUES ('2309', 'El tag DocumentTypeCode es vacío', '1');
INSERT INTO `tbl_error` VALUES ('2310', 'El dato ingresado  no cumple con el patron SERIE', '1');
INSERT INTO `tbl_error` VALUES ('2311', 'El tag DocumentSerialID es vacío', '1');
INSERT INTO `tbl_error` VALUES ('2312', 'El dato ingresado en DocumentNumberID debe ser numerico y como maximo de 8 digitos', '1');
INSERT INTO `tbl_error` VALUES ('2313', 'El tag DocumentNumberID esta vacío', '1');
INSERT INTO `tbl_error` VALUES ('2314', 'El dato ingresado en VoidReasonDescription debe contener información válida', '1');
INSERT INTO `tbl_error` VALUES ('2315', 'El tag VoidReasonDescription esta vacío', '1');
INSERT INTO `tbl_error` VALUES ('2316', 'Debe indicar Items en VoidedDocumentsLine', '1');
INSERT INTO `tbl_error` VALUES ('2317', 'Error al procesar el resumen de anulados', '1');
INSERT INTO `tbl_error` VALUES ('2318', 'CustomizationID - La version del documento no es correcta', '1');
INSERT INTO `tbl_error` VALUES ('2319', 'El XML no contiene el tag CustomizationID', '1');
INSERT INTO `tbl_error` VALUES ('2320', 'UBLVersionID - La version del UBL  no es la correcta', '1');
INSERT INTO `tbl_error` VALUES ('2321', 'El XML no contiene el tag UBLVersionID', '1');
INSERT INTO `tbl_error` VALUES ('2322', 'Error en la validacion de los rangos', '1');
INSERT INTO `tbl_error` VALUES ('2323', 'Existe documento ya informado anteriormente en una comunicacion de baja', '1');
INSERT INTO `tbl_error` VALUES ('2324', 'El archivo de comunicacion de baja ya fue presentado anteriormente', '1');
INSERT INTO `tbl_error` VALUES ('2325', 'El certificado usado no es el comunicado a SUNAT', '1');
INSERT INTO `tbl_error` VALUES ('2326', 'El certificado usado se encuentra de baja', '1');
INSERT INTO `tbl_error` VALUES ('2327', 'El certificado usado no se encuentra vigente', '1');
INSERT INTO `tbl_error` VALUES ('2328', 'El certificado usado se encuentra revocado', '1');
INSERT INTO `tbl_error` VALUES ('2329', 'La fecha de emision se encuentra fuera del limite permitido', '1');
INSERT INTO `tbl_error` VALUES ('2330', 'La fecha de generación de la comunicación debe ser igual a la fecha consignada en el nombre del archivo', '1');
INSERT INTO `tbl_error` VALUES ('2331', 'Número de RUC del nombre del archivo no coincide con el consignado en el contenido del archivo XML', '1');
INSERT INTO `tbl_error` VALUES ('2332', 'Número de Serie del nombre del archivo no coincide con el consignado en el contenido del archivo XML', '1');
INSERT INTO `tbl_error` VALUES ('2333', 'Número de documento en el nombre del archivo no coincide con el consignado en el contenido del XML', '1');
INSERT INTO `tbl_error` VALUES ('2334', 'El documento electrónico ingresado ha sido alterado', '1');
INSERT INTO `tbl_error` VALUES ('2335', 'El documento electrónico ingresado ha sido alterado', '1');
INSERT INTO `tbl_error` VALUES ('2336', 'Ocurrió un error en el proceso de validación de la firma digital', '1');
INSERT INTO `tbl_error` VALUES ('2337', 'La moneda debe ser la misma en todo el documento', '1');
INSERT INTO `tbl_error` VALUES ('2338', 'La moneda debe ser la misma en todo el documento', '1');
INSERT INTO `tbl_error` VALUES ('2339', 'El dato ingresado en PayableAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2340', 'El valor ingresado en AdditionalMonetaryTotal/cbc:ID es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2341', 'AdditionalMonetaryTotal/cbc:ID debe tener valor', '1');
INSERT INTO `tbl_error` VALUES ('2342', 'Fecha de emision de la factura no coincide con la informada en la comunicacion', '1');
INSERT INTO `tbl_error` VALUES ('2343', 'cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount - El dato ingresado no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2344', 'El XML no contiene el tag cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount', '1');
INSERT INTO `tbl_error` VALUES ('2345', 'La serie no corresponde al tipo de comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2346', 'La fecha de generación del resumen debe ser igual a la fecha consignada en el nombre del archivo', '1');
INSERT INTO `tbl_error` VALUES ('2347', 'Los rangos informados en el archivo XML se encuentran duplicados o superpuestos', '1');
INSERT INTO `tbl_error` VALUES ('2348', 'Los documentos informados en el archivo XML se encuentran duplicados', '1');
INSERT INTO `tbl_error` VALUES ('2349', 'Debe consignar solo un elemento sac:AdditionalMonetaryTotal con cbc:ID igual a 1001', '1');
INSERT INTO `tbl_error` VALUES ('2350', 'Debe consignar solo un elemento sac:AdditionalMonetaryTotal con cbc:ID igual a 1002', '1');
INSERT INTO `tbl_error` VALUES ('2351', 'Debe consignar solo un elemento sac:AdditionalMonetaryTotal con cbc:ID igual a 1003', '1');
INSERT INTO `tbl_error` VALUES ('2352', 'Debe consignar solo un elemento cac:TaxTotal a nivel global para IGV (cbc:ID igual a 1000)', '1');
INSERT INTO `tbl_error` VALUES ('2353', 'Debe consignar solo un elemento cac:TaxTotal a nivel global para ISC (cbc:ID igual a 2000)', '1');
INSERT INTO `tbl_error` VALUES ('2354', 'Debe consignar solo un elemento cac:TaxTotal a nivel global para Otros (cbc:ID igual a 9999)', '1');
INSERT INTO `tbl_error` VALUES ('2355', 'Debe consignar solo un elemento cac:TaxTotal a nivel de item para IGV (cbc:ID igual a 1000)', '1');
INSERT INTO `tbl_error` VALUES ('2356', 'Debe consignar solo un elemento cac:TaxTotal a nivel de item para ISC (cbc:ID igual a 2000)', '1');
INSERT INTO `tbl_error` VALUES ('2357', 'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 01', '1');
INSERT INTO `tbl_error` VALUES ('2358', 'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 02', '1');
INSERT INTO `tbl_error` VALUES ('2359', 'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 03', '1');
INSERT INTO `tbl_error` VALUES ('2360', 'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 04', '1');
INSERT INTO `tbl_error` VALUES ('2361', 'Debe consignar solo un elemento cac:TaxTotal a nivel de item para Otros (cbc:ID igual a 9999)', '1');
INSERT INTO `tbl_error` VALUES ('2362', 'Debe consignar solo un tag cac:AccountingSupplierParty/cbc:AdditionalAccountID', '1');
INSERT INTO `tbl_error` VALUES ('2363', 'Debe consignar solo un tag cac:AccountingCustomerParty/cbc:AdditionalAccountID', '1');
INSERT INTO `tbl_error` VALUES ('2364', 'El comprobante contiene un tipo y número de Guía de Remisión repetido', '1');
INSERT INTO `tbl_error` VALUES ('2365', 'El comprobante contiene un tipo y número de Documento Relacionado repetido', '1');
INSERT INTO `tbl_error` VALUES ('2366', 'El codigo en el tag sac:AdditionalProperty/cbc:ID debe tener 4 posiciones', '1');
INSERT INTO `tbl_error` VALUES ('2367', 'El dato ingresado en PriceAmount del Precio de venta unitario por item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2368', 'El dato ingresado en TaxSubtotal/cbc:TaxAmount del item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2369', 'El dato ingresado en PriceAmount del Valor de venta unitario por item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2370', 'El dato ingresado en LineExtensionAmount del item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2371', 'El XML no contiene el tag cbc:TaxExemptionReasonCode de Afectacion al IGV', '1');
INSERT INTO `tbl_error` VALUES ('2372', 'El tag en el item cac:TaxTotal/cbc:TaxAmount debe tener el mismo valor que cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount', '1');
INSERT INTO `tbl_error` VALUES ('2373', 'Si existe monto de ISC en el ITEM debe especificar el sistema de calculo', '1');
INSERT INTO `tbl_error` VALUES ('2374', 'La factura a dar de baja tiene una fecha de recepcion fuera del plazo permitido', '1');
INSERT INTO `tbl_error` VALUES ('2375', 'Fecha de emision del comprobante no coincide con la fecha de emision consignada en la comunicacion', '1');
INSERT INTO `tbl_error` VALUES ('2376', 'La boleta de venta a dar de baja fue informada en un resumen con fecha de recepcion fuera del plazo permitido', '1');
INSERT INTO `tbl_error` VALUES ('2377', 'El Name o TaxTypeCode debe corresponder con el Id para el IGV', '1');
INSERT INTO `tbl_error` VALUES ('2378', 'El Name o TaxTypeCode debe corresponder con el Id para el ISC', '1');
INSERT INTO `tbl_error` VALUES ('2379', 'La numeracion de boleta de venta a dar de baja fue generada en una fecha fuera del plazo permitido', '1');
INSERT INTO `tbl_error` VALUES ('2380', 'El documento tiene observaciones', '1');
INSERT INTO `tbl_error` VALUES ('2381', 'Comprobante no cumple con el Grupo 1: No todos los items corresponden a operaciones gravadas a IGV', '1');
INSERT INTO `tbl_error` VALUES ('2382', 'Comprobante no cumple con el Grupo 2: No todos los items corresponden a operaciones inafectas o exoneradas al IGV', '1');
INSERT INTO `tbl_error` VALUES ('2383', 'Comprobante no cumple con el Grupo 3: Falta leyenda con codigo 1002', '1');
INSERT INTO `tbl_error` VALUES ('2384', 'Comprobante no cumple con el Grupo 3: Existe item con operación onerosa', '1');
INSERT INTO `tbl_error` VALUES ('2385', 'Comprobante no cumple con el Grupo 4: Debe exitir Total descuentos mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2386', 'Comprobante no cumple con el Grupo 5: Todos los items deben tener operaciones afectas a ISC', '1');
INSERT INTO `tbl_error` VALUES ('2387', 'Comprobante no cumple con el Grupo 6: El monto de percepcion no existe o es cero', '1');
INSERT INTO `tbl_error` VALUES ('2388', 'Comprobante no cumple con el Grupo 6: Todos los items deben tener código de Afectación al IGV igual a 10', '1');
INSERT INTO `tbl_error` VALUES ('2389', 'Comprobante no cumple con el Grupo 7: El codigo de moneda no es diferente a PEN', '1');
INSERT INTO `tbl_error` VALUES ('2390', 'Comprobante no cumple con el Grupo 8: No todos los items corresponden a operaciones gravadas a IGV', '1');
INSERT INTO `tbl_error` VALUES ('2391', 'Comprobante no cumple con el Grupo 9: No todos los items corresponden a operaciones inafectas o exoneradas al IGV', '1');
INSERT INTO `tbl_error` VALUES ('2392', 'Comprobante no cumple con el Grupo 10: Falta leyenda con codigo 1002', '1');
INSERT INTO `tbl_error` VALUES ('2393', 'Comprobante no cumple con el Grupo 10: Existe item con operación onerosa', '1');
INSERT INTO `tbl_error` VALUES ('2394', 'Comprobante no cumple con el Grupo 11: Debe existir Total descuentos mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2395', 'Comprobante no cumple con el Grupo 12: El codigo de moneda no es diferente a PEN', '1');
INSERT INTO `tbl_error` VALUES ('2396', 'Si el monto total es mayor a S/. 700.00 debe consignar tipo y numero de documento del adquiriente', '1');
INSERT INTO `tbl_error` VALUES ('2397', 'El tipo de documento del adquiriente no puede ser Numero de RUC', '1');
INSERT INTO `tbl_error` VALUES ('2398', 'El documento a dar de baja se encuentra rechazado', '1');
INSERT INTO `tbl_error` VALUES ('2399', 'El tipo de documento modificado por la Nota de credito debe ser boleta electronica', '1');
INSERT INTO `tbl_error` VALUES ('2400', 'El tipo de documento modificado por la Nota de debito debe ser boleta electronica', '1');
INSERT INTO `tbl_error` VALUES ('2401', 'No se puede leer (parsear) el archivo XML', '1');
INSERT INTO `tbl_error` VALUES ('2402', 'El caso de prueba no existe', '1');
INSERT INTO `tbl_error` VALUES ('2403', 'La numeracion o nombre del documento ya ha sido enviado anteriormente', '1');
INSERT INTO `tbl_error` VALUES ('2404', 'Documento afectado por la nota electronica no se encuentra autorizado', '1');
INSERT INTO `tbl_error` VALUES ('2405', 'Contribuyente no se encuentra autorizado como emisor de boletas electronicas', '1');
INSERT INTO `tbl_error` VALUES ('2406', 'Existe mas de un tag sac:AdditionalMonetaryTotal con el mismo ID', '1');
INSERT INTO `tbl_error` VALUES ('2407', 'Existe mas de un tag sac:AdditionalProperty con el mismo ID', '1');
INSERT INTO `tbl_error` VALUES ('2408', 'El dato ingresado en PriceAmount del Valor referencial unitario por item no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2409', 'Existe mas de un tag cac:AlternativeConditionPrice con el mismo cbc:PriceTypeCode', '1');
INSERT INTO `tbl_error` VALUES ('2410', 'Se ha consignado un valor invalido en el campo cbc:PriceTypeCode', '1');
INSERT INTO `tbl_error` VALUES ('2411', 'Ha consignado mas de un elemento cac:AllowanceCharge con el mismo campo cbc:ChargeIndicator', '1');
INSERT INTO `tbl_error` VALUES ('2412', 'Se ha consignado mas de un documento afectado por la nota (tag cac:BillingReference)', '1');
INSERT INTO `tbl_error` VALUES ('2413', 'Se ha consignado mas de un motivo o sustento de la nota (tag cac:DiscrepancyResponse/cbc:Description)', '1');
INSERT INTO `tbl_error` VALUES ('2414', 'No se ha consignado en la nota el tag cac:DiscrepancyResponse', '1');
INSERT INTO `tbl_error` VALUES ('2415', 'Se ha consignado en la nota mas de un tag cac:DiscrepancyResponse', '1');
INSERT INTO `tbl_error` VALUES ('2416', 'Si existe leyenda Transferencia Gratuita debe consignar Total Valor de Venta de Operaciones Gratuitas', '1');
INSERT INTO `tbl_error` VALUES ('2417', 'Debe consignar Valor Referencial unitario por item en operaciones no onerosas', '1');
INSERT INTO `tbl_error` VALUES ('2418', 'Si consigna Valor Referencial unitario por item en operaciones no onerosas,la operacion debe ser no onerosa.', '1');
INSERT INTO `tbl_error` VALUES ('2419', 'El dato ingresado en AllowanceTotalAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2420', 'Ya transcurrieron mas de 25 dias calendarios para concluir con su proceso de homologacion', '1');
INSERT INTO `tbl_error` VALUES ('2421', 'Debe indicar  toda la informacion de  sustento de translado de bienes.', '1');
INSERT INTO `tbl_error` VALUES ('2422', 'El valor unitario debe ser menor al precio unitario.', '1');
INSERT INTO `tbl_error` VALUES ('2423', 'Si ha consignado monto ISC a nivel de item, debe consignar un monto a nivel de total.', '1');
INSERT INTO `tbl_error` VALUES ('2424', 'RC Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 05.', '1');
INSERT INTO `tbl_error` VALUES ('2425', 'Si la  operacion es gratuita PriceTypeCode =02 y cbc:PriceAmount> 0 el codigo de afectacion de igv debe ser  no onerosa es  decir diferente de 10,20,30.', '1');
INSERT INTO `tbl_error` VALUES ('2426', 'Documentos relacionados duplicados en el comprobante.', '1');
INSERT INTO `tbl_error` VALUES ('2427', 'Solo debe de existir un tag AdditionalInformation.', '1');
INSERT INTO `tbl_error` VALUES ('2428', 'Comprobante no cumple con grupo de facturas con detracciones.', '1');
INSERT INTO `tbl_error` VALUES ('2429', 'Comprobante no cumple con grupo de facturas con comercio exterior.', '1');
INSERT INTO `tbl_error` VALUES ('2430', 'Comprobante no cumple con grupo de facturas con tag de factura guia.', '1');
INSERT INTO `tbl_error` VALUES ('2431', 'Comprobante no cumple con grupo de facturas con tags no tributarios.', '1');
INSERT INTO `tbl_error` VALUES ('2432', 'Comprobante no cumple con grupo de boletas con tags no tributarios.', '1');
INSERT INTO `tbl_error` VALUES ('2433', 'Comprobante no cumple con grupo de facturas con tag venta itinerante.', '1');
INSERT INTO `tbl_error` VALUES ('2434', 'Comprobante no cumple con grupo de boletas con tag venta itinerante.', '1');
INSERT INTO `tbl_error` VALUES ('2435', 'Comprobante no cumple con grupo de boletas con ISC.', '1');
INSERT INTO `tbl_error` VALUES ('2436', 'Comprobante no cumple con el grupo de boletas de venta con percepcion: El monto de percepcion no existe o es cero.', '1');
INSERT INTO `tbl_error` VALUES ('2437', 'Comprobante no cumple con el grupo de boletas de venta con percepcion: Todos los items deben tener código de Afectación al IGV igual a 10.', '1');
INSERT INTO `tbl_error` VALUES ('2438', 'Comprobante no cumple con grupo de facturas con tag venta anticipada I.', '1');
INSERT INTO `tbl_error` VALUES ('2439', 'Comprobante no cumple con grupo de facturas con tag venta anticipada II.', '1');
INSERT INTO `tbl_error` VALUES ('2500', 'Ingresar descripción y valor venta por ítem para documento de anticipos.', '1');
INSERT INTO `tbl_error` VALUES ('2501', 'Valor venta debe ser mayor a cero.', '1');
INSERT INTO `tbl_error` VALUES ('2502', 'Los valores totales deben ser mayores a cero.', '1');
INSERT INTO `tbl_error` VALUES ('2503', 'PaidAmount: monto anticipado por documento debe ser mayor a cero.', '1');
INSERT INTO `tbl_error` VALUES ('2504', 'Falta referencia de la factura relacionada con anticipo.', '1');
INSERT INTO `tbl_error` VALUES ('2505', 'cac:PrepaidPayment/cbc:ID/@SchemaID: Código de referencia debe ser 02 o 03.', '1');
INSERT INTO `tbl_error` VALUES ('2506', 'cac:PrepaidPayment/cbc:ID: Factura o boleta no existe o comunicada de Baja.', '1');
INSERT INTO `tbl_error` VALUES ('2507', 'Factura relacionada con anticipo no corresponde como factura de anticipo.', '1');
INSERT INTO `tbl_error` VALUES ('2508', 'Ingresar documentos por anticipos.', '1');
INSERT INTO `tbl_error` VALUES ('2509', 'Total de anticipos diferente a los montos anticipados por documento.', '1');
INSERT INTO `tbl_error` VALUES ('2510', 'Nro nombre del documento no tiene el formato correcto.', '1');
INSERT INTO `tbl_error` VALUES ('2511', 'El tipo de documento no es aceptado.', '1');
INSERT INTO `tbl_error` VALUES ('2512', 'No existe información de serie o número.', '1');
INSERT INTO `tbl_error` VALUES ('2513', 'Dato no cumple con formato de acuerdo al número de comprobante.', '1');
INSERT INTO `tbl_error` VALUES ('2514', 'No existe información de receptor de documento.', '1');
INSERT INTO `tbl_error` VALUES ('2515', 'Dato ingresado no cumple con catalogo 6.', '1');
INSERT INTO `tbl_error` VALUES ('2516', 'Debe indicar tipo de documento.', '1');
INSERT INTO `tbl_error` VALUES ('2517', 'Dato no cumple con formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2518', 'Calculo IGV no es correcto.', '1');
INSERT INTO `tbl_error` VALUES ('2519', 'El importe total no coincide con la sumatoria de los valores de venta mas los tributos mas los cargos menos los descuentos que no afectan la base imponible', '1');
INSERT INTO `tbl_error` VALUES ('2520', 'El tipo documento debe ser 6 del catalogo de tipo de documento.', '1');
INSERT INTO `tbl_error` VALUES ('2521', 'El dato ingresado debe indicar SERIE-CORRELATIVO del documento que se realizo el anticipo.', '1');
INSERT INTO `tbl_error` VALUES ('2522', 'No Se indica el código de tipo de operacion.', '1');
INSERT INTO `tbl_error` VALUES ('2523', 'GrossWeightMeasure - El dato ingresado no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2524', 'El dato ingresado en Amount no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2525', 'El dato ingresado en Quantity no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2526', 'El dato ingresado en Percent no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2527', 'PrepaidAmount: Monto total anticipado debe ser mayor a cero.', '1');
INSERT INTO `tbl_error` VALUES ('2528', 'cac:OriginatorDocumentReference/cbc:ID/@SchemaID - El tipo documento debe ser 6 del catalogo de tipo de documento.', '1');
INSERT INTO `tbl_error` VALUES ('2529', 'RUC que emitio documento de anticipo, no existe.', '1');
INSERT INTO `tbl_error` VALUES ('2530', 'RUC que solicita la emision de la factura, no existe.', '1');
INSERT INTO `tbl_error` VALUES ('2531', 'Codigo del Local Anexo del emisor no existe.', '1');
INSERT INTO `tbl_error` VALUES ('2532', 'No existe información de modalidad de transporte.', '1');
INSERT INTO `tbl_error` VALUES ('2533', 'Si ha consignado Transporte Privado, debe consignar Licencia de conducir, Placa, N constancia de inscripcion y marca del vehiculo.', '1');
INSERT INTO `tbl_error` VALUES ('2534', 'Si ha consignado Transporte púbico, debe consignar Datos del transportista.', '1');
INSERT INTO `tbl_error` VALUES ('2535', 'La nota de crédito por otros conceptos tributarios debe tener Otros Documentos Relacionados.', '1');
INSERT INTO `tbl_error` VALUES ('2536', 'Serie y numero no se encuentra registrado como baja por cambio de destinatario.', '1');
INSERT INTO `tbl_error` VALUES ('2537', 'cac:OrderReference/cac:DocumentReference/cbc:DocumentTypeCode - El tipo de documento de serie y número dado de baja es incorrecta.', '1');
INSERT INTO `tbl_error` VALUES ('2538', 'El contribuyente no se encuentra autorizado como emisor electronico de Guía o de factura o de boletaFactura GEM.', '1');
INSERT INTO `tbl_error` VALUES ('2539', 'El contribuyente no esta activo.', '1');
INSERT INTO `tbl_error` VALUES ('2540', 'El contribuyente no esta habido.', '1');
INSERT INTO `tbl_error` VALUES ('2541', 'El XML no contiene el tag o no existe informacion del tipo de documento identidad del remitente.', '1');
INSERT INTO `tbl_error` VALUES ('2542', 'cac:DespatchSupplierParty/cbc:CustomerAssignedAccountID@schemeID - El valor ingresado como tipo de documento identidad del remitente es incorrecta.', '1');
INSERT INTO `tbl_error` VALUES ('2543', 'El XML no contiene el tag o no existe informacion de la dirección completa y detallada en domicilio fiscal.', '1');
INSERT INTO `tbl_error` VALUES ('2544', 'El XML no contiene el tag o no existe información de la provincia en domicilio fiscal.', '1');
INSERT INTO `tbl_error` VALUES ('2545', 'El XML no contiene el tag o no existe información del departamento en domicilio fiscal.', '1');
INSERT INTO `tbl_error` VALUES ('2546', 'El XML no contiene el tag o no existe información del distrito en domicilio fiscal.', '1');
INSERT INTO `tbl_error` VALUES ('2547', 'El XML no contiene el tag o no existe información del país en domicilio fiscal.', '1');
INSERT INTO `tbl_error` VALUES ('2548', 'El valor del país inválido.', '1');
INSERT INTO `tbl_error` VALUES ('2549', 'El XML no contiene el tag o no existe informacion del tipo de documento identidad del destinatario.', '1');
INSERT INTO `tbl_error` VALUES ('2550', 'cac:DeliveryCustomerParty/cbc:CustomerAssignedAccountID@schemeID - El dato ingresado de tipo de documento identidad del destinatario no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2551', 'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del proveedor de servicios.', '1');
INSERT INTO `tbl_error` VALUES ('2552', 'El XML no contiene el tag o no existe informacion del tipo de documento identidad del proveedor.', '1');
INSERT INTO `tbl_error` VALUES ('2553', 'cac:SellerSupplierParty/cbc:CustomerAssignedAccountID@schemeID - El dato ingresado no es valido.', '1');
INSERT INTO `tbl_error` VALUES ('2554', 'Para el motivo de traslado ingresado el Destinatario debe ser igual al remitente.', '1');
INSERT INTO `tbl_error` VALUES ('2555', 'Destinatario no debe ser igual al remitente.', '1');
INSERT INTO `tbl_error` VALUES ('2556', 'cbc:TransportModeCode -  dato ingresado no es valido.', '1');
INSERT INTO `tbl_error` VALUES ('2557', 'La fecha del StartDate no debe ser menor al Today.', '1');
INSERT INTO `tbl_error` VALUES ('2558', 'El XML no contiene el tag o no existe informacion en Numero de Ruc del transportista.', '1');
INSERT INTO `tbl_error` VALUES ('2559', '/DespatchAdvice/cac:Shipment/cac:ShipmentStage/cac:CarrierParty/cac:PartyIdentification/cbc:ID  - El dato ingresado no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2560', 'Transportista  no debe ser igual al remitente o destinatario.', '1');
INSERT INTO `tbl_error` VALUES ('2561', 'El XML no contiene el tag o no existe informacion del tipo de documento identidad del transportista.', '1');
INSERT INTO `tbl_error` VALUES ('2562', '/DespatchAdvice/cac:Shipment/cac:ShipmentStage/cac:CarrierParty/cac:PartyIdentification/cbc:ID@schemeID  - El dato ingresado no es valido.', '1');
INSERT INTO `tbl_error` VALUES ('2563', 'El XML no contiene el tag o no existe informacion de Apellido, Nombre o razon social del transportista.', '1');
INSERT INTO `tbl_error` VALUES ('2564', 'Razon social transportista - El dato ingresado no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2565', 'El XML no contiene el tag o no existe informacion del tipo de unidad de transporte.', '1');
INSERT INTO `tbl_error` VALUES ('2566', 'El XML no contiene el tag o no existe informacion del Numero de placa del vehículo.', '1');
INSERT INTO `tbl_error` VALUES ('2567', 'Numero de placa del vehículo - El dato ingresado no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2568', 'El XML no contiene el tag o no existe informacion en el Numero de documento de identidad del conductor.', '1');
INSERT INTO `tbl_error` VALUES ('2569', 'Documento identidad del conductor - El dato ingresado no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2570', 'El XML no contiene el tag o no existe informacion del tipo de documento identidad del conductor.', '1');
INSERT INTO `tbl_error` VALUES ('2571', 'cac:DriverPerson/ID@schemeID - El valor ingresado de tipo de documento identidad de conductor es incorrecto.', '1');
INSERT INTO `tbl_error` VALUES ('2572', 'El XML no contiene el tag o no existe informacion del Numero de licencia del conductor.', '1');
INSERT INTO `tbl_error` VALUES ('2573', 'Numero de licencia del conductor - El dato ingresado no cumple con el formato establecido.', '1');
INSERT INTO `tbl_error` VALUES ('2574', 'El XML no contiene el tag o no existe informacion de direccion detallada de punto de llegada.', '1');
INSERT INTO `tbl_error` VALUES ('2575', 'El XML no contiene el tag o no existe informacion de CityName.', '1');
INSERT INTO `tbl_error` VALUES ('2576', 'El XML no contiene el tag o no existe informacion de District.', '1');
INSERT INTO `tbl_error` VALUES ('2577', 'El XML no contiene el tag o no existe informacion de direccion detallada de punto de partida.', '1');
INSERT INTO `tbl_error` VALUES ('2578', 'El XML no contiene el tag o no existe informacion de CityName.', '1');
INSERT INTO `tbl_error` VALUES ('2579', 'El XML no contiene el tag o no existe informacion de District.', '1');
INSERT INTO `tbl_error` VALUES ('2580', 'El XML No contiene el tag o no existe información de la cantidad del item.', '1');
INSERT INTO `tbl_error` VALUES ('2600', 'El comprobante fue enviado fuera del plazo permitido.', '1');
INSERT INTO `tbl_error` VALUES ('2601', 'Señor contribuyente a la fecha no se encuentra registrado ó habilitado con la condición de Agente de percepción.', '1');
INSERT INTO `tbl_error` VALUES ('2602', 'El régimen percepción enviado no corresponde con su condición de Agente de percepción.', '1');
INSERT INTO `tbl_error` VALUES ('2603', 'La tasa de percepción enviada no corresponde con el régimen de percepción.', '1');
INSERT INTO `tbl_error` VALUES ('2604', 'El Cliente no puede ser el mismo que el Emisor del comprobante de percepción.', '1');
INSERT INTO `tbl_error` VALUES ('2605', 'Número de RUC del Cliente no existe.', '1');
INSERT INTO `tbl_error` VALUES ('2606', 'Documento de identidad del Cliente no existe.', '1');
INSERT INTO `tbl_error` VALUES ('2607', 'La moneda del importe de cobro debe ser la misma que la del documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2608', 'Los montos de pago, percibidos y montos cobrados consignados para el documento relacionado no son correctos.', '1');
INSERT INTO `tbl_error` VALUES ('2609', 'El comprobante electrónico enviado no se encuentra registrado en la SUNAT.', '1');
INSERT INTO `tbl_error` VALUES ('2610', 'La fecha de emisión, Importe total del comprobante y la moneda del comprobante electrónico enviado no son los registrados en los Sistemas de SUNAT.', '1');
INSERT INTO `tbl_error` VALUES ('2611', 'El comprobante electrónico no ha sido emitido al cliente.', '1');
INSERT INTO `tbl_error` VALUES ('2612', 'La fecha de cobro debe estar entre el primer día calendario del mes al cual corresponde la fecha de emisión del comprobante de percepción o desde la fecha de emisión del comprobante relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2613', 'El Nro. de documento con número de cobro ya se encuentra en la Relación de Documentos Relacionados agregados.', '1');
INSERT INTO `tbl_error` VALUES ('2614', 'El Nro. de documento con el número de cobro ya se encuentra registrado como pago realizado.', '1');
INSERT INTO `tbl_error` VALUES ('2615', 'Importe total percibido debe ser igual a la suma de los importes percibidos por cada documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2616', 'Importe total cobrado debe ser igual a la suma de los importe totales cobrados por cada documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2617', 'Señor contribuyente a la fecha no se encuentra registrado ó habilitado con la condición de Agente de retención.', '1');
INSERT INTO `tbl_error` VALUES ('2618', 'El régimen retención enviado no corresponde con su condición de Agente de retención.', '1');
INSERT INTO `tbl_error` VALUES ('2619', 'La tasa de retención enviada no corresponde con el régimen de retención.', '1');
INSERT INTO `tbl_error` VALUES ('2620', 'El Proveedor no puede ser el mismo que el Emisor del comprobante de retención.', '1');
INSERT INTO `tbl_error` VALUES ('2621', 'Número de RUC del Proveedor no existe.', '1');
INSERT INTO `tbl_error` VALUES ('2622', 'La moneda del importe de pago debe ser la misma que la del documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2623', 'Los montos de pago, retenidos y montos pagados consignados para el documento relacionado no son correctos.', '1');
INSERT INTO `tbl_error` VALUES ('2624', 'El comprobante electrónico no ha sido emitido por el proveedor.', '1');
INSERT INTO `tbl_error` VALUES ('2625', 'La fecha de pago debe estar entre el primer día calendario del mes al cual corresponde la fecha de emisión del comprobante de retención o desde la fecha de emisión del comprobante relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2626', 'El Nro. de documento con el número de pago ya se encuentra en la Relación de Documentos Relacionados agregados.', '1');
INSERT INTO `tbl_error` VALUES ('2627', 'El Nro. de documento con el número de pago ya se encuentra registrado como pago realizado.', '1');
INSERT INTO `tbl_error` VALUES ('2628', 'Importe total retenido debe ser igual a la suma de los importes retenidos por cada documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2629', 'Importe total pagado debe ser igual a la suma de los importes pagados por cada documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2630', 'La serie o numero del documento(01) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', '1');
INSERT INTO `tbl_error` VALUES ('2631', 'La serie o numero del documento(12) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', '1');
INSERT INTO `tbl_error` VALUES ('2632', 'La serie o numero del documento(56) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', '1');
INSERT INTO `tbl_error` VALUES ('2633', 'La serie o numero del documento(03) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', '1');
INSERT INTO `tbl_error` VALUES ('2634', 'ReferenceID - El dato ingresado debe indicar serie correcta del documento al que se relaciona la Nota tipo 10.', '1');
INSERT INTO `tbl_error` VALUES ('2635', 'Debe existir DocumentTypeCode de Otros documentos relacionados con valor 99 para un tipo codigo Nota Credito 10.', '1');
INSERT INTO `tbl_error` VALUES ('2636', 'No existe datos del ID de los documentos relacionados con valor 99 para un tipo codigo Nota Credito 10.', '1');
INSERT INTO `tbl_error` VALUES ('2637', 'No existe datos del DocumentType de los documentos relacionados con valor 99 para un tipo codigo Nota Credito 10.', '1');
INSERT INTO `tbl_error` VALUES ('2640', 'Operacion gratuita, solo debe consignar un monto referencial', '1');
INSERT INTO `tbl_error` VALUES ('2641', 'Operacion gratuita,  debe consignar Total valor venta - operaciones gratuitas  mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2642', 'Operaciones de exportacion, deben consignar Tipo Afectacion igual a 40', '1');
INSERT INTO `tbl_error` VALUES ('2643', 'Factura de operacion sujeta IVAP debe consignar Monto de impuestos por item', '1');
INSERT INTO `tbl_error` VALUES ('2644', 'Factura de operacion sujeta IVAP solo debe tener ítems con código afectación IGV 17.', '1');
INSERT INTO `tbl_error` VALUES ('2645', 'Factura de operacion sujeta a IVAP debe consignar items con codigo de tributo 1000', '1');
INSERT INTO `tbl_error` VALUES ('2646', 'Factura de operacion sujeta a IVAP debe consignar  items con nombre  de tributo IVAP', '1');
INSERT INTO `tbl_error` VALUES ('2647', 'Código tributo  UN/ECE debe ser VAT', '1');
INSERT INTO `tbl_error` VALUES ('2648', 'Factura de operacion sujeta al IVAP, solo puede consignar informacion para operacion gravadas', '1');
INSERT INTO `tbl_error` VALUES ('2649', 'Operación sujeta al IVAP, debe consignar monto en total operaciones gravadas', '1');
INSERT INTO `tbl_error` VALUES ('2650', 'Factura de operacion sujeta al IVAP , no debe consignar valor para ISC o debe ser 0', '1');
INSERT INTO `tbl_error` VALUES ('2651', 'Factura de operacion sujeta al IVAP , no debe consignar valor para IGV o debe ser 0', '1');
INSERT INTO `tbl_error` VALUES ('2652', 'Factura de operacion sujeta al IVAP , debe registrar mensaje 2007', '1');
INSERT INTO `tbl_error` VALUES ('2653', 'Servicios prestados No domiciliados. Total IGV debe se mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2654', 'Servicios prestados No domiciliados. Código tributo a consignar debe ser 1000', '1');
INSERT INTO `tbl_error` VALUES ('2655', 'Servicios prestados No domiciliados. El código de afectación debe ser 40', '1');
INSERT INTO `tbl_error` VALUES ('2656', 'Servicios prestados No domiciliados. Código tributo  UN/ECE debe ser VAT', '1');
INSERT INTO `tbl_error` VALUES ('2657', 'El Nro. de documento ya fué utilizado en la emision de CPE.', '1');
INSERT INTO `tbl_error` VALUES ('2658', 'El Nro. de documento no se ha informado o no se encuentra en estado Revertido', '1');
INSERT INTO `tbl_error` VALUES ('2659', 'La fecha de cobro de cada documento relacionado deben ser del mismo Periodo (mm/aaaa), asimismo estas fechas podrán ser menores o iguales a la fecha de emisión del comprobante de percepción', '1');
INSERT INTO `tbl_error` VALUES ('2660', 'Los datos del CPE revertido no corresponden a los registrados en la SUNAT', '1');
INSERT INTO `tbl_error` VALUES ('2661', 'La fecha de cobro de cada documento relacionado deben ser del mismo Periodo (mm/aaaa), asimismo estas fechas podrán ser menores o iguales a la fecha de emisión del comprobante de retencion', '1');
INSERT INTO `tbl_error` VALUES ('2662', 'El Nro. de documento ya fué utilizado en la emision de CRE.', '1');
INSERT INTO `tbl_error` VALUES ('2663', 'El documento indicado no existe no puede ser modificado/eliminado', '1');
INSERT INTO `tbl_error` VALUES ('2664', 'El calculo de la base imponible de percepción y el monto de la percepción no coincide con el monto total informado.', '1');
INSERT INTO `tbl_error` VALUES ('2665', 'El contribuyente no se encuentra autorizado a emitir Tickets', '1');
INSERT INTO `tbl_error` VALUES ('2666', 'Las percepciones son solo válidas para boletas de venta al contado.', '1');
INSERT INTO `tbl_error` VALUES ('2667', 'Importe total percibido debe ser igual a la suma de los importes percibidos por cada documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2668', 'Importe total cobrado debe ser igual a la suma de los importes cobrados por cada documento relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2669', 'El dato ingresado en TotalInvoiceAmount debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2670', 'La razón social no corresponde al ruc informado.', '1');
INSERT INTO `tbl_error` VALUES ('2671', 'La fecha de generación de la comunicación debe ser mayor o igual a la fecha de generación del documento revertido.', '1');
INSERT INTO `tbl_error` VALUES ('2672', 'La fecha de generación del documento revertido debe ser menor o igual a la fecha actual.', '1');
INSERT INTO `tbl_error` VALUES ('2673', 'El dato ingresado no cumple con el formato RR-fecha-correlativo.', '1');
INSERT INTO `tbl_error` VALUES ('2674', 'El dato ingresado  no cumple con el formato de DocumentSerialID, para DocumentTypeCode con valor 20.', '1');
INSERT INTO `tbl_error` VALUES ('2675', 'El dato ingresado  no cumple con el formato de DocumentSerialID, para DocumentTypeCode con valor 40.', '1');
INSERT INTO `tbl_error` VALUES ('2676', 'El XML no contiene el tag o no existe información del número de RUC del emisor', '1');
INSERT INTO `tbl_error` VALUES ('2677', 'El valor ingresado como número de RUC del emisor es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2678', 'El XML no contiene el atributo o no existe información del tipo de documento del emisor', '1');
INSERT INTO `tbl_error` VALUES ('2679', 'El XML no contiene el tag o no existe información del número de documento de identidad del cliente', '1');
INSERT INTO `tbl_error` VALUES ('2680', 'El valor ingresado como documento de identidad del cliente es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2681', 'El XML no contiene el atributo o no existe información del tipo de documento del cliente', '1');
INSERT INTO `tbl_error` VALUES ('2682', 'El valor ingresado como tipo de documento del cliente es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2683', 'El XML no contiene el tag o no existe información del Importe total Percibido', '1');
INSERT INTO `tbl_error` VALUES ('2684', 'El XML no contiene el tag o no existe información de la moneda del Importe total Percibido', '1');
INSERT INTO `tbl_error` VALUES ('2685', 'El valor de la moneda del Importe total Percibido debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2686', 'El XML no contiene el tag o no existe información del Importe total Cobrado', '1');
INSERT INTO `tbl_error` VALUES ('2687', 'El dato ingresado en SUNATTotalCashed debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2689', 'El XML no contiene el tag o no existe información de la moneda del Importe total Cobrado', '1');
INSERT INTO `tbl_error` VALUES ('2690', 'El valor de la moneda del Importe total Cobrado debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2691', 'El XML no contiene el tag o no existe información del tipo de documento relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2692', 'El tipo de documento relacionado no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2693', 'El XML no contiene el tag o no existe información del número de documento relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2694', 'El número de documento relacionado no está permitido o no es valido', '1');
INSERT INTO `tbl_error` VALUES ('2695', 'El XML no contiene el tag o no existe información del Importe total documento Relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2696', 'El dato ingresado en el importe total documento relacionado debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2697', 'El XML no contiene el tag o no existe información del número de cobro', '1');
INSERT INTO `tbl_error` VALUES ('2698', 'El dato ingresado en el número de cobro no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2699', 'El XML no contiene el tag o no existe información del Importe del cobro', '1');
INSERT INTO `tbl_error` VALUES ('2700', 'El dato ingresado en el Importe del cobro debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2701', 'El XML no contiene el tag o no existe información de la moneda del documento Relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2702', 'El XML no contiene el tag o no existe información de la fecha de cobro del documento Relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2703', 'La fecha de cobro del documento relacionado no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2704', 'El XML no contiene el tag o no existe información del Importe percibido', '1');
INSERT INTO `tbl_error` VALUES ('2705', 'El dato ingresado en el Importe percibido debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2706', 'El XML no contiene el tag o no existe información de la moneda de importe percibido', '1');
INSERT INTO `tbl_error` VALUES ('2707', 'El valor de la moneda de importe percibido debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2708', 'El XML no contiene el tag o no existe información de la Fecha de Percepción', '1');
INSERT INTO `tbl_error` VALUES ('2709', 'La fecha de percepción no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2710', 'El XML no contiene el tag o no existe información del Monto total a cobrar', '1');
INSERT INTO `tbl_error` VALUES ('2711', 'El dato ingresado en el Monto total a cobrar debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2712', 'El XML no contiene el tag o no existe información de la moneda del Monto total a cobrar', '1');
INSERT INTO `tbl_error` VALUES ('2713', 'El valor de la moneda del Monto total a cobrar debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2714', 'El valor de la moneda de referencia para el tipo de cambio no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2715', 'El valor de la moneda objetivo para la Tasa de Cambio debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2716', 'El dato ingresado en el tipo de cambio debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2717', 'La fecha de cambio no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2718', 'El valor de la moneda del documento Relacionado no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2719', 'El XML no contiene el tag o no existe información de la moneda de referencia para el tipo de cambio', '1');
INSERT INTO `tbl_error` VALUES ('2720', 'El XML no contiene el tag o no existe información de la moneda objetivo para la Tasa de Cambio', '1');
INSERT INTO `tbl_error` VALUES ('2721', 'El XML no contiene el tag o no existe información del tipo de cambio', '1');
INSERT INTO `tbl_error` VALUES ('2722', 'El XML no contiene el tag o no existe información de la fecha de cambio', '1');
INSERT INTO `tbl_error` VALUES ('2723', 'El XML no contiene el tag o no existe información del número de documento de identidad del proveedor', '1');
INSERT INTO `tbl_error` VALUES ('2724', 'El valor ingresado como documento de identidad del proveedor es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2725', 'El XML no contiene el tag o no existe información del Importe total Retenido', '1');
INSERT INTO `tbl_error` VALUES ('2726', 'El XML no contiene el tag o no existe información de la moneda del Importe total Retenido', '1');
INSERT INTO `tbl_error` VALUES ('2727', 'El XML no contiene el tag o no existe información de la moneda del Importe total Retenido', '1');
INSERT INTO `tbl_error` VALUES ('2728', 'El valor de la moneda del Importe total Retenido debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2729', 'El XML no contiene el tag o no existe información del Importe total Pagado', '1');
INSERT INTO `tbl_error` VALUES ('2730', 'El dato ingresado en SUNATTotalPaid debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2731', 'El XML no contiene el tag o no existe información de la moneda del Importe total Pagado', '1');
INSERT INTO `tbl_error` VALUES ('2732', 'El valor de la moneda del Importe total Pagado debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2733', 'El XML no contiene el tag o no existe información del número de pago', '1');
INSERT INTO `tbl_error` VALUES ('2734', 'El dato ingresado en el número de pago no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2735', 'El XML no contiene el tag o no existe información del Importe del pago', '1');
INSERT INTO `tbl_error` VALUES ('2736', 'El dato ingresado en el Importe del pago debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2737', 'El XML no contiene el tag o no existe información de la fecha de pago del documento Relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2738', 'La fecha de pago del documento relacionado no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2739', 'El XML no contiene el tag o no existe información del Importe retenido', '1');
INSERT INTO `tbl_error` VALUES ('2740', 'El dato ingresado en el Importe retenido debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2741', 'El XML no contiene el tag o no existe información de la moneda de importe retenido', '1');
INSERT INTO `tbl_error` VALUES ('2742', 'El valor de la moneda de importe retenido debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2743', 'El XML no contiene el tag o no existe información de la Fecha de Retención', '1');
INSERT INTO `tbl_error` VALUES ('2744', 'La fecha de retención no es válido', '1');
INSERT INTO `tbl_error` VALUES ('2745', 'El XML no contiene el tag o no existe información del Importe total a pagar (neto)', '1');
INSERT INTO `tbl_error` VALUES ('2746', 'El dato ingresado en el Importe total a pagar (neto) debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2747', 'El XML no contiene el tag o no existe información de la Moneda del monto neto pagado', '1');
INSERT INTO `tbl_error` VALUES ('2748', 'El valor de la Moneda del monto neto pagado debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2749', 'La moneda de referencia para el tipo de cambio debe ser la misma que la del documento relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2750', 'El comprobante que desea revertir no existe.', '1');
INSERT INTO `tbl_error` VALUES ('2751', 'El comprobante fue informado previamente en una reversión.', '1');
INSERT INTO `tbl_error` VALUES ('2752', 'El número de ítem no puede estar duplicado.', '1');
INSERT INTO `tbl_error` VALUES ('2753', 'No debe existir mas de una referencia en guía dada de baja.', '1');
INSERT INTO `tbl_error` VALUES ('2754', 'El tipo de documento de la guia dada de baja es incorrecto (tipo documento = 09).', '1');
INSERT INTO `tbl_error` VALUES ('2755', 'El tipo de documento relacionado es incorrecto (ver catalogo nro 21).', '1');
INSERT INTO `tbl_error` VALUES ('2756', 'El numero de documento relacionado no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2757', 'El XML no contiene el tag o no existe información del número de documento de identidad del destinatario.', '1');
INSERT INTO `tbl_error` VALUES ('2758', 'El valor ingresado como numero de documento de identidad del destinatario no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2759', 'El XML no contiene el atributo o no existe información del tipo de documento del destinatario.', '1');
INSERT INTO `tbl_error` VALUES ('2760', 'El valor ingresado como tipo de documento del destinatario es incorrecto.', '1');
INSERT INTO `tbl_error` VALUES ('2761', 'El XML no contiene el atributo o no existe información del nombre o razon social del destinatario.', '1');
INSERT INTO `tbl_error` VALUES ('2762', 'El valor ingresado como tipo de documento del nombre o razon social del destinatario es incorrecto.', '1');
INSERT INTO `tbl_error` VALUES ('2763', 'El XML no contiene el tag o no existe información del número de documento de identidad del tercero relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2764', 'El valor ingresado como numero de documento de identidad del tercero relacionado no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2765', 'El XML no contiene el atributo o no existe información del tipo de documento del tercero relacionado.', '1');
INSERT INTO `tbl_error` VALUES ('2766', 'El valor ingresado como tipo de documento del tercero relacionado es incorrecto.', '1');
INSERT INTO `tbl_error` VALUES ('2767', 'Para importación, el XML no contiene el tag o no existe informacion del numero de DAM.', '1');
INSERT INTO `tbl_error` VALUES ('2768', 'Para importación, el XML no contiene el tag o no existe informacion del numero de manifiesto de carga.', '1');
INSERT INTO `tbl_error` VALUES ('2769', 'El valor ingresado como numero de DAM no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2770', 'El valor ingresado como numero de manifiesto de carga no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2771', 'El XML no contiene el atributo o no existe informacion en numero de bultos o pallets obligatorio para importación.', '1');
INSERT INTO `tbl_error` VALUES ('2772', 'El valor ingresado como numero de bultos o pallets no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2773', 'El valor ingresado como modalidad de transporte no es correcto.', '1');
INSERT INTO `tbl_error` VALUES ('2774', 'El XML no contiene datos de vehiculo o datos de conductores para una operación de transporte publico completo.', '1');
INSERT INTO `tbl_error` VALUES ('2775', 'El XML no contiene el atributo o no existe informacion del codigo de ubigeo.', '1');
INSERT INTO `tbl_error` VALUES ('2776', 'El valor ingresado como codigo de ubigeo no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2777', 'El XML no contiene el atributo o no existe informacion de direccion completa y detallada.', '1');
INSERT INTO `tbl_error` VALUES ('2778', 'El valor ingresado como direccion completa y detallada no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2779', 'El XML no contiene el atributo o no existe informacion de cantida de items', '1');
INSERT INTO `tbl_error` VALUES ('2780', 'El valor ingresado en cantidad de items no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2781', 'El XML no contiene el atributo o no existe informacion de descripcion del items', '1');
INSERT INTO `tbl_error` VALUES ('2782', 'El valor ingresado en descripcion del items no cumple con el estandar', '1');
INSERT INTO `tbl_error` VALUES ('2783', 'El valor ingresado en codigo del item no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2784', 'Debe consignar codigo de regimen de percepcion (sac:AdditionalMonetaryTotal/cbc:ID@schemeID).', '1');
INSERT INTO `tbl_error` VALUES ('2785', 'sac:ReferenceAmount es obligatorio y mayor a cero cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', '1');
INSERT INTO `tbl_error` VALUES ('2786', 'El dato ingresado en sac:ReferenceAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2787', 'Debe consignar la moneda para la Base imponible percepcion (sac:ReferenceAmount/@currencyID)', '1');
INSERT INTO `tbl_error` VALUES ('2788', 'El dato ingresado en moneda debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2789', 'cbc:PayableAmount es obligatorio y mayor a cero cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', '1');
INSERT INTO `tbl_error` VALUES ('2790', 'El dato ingresado en cbc:PayableAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2791', 'Debe consignar la moneda para el Monto de la percepcion (cbc:PayableAmount/@currencyID)', '1');
INSERT INTO `tbl_error` VALUES ('2792', 'El dato ingresado en moneda del monto de cargo/descuento para percepcion debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2793', 'sac:TotalAmount es obligatorio y mayor a cero cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', '1');
INSERT INTO `tbl_error` VALUES ('2794', 'El dato ingresado en sac:TotalAmount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2795', 'Debe consignar la moneda para el Monto Total incluido la percepcion (sac:TotalAmount/@currencyID)', '1');
INSERT INTO `tbl_error` VALUES ('2796', 'El dato ingresado en sac:TotalAmount/@currencyID debe ser PEN', '1');
INSERT INTO `tbl_error` VALUES ('2797', 'El monto de percepcion no puede ser mayor al importe total del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2798', 'El Monto de percepcion no tiene el valor correcto según el tipo de percepcion.', '1');
INSERT INTO `tbl_error` VALUES ('2799', 'sac:TotalAmount no tiene el valor correcto cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', '1');
INSERT INTO `tbl_error` VALUES ('2800', 'El dato ingresado en el tipo de documento de identidad del receptor no esta permitido.', '1');
INSERT INTO `tbl_error` VALUES ('2801', 'CustomerAssignedAccountID -  El DNI ingresado no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2802', 'CustomerAssignedAccountID -  El RUC ingresado no cumple con el estandar.', '1');
INSERT INTO `tbl_error` VALUES ('2803', 'ID - No cumple con el formato UUID', '1');
INSERT INTO `tbl_error` VALUES ('2804', 'La fecha de recepcion del comprobante por ose, no debe de ser mayor a la fecha de recepcion de sunat', '1');
INSERT INTO `tbl_error` VALUES ('2805', 'El XML no contiene el tag IssueTime', '1');
INSERT INTO `tbl_error` VALUES ('2806', 'IssueTime - El dato ingresado  no cumple con el patrón hh:mm:ss.sssss', '1');
INSERT INTO `tbl_error` VALUES ('2807', 'El XML no contiene el tag ResponseDate', '1');
INSERT INTO `tbl_error` VALUES ('2808', 'ResponseDate - El dato ingresado  no cumple con el patrón YYYY-MM-DD', '1');
INSERT INTO `tbl_error` VALUES ('2809', 'La fecha de recepcion del comprobante por ose, no debe de ser mayor a la fecha de comprobacion del ose', '1');
INSERT INTO `tbl_error` VALUES ('2810', 'La fecha de comprobacion del comprobante en OSE no puede ser mayor a la fecha de recepcion en SUNAT.', '1');
INSERT INTO `tbl_error` VALUES ('2811', 'El XML no contiene el tag ResponseTime', '1');
INSERT INTO `tbl_error` VALUES ('2812', 'ResponseTime - El dato ingresado  no cumple con el patrón hh:mm:ss.sssss', '1');
INSERT INTO `tbl_error` VALUES ('2813', 'El XML no contiene el tag o no existe información del Número de documento de identificación del que envía el CPE (emisor o PSE)', '1');
INSERT INTO `tbl_error` VALUES ('2814', 'El valor ingresado como Número de documento de identificación del que envía el CPE (emisor o PSE) es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2816', 'El XML no contiene el atributo schemeID o no existe información del Tipo de documento de identidad del que envía el CPE (emisor o PSE)', '1');
INSERT INTO `tbl_error` VALUES ('2817', 'El valor ingresado como Tipo de documento de identidad del que envía el CPE (emisor o PSE) es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2818', 'El XML no contiene el atributo schemeAgencyName o no existe información del Tipo de documento de identidad del que envía el CPE (emisor o PSE)', '1');
INSERT INTO `tbl_error` VALUES ('2819', 'El valor ingresado en el atributo schemeAgencyName del Tipo de documento de identidad del que envía el CPE (emisor o PSE) es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2820', 'El XML no contiene el atributo schemeURI o no existe información del Tipo de documento de identidad del que envía el CPE (emisor o PSE)', '1');
INSERT INTO `tbl_error` VALUES ('2821', 'El valor ingresado en el atributo schemeURI del Tipo de documento de identidad del que envía el CPE (emisor o PSE) es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2822', 'El XML no contiene el tag o no existe información del Número de documento de identificación del OSE', '1');
INSERT INTO `tbl_error` VALUES ('2823', 'El valor ingresado como Número de documento de identificación del OSE es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2824', 'El certificado digital con el que se firma el CDR OSE no corresponde con el RUC del OSE informado', '1');
INSERT INTO `tbl_error` VALUES ('2825', 'El Número de documento de identificación del OSE informado no esta registrado en el padron.', '1');
INSERT INTO `tbl_error` VALUES ('2826', 'El XML no contiene el atributo schemeID o no existe información del Tipo de documento de identidad del OSE', '1');
INSERT INTO `tbl_error` VALUES ('2827', 'El valor ingresado como Tipo de documento de identidad del OSE es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2828', 'El XML no contiene el atributo schemeAgencyName o no existe información del Tipo de documento de identidad del OSE', '1');
INSERT INTO `tbl_error` VALUES ('2829', 'El valor ingresado en el atributo schemeAgencyName del Tipo de documento de identidad del OSE es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2830', 'El XML no contiene el atributo schemeURI o no existe información del Tipo de documento de identidad del OSE', '1');
INSERT INTO `tbl_error` VALUES ('2831', 'El valor ingresado en el atributo schemeURI del Tipo de documento de identidad del OSE es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2832', 'El XML no contiene el tag o no existe información del Código de Respuesta', '1');
INSERT INTO `tbl_error` VALUES ('2833', 'El valor ingresado como Código de Respuesta es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2834', 'El XML no contiene el atributo listAgencyName o no existe información del Código de Respuesta', '1');
INSERT INTO `tbl_error` VALUES ('2835', 'El valor ingresado en el atributo listAgencyName del Código de Respuesta es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2836', 'El XML no contiene el tag o no existe información de la Descripción de la Respuesta', '1');
INSERT INTO `tbl_error` VALUES ('2837', 'El valor ingresado como Descripción de la Respuesta es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2838', 'El valor ingresado como Código de observación es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2839', 'El XML no contiene el atributo listURI o no existe información del Código de observación', '1');
INSERT INTO `tbl_error` VALUES ('2840', 'El valor ingresado en el atributo listURI del Código de observación es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2841', 'El XML no contiene el tag o no existe información de la Descripción de la observación', '1');
INSERT INTO `tbl_error` VALUES ('2842', 'El valor ingresado como Descripción de la observación es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2843', 'Se ha encontrado mas de una Descripción de la observación, tag cac:Response/cac:Status/cbc:StatusReason', '1');
INSERT INTO `tbl_error` VALUES ('2844', 'No se encontro el tag cbc:StatusReasonCode cuando ingresó la Descripción de la observación', '1');
INSERT INTO `tbl_error` VALUES ('2845', 'El XML contiene mas de un elemento cac:DocumentReference', '1');
INSERT INTO `tbl_error` VALUES ('2846', 'El XML no contiene informacion en el tag cac:DocumentReference/cbc:ID', '1');
INSERT INTO `tbl_error` VALUES ('2848', 'El valor ingresado como Serie y número del comprobante no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2849', 'El XML no contiene el tag o no existe información de la Fecha de emisión del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2851', 'El valor ingresado como Fecha de emisión del comprobante no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2852', 'El XML no contiene el tag o no existe información de la Hora de emisión del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2853', 'El valor ingresado como Hora de emisión del comprobante no cumple con el patrón hh:mm:ss.sssss', '1');
INSERT INTO `tbl_error` VALUES ('2854', 'El valor ingresado como Hora de emisión del comprobante no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2855', 'El XML no contiene el tag o no existe información del Tipo de comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2856', 'El valor ingresado como Tipo de comprobante es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2857', 'El valor ingresado como Tipo de comprobante no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2858', 'El XML no contiene el tag o no existe información del Hash del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2859', 'El valor ingresado como Hash del comprobante es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2860', 'El valor ingresado como Hash del comprobante no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2861', 'El XML no contiene el tag o no existe información del Número de documento de identificación del emisor', '1');
INSERT INTO `tbl_error` VALUES ('2862', 'El valor ingresado como Número de documento de identificación del emisor es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2863', 'El valor ingresado como Número de documento de identificación del emisor no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2864', 'El XML no contiene el atributo o no existe información del Tipo de documento de identidad del emisor', '1');
INSERT INTO `tbl_error` VALUES ('2865', 'El valor ingresado como Tipo de documento de identidad del emisor es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2866', 'El valor ingresado como Tipo de documento de identidad del emisor no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2867', 'El XML no contiene el tag o no existe información del Número de documento de identificación del receptor', '1');
INSERT INTO `tbl_error` VALUES ('2868', 'El valor ingresado como Número de documento de identificación del receptor es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2869', 'El valor ingresado como Número de documento de identificación del receptor no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2870', 'El XML no contiene el atributo o no existe información del Tipo de documento de identidad del receptor', '1');
INSERT INTO `tbl_error` VALUES ('2871', 'El valor ingresado como Tipo de documento de identidad del receptor es incorrecto', '1');
INSERT INTO `tbl_error` VALUES ('2872', 'El valor ingresado como Tipo de documento de identidad del receptor no corresponde con el del comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2873', 'El PSE informado no se encuentra vinculado con el  emisor del comprobante en la fecha de comprobación', '1');
INSERT INTO `tbl_error` VALUES ('2874', 'El Número de documento de identificación del OSE informado no se encuentra vinculado al emisor del comprobante en la fecha de comprobación', '1');
INSERT INTO `tbl_error` VALUES ('2875', 'ID - El dato ingresado no cumple con el formato R#-fecha-correlativo', '1');
INSERT INTO `tbl_error` VALUES ('2876', 'La fecha de recepción del comprobante por OSE debe ser mayor a la fecha de emisión del comprobante enviado', '1');
INSERT INTO `tbl_error` VALUES ('2880', 'Es obligatorio ingresar el peso bruto total de la guía', '1');
INSERT INTO `tbl_error` VALUES ('2881', 'Es obligatorio indicar la unidad de medida del Peso Total de la guía', '1');
INSERT INTO `tbl_error` VALUES ('2883', 'Es obligatorio indicar la unidad de medida del ítem', '1');
INSERT INTO `tbl_error` VALUES ('2891', 'El código ingresado como tasa de percepción no existe en el catálogo', '1');
INSERT INTO `tbl_error` VALUES ('2892', 'El valor del tag no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2893', 'Debe consignar un importe igual o mayor a cero (0)', '1');
INSERT INTO `tbl_error` VALUES ('2894', 'El valor del tag no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2895', 'Debe consignar un importe igual o mayor a cero (0)', '1');
INSERT INTO `tbl_error` VALUES ('2896', 'El código ingresado como estado del ítem no existe en el catálogo', '1');
INSERT INTO `tbl_error` VALUES ('2897', 'Debe consignar un importe igual o mayor a cero (0)', '1');
INSERT INTO `tbl_error` VALUES ('2900', 'El Número de comprobante de fin de rango debe ser igual o mayor al de inicio', '1');
INSERT INTO `tbl_error` VALUES ('2901', 'El nombre comercial del emisor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2902', 'La urbanización del domicilio fiscal del emisor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2903', 'La provincia del domicilio fiscal del emisor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2904', 'El departamento del domicilio fiscal del emisor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2905', 'El distrito del domicilio fiscal del emisor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2906', 'El nombre comercial del proveedor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2907', 'La urbanización del domicilio fiscal del proveedor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2908', 'La provincia del domicilio fiscal del proveedor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2909', 'El departamento del domicilio fiscal del proveedor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2910', 'El distrito del domicilio fiscal del proveedor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2911', 'El nombre comercial del cliente no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2912', 'La urbanización del domicilio fiscal del cliente no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2913', 'La provincia del domicilio fiscal del cliente no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2914', 'El departamento del domicilio fiscal del cliente no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2915', 'El distrito del domicilio fiscal del cliente no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2916', 'La dirección completa y detallada del domicilio fiscal del emisor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2917', 'Debe corresponder a algún valor válido establecido en el catálogo 13', '1');
INSERT INTO `tbl_error` VALUES ('2918', 'La dirección completa y detallada del domicilio fiscal del proveedor no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2919', 'La dirección completa y detallada del domicilio fiscal del cliente no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2920', 'Dato no cumple con formato de acuerdo al número de comprobante', '1');
INSERT INTO `tbl_error` VALUES ('2921', 'Es obligatorio informar el detalle el tipo de servicio público', '1');
INSERT INTO `tbl_error` VALUES ('2922', 'El valor del Tag no se encuentra en el catálogo', '1');
INSERT INTO `tbl_error` VALUES ('2923', 'Es obligatorio informar el código de servicios de telecomunicaciones para el tipo servicio público informado', '1');
INSERT INTO `tbl_error` VALUES ('2924', 'Sólo enviar información para el tipos de servicios públicos 5', '1');
INSERT INTO `tbl_error` VALUES ('2925', 'El valor del Tag no se encuentra en el catálogo', '1');
INSERT INTO `tbl_error` VALUES ('2926', 'Es obligatorio informar el número del suministro para el tipo servicio público informado', '1');
INSERT INTO `tbl_error` VALUES ('2927', 'Comprobante de Servicio Publico no se encuenta registrado en sunat', '1');
INSERT INTO `tbl_error` VALUES ('2928', 'El valor del Tag no cumple con el tipo y longitud esperada', '1');
INSERT INTO `tbl_error` VALUES ('2929', 'Debe remitir información del número de teléfono para el código de servicios de telecomunicaciones informado', '1');
INSERT INTO `tbl_error` VALUES ('2930', 'El tipo de documento modificado por la Nota de debito debe ser Servicio Publico electronico', '1');
INSERT INTO `tbl_error` VALUES ('2931', 'El valor del Tag no cumple con el tipo y longitud esperada', '1');
INSERT INTO `tbl_error` VALUES ('2932', 'Es obligatorio informar el código de tarifa contratada para el tipo servicio público informado', '1');
INSERT INTO `tbl_error` VALUES ('2933', 'Sólo enviar información para el tipos de servicios públicos 1 o 2', '1');
INSERT INTO `tbl_error` VALUES ('2934', 'El valor del Tag no se encuentra en el catálogo', '1');
INSERT INTO `tbl_error` VALUES ('2935', 'Es obligatorio informar el detalle de la potencia contratada', '1');
INSERT INTO `tbl_error` VALUES ('2936', 'Sólo enviar información para el tipo de servicios público 1', '1');
INSERT INTO `tbl_error` VALUES ('2937', 'Es obligatorio informar el detalle de la potencia contratada', '1');
INSERT INTO `tbl_error` VALUES ('2938', 'Sólo enviar información para el tipo de servicios público 1', '1');
INSERT INTO `tbl_error` VALUES ('2939', 'El valor del Tag no cumple con el tipo y longitud esperada', '1');
INSERT INTO `tbl_error` VALUES ('2940', 'Es obligatorio informar el tipo de medidor', '1');
INSERT INTO `tbl_error` VALUES ('2941', 'Sólo enviar información para el tipo de servicios público 1', '1');
INSERT INTO `tbl_error` VALUES ('2942', 'El valor del Tag no se encuentra en el catálogo', '1');
INSERT INTO `tbl_error` VALUES ('2943', 'Es obligatorio informar el número del medidor', '1');
INSERT INTO `tbl_error` VALUES ('2944', 'Sólo enviar información para el tipos de servicios públicos 1', '1');
INSERT INTO `tbl_error` VALUES ('2945', 'El valor del Tag no cumple con el tipo y longitud esperada', '1');
INSERT INTO `tbl_error` VALUES ('2946', 'Sólo enviar información para el tipos de servicios públicos 1 o 2', '1');
INSERT INTO `tbl_error` VALUES ('2947', 'No existe el detalle del número del medidor', '1');
INSERT INTO `tbl_error` VALUES ('2948', 'Sólo enviar información para el tipos de servicios públicos 1 o 2', '1');
INSERT INTO `tbl_error` VALUES ('2949', 'El impuesto ICBPER no se encuentra vigente', '1');
INSERT INTO `tbl_error` VALUES ('2950', 'No existe el detalle del número del medidor', '1');
INSERT INTO `tbl_error` VALUES ('2951', 'Sólo enviar información para el tipos de servicios públicos 1 o 2', '1');
INSERT INTO `tbl_error` VALUES ('2952', 'El valor del Tag no cumple con el tipo y longitud esperada', '1');
INSERT INTO `tbl_error` VALUES ('2953', 'El valor del atributo no existe', '1');
INSERT INTO `tbl_error` VALUES ('2954', 'El valor ingresado como codigo de motivo de cargo/descuento por linea no es valido (catalogo 53)', '1');
INSERT INTO `tbl_error` VALUES ('2955', 'El formato ingresado en el tag cac:InvoiceLine/cac:Allowancecharge/cbc:Amount no cumple con el formato establecido', '1');
INSERT INTO `tbl_error` VALUES ('2956', 'El Monto total de impuestos es obligatorio', '1');
INSERT INTO `tbl_error` VALUES ('2957', 'El valor del tag categoria de impuestos no corresponde al valor esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2958', 'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID/@schemeID no corresponde al esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2959', 'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID/ no corresponde al esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2960', 'El valor del tag no corresponde al esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2961', 'El valor del tag codigo de tributo internacional no corresponde al esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2962', 'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID no corresponde al esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2963', 'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID/ no corresponde al esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2964', 'El valor del tag nombre del tributo no corresponde al esperado.', '1');
INSERT INTO `tbl_error` VALUES ('2965', 'La sumatoria de otros tributos no corresponde al total', '1');
INSERT INTO `tbl_error` VALUES ('2966', 'Sólo se puede indicar el códigos (54 o 55) del catálogo 53', '1');
INSERT INTO `tbl_error` VALUES ('2967', 'Los importes de otros cargos a nivel de línea no corresponden a la suma total.', '1');
INSERT INTO `tbl_error` VALUES ('2968', 'Debe contener un importe mayor a 0.00 si envía el tag cac:AllowanceCharge/cbc:Amount', '1');
INSERT INTO `tbl_error` VALUES ('2969', 'Los importes de otros cargos a nivel de línea no corresponden a la suma total.', '1');
INSERT INTO `tbl_error` VALUES ('2970', 'El dato ingresado en sac:SUNATTotalPaidBeforeRounding debe ser numérico mayor a cero', '1');
INSERT INTO `tbl_error` VALUES ('2971', 'Si existe tag sac:SUNATTotalPaidBeforeRounding debe existir tag cbc:PayableRoundingAmount', '1');
INSERT INTO `tbl_error` VALUES ('2972', 'Importe total pagado antes de redondeo debe ser igual a la suma de los importes pagados por cada documento relacionado', '1');
INSERT INTO `tbl_error` VALUES ('2973', 'El valor de la moneda del Importe total pagado antes de redondeo debe ser PEN', '1');

-- ----------------------------
-- Table structure for tbl_forma_pago
-- ----------------------------
DROP TABLE IF EXISTS `tbl_forma_pago`;
CREATE TABLE `tbl_forma_pago`  (
  `id_fdp` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `nombre_fdp` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `dias` int(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_fdp`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_forma_pago
-- ----------------------------
INSERT INTO `tbl_forma_pago` VALUES ('EF', 'CONTADO', '1', 0);
INSERT INTO `tbl_forma_pago` VALUES ('L2', 'CREDITO 30 DIAS', '2', 30);
INSERT INTO `tbl_forma_pago` VALUES ('L3', 'CREDITO 45 DIAS', '2', 45);
INSERT INTO `tbl_forma_pago` VALUES ('L4', 'CREDITO 60 DIAS', '2', 60);
INSERT INTO `tbl_forma_pago` VALUES ('LT', 'CREDITO 15 DIAS', '2', 15);

-- ----------------------------
-- Table structure for tbl_insumos
-- ----------------------------
DROP TABLE IF EXISTS `tbl_insumos`;
CREATE TABLE `tbl_insumos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `marca` int(5) NULL DEFAULT NULL,
  `unidad` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `precio_venta` decimal(10, 5) NOT NULL DEFAULT 0.00000,
  `precio_compra` decimal(10, 5) NULL DEFAULT 0.00000,
  `por1` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `por2` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `stock` decimal(10, 5) NOT NULL DEFAULT 0.00000,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  `empresa` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_unidad_insumo`(`unidad`) USING BTREE,
  CONSTRAINT `fk_unidad_insumo` FOREIGN KEY (`unidad`) REFERENCES `tbl_unidad` (`cod`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_insumos
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_marcas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_marcas`;
CREATE TABLE `tbl_marcas`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  `empresa` int(5) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 157 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_marcas
-- ----------------------------
INSERT INTO `tbl_marcas` VALUES (4, 'NESTLE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (6, 'GENERICO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (7, 'GLORIA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (8, 'MARINA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (9, 'ELISASAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (10, 'NORSAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (11, 'PURA VIDA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (12, 'BONLE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (13, 'IDEAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (14, 'PRIMOR', '1', 1);
INSERT INTO `tbl_marcas` VALUES (15, 'CAPRI', '1', 1);
INSERT INTO `tbl_marcas` VALUES (16, 'CHEFF', '1', 1);
INSERT INTO `tbl_marcas` VALUES (17, 'SOYA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (18, 'TONDERO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (19, 'PALMEROLA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (20, 'SAO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (21, 'WINTERS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (22, 'CURAZAO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (23, 'INTI', '1', 1);
INSERT INTO `tbl_marcas` VALUES (24, 'ALTOMAYO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (25, 'DON CAFE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (26, 'FIRME', '1', 1);
INSERT INTO `tbl_marcas` VALUES (27, 'WICUME', '1', 1);
INSERT INTO `tbl_marcas` VALUES (28, 'CAMPERO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (29, 'AJINOSILLAO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (30, 'KIKO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (31, 'DURYEA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (32, 'MCCOLIN\'S', '1', 1);
INSERT INTO `tbl_marcas` VALUES (33, 'TOKAI', '1', 1);
INSERT INTO `tbl_marcas` VALUES (34, 'TUMI', '1', 1);
INSERT INTO `tbl_marcas` VALUES (35, 'SANTA CRUZ', '1', 1);
INSERT INTO `tbl_marcas` VALUES (36, 'PANASONIC', '1', 1);
INSERT INTO `tbl_marcas` VALUES (37, 'NESCAFE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (38, 'VALLENORTE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (39, 'GERALDINE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (40, 'CLEMAR', '1', 1);
INSERT INTO `tbl_marcas` VALUES (41, 'RICO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (42, 'A1', '1', 1);
INSERT INTO `tbl_marcas` VALUES (43, 'MONTEALTO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (44, 'REAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (45, 'CHAPOÑAN', '1', 1);
INSERT INTO `tbl_marcas` VALUES (46, 'DON VITTORIO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (47, 'LAVAGGI', '1', 1);
INSERT INTO `tbl_marcas` VALUES (48, 'ALIANZA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (49, 'GRANO DE ORO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (50, 'MARCO POLO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (51, 'ESPIGA DE ORO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (52, 'MOLITALIA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (53, 'ALACENA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (54, 'FAVORITA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (55, 'ANCHOR', '1', 1);
INSERT INTO `tbl_marcas` VALUES (56, 'UMSHA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (57, '3 OSITOS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (58, 'KOTEX', '1', 1);
INSERT INTO `tbl_marcas` VALUES (59, 'MARSELLA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (60, 'OPAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (61, 'MAGIA BLANCA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (62, 'BOLIVAR', '1', 1);
INSERT INTO `tbl_marcas` VALUES (63, 'ACE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (64, 'ARIEL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (65, 'NOSOTRAS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (66, 'SPEEK STICK', '1', 1);
INSERT INTO `tbl_marcas` VALUES (67, 'COLGATE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (68, 'KOLYNOS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (69, 'PROTEX', '1', 1);
INSERT INTO `tbl_marcas` VALUES (70, 'SAPOLIO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (71, 'PATITO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (72, 'LAVA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (73, 'LESLY', '1', 1);
INSERT INTO `tbl_marcas` VALUES (74, 'ÑAPANCHA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (75, 'AYUDIN', '1', 1);
INSERT INTO `tbl_marcas` VALUES (76, 'DOWNY', '1', 1);
INSERT INTO `tbl_marcas` VALUES (77, 'DENTO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (78, 'ALWAYS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (79, 'PRO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (80, 'ORAL B', '1', 1);
INSERT INTO `tbl_marcas` VALUES (81, 'DOFFI', '1', 1);
INSERT INTO `tbl_marcas` VALUES (82, 'ESPUMIL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (83, 'PALMOLIVE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (84, 'SAPOLIO', '0', 1);
INSERT INTO `tbl_marcas` VALUES (85, 'SHIROI', '1', 1);
INSERT INTO `tbl_marcas` VALUES (86, 'AVAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (87, 'VIALE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (88, 'BAYGON', '1', 1);
INSERT INTO `tbl_marcas` VALUES (89, 'CAMAY', '1', 1);
INSERT INTO `tbl_marcas` VALUES (90, 'REXONA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (91, 'MONCLER', '1', 1);
INSERT INTO `tbl_marcas` VALUES (92, 'HENO DE PRAVIA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (93, 'POET', '1', 1);
INSERT INTO `tbl_marcas` VALUES (94, 'CLOROX', '1', 1);
INSERT INTO `tbl_marcas` VALUES (95, 'CLOROSUR', '1', 1);
INSERT INTO `tbl_marcas` VALUES (96, 'FORTUNA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (97, 'ZOTE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (98, 'LA PODEROSA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (99, 'POPEYE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (100, 'TROMEN', '1', 1);
INSERT INTO `tbl_marcas` VALUES (101, 'JUMBO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (102, 'SUAVITEL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (103, 'ELITE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (104, 'NOBLE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (105, 'NOVA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (106, 'SUPER', '1', 1);
INSERT INTO `tbl_marcas` VALUES (107, 'VANISH', '1', 1);
INSERT INTO `tbl_marcas` VALUES (108, 'SAN CARLOS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (109, 'H&S', '1', 1);
INSERT INTO `tbl_marcas` VALUES (110, 'PANTENE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (111, 'GILLETTE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (112, 'VENUS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (113, 'SHICK', '1', 1);
INSERT INTO `tbl_marcas` VALUES (114, 'SUAVE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (115, 'LADY SOFT', '1', 1);
INSERT INTO `tbl_marcas` VALUES (116, 'NUTRICAN', '1', 1);
INSERT INTO `tbl_marcas` VALUES (117, 'DOÑA GUSTA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (118, 'OLD SPICE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (119, 'REYENITO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (120, 'RIO BRANCO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (121, 'DULCE OLMOS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (122, 'HIGIENOL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (123, 'RANGO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (124, 'RENDIPEL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (125, 'DIA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (126, 'GN', '1', 1);
INSERT INTO `tbl_marcas` VALUES (127, 'VICTORIA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (128, 'OREO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (129, 'RITZ', '1', 1);
INSERT INTO `tbl_marcas` VALUES (130, 'SALTICAS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (131, 'SAYON', '1', 1);
INSERT INTO `tbl_marcas` VALUES (132, 'CONFITECA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (133, 'AMERICANDY', '1', 1);
INSERT INTO `tbl_marcas` VALUES (134, 'COSTA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (135, 'COLOMBINA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (136, 'HUGGIES', '1', 1);
INSERT INTO `tbl_marcas` VALUES (137, 'DKASA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (138, 'HIT', '1', 1);
INSERT INTO `tbl_marcas` VALUES (139, 'ECCO', '0', 1);
INSERT INTO `tbl_marcas` VALUES (140, 'POMAROLA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (141, 'CASUARINAS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (142, 'TRIBAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (143, 'SEDAL', '1', 1);
INSERT INTO `tbl_marcas` VALUES (144, 'MONTENEGRO', '1', 1);
INSERT INTO `tbl_marcas` VALUES (145, 'ADAMS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (146, 'SELVA DORADA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (147, 'DANESA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (148, 'DOVE', '1', 1);
INSERT INTO `tbl_marcas` VALUES (149, 'TRIDENT', '1', 1);
INSERT INTO `tbl_marcas` VALUES (150, 'HALLS', '1', 1);
INSERT INTO `tbl_marcas` VALUES (151, 'KATITA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (152, 'BABYSEC', '1', 1);
INSERT INTO `tbl_marcas` VALUES (153, 'SPEED STICK', '1', 1);
INSERT INTO `tbl_marcas` VALUES (154, 'SAGAZ', '1', 1);
INSERT INTO `tbl_marcas` VALUES (155, 'PEQUEÑIN', '1', 1);
INSERT INTO `tbl_marcas` VALUES (156, 'CEMAR', '1', 1);

-- ----------------------------
-- Table structure for tbl_medio_pago
-- ----------------------------
DROP TABLE IF EXISTS `tbl_medio_pago`;
CREATE TABLE `tbl_medio_pago`  (
  `id_mdp` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_mdp` char(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_mdp`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_medio_pago
-- ----------------------------
INSERT INTO `tbl_medio_pago` VALUES ('001', 'DEPÓSITO EN CUENTA');
INSERT INTO `tbl_medio_pago` VALUES ('002', 'GIRO');
INSERT INTO `tbl_medio_pago` VALUES ('003', 'TRANSFERENCIA DE FONDOS');
INSERT INTO `tbl_medio_pago` VALUES ('004', 'ORDEN DE PAGO');
INSERT INTO `tbl_medio_pago` VALUES ('005', 'TARJETA DE DÉBITO');
INSERT INTO `tbl_medio_pago` VALUES ('006', 'TARJETA DE CRÉDITO');
INSERT INTO `tbl_medio_pago` VALUES ('007', 'CHEQUES CON LA CLÁUSULA DE \"NO NEGOCIABLE\"');
INSERT INTO `tbl_medio_pago` VALUES ('008', 'EFECTIVO, POR OPERACIONES EN LAS QUE NO EXISTE OBLIGACIÓN DE UTILIZAR MEDIOS DE PAGO');
INSERT INTO `tbl_medio_pago` VALUES ('009', 'EFECTIVO, EN LOS DEMÁS CASOS');
INSERT INTO `tbl_medio_pago` VALUES ('010', 'MEDIOS DE PAGO DE COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('011', 'LETRAS DE CAMBIO');
INSERT INTO `tbl_medio_pago` VALUES ('101', 'TRANSFERENCIAS - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('102', 'CHEQUES BANCARIOS  - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('103', 'ORDEN DE PAGO SIMPLE  - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('104', 'ORDEN DE PAGO DOCUMENTARIO  - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('105', 'REMESA SIMPLE  - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('106', 'REMESA DOCUMENTARIA  - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('107', 'CARTA DE CRÉDITO SIMPLE  - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('108', 'CARTA DE CRÉDITO DOCUMENTARIO  - COMERCIO EXTERIOR');
INSERT INTO `tbl_medio_pago` VALUES ('109', 'NOTA DE CREDITO');
INSERT INTO `tbl_medio_pago` VALUES ('999', 'OTROS MEDIOS DE PAGO (ESPECIFICAR)');

-- ----------------------------
-- Table structure for tbl_not_cre_deb
-- ----------------------------
DROP TABLE IF EXISTS `tbl_not_cre_deb`;
CREATE TABLE `tbl_not_cre_deb`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `codigo` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `descripcion` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_not_cre_deb
-- ----------------------------
INSERT INTO `tbl_not_cre_deb` VALUES (1, '01', 'ANULACION DE LA OPERACION', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (2, '02', 'ANULACION POR ERROR EN EL RUC', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (3, '03', 'CORRECCION POR ERROR EN LA DESCRIPCION', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (4, '04', 'DESCUENTO GLOBAL', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (5, '05', 'DESCUENTO POR ITEM', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (6, '06', 'DEVOLUCION TOTAL', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (7, '07', 'DEVOLUCION POR ITEM', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (8, '08', 'BONIFICACION', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (9, '09', 'DISMINUCION EN EL VALOR', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (10, '10', 'OTROS CONCEPTOS', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (11, '11', 'AJUSTES DE OPERACIONES DE EXPORTACION', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (12, '12', 'AJUSTES AFECTOS AL IVAP', '1');
INSERT INTO `tbl_not_cre_deb` VALUES (13, '01', 'INTERES POR MORA', '2');
INSERT INTO `tbl_not_cre_deb` VALUES (14, '02', 'AUMENTO EN EL VALOR', '2');
INSERT INTO `tbl_not_cre_deb` VALUES (15, '03', 'PENALIDADES / OTROS DESCUENTOS', '2');
INSERT INTO `tbl_not_cre_deb` VALUES (16, '11', 'AJUSTES DE OPERACIONES DE EXPORTACION', '2');
INSERT INTO `tbl_not_cre_deb` VALUES (17, '12', 'AJUSTES AFECTOS  AL IVAP', '2');

-- ----------------------------
-- Table structure for tbl_plan_cuentas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_cuentas`;
CREATE TABLE `tbl_plan_cuentas`  (
  `cuenta` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `cuenta2` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre` char(70) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nivel` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `clase` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `destino` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `monetaria` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cc` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cuenta`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_plan_cuentas
-- ----------------------------
INSERT INTO `tbl_plan_cuentas` VALUES ('10', NULL, 'EFECTIVO Y EQUIVALENTES DE EFECTIVO', 'B', '01', NULL, 'S', NULL);

-- ----------------------------
-- Table structure for tbl_productos
-- ----------------------------
DROP TABLE IF EXISTS `tbl_productos`;
CREATE TABLE `tbl_productos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `marca` int(5) NULL DEFAULT NULL,
  `unidad` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `factor` int(11) NOT NULL DEFAULT 1,
  `costo` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `por1` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `precio_venta` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `por2` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `precio2` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `afectacion` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  `empresa` int(5) NULL DEFAULT NULL,
  `stock` decimal(10, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_unidad_insumo`(`unidad`) USING BTREE,
  CONSTRAINT `tbl_productos_ibfk_1` FOREIGN KEY (`unidad`) REFERENCES `tbl_unidad` (`cod`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 589 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_productos
-- ----------------------------
INSERT INTO `tbl_productos` VALUES (176, 'SAL MARINA X 1 KG X 25 BLS', '', 8, 'BLS', 25, 1.07, 40.17, 37.50, 8.40, 29.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (177, 'HOLA', '', 125, 'PK', 12, 1.31, 40.00, 22.01, 14.00, 17.92, '20', '0', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (178, 'SAL ELISASAL X 1KG X 24 BLS', '', 9, 'BLS', 24, 0.66, 51.50, 24.00, 13.65, 18.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (179, 'SAL X 1KG', '', 9, 'NIU', 1, 0.67, 49.00, 1.00, 12.00, 0.75, '20', '0', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (180, 'SAL X 1KG X 25 BLS', '', 10, 'BLS', 25, 0.66, 51.50, 25.00, 9.10, 18.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (181, 'SAL X 1KG', '', 10, 'NIU', 1, 0.64, 57.00, 1.00, 17.00, 0.75, '20', '0', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (182, 'SARDINA OVALADO X 24 UNID', '', 45, 'NIU', 24, 3.95, 26.58, 120.00, 16.03, 110.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (183, 'JABON LIQUIDO PROTEX', '', 69, 'NIU', 1, 6.50, 7.64, 7.00, 7.64, 7.00, '20', '0', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (184, 'SARDINA PORTOLA LARGA X 24 UNID', '', 45, 'NIU', 24, 3.42, 31.58, 108.00, 9.65, 90.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (185, 'SARDINA PORTOLA CHICA X UNID', '', 45, 'NIU', 1, 1.71, 46.00, 2.50, 7.15, 1.83, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (186, 'CHOCOLISTO X 300GR', '', 6, 'NIU', 1, 7.50, 13.30, 8.50, 13.30, 8.50, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (187, 'SARDINA PORTOLA CHICA X 48 UNID', '', 45, 'NIU', 1, 80.00, 10.00, 88.00, 10.00, 88.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (188, 'HARINA FAVORITA X 200 GR X 18 UNID', '', 54, 'NIU', 18, 0.87, 14.93, 18.00, 5.35, 16.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (189, 'HARINA GRANO DE ORO X 180 GR X 18 UNID', '', 49, 'NIU', 18, 0.66, 51.48, 18.00, 9.39, 13.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (190, 'GRATED GERALDINE EN AGUA Y SAL X 48 UNID', '', 39, 'NIU', 48, 1.54, 29.87, 96.00, 8.23, 80.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (191, 'SERVILLETA REAL X 18 UNID', '', 44, 'PQT', 1, 14.50, 10.34, 16.00, 10.34, 16.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (192, 'FILETE RICO ATUN X 48 UNID', '', 41, 'NIU', 48, 3.02, 15.90, 168.01, 10.38, 160.01, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (193, 'PAPEL HIGIENICO ELITE SOFT X 6 X 6 PACKS', '', 103, 'PQT', 6, 4.85, 13.40, 33.00, 10.00, 32.01, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (194, 'JABONCILLO X 150 GR', '', 92, 'NIU', 1, 3.37, 18.55, 4.00, 10.00, 3.71, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (195, 'VELA SANTA CRUZ X 20 UNID', '', 35, 'NIU', 20, 1.95, 28.20, 50.00, 10.25, 43.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (196, 'VELA MONTENEGRO X 20 UNID', '', 144, 'NIU', 20, 1.95, 28.20, 50.00, 10.25, 43.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (197, 'DETERGENTE SAPOLIO X 14 KG', '', 70, 'SAC', 1, 81.00, 3.70, 84.00, 4.94, 85.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (198, 'DETERGENTE X 150 GR X 60 UNID', '', 81, 'NIU', 60, 0.82, 21.95, 60.00, 9.76, 54.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (199, 'PAPEL HIGIENICO NOBLE X 24 UNID', '', 104, 'NIU', 1, 16.12, 11.64, 18.00, 11.64, 18.00, '20', '1', 1, -20.00);
INSERT INTO `tbl_productos` VALUES (200, 'DETERGENTE PATITO X 60 UNID', '', 71, 'NIU', 60, 0.84, 19.05, 60.00, 7.15, 54.00, '20', '1', 1, -8.00);
INSERT INTO `tbl_productos` VALUES (201, 'LEJIA PATITO X 615 GR X 12 UNID', '', 71, 'NIU', 12, 1.31, 37.40, 21.60, 14.50, 18.00, '20', '1', 1, -8.00);
INSERT INTO `tbl_productos` VALUES (202, 'LEJIA PATITO X 1 LT X 12 UNID', '', 71, 'NIU', 12, 2.33, 50.20, 42.00, 28.77, 36.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (203, 'LEJIA X 308 GR X 24 UNID', '', 71, 'NIU', 24, 0.79, 26.57, 24.00, 26.57, 25.00, '20', '1', 1, -15.00);
INSERT INTO `tbl_productos` VALUES (204, 'BOLSA 21 X 24', '', 6, 'BLS', 1, 10.00, 20.00, 12.00, 20.00, 12.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (205, 'DETERGENTE HIT X 15 KG', '', 138, 'KG', 15, 4.73, 26.85, 90.00, 5.71, 75.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (206, 'PAPEL HIGIENICO X 6 ROLLOS', '', 124, 'NIU', 1, 17.71, 12.95, 20.00, 12.95, 20.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (207, 'PAPEL TOALLA NOVA MEGARROLLO X 12 UNID', '', 105, 'NIU', 12, 1.95, 28.19, 30.00, 11.10, 26.00, '20', '1', 1, -9.00);
INSERT INTO `tbl_productos` VALUES (208, 'LEJIA SAPOLIO X 5 LT', '', 70, 'NIU', 1, 10.00, 20.00, 12.00, 15.00, 11.50, '20', '1', 1, -6.00);
INSERT INTO `tbl_productos` VALUES (209, 'LECHE EVAPORADA X 400 GR X 24 UNID', '', 7, 'CAJ', 24, 3.35, 7.46, 86.40, 5.72, 85.00, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (210, 'AJINOMOTO X 250 GR', '', 6, 'NIU', 1, 3.30, 21.12, 4.00, 21.12, 4.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (211, 'TE MANZANILLA X 100 UNID', '', 32, 'CAJ', 1, 6.37, 17.69, 7.50, 17.69, 7.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (212, 'TE CANELA Y CLAVO X 100 UNI', '', 32, 'CAJ', 1, 6.37, 17.69, 7.50, 17.69, 7.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (213, 'TE ANIS X 100 UNID', '', 32, 'CAJ', 1, 6.37, 17.69, 7.50, 17.69, 7.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (214, 'LECHE NIÑOS X 400 GR X 24 UNID', '', 7, 'NIU', 24, 3.44, 10.46, 91.20, 6.59, 88.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (215, 'PAPEL TOALLA MEGARROLLO X 12 UNID', '', 106, 'NIU', 12, 2.03, 23.15, 30.00, 6.72, 26.00, '20', '1', 1, -5.00);
INSERT INTO `tbl_productos` VALUES (216, 'SALSA CLASICA 160 GR X 24 UNID', '', 140, 'CAJ', 24, 1.14, 31.57, 36.00, 9.65, 30.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (217, 'JABONCILLO X 145 GR', '', 91, 'NIU', 12, 2.96, 18.25, 42.00, 9.80, 39.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (218, 'JABON JUMBO FLORAL X 190 GR X 40 UNID', '', 101, 'CAJ', 40, 1.51, 19.20, 72.00, 9.27, 66.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (219, 'COCOA CURAZAO 160 GR X 6 UNID', '', 22, 'NIU', 6, 4.95, 11.10, 33.00, 7.75, 32.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (220, 'SIYAU X 500 ML', '', 30, 'NIU', 1, 2.30, 30.25, 3.00, 10.00, 2.53, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (221, 'DETERGENTE MARSELLA X 140 GR X 60 UNID', '', 59, 'NIU', 60, 1.40, 21.43, 102.00, 13.08, 94.99, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (222, 'ESENCIA DE VAINILLA KATITA 30 ML X 12 UNID', '', 151, 'NIU', 12, 0.56, 78.64, 12.00, 18.98, 8.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (223, 'DETERGENTE SAPOLIO X KG', '', 70, 'KG', 1, 5.56, 16.90, 6.50, 16.90, 6.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (224, 'COLGATE TRIPLE ACCION X 150 ML', '', 67, 'NIU', 12, 7.50, 20.00, 108.00, 12.78, 101.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (225, 'JABONCILLO PALMOLIVE X 120 GR', '', 83, 'PCK', 1, 2.50, 20.00, 3.00, 16.00, 2.90, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (226, 'PAPEL HIGIENICO SUAVE RINDEMAX X 24 UNID', '', 114, 'PK', 1, 16.50, 9.10, 18.00, 9.10, 18.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (227, 'PAPEL HIGIENICO CASUARINAS X 6 ROLLOS', '', 141, 'PQT', 1, 15.50, 16.10, 18.00, 16.10, 18.00, '20', '1', 1, -8.00);
INSERT INTO `tbl_productos` VALUES (228, 'LECHE IDEAL AMANECER X 395 GR X 24 UNID', '', 13, 'NIU', 24, 2.63, 14.07, 72.00, 4.57, 66.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (229, 'SODA VICTORIA PACK X 6 UNID X 36 PACK', '', 127, 'PCK', 216, 0.39, 28.20, 108.00, 10.99, 93.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (230, 'YOMOST X 4 PACK X 6 UNID', '', 7, 'PCK', 1, 1.74, 14.90, 2.00, 10.09, 1.92, '20', '1', 1, -14.00);
INSERT INTO `tbl_productos` VALUES (231, 'ACEITE CAPRI X 1 LT', '', 15, 'NIU', 1, 11.00, 13.60, 12.50, 9.10, 12.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (232, 'JABON JUMBO FRESCURA INTENSA X 190 GR X 40 UNID', '', 101, 'NIU', 40, 1.51, 19.20, 72.00, 9.27, 66.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (233, 'TOALLA KOTEX NORMAL X 10 UNID', '', 58, 'NIU', 12, 3.20, 25.00, 48.00, 11.97, 43.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (234, 'COCOA WINTERS 160 GR X 6 UNID', '', 21, 'NIU', 1, 5.14, 16.70, 6.00, 10.00, 5.65, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (235, 'GALLETA RELLENITA GN X 8 PQT X 5 PCK', '', 126, 'NIU', 40, 0.34, 10.30, 15.00, 10.30, 15.00, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (236, 'MILO X 380 GR', '', 4, 'NIU', 1, 14.41, 11.00, 16.00, 11.00, 16.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (237, 'PROTECTORES DIARIOS NOSOTRAS', '', 65, 'NIU', 1, 2.50, 40.10, 3.50, 16.50, 2.91, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (238, 'DETERGENTE TROME SACO X 15 KG', '', 100, 'SAC', 15, 4.73, 26.85, 90.00, 7.12, 76.00, '20', '1', 1, -24.00);
INSERT INTO `tbl_productos` VALUES (239, 'ARROZ RIO BRANCO X 50 KG', '', 120, 'SAC', 50, 2.76, 15.94, 160.00, 5.07, 145.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (240, 'GALLETA SODA DIA X 12 PACKS', '', 125, 'PK', 12, 1.39, 43.90, 24.00, 19.88, 20.00, '20', '1', 1, -7.00);
INSERT INTO `tbl_productos` VALUES (241, 'AVENA GRANO DE ORO X 145 GR X 24', '', 49, 'PK', 24, 0.91, 31.85, 28.80, 9.87, 24.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (242, 'FOSFORO INTI X 10 PACK', '', 23, 'PK', 10, 1.70, 17.65, 20.00, 8.80, 18.50, '20', '1', 1, -7.00);
INSERT INTO `tbl_productos` VALUES (243, 'GOLD TOFFEE X 80 UNID', '', 6, 'BLS', 1, 5.50, 18.10, 6.50, 18.10, 6.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (244, 'CARAMELO YOGURT X 100 UNID', '', 131, 'BLS', 1, 3.80, 18.50, 4.50, 18.50, 4.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (245, 'MERMELADA GLORIA SACHET X 12 UNID', '', 7, 'CAJ', 12, 1.29, 16.30, 18.00, 9.80, 17.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (246, 'AJINOMEN GALLINA X 24 UNID', '', 6, 'PQT', 24, 1.16, 29.30, 36.00, 7.75, 30.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (247, 'FILETE GLORIA X 48 UNID', '', 7, 'CAJ', 48, 4.80, 14.59, 264.02, 11.11, 256.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (248, 'AZUCAR RUBIA DULCE OLMOS X 50 KG', '', 121, 'SAC', 50, 3.42, 16.96, 200.00, 3.51, 177.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (249, 'ACEITE SOYA X 900 X 20 UNID', '', 17, 'NIU', 20, 8.57, 5.02, 180.00, 3.85, 178.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (250, 'FIDEO LAVAGGI X 20 BLS', '', 47, 'NIU', 20, 2.43, 15.23, 56.00, 7.00, 52.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (251, 'LECHE IDEAL CREMOSITA X 395 GR X 24 UNID', '', 13, 'NIU', 24, 3.22, 8.70, 84.00, 6.11, 82.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (252, 'FILETE DE ATUN REAL X 48 UNID', '', 44, 'NIU', 48, 5.00, 20.00, 288.00, 13.34, 272.02, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (253, 'AVENA GRANO DE ORO X 370 X 12 UNID', '', 49, 'NIU', 12, 2.12, 18.00, 30.02, 10.05, 28.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (254, 'MERMELADA GLORIA POTE', '', 7, 'NIU', 1, 3.38, 48.00, 5.00, 40.39, 4.75, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (255, 'ALIANZA SPAGUETTI X 500 GR X 20 UNID', '', 48, 'NIU', 20, 1.90, 15.80, 44.00, 10.53, 42.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (256, 'TE MANZANILLA X 25 UNID', '', 32, 'CAJ', 1, 2.01, 24.60, 2.50, 24.60, 2.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (257, 'GELATINA FRESA UMSHA X 150 GR', '', 56, 'NIU', 12, 2.85, 22.80, 42.00, 11.10, 38.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (258, 'MAYONESA ALACENA X 95 GR', '', 53, 'NIU', 1, 4.16, 20.09, 5.00, 10.20, 4.58, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (259, 'MARSELLA SACO X 13.5 KG', '', 59, 'KG', 1, 104.90, 2.96, 108.01, 2.96, 108.01, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (260, 'PAPEL SUAVE NARANJA X 10 PQTS X 2 PACK', '', 114, 'PQT', 10, 1.44, 38.90, 20.00, 7.66, 15.50, '20', '1', 1, -25.00);
INSERT INTO `tbl_productos` VALUES (261, 'DETERGENTE TROME BEBE X 150 GR X 60 UNID', '', 100, 'NIU', 60, 1.15, 30.44, 90.00, 8.70, 75.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (262, 'CHICLE TATOO BUZZI X 100 UNID', '', 142, 'CAJ', 1, 6.80, 17.60, 8.00, 17.60, 8.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (263, 'CARAMELO COFEE X 100 UNID', '', 6, 'BLS', 1, 5.26, 14.00, 6.00, 14.00, 6.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (264, 'TOFFE SURTIDO X 100 UNID', '', 6, 'BLS', 1, 7.09, 12.80, 8.00, 12.80, 8.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (265, 'CHIKIJELLY TAPER X 100 UNID', '', 6, 'PK', 1, 15.68, 11.60, 17.50, 11.60, 17.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (266, 'ACEITE PALMEROLA X 900 ML X 12 UNID', '', 19, 'NIU', 12, 7.89, 7.73, 102.00, 5.09, 99.50, '20', '1', 1, -5.00);
INSERT INTO `tbl_productos` VALUES (267, 'LEJIA CLOROX CHICO X 20 UNID', '', 94, 'PK', 20, 0.93, 29.05, 24.00, 10.19, 20.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (268, 'CAFE ALTOMAYO DISPLAY X 55 UNID', '', 24, 'CAJ', 55, 0.39, 28.19, 27.50, 7.23, 23.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (269, 'CAFE ALTOMAYO X 12 GR', '', 24, 'NIU', 1, 0.70, 43.00, 1.00, 43.00, 1.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (270, 'CAFE ALTOMAYO TIRA X 9 UNID', '', 24, 'NIU', 1, 1.00, 20.00, 1.20, 0.50, 1.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (271, 'GRATED MONTEALTO DE ATUN X 48 UNID', '', 43, 'NIU', 1, 3.03, 15.39, 3.50, 10.00, 3.33, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (272, 'AJINOMOTO X 500 GR', '', 6, 'NIU', 1, 6.52, 7.30, 7.00, 7.30, 7.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (273, 'LEJIA CLOROX GRANDE X 15 UNID', '', 94, 'NIU', 15, 1.71, 16.96, 30.00, 9.18, 28.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (274, 'ESPIRAL TOKAI', '', 33, 'NIU', 60, 2.08, 20.19, 150.00, 12.18, 140.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (275, 'LIMPIATODO SAPOLIO X 900ML X 12 UNID', '', 70, 'NIU', 12, 2.42, 44.64, 42.00, 23.95, 36.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (276, 'LECHE GLORIA UHT ENTERA X 1LT X 12 UNID', '', 7, 'CAJ', 12, 4.32, 15.75, 60.00, 8.03, 56.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (277, 'PURA VIDA X 165 GR X 48 UNID', '', 11, 'NIU', 48, 1.52, 18.42, 86.40, 6.91, 78.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (278, 'PURA VIDA X 395 GR X 24 UNID', '', 11, 'NIU', 24, 2.67, 12.36, 72.00, 7.68, 69.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (279, 'GRANO DE ORO PARA SOPA X 250 GR X 20 UNID', '', 49, 'BLS', 20, 0.83, 20.49, 20.00, 11.43, 18.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (280, 'OPAL ULTRA FLORAL X 330 GR X 30 UNID', '', 60, 'NIU', 30, 3.35, 19.40, 120.00, 9.44, 109.99, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (281, 'MARSELLA PETALOS X 330 GR X 30 UNID', '', 59, 'NIU', 30, 3.19, 9.72, 105.00, 5.80, 101.25, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (282, 'BOLIVAR ACTIVE CARE X 750 GR X 15 UNID', '', 62, 'NIU', 1, 8.60, 10.45, 9.50, 10.45, 9.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (283, 'ALIANZA CABELLO DE ANGEL X 250 GR X 40 BLS', '', 48, 'PK', 40, 0.95, 15.80, 44.00, 10.53, 42.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (284, 'ALIANZA PARA SOPA X 250 GR X 20 BLS', '', 48, 'BLS', 20, 0.95, 26.30, 24.00, 10.53, 21.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (285, 'VAINILLA DIA X 8 PQT X 5 PACK', '', 125, 'PK', 40, 0.21, 48.80, 12.50, 13.06, 9.50, '20', '1', 1, -9.00);
INSERT INTO `tbl_productos` VALUES (286, 'SODA DIA X 10 PQT X 4 PCK', '', 125, 'PK', 40, 0.21, 48.76, 12.50, 13.05, 9.50, '20', '1', 1, -14.00);
INSERT INTO `tbl_productos` VALUES (287, 'JABON FORTUNA FLORAL X 40 UNID', '', 96, 'NIU', 40, 1.25, 12.00, 56.00, 10.00, 55.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (288, 'LECHE GLORIA UHT LIGHT X 1LT X 12 UNID', '', 7, 'NIU', 12, 4.48, 11.60, 60.00, 7.88, 58.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (289, 'SUAVIZANTE BOLIVAR TIRA X 80 ML X 12 UNID', '', 62, 'TIR', 12, 0.75, 33.28, 12.00, 11.07, 10.00, '20', '1', 1, -6.00);
INSERT INTO `tbl_productos` VALUES (290, 'GLORIA EVAPORADA X 170 GR X 48 UNID', '', 7, 'NIU', 48, 1.80, 11.11, 96.00, 8.80, 94.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (291, 'LECHE GLORIA UHT S/LACTOSA X 1LT X 12 UNID', '', 7, 'CAJ', 12, 4.71, 16.77, 66.00, 7.92, 61.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (292, 'TE CANELA Y CLAVO X 25 UNID', '', 32, 'CAJ', 1, 2.01, 24.60, 2.50, 24.60, 2.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (293, 'TE ANIS X 25 UNID', '', 32, 'CAJ', 1, 2.01, 24.61, 2.50, 24.61, 2.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (294, 'GALLETA ANIMALITOS GN X 60 GR', '', 126, 'PQT', 1, 12.19, 10.73, 13.50, 10.73, 13.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (295, 'SHAMPOO SEDAL TIRA X 10 ML X 12 UNID', '', 143, 'TIR', 12, 0.78, 28.18, 12.00, 12.20, 10.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (296, 'BOLSA BLANCO 12 X 16', '', 6, 'BLS', 1, 1.56, 60.00, 2.50, 60.00, 2.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (297, 'ESPIGA DE ORO SPAGHETTI X 500 GR X 20 UNID', '', 51, 'KG', 20, 1.67, 19.77, 40.00, 10.78, 37.00, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (298, 'GLORIA LIGHT X 400 GR X 24 UNID', '', 7, 'NIU', 24, 3.44, 10.46, 91.20, 6.59, 88.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (299, 'LECHE CONDENSADA GLORIA X 200 GR', '', 7, 'NIU', 1, 3.38, 18.20, 4.00, 11.00, 3.75, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (300, 'CLOROX ROPA COLOR X 292 ML X 20 UNID', '', 94, 'NIU', 20, 2.17, 15.20, 50.00, 10.60, 48.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (301, 'CHICLE ADAMS X 100 UNID', '', 145, 'CAJ', 1, 13.03, 15.09, 15.00, 15.09, 15.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (302, 'GALLETA RITZ QUESO X 6PCKS', '', 129, 'PCK', 6, 0.68, 47.00, 6.00, 22.50, 5.00, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (303, 'GALLETA OREO ROLLO X 126 GR', '', 128, 'NIU', 1, 1.95, 28.00, 2.50, 11.06, 2.17, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (304, 'GALLETA OREO X 36 GR X 6 PCK', '', 128, 'PCK', 1, 3.91, 28.00, 5.00, 28.00, 5.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (305, 'GALLETA RITZ TACO', '', 129, 'NIU', 12, 0.99, 21.19, 14.40, 5.20, 12.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (306, 'PAPEL SUAVE NARANJA X 10 PQTS X 4 PACK', '', 114, 'PQT', 10, 2.70, 29.63, 35.00, 11.10, 30.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (307, 'PAPEL HIGIENICO RANGO X 24 UNID', '', 123, 'PQT', 1, 11.80, 10.20, 13.00, 10.20, 13.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (308, 'PAPEL HIGIENICO REAL X 10 PACK', '', 44, 'PQT', 1, 11.00, 18.20, 13.00, 18.20, 13.00, '20', '1', 1, -8.00);
INSERT INTO `tbl_productos` VALUES (309, 'MILO TIRA X 12 UNID', '', 4, 'TIR', 12, 0.85, 17.60, 12.00, 7.80, 11.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (310, 'GALLETAS MOROCHAS X 8 PQTS', '', 4, 'PCK', 8, 0.75, 33.25, 8.00, 8.30, 6.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (311, 'JABON BOLIVAR BEBE X 48 UNID', '', 62, 'NIU', 48, 2.40, 16.67, 134.40, 8.51, 125.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (312, 'JABON BOLIVAR ANTIBACTERIAL X 48 UNID', '', 62, 'NIU', 48, 2.40, 16.67, 134.40, 8.51, 125.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (313, 'JABON BOLIVAR LIMON X 48 UNID', '', 62, 'NIU', 48, 2.40, 16.67, 134.40, 8.51, 125.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (314, 'JABON BOLIVAR FLORAL X 48 UNID', '', 62, 'NIU', 48, 2.40, 16.67, 134.40, 8.51, 125.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (315, 'DETERGENTE TROME FLORAL X 150 GR X 60 UNID', '', 100, 'NIU', 60, 1.15, 30.44, 90.00, 8.70, 75.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (316, 'CARAMELO LIMON SAYON X 110 UNID', '', 131, 'BLS', 1, 3.31, 20.70, 4.00, 20.70, 4.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (317, 'CARAMELO MENTA SAYON', '', 131, 'BLS', 1, 3.80, 18.29, 4.50, 18.29, 4.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (318, 'CARAMELO TOFFEE SAYON X 70 UNID', '', 131, 'BLS', 1, 4.81, 14.30, 5.50, 14.30, 5.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (319, 'AVENA GRANO DE ORO X KG', '', 49, 'KG', 1, 4.00, 50.00, 6.00, 50.00, 6.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (320, 'ARROZ SELVA DORADA X 50 KG', '', 146, 'KG', 50, 2.70, 11.11, 150.00, 11.11, 150.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (321, 'SUAVIZANTE SUAVITEL X 80 ML X 12 UNID', '', 102, 'TIR', 12, 0.83, 20.45, 12.00, 15.45, 11.50, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (322, 'SUAVIZANTE SUAVITEL X 200 ML', '', 102, 'NIU', 12, 2.17, 15.20, 30.00, 7.52, 28.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (323, 'LECHE BONLE CREMOSA X 395 GR X 24 UNID', '', 12, 'NIU', 24, 2.94, 8.84, 76.80, 6.29, 75.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (324, 'LECHE CHOCOLATADA BONLE BOLSA', '', 12, 'BLS', 1, 2.85, 22.80, 3.50, 22.80, 3.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (325, 'AGUA SAN CARLOS X 3 LT X 4 UNID', '', 108, 'NIU', 4, 2.38, 26.00, 12.00, 5.00, 10.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (326, 'DESODORANTE REXONA V8 MEN X 10 GR X 10 UNID', '', 90, 'TIR', 10, 0.94, 27.70, 12.00, 6.33, 10.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (327, 'DESODORANTE REXONA NUTRITIVE X 10 GR X 10 UNID', '', 90, 'TIR', 10, 0.94, 27.70, 12.00, 6.33, 10.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (328, 'VINAGRE DEL FIRME BLANCO X 1 LT', '', 26, 'NIU', 1, 3.08, 13.60, 3.50, 13.60, 3.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (329, 'VINAGRE DEL FIRME TINTO X 1 LT', '', 26, 'NIU', 1, 3.08, 13.49, 3.50, 13.49, 3.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (330, 'NESCAFE KIRMA X 8GR X 8 UNID', '', 4, 'TIR', 8, 0.83, 20.45, 8.00, 13.00, 7.50, '20', '1', 1, -8.00);
INSERT INTO `tbl_productos` VALUES (331, 'LAVAVAJILLA LESLY X 1 KG X 12 UNID', '', 73, 'NIU', 12, 4.83, 13.87, 66.00, 6.97, 62.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (332, 'SHICK 2 AMARILLO DSP X 12 UNID', '', 113, 'TIR', 12, 0.77, 29.90, 12.00, 8.18, 10.00, '20', '1', 1, -6.00);
INSERT INTO `tbl_productos` VALUES (333, 'MERMELADA A1 POTE X 320 GR', '', 42, 'NIU', 12, 4.28, 16.83, 60.00, 10.99, 57.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (334, 'LENTEJA IMPORTADA X KG', '', 6, 'KG', 1, 6.00, 16.59, 7.00, 16.59, 7.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (335, 'ARVERJA VERDE PARTIDA X KG', '', 6, 'KG', 1, 4.44, 12.60, 5.00, 12.60, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (336, 'CEBADA X KG', '', 6, 'KG', 1, 2.80, 25.00, 3.50, 25.00, 3.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (337, 'MAIZ POP CORN X KG', '', 6, 'KG', 1, 4.44, 23.90, 5.50, 23.90, 5.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (338, 'FRIJOL HUASCAR X KG', '', 6, 'KG', 1, 8.00, 12.50, 9.00, 12.50, 9.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (339, 'TRIGO X KG', '', 6, 'KG', 1, 3.80, 18.50, 4.50, 18.50, 4.50, '20', '1', 1, -5.00);
INSERT INTO `tbl_productos` VALUES (340, 'PAPEL SUAVE VERDE X 24 UNID', '', 114, 'PQT', 1, 18.80, 17.00, 22.00, 17.00, 22.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (341, 'ACEITE BELINI X 200 ML X 24 UNID', '', 6, 'NIU', 24, 2.33, 15.88, 64.80, 10.87, 62.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (342, 'POPEYE ANTIBACTERIAL X 40 UNID', '', 99, 'NIU', 40, 1.95, 12.82, 88.00, 5.13, 82.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (343, 'ECCO LATA X 170 GR', '', 4, 'NIU', 1, 10.82, 10.90, 12.00, 10.90, 12.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (344, 'ACEITE PRIMOR PREMIUM X 200 ML X 24 UNID', '', 14, 'NIU', 24, 2.61, 14.94, 72.00, 3.76, 65.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (345, 'ACEITE PRIMOR VEGETAL X 200 ML X 24 UNID', '', 14, 'NIU', 24, 2.41, 16.18, 67.20, 10.65, 64.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (346, 'LAVAVAJILLA ÑAPANCHA X 800 GR', '', 74, 'NIU', 1, 4.77, 15.39, 5.50, 15.39, 5.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (347, 'MILO X 200 GR', '', 4, 'NIU', 1, 8.97, 11.50, 10.00, 11.50, 10.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (348, 'NESCAFE FINA SELECCION X 120 GR', '', 4, 'NIU', 1, 16.47, 9.30, 18.00, 9.30, 18.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (349, 'SUAVE RINDEMAX X 40 UNID', '', 114, 'PQT', 1, 25.99, 9.66, 28.50, 9.66, 28.50, '20', '1', 1, -5.00);
INSERT INTO `tbl_productos` VALUES (350, 'AJINOMOTO SOB 20 UNID X 60 GR', '', 6, 'BLS', 20, 0.96, 25.00, 24.00, 9.40, 21.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (351, 'AJINOMOTO X 300 UNID X 1.8 GR', '', 6, 'PQT', 1, 8.50, 11.80, 9.50, 11.80, 9.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (352, 'MARGARINA LA DANESA X 50 GR X 24 UNID', '', 147, 'CAJ', 1, 24.01, 10.35, 26.50, 10.35, 26.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (353, 'GRANO DE ORO SPAGUETTI X 500GR X 20UNID', '', 49, 'PQT', 20, 1.65, 21.20, 40.00, 12.13, 37.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (354, 'MAYONESA ALACENA X 8GR', '', 53, 'NIU', 12, 0.25, 16.50, 3.50, 16.50, 3.50, '20', '1', 1, -5.00);
INSERT INTO `tbl_productos` VALUES (355, 'TARI ALACENA X 8GR', '', 53, 'NIU', 12, 0.25, 16.50, 3.50, 16.50, 3.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (356, 'KETCHUP ALACENA X 8GR', '', 53, 'NIU', 12, 0.13, 28.00, 2.00, 28.00, 2.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (357, 'REFRESCO UMSHA X 13 GR X 12 UNID', '', 56, 'NIU', 12, 0.80, 25.00, 12.00, 9.40, 10.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (358, 'ACEITE PRIMOR PREMIUM X 1 LT X 12 UNID', '', 14, 'NIU', 12, 11.51, 12.95, 156.01, 8.60, 150.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (359, 'MAZAMORRA UMSHA X 150 GR X 12 UNID', '', 56, 'NIU', 12, 2.62, 14.50, 36.00, 11.33, 35.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (360, 'SHAMPOO DOVE TIRA X 12 UNID', '', 148, 'TIR', 12, 0.78, 28.18, 12.00, 12.20, 10.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (361, 'SHAMPOO SEDAL X 45ML X 6 UNID', '', 143, 'TIR', 6, 1.13, 32.70, 9.00, 10.59, 7.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (362, 'BONLE MANJAR BLANCO X 200 GR', '', 12, 'NIU', 1, 3.45, 16.00, 4.00, 10.00, 3.79, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (363, 'LECHE BONLE PUNCHE X 395 GR X 24 UNID', '', 12, 'NIU', 24, 2.68, 11.94, 72.00, 8.83, 70.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (364, 'LESLY X 180 GR X 24 UNID', '', 73, 'NIU', 24, 1.13, 15.03, 31.20, 6.92, 29.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (365, 'LESLY X 400 GR X 12 UNID', '', 73, 'NIU', 12, 2.25, 33.32, 36.00, 7.40, 29.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (366, 'DESINFECTANTE POET X 15 UNID', '', 93, 'PQT', 15, 1.37, 45.97, 30.00, 16.80, 24.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (367, 'CLOROX SHIROI X 340 GR X 24 UNID', '', 85, 'PQT', 24, 0.84, 19.04, 24.00, 11.60, 22.50, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (368, 'SHICK DOBLE HOJA AZUL DSP X 12 UNID', '', 113, 'TIR', 12, 1.50, 33.34, 24.00, 11.09, 20.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (369, 'AJINOMOTO SOB 20 UNID X 27 GR', '', 6, 'NIU', 20, 0.45, 33.29, 12.00, 11.10, 10.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (370, 'ACEITE SAO X 3 LT', '', 20, 'NIU', 1, 27.80, 11.50, 31.00, 11.50, 31.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (371, 'CHICOLAC X 180 ML X 24 UNID', '', 7, 'NIU', 24, 1.04, 44.23, 36.00, 12.16, 28.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (372, 'WAFER GN X 61 GR X 16 UNID', '', 126, 'NIU', 16, 0.93, 29.00, 19.20, 7.50, 16.00, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (373, 'LECHE GLORIA S/LACTOSA X 170 GR X 48 UNID', '', 7, 'NIU', 48, 2.18, 5.50, 110.40, 4.17, 109.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (374, 'PASTA DE TOMATE MOLITALIA X 80 GR X 12 UNID', '', 52, 'TIR', 12, 0.83, 20.50, 12.00, 10.40, 11.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (375, 'BOLSA 16 X 19', '', 6, 'BLS', 1, 2.69, 30.00, 3.50, 30.00, 3.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (376, 'DOWNY X 3 LT', '', 76, 'NIU', 1, 20.00, 20.00, 24.00, 20.00, 24.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (377, 'TRIDENT X 8.5 GR X 18 UNID', '', 149, 'NIU', 18, 0.92, 8.70, 18.00, 5.70, 17.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (378, 'H&S LIMPIEZA RENOVADORA TIRA X 10ML X 12 UNID', '', 109, 'TIR', 12, 0.67, 49.20, 12.00, 18.10, 9.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (379, 'H&S SUAVE MANEJABLE TIRA X 10ML X 12 UNID', '', 109, 'TIR', 12, 0.67, 49.20, 12.00, 18.10, 9.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (380, 'H&S ALIVIO REFRESCANTE TIRA X 10ML X 12 UNID', '', 109, 'TIR', 12, 0.67, 49.20, 12.00, 18.10, 9.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (381, 'H&S ACEITE DE COCO TIRA X 10ML X 12 UNID', '', 109, 'TIR', 12, 0.67, 49.20, 12.00, 18.10, 9.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (382, 'H&S PROTECCION CAIDA TIRA X 10ML X 12 UNID', '', 109, 'TIR', 12, 0.67, 49.20, 12.00, 18.10, 9.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (383, 'PANTENE RIZO DEFINIDOS TIRA X 18ML X 12 UNID', '', 110, 'TIR', 12, 0.75, 33.30, 12.00, 11.10, 10.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (384, 'PANTENE RESTAURACION TIRA X 18ML X 12 UNID', '', 110, 'TIR', 12, 0.75, 33.30, 12.00, 11.10, 10.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (385, 'PANTENE SUMMER EDITION TIRA X 18ML X 12 UNID', '', 110, 'TIR', 12, 0.75, 33.30, 12.00, 11.10, 10.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (386, 'PANTENE CREMA DE PEINAR X 16 ML X 12 UNID', '', 110, 'TIR', 12, 0.75, 33.30, 12.00, 11.10, 10.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (387, 'DOWNY BRISA FRESCA TIRA X 90 ML X 12 UNID', '', 76, 'TIR', 12, 0.75, 33.30, 12.00, 11.10, 10.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (388, 'DOWNY FLORAL SUAVIZANTE TIRA X 90 ML X 12 UNID', '', 76, 'TIR', 12, 0.75, 33.30, 12.00, 11.10, 10.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (389, 'DOWNY FLORAL TIRA X 90 ML X 12 UNID', '', 76, 'TIR', 12, 0.75, 33.30, 12.00, 11.10, 10.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (390, 'H&S FRASCO LIMPIEZA RENOVADORA X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (391, 'H&S FRASCO CARBON ACTIVADO X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (392, 'H&S FRASCO ALIVIO REFRESCANTE X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (393, 'H&S FRASCO SUAVE MANEJABLE X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (394, 'H&S FRASCO MANZANA FRESH X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (395, 'H&S FRASCO DERMO SENSITIVE X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (396, 'H&S FRASCO COCO X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (397, 'H&S FRASCO HUMECTACION X 375 ML', '', 109, 'NIU', 1, 15.45, 10.05, 17.00, 10.05, 17.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (398, 'LECHE CONDENSADA GLORIA X 393 GR', '', 7, 'NIU', 1, 4.73, 16.19, 5.50, 10.00, 5.20, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (399, 'DOÑA GUSTA TIRA X 10 UNID', '', 6, 'TIR', 10, 0.18, 39.00, 2.50, 8.00, 1.94, '20', '1', 1, -44.00);
INSERT INTO `tbl_productos` VALUES (400, 'VASOS DESCARTABLE X 6 ONZ X 5O UNID', '', 6, 'PQT', 1, 2.00, 25.00, 2.50, 25.00, 2.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (401, 'RAFIA TORCIDA X 12 UNID', '', 6, 'PQT', 12, 0.42, 19.00, 6.00, 19.00, 6.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (402, 'PAPEL HIGIENICO RENDIPEL X 115 MT X 6 ROLLOS', '', 124, 'PQT', 1, 17.71, 12.95, 20.00, 12.95, 20.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (403, 'GEL DENTAL COLGATE KIDS FRUTILLA X 50 ML', '', 67, 'NIU', 12, 2.95, 18.63, 42.00, 10.16, 39.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (404, 'KOLYNOS LIMPIEZA COMPLETA X 90 GR', '', 68, 'NIU', 12, 2.59, 15.83, 36.00, 9.40, 34.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (405, 'CEPILLO COLGATE KIDS X 12 UNID', '', 67, 'NIU', 12, 2.67, 31.10, 42.00, 9.24, 35.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (406, 'COLGATE TRIPLE ACCION X 75 ML', '', 67, 'NIU', 12, 4.82, 14.10, 66.00, 10.65, 64.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (407, 'SUAVITEL PRIMAVERA X 3 LT', '', 102, 'NIU', 1, 23.80, 9.23, 26.00, 9.23, 26.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (408, 'PAPEL HIGIENICO ELITE DUO X 6 X 8 PACKS', '', 103, 'PQT', 8, 5.08, 18.10, 48.00, 9.50, 44.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (409, 'PAPEL HIGIENICO ELITE DUO X 4 X 12 PACKS', '', 103, 'PQT', 12, 3.45, 16.00, 48.02, 8.60, 44.96, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (410, 'ELITE CLASICO X 24 UNID', '', 103, 'PQT', 1, 14.45, 10.75, 16.00, 10.75, 16.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (411, 'ELITE CLASICO X 4O UNID', '', 103, 'PQT', 1, 23.81, 11.28, 26.50, 11.28, 26.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (412, 'NOBLE AHORRO PLUS X 6 PACK X 4 UNID', '', 104, 'PQT', 1, 4.75, 15.80, 5.50, 5.20, 5.00, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (413, 'CARAMELO BAMBI X 374 GR', '', 131, 'BLS', 1, 4.00, 12.40, 4.50, 12.40, 4.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (414, 'CHOCOLISTO TIRA X 20 GR', '', 6, 'TIR', 1, 0.50, 39.00, 0.70, 10.00, 0.55, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (415, 'COCOA WINTER X 21 GR X 20 UNID', '', 21, 'NIU', 20, 0.81, 23.43, 20.00, 11.09, 18.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (416, 'COCOA WINTER X 10 GR X 50 UNID', '', 21, 'NIU', 50, 0.41, 21.93, 25.00, 9.74, 22.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (417, 'PAPEL HIGIENICO RANGO X 6 ROLLOS', '', 123, 'PQT', 1, 20.00, 10.00, 22.00, 10.00, 22.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (418, 'LECHE NIÑOS X 170 GR X 48', '', 7, 'NIU', 48, 2.00, 10.00, 105.60, 6.25, 102.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (419, 'ESENCIA DE VAINILLA KATITA X 90 ML X 12 UNID', '', 151, 'NIU', 12, 0.99, 51.50, 18.00, 13.60, 13.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (420, 'GELATINA MONTENEGRO FRESA X 5 KG', '', 144, 'KG', 5, 6.67, 12.44, 37.50, 10.95, 37.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (421, 'CINTA DE EMBALAJE', '', 6, 'NIU', 1, 2.66, 12.60, 3.00, 9.90, 2.92, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (422, 'SUAVE CUIDADO COMPLETO VERDE X 40 UNID', '', 114, 'PQT', 1, 36.77, 8.78, 40.00, 8.78, 40.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (423, 'TOALLA KOTEX NOCTURNA X 8 UNID', '', 58, 'NIU', 12, 3.81, 18.10, 54.00, 9.36, 50.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (424, 'AJINOMEN POLLO X 24 UNID', '', 6, 'PQT', 24, 1.16, 29.30, 36.00, 7.75, 30.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (425, 'LAVA X 900 GR X 12 UNID', '', 72, 'NIU', 1, 5.85, 11.10, 6.50, 11.10, 6.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (426, 'BOLSA PARA BASURA 26 X 40', '', 6, 'NIU', 1, 11.58, 12.26, 13.00, 12.26, 13.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (427, 'DOFFY X 15 KG', '', 81, 'SAC', 1, 75.48, 11.29, 84.00, 11.29, 84.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (428, 'SAL DE ANDREWS X 100 UNID', '', 6, 'NIU', 100, 0.39, 28.20, 50.00, 12.83, 44.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (429, 'LIMPIATODO SHIROI X 330 ML X 15 UNID', '', 85, 'NIU', 15, 1.11, 35.13, 22.50, 8.10, 18.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (430, 'SALSA ROJA DON VITTORIO X 200 GR', '', 46, 'NIU', 1, 2.10, 19.00, 2.50, 10.80, 2.33, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (431, 'TARI ALACENA X 85 GR', '', 53, 'NIU', 12, 3.90, 15.38, 54.00, 11.12, 52.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (432, 'WAFER GN X 29 GR X 30 UNID', '', 126, 'NIU', 30, 0.35, 42.90, 15.00, 14.30, 12.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (433, 'WAFER TUYO X 22 GR X 20 UNID', '', 126, 'NIU', 20, 0.46, 30.40, 12.00, 14.08, 10.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (434, 'NUTRICAN GATOS ATUN SARDINA ADULTO X KG', '', 116, 'KG', 1, 7.20, 25.00, 9.00, 25.00, 9.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (435, 'OPAL ULTRA FLORAL X 140 GR X 60 UNID', '', 60, 'NIU', 60, 1.63, 22.70, 120.00, 12.46, 109.99, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (436, 'DETERGENTE BOLIVAR ACTIVE CARE X 140 GR X 60 UNID', '', 62, 'NIU', 60, 2.17, 15.21, 150.00, 9.45, 142.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (437, 'ARROZ CAMPERO X 5 KG', '', 28, 'KG', 1, 17.50, 8.60, 19.00, 8.60, 19.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (438, 'COLGATE TRIPLE ACCION X 37 ML', '', 67, 'NIU', 12, 1.90, 31.60, 30.00, 9.64, 25.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (439, 'SUAVITEL PRIMAVERA X 8.5 LT', '', 102, 'NIU', 1, 56.11, 10.50, 62.00, 10.50, 62.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (440, 'COLGATE TOTAL CLEAN MNT X 75 ML', '', 67, 'NIU', 1, 9.82, 12.00, 11.00, 12.00, 11.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (441, 'SUAVITEL PRIMAVERA X 800 ML', '', 102, 'NIU', 1, 8.40, 13.10, 9.50, 13.10, 9.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (442, 'NESCAFE KIRMA LATA X 190 GR', '', 37, 'NIU', 1, 19.03, 10.33, 21.00, 10.33, 21.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (443, 'ACEITE PALMEROLA X 450 ML X 12 UNID', '', 19, 'NIU', 12, 4.33, 10.85, 57.60, 5.85, 55.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (444, 'PALMEROLA X 4.5 LT', '', 19, 'NIU', 1, 39.60, 6.07, 42.00, 6.07, 42.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (445, 'ACEITE TONDERO X 450 ML X 24 UNID', '', 18, 'NIU', 24, 5.03, 9.34, 132.00, 6.03, 128.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (446, 'ACEITE TONDERO X 900 ML X 12 UNID', '', 18, 'NIU', 12, 8.75, 8.57, 114.00, 6.67, 112.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (447, 'POPEYE MULTIUSOS X 40 UNID', '', 99, 'NIU', 40, 1.95, 12.82, 88.00, 5.13, 82.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (448, 'POPEYE EXTRA BLANCURA AMARILLO X 40 UNID', '', 99, 'NIU', 40, 1.45, 17.24, 68.00, 8.62, 63.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (449, 'POPEYE EXTRA SUAVIDAD ROSADO X 40 UNID', '', 99, 'NIU', 40, 1.75, 14.28, 80.00, 7.15, 75.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (450, 'GRATED DE JUREL CEMAR X 48 UNID', '', 39, 'NIU', 48, 2.39, 12.97, 129.60, 9.83, 126.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (451, 'CHOCOLATADA X 180 ML X 24 UNID', '', 7, 'NIU', 24, 1.36, 32.34, 43.20, 10.30, 36.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (452, 'GRATED DE ATUN GLORIA X 48 UNID', '', 7, 'NIU', 48, 2.99, 17.06, 168.00, 8.70, 156.01, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (453, 'VANISH GEL BLANCO X 100 ML X 6 UNID', '', 107, 'TIR', 6, 1.28, 17.13, 9.00, 10.70, 8.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (454, 'HIGIENOL 4 X 6 X 40 MT', '', 122, 'PCK', 6, 6.04, 12.57, 40.80, 7.62, 39.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (455, 'NOBLE PREMIUM 4 X 6 X 40 MT', '', 104, 'PQT', 6, 6.05, 12.40, 40.80, 7.43, 39.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (456, 'HIGIENOL 4 X 12 X 25 MT', '', 122, 'PQT', 12, 3.25, 23.07, 48.00, 10.25, 43.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (457, 'PAÑAL BABYSEC XXG X 44 UNID', '', 152, 'PQT', 1, 37.90, 10.81, 42.00, 10.81, 42.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (458, 'PAÑAL BABYSEC XG X 48 UNID', '', 152, 'PQT', 1, 37.90, 10.83, 42.00, 10.83, 42.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (459, 'SERVILLETA DOBLADA ELITE 100 X 6', '', 103, 'PQT', 6, 3.28, 15.83, 22.80, 9.23, 21.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (460, 'NOBLE PREMIUM 2 X 10', '', 104, 'PQT', 1, 13.35, 12.33, 15.00, 12.33, 15.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (461, 'MAGIA BLANCA FLORAL X 4 KG', '', 61, 'NIU', 1, 25.88, 8.20, 28.00, 8.20, 28.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (462, 'MAGIA BLANCA LAVANDA X 140 GR X 60 UNID', '', 61, 'NIU', 60, 1.05, 19.04, 75.00, 6.35, 67.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (463, 'MAGIA BLANCA FLORAL X 280 GR X 30 UNID', '', 61, 'NIU', 30, 1.95, 28.20, 75.00, 11.11, 65.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (464, 'MAGIA BLANCA FLORAL X 140 GR X 60 UNID', '', 61, 'NIU', 60, 1.05, 19.04, 75.00, 6.35, 67.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (465, 'MAGIA BLANCA LAVANDA X 4 KG', '', 61, 'NIU', 1, 25.88, 8.20, 28.00, 8.20, 28.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (466, 'MAGIA BLANCA LAVANDA X 280 GR X 30 UNID', '', 61, 'NIU', 30, 1.95, 28.20, 75.00, 11.11, 65.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (467, 'MAGIA BLANCA FLORAL X 780 GR', '', 61, 'NIU', 1, 6.50, 7.69, 7.00, 7.69, 7.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (468, 'MAGIA BLANCA LAVANDA X 780 GR', '', 61, 'NIU', 1, 6.50, 7.70, 7.00, 7.70, 7.00, '20', '1', 1, -4.00);
INSERT INTO `tbl_productos` VALUES (469, 'MAGIA BLANCA FLORAL X 2 KG', '', 61, 'NIU', 1, 14.53, 23.87, 18.00, 23.87, 18.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (470, 'MAGIA BLANCA LAVANDA X 2 KG', '', 61, 'NIU', 1, 14.53, 23.87, 18.00, 23.87, 18.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (471, 'MARGARINA MANTY X 90 GR', '', 6, 'NIU', 12, 2.12, 17.92, 30.00, 10.05, 28.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (472, 'CARAMELO CHICHA MORADA SAYON', '', 131, 'BLS', 1, 3.80, 18.29, 4.50, 18.29, 4.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (473, 'CARAMELO PERITA SAYON', '', 131, 'BLS', 1, 4.00, 12.62, 4.50, 12.62, 4.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (474, 'ELITE NATURAL SOFT 4 X 6 PACK X 36 MT', '', 103, 'PQT', 6, 6.05, 12.40, 40.80, 7.43, 39.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (475, 'SERVILLETA MARGARITA X 18 UNID', '', 6, 'PQT', 1, 14.00, 10.70, 15.50, 10.70, 15.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (476, 'ECCO LATA X 50 GR', '', 4, 'NIU', 1, 4.50, 11.00, 5.00, 11.00, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (477, 'ECCO TIRA X 18 UNID', '', 4, 'TIR', 18, 0.40, 75.00, 12.60, 32.00, 9.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (478, 'KOLYNOS X 22 ML', '', 68, 'NIU', 12, 1.50, 0.00, 18.00, 27.75, 23.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (479, 'PILA PANASONIC 2AA', '', 36, 'CAJ', 1, 12.00, 0.00, 12.00, 16.63, 14.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (480, 'CEPILLO KOLYNOS DSPL X 14 UNID', '', 68, 'NIU', 14, 1.64, 21.94, 28.00, 15.40, 26.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (481, 'NOSOTRAS ALAS TELA GEL X 10 UNID', '', 65, 'NIU', 12, 3.99, 25.31, 60.00, 10.70, 53.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (482, 'GALLETA VAINILLA X 12 PACKS', '', 125, 'CAJ', 12, 1.20, 11.08, 16.00, 11.08, 16.00, '20', '1', 1, -5.00);
INSERT INTO `tbl_productos` VALUES (483, 'NOSOTRAS INVISIBLE RAPIGEL X 10 UNID', '', 65, 'NIU', 12, 4.27, 28.80, 66.00, 10.26, 56.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (484, 'LADYSOFT BASICA CON ALAS X 10 UNID', '', 115, 'NIU', 12, 2.56, 17.20, 36.00, 10.67, 34.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (485, 'LADYSOFT NORMAL CON ALAS X 10 UNID', '', 115, 'NIU', 12, 3.23, 23.83, 48.00, 10.93, 43.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (486, 'PANTENE RESTAURACION FRASCO X 100 ML', '', 110, 'NIU', 1, 3.77, 32.50, 5.00, 32.50, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (487, 'PANTENE RIZOS DEFINIDOS FRASCO X 100 ML', '', 110, 'NIU', 1, 3.77, 32.50, 5.00, 32.50, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (488, 'PANTENE CUIDADO CLASICO FRASCO X 100 ML', '', 110, 'NIU', 1, 3.77, 32.50, 5.00, 32.50, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (489, 'H&S MEN OLD SPICE FRASCO X 90 ML', '', 109, 'NIU', 1, 3.77, 32.50, 5.00, 32.50, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (490, 'H& SUAVE MANEJABLE FRASCO X 90 ML', '', 109, 'NIU', 1, 3.77, 32.50, 5.00, 32.50, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (491, 'H&S LIMPIEZA RENOVADORA FRASCO X 90 ML', '', 109, 'NIU', 1, 3.77, 32.50, 5.00, 32.50, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (492, 'H&S PACK 375 ML + 180 ML LIMPIEZA RENOVADORA', '', 109, 'PCK', 1, 17.14, 22.50, 21.00, 22.50, 21.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (493, 'H&S PACK 375 ML + 180 ML SUAVE Y MANEJABLE', '', 109, 'PCK', 1, 17.14, 22.50, 21.00, 22.50, 21.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (494, 'H&S PACK 375 ML + 180 ML DERMO SENSITIVE', '', 109, 'NIU', 1, 17.14, 22.50, 21.00, 22.50, 21.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (495, 'H&S PACK COCO 375 ML + ACONDICIONADOR 300 ML', '', 109, 'PCK', 1, 17.14, 45.85, 25.00, 45.83, 25.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (496, 'H&S PACK LIMP REN 375 ML + ACONDICIONADOR 300 ML', '', 109, 'PCK', 1, 17.14, 45.83, 25.00, 45.83, 25.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (497, 'AGUA SAN CARLOS SIN GAS X 500 ML X 15 UNID', '', 108, 'PQT', 15, 0.63, 58.70, 15.00, 16.39, 11.00, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (498, 'JABON EN BARRA ZOTE', '', 97, 'NIU', 1, 2.20, 13.49, 2.50, 13.49, 2.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (499, 'AGUARDIENTE', '', 6, 'NIU', 1, 2.20, 13.49, 2.50, 13.49, 2.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (500, 'JABON EN BARRA ESPUMIL', '', 82, 'NIU', 12, 1.80, 22.20, 26.40, 13.41, 24.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (501, 'MARSELLA X KG', '', 59, 'KG', 1, 7.77, 9.39, 8.50, 9.39, 8.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (502, 'MARSELLA PETALOS X 750 GR', '', 59, 'NIU', 1, 7.10, 12.69, 8.00, 9.79, 7.80, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (503, 'MARSELLA PETALOS X 2 KG', '', 59, 'BLS', 1, 18.00, 11.10, 20.00, 11.10, 20.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (504, 'DETERGENTE TROME CITRICO X 150 GR X 60 UNID', '', 100, 'NIU', 60, 1.15, 30.44, 90.00, 8.70, 75.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (505, 'TUCO SIBARITA', '', 6, 'NIU', 1, 0.36, 68.00, 0.60, 68.00, 0.60, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (506, 'COMINO', '', 6, 'NIU', 1, 0.36, 38.00, 0.50, 38.00, 0.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (507, 'SUAVE VERDE X 6 UNID', '', 114, 'PQT', 1, 5.00, 10.00, 5.50, 10.00, 5.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (508, 'CHUPETIN GLOBO POP SURTIDO X 24 UNID', '', 132, 'BLS', 24, 0.25, 100.00, 12.00, 8.40, 6.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (509, 'DESODORANTE LADY SPEED STICK X 20 UNID', '', 153, 'CAJ', 20, 0.80, 25.00, 20.00, 11.22, 17.80, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (510, 'DESODORANTE SPEED STICK X 20 UNID', '', 66, 'CAJ', 20, 0.80, 25.00, 20.00, 11.22, 17.80, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (511, 'BOLSA 10 X 15', '', 6, 'BLS', 1, 0.70, 43.00, 1.00, 43.00, 1.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (512, 'JABON LIQUIDO AVAL ANTIBACTERIAL', '', 86, 'NIU', 1, 5.00, 20.00, 6.00, 10.00, 5.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (513, 'CHEMER VERDE X 12 UNID', '', 6, 'BLI', 12, 0.38, 100.00, 12.00, 20.56, 5.50, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (514, 'AVENA GRANO DE ORO X 170 GR X 24 UNID', '', 49, 'PQT', 24, 0.83, 20.46, 24.00, 10.42, 22.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (515, 'AVENA GRANO DE ORO X 80 GR X 48 UNID', '', 49, 'PQT', 48, 0.43, 39.52, 28.80, 16.26, 24.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (516, 'AVENA GRANO DE ORO X 370 GR X 12 UNID', '', 49, 'PQT', 12, 1.90, 31.56, 30.00, 14.03, 26.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (517, 'AVENA GRANO DE ORO X KG', '', 49, 'KG', 1, 4.50, 33.29, 6.00, 33.29, 6.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (518, 'NUTRICAN DOG ADULTO X KG', '', 116, 'KG', 1, 4.80, 24.92, 6.00, 24.92, 6.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (519, 'CUCHARA DESCARTABLE X 50 UNID', '', 6, 'BLS', 1, 2.00, 25.00, 2.50, 25.00, 2.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (520, 'LADY SPEED STICK CLINICAL X 30 GR', '', 66, 'NIU', 1, 3.00, 16.80, 3.50, 16.80, 3.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (521, 'SPEED STICK CLINICAL X 30 GR', '', 66, 'NIU', 1, 3.00, 16.80, 3.50, 16.80, 3.50, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (522, 'LADY SPEED STICK AEREOSOL X 100 ML', '', 66, 'NIU', 1, 6.00, 8.40, 6.50, 8.40, 6.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (523, 'LECHE GLORIA S/LACTOSA X 400 GR X 24 UNID', '', 7, 'NIU', 24, 3.63, 10.19, 96.00, 5.60, 92.00, '20', '1', 1, -1.00);
INSERT INTO `tbl_productos` VALUES (524, 'GLORIA LIGHT X 170 GR X 48 UNID', '', 7, 'NIU', 48, 2.00, 10.00, 105.60, 6.25, 102.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (525, 'NOBLE MORADO 2 X 10', '', 104, 'PQT', 1, 13.50, 14.80, 15.50, 14.80, 15.50, '20', '1', 1, -3.00);
INSERT INTO `tbl_productos` VALUES (526, 'ALIANZA TALLARIN X 500 GR X 20 UNID', '', 48, 'NIU', 20, 1.90, 15.80, 44.00, 10.53, 42.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (527, 'ESPIGA DE ORO TALLARIN X 500 GR X 20 UNID', '', 51, 'NIU', 20, 1.67, 19.77, 40.00, 10.78, 37.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (528, 'ESPIGA DE ORO CABELLO DE ANGEL X 250 GR X 40 UNID', '', 51, 'NIU', 40, 0.84, 19.06, 40.00, 10.12, 37.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (529, 'ESPIGA DE ORO PARA SOPA X 250 GR X 20 UNID', '', 51, 'BLS', 20, 0.84, 19.07, 20.00, 10.10, 18.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (530, 'MARCO POLO SPAGUETTI X 500 GR X 20 UNID', '', 50, 'NIU', 20, 2.10, 19.04, 50.00, 9.53, 46.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (531, 'GRANO DE ORO CABELLO DE ANGEL X 250 GR X 40 UNID', '', 49, 'NIU', 40, 0.00, 0.00, 0.00, 0.00, 0.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (532, 'GRANO DE ORO CABELLO DE ANGEL X 250 GR X 40 UNID', '', 49, 'NIU', 40, 0.83, 20.49, 40.00, 11.44, 37.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (533, 'AJINOSILLAO X 280 ML', '', 29, 'NIU', 1, 2.00, 25.00, 2.50, 12.28, 2.25, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (534, 'JABON TROME FLORAL X 190 GR X 40 UNID', '', 100, 'NIU', 40, 1.42, 19.72, 68.00, 9.15, 62.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (535, 'JABON TROME LIMON X 190 GR X 40 UNID', '', 100, 'NIU', 40, 1.42, 19.72, 68.00, 9.15, 62.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (536, 'JABON JUMBO LIMON X 190 GR X 40 UNID', '', 101, 'NIU', 40, 1.51, 19.20, 72.00, 9.27, 66.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (537, 'CARAMELO IQUEÑO SAYON X 120 UNID', '', 131, 'BLS', 1, 4.46, 12.00, 5.00, 12.00, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (538, 'AGUA SAN CARLOS CON GAS X 500 ML X 15 UNID', '', 108, 'PQT', 15, 0.62, 61.24, 15.00, 18.30, 11.00, '20', '1', 1, -2.00);
INSERT INTO `tbl_productos` VALUES (539, 'PAPEL HIGIENICO SUPER X 24 UNID', '', 106, 'PQT', 1, 13.75, 12.70, 15.50, 12.70, 15.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (540, 'OPAL ULTRA FLORAL X 780 GR', '', 60, 'NIU', 1, 7.95, 7.00, 8.51, 7.00, 8.51, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (541, 'FIDEO DON VITTORIO X 500 GR X 20 UNID', '', 46, 'NIU', 1, 3.45, 16.00, 4.00, 16.00, 4.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (542, 'OPAL ULTRA FLORAL X 2 KG', '', 60, 'BLS', 1, 22.00, 13.65, 25.00, 13.65, 25.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (543, 'LAVAVAJILLA ZAGAZ X 1 KG', '', 154, 'NIU', 1, 5.80, 11.99, 6.50, 11.99, 6.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (544, 'PAÑOS HUMEDOS PEQUEÑIN ALOE X 100 UNID', '', 155, 'PCK', 1, 10.00, 12.00, 11.20, 12.00, 11.20, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (545, 'BOLIVAR ACTIVE CARE X 2.6 KG', '', 62, 'NIU', 1, 32.00, 9.36, 35.00, 9.36, 35.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (546, 'TOALLA KOTEX DISCRETA X 10 UNID', '', 58, 'NIU', 12, 3.20, 25.00, 48.00, 11.97, 43.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (547, 'LAVAVAJILLA PATITO X 1 KG', '', 71, 'NIU', 1, 3.80, 18.50, 4.50, 11.76, 4.25, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (548, 'LAVAVAJILLA SAPOLIO X 800 GR', '', 70, 'NIU', 1, 4.25, 18.00, 5.01, 11.70, 4.75, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (549, 'BOLIVAR AROMA Y SUAVIDAD X 750 GR X 15 UNID', '', 62, 'NIU', 1, 8.60, 10.45, 9.50, 10.45, 9.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (550, 'ARIEL PRO CUIDADO X 4 KG', '', 64, 'NIU', 1, 41.23, 11.57, 46.00, 11.57, 46.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (551, 'ARIEL DOWNY X 4 KG', '', 64, 'NIU', 1, 41.23, 11.57, 46.00, 11.57, 46.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (552, 'ARIEL REVITA COLOR X 4 KG', '', 64, 'NIU', 1, 41.23, 11.57, 46.00, 11.57, 46.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (553, 'ESPONJA X 12 UNID', '', 6, 'TIR', 12, 0.79, 26.53, 12.00, 10.80, 10.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (554, 'SHICK 3 XTREME X 12 UNID', '', 113, 'TIR', 12, 2.08, 44.23, 36.00, 20.20, 30.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (555, 'ARIEL DOWNY X 2 KG', '', 64, 'NIU', 1, 21.68, 10.70, 24.00, 10.70, 24.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (556, 'ARIEL PRO CUIDADO X 2 KG', '', 64, 'NIU', 1, 21.68, 10.70, 24.00, 10.70, 24.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (557, 'ARIEL REVITA COLOR X 2 KG', '', 64, 'NIU', 1, 21.68, 10.70, 24.00, 10.70, 24.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (558, 'ARIEL DOWNY X 800 GR', '', 64, 'NIU', 1, 8.00, 12.50, 9.00, 12.50, 9.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (559, 'ARIEL REVITA COLOR X 780 GR', '', 64, 'NIU', 1, 8.00, 12.50, 9.00, 12.50, 9.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (560, 'ARIEL PRO CUIDADO X 330 GR', '', 64, 'NIU', 12, 3.80, 18.43, 54.00, 14.03, 52.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (561, 'ACE AROMA FLORAL X 4 KG', '', 63, 'NIU', 1, 34.92, 11.67, 39.00, 11.67, 39.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (562, 'ACE AROMA FLORAL X 2 KG', '', 63, 'NIU', 1, 19.00, 10.50, 21.00, 10.50, 21.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (563, 'ACE AROMA FLORAL X 830 GR', '', 63, 'NIU', 1, 7.27, 10.00, 8.00, 10.00, 8.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (564, 'ACE AROMA FLORAL X 330 GR', '', 63, 'NIU', 12, 2.80, 25.00, 42.00, 16.06, 39.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (565, 'BONLE CONDENSADA X 397 GR', '', 12, 'NIU', 1, 3.43, 16.50, 4.00, 10.00, 3.77, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (566, 'CAÑONAZO X 22 GR X 24 UNID', '', 134, 'NIU', 24, 0.43, 16.30, 12.00, 11.40, 11.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (567, 'GALLETA OREO X 54 GR', '', 128, 'NIU', 1, 1.20, 25.00, 1.50, 25.00, 1.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (568, 'AYUDIN LIQUIDO LIMON Y SABILA X 900 ML', '', 75, 'NIU', 1, 10.89, 14.78, 12.50, 14.78, 12.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (569, 'AYUDIN LIQUIDO LIMON Y SABILA X 640 ML', '', 75, 'NIU', 1, 7.75, 61.23, 12.50, 61.23, 12.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (570, 'AYUDIN LIQUIDO LIMON Y SABILA X 280 ML', '', 75, 'NIU', 1, 4.54, 10.06, 5.00, 10.06, 5.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (571, 'CEPILLO ORAL B 123 X 35 M', '', 80, 'NIU', 1, 1.75, 43.00, 2.50, 43.00, 2.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (572, 'CEPILLO PRO 2 PACK PROFILE', '', 79, 'NIU', 1, 6.48, 15.70, 7.50, 15.70, 7.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (573, 'CEPILLO PRO DELUXE ANTICARIES X 36 M', '', 79, 'NIU', 1, 4.73, 16.18, 5.50, 16.18, 5.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (574, 'PRESTOBARBA VENUS TIRA', '', 112, 'TIR', 1, 3.64, 10.00, 4.00, 10.00, 4.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (575, 'PANTENE PRO-V MIRACLES COLAGENO X 18 ML X 12 UNID', '', 110, 'TIR', 12, 0.75, 11.10, 10.00, 11.10, 10.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (576, 'AYUDIN X 170 GR X 24 UNID', '', 75, 'NIU', 24, 1.60, 25.00, 48.00, 11.97, 43.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (577, 'AYUDIN X 285 GR X 24 UNID', '', 75, 'NIU', 24, 2.18, 14.67, 60.00, 10.85, 58.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (578, 'AYUDIN X 750 GR X 12 UNID', '', 75, 'NIU', 12, 4.85, 13.40, 66.00, 9.97, 64.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (579, 'AYUDIN REPUESTO X 24 UNID', '', 75, 'NIU', 24, 0.97, 23.70, 28.80, 11.70, 26.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (580, 'DOWNY AROMA FLORAL X 360 ML', '', 76, 'NIU', 1, 3.24, 23.35, 4.00, 23.35, 4.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (581, 'DOWNY FLORAL X 800 ML', '', 76, 'NIU', 1, 8.18, 10.00, 9.00, 10.00, 9.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (582, 'DOWNY FLORAL X 1.4 LT', '', 76, 'NIU', 1, 12.27, 10.00, 13.50, 10.00, 13.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (583, 'DOWNY FLORAL X 2.8 LT', '', 76, 'NIU', 1, 18.00, 22.20, 22.00, 22.20, 22.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (584, 'SARDINA EN SALSA DE TOMATE CLEMAR X 48 UNID', '', 40, 'NIU', 48, 1.88, 32.98, 120.00, 10.82, 100.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (585, 'CEMAR SARDINA EN SALSA DE TOMATE X 48 UNID', '', 156, 'NIU', 48, 1.79, 11.73, 96.00, 10.57, 95.00, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (586, 'CHUPETIN GLOBO POP FRESA X 24 UNID', '', 132, 'BLS', 24, 0.25, 100.00, 12.00, 8.40, 6.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (587, 'TAPER HUEVITOS X 165 UNID', '', 132, 'KG', 1, 12.13, 11.30, 13.50, 11.30, 13.50, '20', '1', 1, 0.00);
INSERT INTO `tbl_productos` VALUES (588, 'GLOBO POP LED SURTIDO X 20 UNID', '', 132, 'CAJ', 20, 0.53, 88.67, 20.00, 13.17, 12.00, '20', '1', 1, 0.00);

-- ----------------------------
-- Table structure for tbl_recetas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_recetas`;
CREATE TABLE `tbl_recetas`  (
  `id_receta` int(5) NOT NULL AUTO_INCREMENT,
  `id_producto` int(5) NULL DEFAULT NULL,
  `id_insumo` int(5) NULL DEFAULT NULL,
  `cantidad` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_receta`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_recetas
-- ----------------------------
INSERT INTO `tbl_recetas` VALUES (5, 6, 4, 1.00);
INSERT INTO `tbl_recetas` VALUES (6, 7, 4, 24.00);
INSERT INTO `tbl_recetas` VALUES (7, 8, 5, 24.00);
INSERT INTO `tbl_recetas` VALUES (8, 9, 5, 1.00);
INSERT INTO `tbl_recetas` VALUES (9, 6, 5, 1.00);
INSERT INTO `tbl_recetas` VALUES (10, 10, 4, 4.00);

-- ----------------------------
-- Table structure for tbl_series
-- ----------------------------
DROP TABLE IF EXISTS `tbl_series`;
CREATE TABLE `tbl_series`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_td` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `serie` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `correlativo` int(8) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `id_empresa` int(5) NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '1',
  `flat` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_serie`(`id_td`) USING BTREE,
  CONSTRAINT `fk_serie` FOREIGN KEY (`id_td`) REFERENCES `tbl_tipo_documento` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_series
-- ----------------------------
INSERT INTO `tbl_series` VALUES (15, '01', 'F001', 00000043, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (16, '03', 'B001', 00000110, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (17, '01', 'F002', 00000005, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (18, '07', 'FC01', 00000005, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (19, '07', 'BC01', 00000001, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (20, '99', 'NV01', 00000001, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (21, '03', 'B002', 00000130, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (22, '07', 'BC02', 00000001, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (23, '01', 'F002', 00000005, 1, '1', '0');
INSERT INTO `tbl_series` VALUES (24, '99', 'NV02', 00000053, 1, '1', '0');

-- ----------------------------
-- Table structure for tbl_series_usuarios
-- ----------------------------
DROP TABLE IF EXISTS `tbl_series_usuarios`;
CREATE TABLE `tbl_series_usuarios`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(5) NULL DEFAULT NULL,
  `id_serie` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_series_usuarios
-- ----------------------------
INSERT INTO `tbl_series_usuarios` VALUES (15, 1, 15);
INSERT INTO `tbl_series_usuarios` VALUES (16, 1, 16);
INSERT INTO `tbl_series_usuarios` VALUES (17, 1, 18);
INSERT INTO `tbl_series_usuarios` VALUES (18, 1, 19);
INSERT INTO `tbl_series_usuarios` VALUES (19, 1, 20);
INSERT INTO `tbl_series_usuarios` VALUES (20, 5, 17);
INSERT INTO `tbl_series_usuarios` VALUES (21, 5, 21);
INSERT INTO `tbl_series_usuarios` VALUES (22, 5, 22);
INSERT INTO `tbl_series_usuarios` VALUES (23, 5, 24);

-- ----------------------------
-- Table structure for tbl_tipo_afectacion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_afectacion`;
CREATE TABLE `tbl_tipo_afectacion`  (
  `codigo` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `codigo_tributo` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `fk_cod_tributo`(`codigo_tributo`) USING BTREE,
  CONSTRAINT `fk_cod_tributo` FOREIGN KEY (`codigo_tributo`) REFERENCES `tbl_tipo_tributo` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_tipo_afectacion
-- ----------------------------
INSERT INTO `tbl_tipo_afectacion` VALUES ('10', 'GRAVADO - OPERACION ONEROSA', '1000');
INSERT INTO `tbl_tipo_afectacion` VALUES ('11', 'GRAVADO - RETIRO POR PREMIO', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('12', 'GRAVADO - RETIRO POR DONACION', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('13', 'GRAVADO - RETIRO', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('14', 'GRAVADO - RETIRO POR PUBLICIDAD', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('15', 'GRAVADO - BONIFICACIONES', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('16', 'GRAVADO - RETIRO POR ENTREGA A TRABAJADORES', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('17', 'GRAVADO - IVAP', '1016');
INSERT INTO `tbl_tipo_afectacion` VALUES ('20', 'EXONERADO - OPERACION ONEROSA', '9997');
INSERT INTO `tbl_tipo_afectacion` VALUES ('21', 'EXONERADO - TRANSFERENCIA GRATUITA', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('30', 'INAFECTO - OPERACION ONEROSA', '9998');
INSERT INTO `tbl_tipo_afectacion` VALUES ('31', 'INAFECTO - RETIRO POR BONIFICACION', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('32', 'INAFCETO - RETIRO', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('33', 'INAFECTO - RETIRO POR MUESTRAS MEDICAS', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('34', 'INAFECTO - RETIRO POR CONVENIO COLECTIVO', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('35', 'INAFECTO - RETIRO POR PREMIO', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('36', 'INAFECTO - RETIRO POR PUBLICIDAD', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('37', 'INAFECTO - TRANSFERENCIA GRATUITA', '9996');
INSERT INTO `tbl_tipo_afectacion` VALUES ('40', 'EXPORTACION DE BIENES O SERVICIOS', '9995');

-- ----------------------------
-- Table structure for tbl_tipo_documento
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_documento`;
CREATE TABLE `tbl_tipo_documento`  (
  `cod` int(5) NOT NULL AUTO_INCREMENT,
  `id` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `nombre` char(30) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `fe` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '0',
  PRIMARY KEY (`cod`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_tipo_documento
-- ----------------------------
INSERT INTO `tbl_tipo_documento` VALUES (1, '00', 'OTROS', '0');
INSERT INTO `tbl_tipo_documento` VALUES (2, '01', 'FACTURA', '1');
INSERT INTO `tbl_tipo_documento` VALUES (3, '02', 'RECIBO POR HONORARIO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (4, '03', 'BOLETA DE VENTA', '1');
INSERT INTO `tbl_tipo_documento` VALUES (5, '04', 'LIQUIDAC. DE COMPRA', '0');
INSERT INTO `tbl_tipo_documento` VALUES (6, '05', 'BOLETO DE AVION', '0');
INSERT INTO `tbl_tipo_documento` VALUES (7, '06', 'CARTA PORTE AEREO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (8, '07', 'NOTA DE CREDITO', '1');
INSERT INTO `tbl_tipo_documento` VALUES (9, '08', 'NOTA DE DEBITO', '1');
INSERT INTO `tbl_tipo_documento` VALUES (10, '09', 'GUIA DE REMISION', '0');
INSERT INTO `tbl_tipo_documento` VALUES (11, '10', 'RECIBO DE ARRENDAMIE', '0');
INSERT INTO `tbl_tipo_documento` VALUES (12, '11', 'POLIZA BOLSA VALORES', '0');
INSERT INTO `tbl_tipo_documento` VALUES (13, '12', 'TICKET MAQUINA REGIS', '0');
INSERT INTO `tbl_tipo_documento` VALUES (14, '13', 'DOCUMENTO BANCOS', '0');
INSERT INTO `tbl_tipo_documento` VALUES (15, '14', 'RECIBOS SERV. PUBLIC', '0');
INSERT INTO `tbl_tipo_documento` VALUES (16, '15', 'BOLETO TRANS. PUBLIC', '0');
INSERT INTO `tbl_tipo_documento` VALUES (17, '16', 'BOLETO DE VIAJE T.P.', '0');
INSERT INTO `tbl_tipo_documento` VALUES (18, '17', 'DOCUMENTO IGLESIA C.', '0');
INSERT INTO `tbl_tipo_documento` VALUES (19, '18', 'DOCUMENTO AFP', '0');
INSERT INTO `tbl_tipo_documento` VALUES (20, '19', 'BOLETO ESP. PUBLICOS', '0');
INSERT INTO `tbl_tipo_documento` VALUES (21, '20', 'COMP. DE RETENCION', '0');
INSERT INTO `tbl_tipo_documento` VALUES (22, '21', 'CONOCIM. EMBARQUE', '0');
INSERT INTO `tbl_tipo_documento` VALUES (23, '22', 'COMPROB. NO HABITUAL', '0');
INSERT INTO `tbl_tipo_documento` VALUES (24, '23', 'POLIZA DE ADJUDICAC.', '0');
INSERT INTO `tbl_tipo_documento` VALUES (25, '24', 'CERTIF. REGALIAS', '0');
INSERT INTO `tbl_tipo_documento` VALUES (26, '25', 'DOC. ATRIB. ISC', '0');
INSERT INTO `tbl_tipo_documento` VALUES (27, '26', 'REC. UNIDAD DE AGUA', '0');
INSERT INTO `tbl_tipo_documento` VALUES (28, '27', 'SEGURO C.T.R.', '0');
INSERT INTO `tbl_tipo_documento` VALUES (29, '28', 'TARIFA U. AEROPUERTO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (30, '29', 'DOC. COFOPRI', '0');
INSERT INTO `tbl_tipo_documento` VALUES (31, '30', 'DOC. EMP. EN T.CRED', '0');
INSERT INTO `tbl_tipo_documento` VALUES (32, '31', 'GUIA RT', '0');
INSERT INTO `tbl_tipo_documento` VALUES (33, '32', 'DOC. INDUS. GAS NATU', '0');
INSERT INTO `tbl_tipo_documento` VALUES (34, '34', 'DOC. OPERADOR', '0');
INSERT INTO `tbl_tipo_documento` VALUES (35, '35', 'DOC. PARTICIPE', '0');
INSERT INTO `tbl_tipo_documento` VALUES (36, '36', 'REC. DIST. GAS NATUR', '0');
INSERT INTO `tbl_tipo_documento` VALUES (37, '37', 'DOC. REVI. TEC. VEHI', '0');
INSERT INTO `tbl_tipo_documento` VALUES (38, '50', 'D.U.A. IMPORTACION', '0');
INSERT INTO `tbl_tipo_documento` VALUES (39, '52', 'DESP. SIM. IMP. SIMP', '0');
INSERT INTO `tbl_tipo_documento` VALUES (40, '53', 'DECLARAC. MENSAJERIA', '0');
INSERT INTO `tbl_tipo_documento` VALUES (41, '54', 'LIQUID. COBRANZAS', '0');
INSERT INTO `tbl_tipo_documento` VALUES (42, '87', 'NOTA DE CREDITO ES.', '0');
INSERT INTO `tbl_tipo_documento` VALUES (43, '88', 'NOTA DE DEBITO ESP.', '0');
INSERT INTO `tbl_tipo_documento` VALUES (44, '91', 'COMP. DE NO DOMICILI', '0');
INSERT INTO `tbl_tipo_documento` VALUES (45, '92', 'EXC. CFR DE BIENES', '0');
INSERT INTO `tbl_tipo_documento` VALUES (46, '97', 'N.C. NO DOMICILIADO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (47, '98', 'N.D. NO DOMICILIADO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (48, '99', 'NOTA DE VENTA', '1');
INSERT INTO `tbl_tipo_documento` VALUES (49, 'BP', 'BOLETA DE PAGO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (50, 'BS', 'BOLETA DE SUELDO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (51, 'CH', 'CHEQUE', '0');
INSERT INTO `tbl_tipo_documento` VALUES (52, 'CP', 'COMPROB DE PERCEPCIO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (53, 'DP', 'DEPOSITO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (54, 'LE', 'LETRA', '0');
INSERT INTO `tbl_tipo_documento` VALUES (55, 'P', 'Entregas comprobante', '0');
INSERT INTO `tbl_tipo_documento` VALUES (56, 'PI', 'factura incluida CP', '0');
INSERT INTO `tbl_tipo_documento` VALUES (57, 'RE', 'RECIBO DE EGRESO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (58, 'RI', 'RECIBO DE INGRESO', '0');
INSERT INTO `tbl_tipo_documento` VALUES (59, 'TR', 'TRANSFERENCIA', '0');

-- ----------------------------
-- Table structure for tbl_tipo_moneda
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_moneda`;
CREATE TABLE `tbl_tipo_moneda`  (
  `id_mon` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_mon` char(40) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_mon`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_tipo_moneda
-- ----------------------------
INSERT INTO `tbl_tipo_moneda` VALUES ('1', 'NUEVOS SOLES');
INSERT INTO `tbl_tipo_moneda` VALUES ('2', 'DÓLARES AMERICANOS');
INSERT INTO `tbl_tipo_moneda` VALUES ('9', 'OTRA MONEDA (ESPECIFICAR)');

-- ----------------------------
-- Table structure for tbl_tipo_operacion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_operacion`;
CREATE TABLE `tbl_tipo_operacion`  (
  `id` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_tipo_operacion
-- ----------------------------
INSERT INTO `tbl_tipo_operacion` VALUES ('01', 'VENTA');
INSERT INTO `tbl_tipo_operacion` VALUES ('02', 'COMPRA');
INSERT INTO `tbl_tipo_operacion` VALUES ('03', 'CONSIGNACIÓN RECIBIDA');
INSERT INTO `tbl_tipo_operacion` VALUES ('04', 'CONSIGNACIÓN ENTREGADA');
INSERT INTO `tbl_tipo_operacion` VALUES ('05', 'DEVOLUCIÓN RECIBIDA');
INSERT INTO `tbl_tipo_operacion` VALUES ('06', 'DEVOLUCIÓN ENTREGADA');
INSERT INTO `tbl_tipo_operacion` VALUES ('07', 'PROMOCIÓN');
INSERT INTO `tbl_tipo_operacion` VALUES ('08', 'PREMIO');
INSERT INTO `tbl_tipo_operacion` VALUES ('09', 'DONACIÓN');
INSERT INTO `tbl_tipo_operacion` VALUES ('10', 'SALIDA A PRODUCCIÓN');
INSERT INTO `tbl_tipo_operacion` VALUES ('11', 'TRANSFERENCIA ENTRE ALMACENES');
INSERT INTO `tbl_tipo_operacion` VALUES ('12', 'RETIRO');
INSERT INTO `tbl_tipo_operacion` VALUES ('13', 'MERMAS');
INSERT INTO `tbl_tipo_operacion` VALUES ('14', 'DESMEDROS');
INSERT INTO `tbl_tipo_operacion` VALUES ('15', 'DESTRUCCIÓN');
INSERT INTO `tbl_tipo_operacion` VALUES ('16', 'SALDO INICIAL');
INSERT INTO `tbl_tipo_operacion` VALUES ('99', 'OTROS (ESPECIFICAR)');

-- ----------------------------
-- Table structure for tbl_tipo_tributo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_tributo`;
CREATE TABLE `tbl_tipo_tributo`  (
  `codigo` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `codigo_internacional` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre` char(6) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_tipo_tributo
-- ----------------------------
INSERT INTO `tbl_tipo_tributo` VALUES ('1000', 'IGV IMPUESTO GENERAL A LAS VENTAS', 'VAT', 'IGV');
INSERT INTO `tbl_tipo_tributo` VALUES ('1016', 'IMPUESTO A LA VENTA DE ARROZ PILADO', 'VAT', 'IVAP');
INSERT INTO `tbl_tipo_tributo` VALUES ('2000', 'ISC IMPUESTO SELECTIVO AL CONSUMO', 'EXC', 'ISC');
INSERT INTO `tbl_tipo_tributo` VALUES ('7152', 'IMPUESTO A LA BOLSA PLASTICA', 'OTH', 'ICBPER');
INSERT INTO `tbl_tipo_tributo` VALUES ('9995', 'EXPORTACION', 'FRE', 'EXP');
INSERT INTO `tbl_tipo_tributo` VALUES ('9996', 'GRATUITO', 'FRE', 'GRA');
INSERT INTO `tbl_tipo_tributo` VALUES ('9997', 'EXONERADO', 'VAT', 'EXO');
INSERT INTO `tbl_tipo_tributo` VALUES ('9998', 'INAFECTO', 'FRE', 'INA');
INSERT INTO `tbl_tipo_tributo` VALUES ('9999', 'OTROS TRIBUTOS', 'OTH', 'OTROS');

-- ----------------------------
-- Table structure for tbl_unidad
-- ----------------------------
DROP TABLE IF EXISTS `tbl_unidad`;
CREATE TABLE `tbl_unidad`  (
  `cod` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `nombre` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_SUNAT` char(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cod`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_unidad
-- ----------------------------
INSERT INTO `tbl_unidad` VALUES ('BLI', 'BLISTER', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('BLS', 'BOLSA', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('CAJ', 'CAJAS', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('KG', 'KILOS', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('NIU', 'UNIDAD', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('PCK', 'PACK', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('PK', 'PAQUETE', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('PQT', 'PAQUETES', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('SAC', 'SACOS', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('TIR', 'TIRA', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('ZZ', 'SERVICIOS', 'ZZ');

-- ----------------------------
-- Table structure for tbl_usuarios
-- ----------------------------
DROP TABLE IF EXISTS `tbl_usuarios`;
CREATE TABLE `tbl_usuarios`  (
  `id_usuario` int(5) NOT NULL AUTO_INCREMENT,
  `usuario` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `clave` char(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre_personal` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `apellido_personal` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `id_empresa` int(5) NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  `almacen` int(5) NULL DEFAULT NULL,
  `perfil` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`) USING BTREE,
  INDEX `fk_empresas`(`id_empresa`) USING BTREE,
  CONSTRAINT `fk_empresas` FOREIGN KEY (`id_empresa`) REFERENCES `tbl_empresas` (`id_empresa`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_usuarios
-- ----------------------------
INSERT INTO `tbl_usuarios` VALUES (1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'ANA CAROLA', 'NUREÑA FLORES', 1, '1', 8, 1);
INSERT INTO `tbl_usuarios` VALUES (5, 'VENTA', '81dc9bdb52d04dc20036dbd8313ed055', 'VENTAS', 'VENTAS', 1, '1', 8, 3);

-- ----------------------------
-- Table structure for tbl_venta_cab
-- ----------------------------
DROP TABLE IF EXISTS `tbl_venta_cab`;
CREATE TABLE `tbl_venta_cab`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempresa` int(5) NULL DEFAULT NULL,
  `tipocomp` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serie` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `correlativo` int(8) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `fecha_emision` date NULL DEFAULT NULL,
  `fecha_vencimiento` date NULL DEFAULT NULL,
  `orden_compra` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `condicion_venta` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cuotas_credito` int(5) NULL DEFAULT 0,
  `codmoneda` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'PEN',
  `op_gravadas` decimal(11, 2) NULL DEFAULT NULL,
  `op_exoneradas` decimal(11, 2) NULL DEFAULT NULL,
  `op_inafectas` decimal(11, 2) NULL DEFAULT NULL,
  `igv` decimal(11, 2) NULL DEFAULT NULL,
  `total` decimal(11, 2) NULL DEFAULT NULL,
  `codcliente` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `feestado` int(1) NOT NULL DEFAULT 0,
  `fecodigoerror` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `femensajesunat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `nombrexml` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `xmlbase64` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cdrbase64` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `hash` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `tipocomp_ref` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serie_ref` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `correlativo_ref` int(8) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `cod_motivo` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `des_motivo` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '1',
  `vendedor` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tipcomp`(`tipocomp`) USING BTREE,
  INDEX `fk_moneda`(`codmoneda`) USING BTREE,
  INDEX `fk_cliente`(`codcliente`) USING BTREE,
  INDEX `fk_emisor`(`idempresa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 617 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_venta_cab
-- ----------------------------
INSERT INTO `tbl_venta_cab` VALUES (256, 1, '01', 'F001', 00000001, '2022-04-01', '2022-04-01', NULL, '1', 0, 'PEN', 0.00, 1.00, 0.00, 0.00, 1.00, '20494168651', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'sBinL/nOmuuQpXcLcjdfEx0ygkc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (257, 1, '07', 'FC01', 00000001, '2022-04-01', '2022-04-01', NULL, '1', 0, 'PEN', 0.00, 1.00, 0.00, 0.00, 1.00, '20494168651', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '4TDFm02NV7AJiBF15yTIGuv87+Q=', '01', 'F001', 00000001, '01', 'ANULACION DE LA OPERACION', '1', NULL);
INSERT INTO `tbl_venta_cab` VALUES (264, 1, '01', 'F001', 00000002, '2022-04-08', '2022-04-08', NULL, '1', 0, 'PEN', 0.00, 111.00, 0.00, 0.00, 111.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'kYG8ZFpc3RZ2ZQ1x+fkfATUbhSs=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (265, 1, '01', 'F001', 00000003, '2022-04-09', '2022-04-09', NULL, '1', 0, 'PEN', 0.00, 24.00, 0.00, 0.00, 24.00, '20450315941', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '1CydX3zrvJWKb4m7wANxHmwau8A=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (267, 1, '01', 'F001', 00000004, '2022-04-13', '2022-04-13', NULL, '1', 0, 'PEN', 0.00, 70.00, 0.00, 0.00, 70.00, '20600680570', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'LvcrldjqD54Wv0ICWY936EZ6dsg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (269, 1, '01', 'F001', 00000005, '2022-04-16', '2022-04-16', NULL, '1', 0, 'PEN', 0.00, 136.00, 0.00, 0.00, 136.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'XB1QZFlwTU7KwDjDaB+Xl7kFRp4=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (270, 1, '01', 'F001', 00000006, '2022-04-16', '2022-04-16', NULL, '1', 0, 'PEN', 0.00, 118.00, 0.00, 0.00, 118.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'H8WI5Ki57mh86X15JZMQtMKCSvw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (271, 1, '01', 'F001', 00000007, '2022-04-18', '2022-04-18', NULL, '1', 0, 'PEN', 0.00, 82.00, 0.00, 0.00, 82.00, '20607393711', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'fwoLP+OBvwpG2lT+AXXJa/6Jytw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (272, 1, '07', 'FC01', 00000002, '2022-04-18', '2022-04-18', NULL, '1', 0, 'PEN', 0.00, 136.00, 0.00, 0.00, 136.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '455Ou2N8chazS4DVSNmTKgXnunU=', '01', 'F001', 00000005, '01', 'ANULACION DE LA OPERACION', '1', NULL);
INSERT INTO `tbl_venta_cab` VALUES (273, 1, '01', 'F001', 00000008, '2022-04-19', '2022-04-19', NULL, '1', 0, 'PEN', 0.00, 60.90, 0.00, 0.00, 60.90, '10008415981', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'rho6Ok++s4IY/URitizTuGh+OcM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (274, 1, '01', 'F001', 00000009, '2022-04-21', '2022-04-21', NULL, '1', 0, 'PEN', 0.00, 36.00, 0.00, 0.00, 36.00, '20606500662', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '4nrKWI0EVDoe+FTuElZfHF3XcSM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (275, 1, '01', 'F001', 00000010, '2022-04-21', '2022-04-21', NULL, '1', 0, 'PEN', 0.00, 57.96, 0.00, 0.00, 57.96, '20450409414', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'WyNcinCn1UVew2O/KtWUFzvNQHc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (276, 1, '01', 'F001', 00000011, '2022-04-22', '2022-04-22', NULL, '1', 0, 'PEN', 0.00, 68.58, 0.00, 0.00, 68.58, '10404317780', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '5QlKNJQPcNZ9OxBsDhieTamJcd0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (277, 1, '01', 'F001', 00000012, '2022-04-25', '2022-04-25', NULL, '1', 0, 'PEN', 0.00, 88.05, 0.00, 0.00, 88.05, '20608860909', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'JzHaozMILEpoEpA1prDxbDBoi34=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (284, 1, '07', 'FC01', 00000003, '2022-04-26', '2022-04-26', NULL, '1', 0, 'PEN', 0.00, 88.05, 0.00, 0.00, 88.05, '20608860909', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ncXHgRZouzag7pRTXoCXkG4NIVA=', '01', 'F001', 00000012, '01', 'ANULACION DE LA OPERACION', '1', NULL);
INSERT INTO `tbl_venta_cab` VALUES (285, 1, '01', 'F001', 00000013, '2022-04-26', '2022-04-26', NULL, '1', 0, 'PEN', 0.00, 88.00, 0.00, 0.00, 88.00, '20608860909', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'JZK8W6g3khm/fLts/G3Z547WOog=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (286, 1, '01', 'F001', 00000014, '2022-04-29', '2022-04-29', NULL, '1', 0, 'PEN', 0.00, 93.00, 0.00, 0.00, 93.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'oqn7b/K95wQadI26TfalZzn4TBA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (287, 1, '01', 'F001', 00000015, '2022-04-29', '2022-04-29', NULL, '1', 0, 'PEN', 0.00, 377.25, 0.00, 0.00, 377.25, '20450105113', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'If01lcIAMpMFyKGJS0ynFRCOmEE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (288, 1, '01', 'F001', 00000016, '2022-05-06', '2022-05-06', NULL, '1', 0, 'PEN', 0.00, 1091.75, 0.00, 0.00, 1091.75, '20600258991', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'YcMoOaTsVsa0B5CEjTCmNSydzOE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (289, 1, '01', 'F001', 00000017, '2022-05-06', '2022-05-06', NULL, '1', 0, 'PEN', 0.00, 38.50, 0.00, 0.00, 38.50, '10094505017', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'HR+An5MEHJOgoz178EPG9pnX7sU=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (290, 1, '01', 'F001', 00000018, '2022-05-10', '2022-05-10', NULL, '1', 0, 'PEN', 0.00, 123.00, 0.00, 0.00, 123.00, '10010780956', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'lNc0B7A3AOjQDqCFWTjFNnDf9bM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (291, 1, '01', 'F001', 00000019, '2022-05-12', '2022-05-12', NULL, '1', 0, 'PEN', 0.00, 47.00, 0.00, 0.00, 47.00, '20600680570', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'f9vqyYIY93MuTKJUUA2+y72TwnQ=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (292, 1, '01', 'F001', 00000020, '2022-05-12', '2022-05-12', NULL, '1', 0, 'PEN', 0.00, 76.00, 0.00, 0.00, 76.00, '20600528263', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '3k+qn/nr91Z4AVFsi+ZiMjzyxFI=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (293, 1, '01', 'F001', 00000021, '2022-05-20', '2022-05-20', NULL, '1', 0, 'PEN', 0.00, 136.00, 0.00, 0.00, 136.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'FBkDP2PUB4K8Vswqb4SnURdzlFs=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (294, 1, '01', 'F001', 00000022, '2022-05-26', '2022-05-26', NULL, '1', 0, 'PEN', 0.00, 75.97, 0.00, 0.00, 75.97, '20450435920', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'fSmNpX1QNygUOiaBv3Yf70xhaC0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (295, 1, '01', 'F001', 00000023, '2022-05-28', '2022-05-28', NULL, '1', 0, 'PEN', 0.00, 58.00, 0.00, 0.00, 58.00, '10010780956', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'u6wuC7AJu6yCrBkxu7pAbguT1xQ=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (298, 1, '99', 'NV02', 00000001, '2022-06-01', '2022-06-01', NULL, '1', 0, 'PEN', 0.00, 15.00, 0.00, 0.00, 15.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (299, 1, '99', 'NV02', 00000002, '2022-06-01', '2022-06-01', NULL, '1', 0, 'PEN', 0.00, 39.00, 0.00, 0.00, 39.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (300, 1, '03', 'B001', 00000001, '2022-06-02', '2022-06-02', NULL, '1', 0, 'PEN', 0.00, 14.00, 0.00, 0.00, 14.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'NUyFpmxw5HNtP1aQqacXr+D8uCw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (301, 1, '03', 'B001', 00000002, '2022-06-02', '2022-06-02', NULL, '1', 0, 'PEN', 0.00, 15.50, 0.00, 0.00, 15.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'LCcvHHql2MvBO6A5UI8+A9NpgZc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (302, 1, '03', 'B002', 00000001, '2022-06-02', '2022-06-02', NULL, '1', 0, 'PEN', 0.00, 54.00, 0.00, 0.00, 54.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'YjF+yzgnHdSQjGEhav64WAslvW0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (303, 1, '99', 'NV02', 00000003, '2022-06-02', '2022-06-02', NULL, '1', 0, 'PEN', 0.00, 41.00, 0.00, 0.00, 41.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (304, 1, '99', 'NV02', 00000004, '2022-06-02', '2022-06-02', NULL, '1', 0, 'PEN', 0.00, 31.30, 0.00, 0.00, 31.30, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (305, 1, '01', 'F001', 00000024, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 4.50, 0.00, 0.00, 4.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'wcXyMtsastvaOqiPc5GnOyyA/yY=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (306, 1, '03', 'B001', 00000003, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 16.00, 0.00, 0.00, 16.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ZNEoGox6AOs6DwPAa4gGPip5FTk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (307, 1, '03', 'B001', 00000004, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 237.00, 0.00, 0.00, 237.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '/A4cGkNX9z5vus0pczVJFsIKBSc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (308, 1, '07', 'FC01', 00000004, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 4.50, 0.00, 0.00, 4.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '7x3PymyV1XpAsGe7TUZVJmkW4Qk=', '01', 'F001', 00000024, '01', 'ANULACION DE LA OPERACION', '1', NULL);
INSERT INTO `tbl_venta_cab` VALUES (309, 1, '01', 'F001', 00000025, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 77.00, 0.00, 0.00, 77.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'V8i530u+q+H8iXA6bAHMypgadSo=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (310, 1, '03', 'B001', 00000005, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 178.00, 0.00, 0.00, 178.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '5gS784PHhdVUcQoK/iqm5vC+qpE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (311, 1, '03', 'B001', 00000006, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 68.30, 0.00, 0.00, 68.30, '99999999', 2, '0109', 'El sistema no puede responder su solicitud. (El servicio de autenticación no está disponible) - Detalle: ', NULL, NULL, NULL, 'fVQrCsOIElUv00RoThbheqsp0gw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (312, 1, '99', 'NV02', 00000005, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 21.00, 0.00, 0.00, 21.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (313, 1, '99', 'NV02', 00000006, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 26.30, 0.00, 0.00, 26.30, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (314, 1, '99', 'NV02', 00000007, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 76.00, 0.00, 0.00, 76.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (315, 1, '03', 'B002', 00000002, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 13.00, 0.00, 0.00, 13.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (317, 1, '99', 'NV02', 00000008, '2022-06-03', '2022-06-03', NULL, '1', 0, 'PEN', 0.00, 51.54, 0.00, 0.00, 51.54, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (318, 1, '03', 'B001', 00000007, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 3.20, 0.00, 0.00, 3.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'V06d8Mmz1saLGAN3bP9lzUe/Cbw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (319, 1, '03', 'B001', 00000008, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 4.00, 0.00, 0.00, 4.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'pFlNsts109CmlzAaCZQZ891l+9s=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (320, 1, '01', 'F001', 00000026, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 24.00, 0.00, 0.00, 24.00, '10010780956', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'bqeVmWFuBfBOFM9Sfp3tsehUXtg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (321, 1, '03', 'B001', 00000009, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 8.80, 0.00, 0.00, 8.80, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'aVjwiBOxklv3oOqcvHz+DtBpMNg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (322, 1, '03', 'B001', 00000010, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 31.00, 0.00, 0.00, 31.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'laCyHfm/TYKNeDBmR0QbDoy4QFk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (323, 1, '01', 'F001', 00000027, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 141.59, 0.00, 0.00, 141.59, '20600108892', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'E7D4sZlCJqSOEpNNsWSmOr3c2H0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (324, 1, '03', 'B001', 00000011, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 37.00, 0.00, 0.00, 37.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'xNyscHsx0UyOtxNiy1JHwDMVsn8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (325, 1, '03', 'B001', 00000012, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 5.00, 0.00, 0.00, 5.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'lMX0kIHNOlL7pWQ8pSDQtV/UxMo=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (326, 1, '03', 'B001', 00000013, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 2.70, 0.00, 0.00, 2.70, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'xUAxFiJrUq7UxhNUaVjg46u48Nc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (327, 1, '03', 'B001', 00000014, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 30.98, 0.00, 0.00, 30.98, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '/Xj1Fa+A2x0HFIOzSMXsTzn6N7g=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (328, 1, '03', 'B001', 00000015, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 6.00, 0.00, 0.00, 6.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'D3SPxqLD9Yu65y1/vxYEDfCmvdk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (329, 1, '03', 'B001', 00000016, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 4.00, 0.00, 0.00, 4.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'XDjeXYo/saIW23h4P6vrHSklFWw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (330, 1, '03', 'B001', 00000017, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 2.80, 0.00, 0.00, 2.80, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'soydKqSGKAkeTOjPfuYddTVAoW4=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (331, 1, '03', 'B001', 00000018, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 76.00, 0.00, 0.00, 76.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'rtwnnzZIZDK73Cfjbs2p6niNv1E=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (332, 1, '03', 'B001', 00000019, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 248.51, 0.00, 0.00, 248.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'LRqr+Bd/Nmu0xWyi3hXQ8QDWQKs=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (333, 1, '99', 'NV02', 00000009, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 63.44, 0.00, 0.00, 63.44, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (334, 1, '99', 'NV02', 00000010, '2022-06-04', '2022-06-04', NULL, '1', 0, 'PEN', 0.00, 57.80, 0.00, 0.00, 57.80, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (335, 1, '03', 'B001', 00000020, '2022-06-06', '2022-06-06', NULL, '1', 0, 'PEN', 0.00, 95.00, 0.00, 0.00, 95.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'RBWodk1qdHEiauaa3nR7MwYrKL0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (336, 1, '03', 'B001', 00000021, '2022-06-06', '2022-06-06', NULL, '1', 0, 'PEN', 0.00, 15.00, 0.00, 0.00, 15.00, '99999999', 3, '', '', NULL, NULL, NULL, 'Pe3ATo1xV1pGOZfwDqpFSaD3tSQ=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (337, 1, '03', 'B001', 00000022, '2022-06-06', '2022-06-06', NULL, '1', 0, 'PEN', 0.00, 15.52, 0.00, 0.00, 15.52, '99999999', 2, '0109', 'El sistema no puede responder su solicitud. (El servicio de autenticación no está disponible) - Detalle: ', NULL, NULL, NULL, 'n9k8R3tPvCZCx8f/+YWAWH9j4qk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (338, 1, '03', 'B002', 00000002, '2022-06-06', '2022-06-06', NULL, '1', 0, 'PEN', 0.00, 49.00, 0.00, 0.00, 49.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'd1mmmzoJHwphEaJudG7JGs/wVio=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (339, 1, '03', 'B002', 00000003, '2022-06-06', '2022-06-06', NULL, '1', 0, 'PEN', 0.00, 54.50, 0.00, 0.00, 54.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '/FkEoq30SMR5Ts0ZQxDcnBX1DOI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (340, 1, '03', 'B002', 00000004, '2022-06-06', '2022-06-06', NULL, '1', 0, 'PEN', 0.00, 32.00, 0.00, 0.00, 32.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'TeYO4jy2gydxO5IE8vebCodeyN4=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (341, 1, '03', 'B002', 00000005, '2022-06-06', '2022-06-06', NULL, '1', 0, 'PEN', 0.00, 53.28, 0.00, 0.00, 53.28, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'JQiDITFGRJk+s5dJlD+pBq2k7VA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (342, 1, '03', 'B001', 00000023, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 24.30, 0.00, 0.00, 24.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Knnmwg7VsgcDeBaK7AJ3ZewFGok=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (343, 1, '03', 'B001', 00000024, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 152.50, 0.00, 0.00, 152.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'o7gVfrFsfO9Ab8BgyEjQaVwSZV8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (344, 1, '03', 'B001', 00000025, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 10.95, 0.00, 0.00, 10.95, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'CLkuo15LTvd2jqvJQMqwbEA9OjI=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (345, 1, '03', 'B001', 00000026, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 32.50, 0.00, 0.00, 32.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'WoET2IBI1Q6+hFPiCKL6kz2Os6M=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (346, 1, '03', 'B001', 00000027, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 41.19, 0.00, 0.00, 41.19, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'OmgfJl0qdT/6Ab7bF6rfyp/ilOw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (347, 1, '01', 'F001', 00000028, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 29.00, 0.00, 0.00, 29.00, '20600108892', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'xg1lC5SoIKlml5apMqZbLBga55M=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (348, 1, '03', 'B002', 00000006, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 32.00, 0.00, 0.00, 32.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'oCWzC+gWY5fyiYodgkOIq86pIfY=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (349, 1, '03', 'B002', 00000007, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 211.00, 0.00, 0.00, 211.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '0PekBZmBxAviNBPqE1Ri5Q/mXVs=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (350, 1, '03', 'B002', 00000008, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 362.54, 0.00, 0.00, 362.54, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'c7O4xJ2LenP6I4BvbsjH4Nc+9vI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (351, 1, '03', 'B002', 00000009, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 345.00, 0.00, 0.00, 345.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'suGOS9tW1HG9GphdqObGTHtEk0g=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (352, 1, '03', 'B002', 00000010, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'CEAzSr/V+0YjkbzlXg7K3Zk2gmQ=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (353, 1, '03', 'B002', 00000011, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 77.10, 0.00, 0.00, 77.10, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '/lTHHp3v8PDjDXX0ha8hvZZ5r3A=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (354, 1, '03', 'B002', 00000012, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 31.00, 0.00, 0.00, 31.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '9S7ofIGLT2iUi9Q8tKeCRdDMeMA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (355, 1, '03', 'B002', 00000013, '2022-06-07', '2022-06-07', NULL, '1', 0, 'PEN', 0.00, 6.40, 0.00, 0.00, 6.40, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'v2SkQpgR2avd1ZJBsW177D3XQRM=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (356, 1, '03', 'B001', 00000028, '2022-06-08', '2022-06-08', NULL, '1', 0, 'PEN', 0.00, 85.50, 0.00, 0.00, 85.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'zMuOw0zAOjOU4g+ZXw+g3Eo2aS0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (357, 1, '01', 'F001', 00000029, '2022-06-08', '2022-06-08', NULL, '1', 0, 'PEN', 0.00, 85.00, 0.00, 0.00, 85.00, '20493190611', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'xOnR8beCDsNDVDWYFzzaLYm8Mvc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (358, 1, '03', 'B001', 00000029, '2022-06-08', '2022-06-08', NULL, '1', 0, 'PEN', 0.00, 35.00, 0.00, 0.00, 35.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'oGI+25DzbRCasQFf+z+hKVVceAQ=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (359, 1, '03', 'B001', 00000030, '2022-06-08', '2022-06-08', NULL, '1', 0, 'PEN', 0.00, 12.00, 0.00, 0.00, 12.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '4zIXkd3zeWNi1n66WxCZ58cdRac=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (360, 1, '03', 'B001', 00000031, '2022-06-08', '2022-06-08', NULL, '1', 0, 'PEN', 0.00, 40.50, 0.00, 0.00, 40.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '0WW+uV/kWTW6ZjQkYWV8+byrOaM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (361, 1, '03', 'B002', 00000014, '2022-06-08', '2022-06-08', NULL, '1', 0, 'PEN', 0.00, 180.45, 0.00, 0.00, 180.45, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ngqtJKlkWUCh38wOr61KKe7w3JM=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (362, 1, '03', 'B002', 00000015, '2022-06-08', '2022-06-08', NULL, '1', 0, 'PEN', 0.00, 73.97, 0.00, 0.00, 73.97, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'OgWZliidvqrgo1JwwA+BRnkjo8w=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (363, 1, '03', 'B002', 00000016, '2022-06-09', '2022-06-09', NULL, '1', 0, 'PEN', 0.00, 24.30, 0.00, 0.00, 24.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'occ9UbfyJxTfxAHTB6Q8Z/4RsRw=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (364, 1, '03', 'B002', 00000017, '2022-06-09', '2022-06-09', NULL, '1', 0, 'PEN', 0.00, 27.50, 0.00, 0.00, 27.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'HmQcWZnG0/59iVOMmBniMvfdAk8=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (365, 1, '03', 'B002', 00000018, '2022-06-09', '2022-06-09', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'LcZZsdyWPybzx9UHX41Lecjz+V0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (366, 1, '03', 'B002', 00000019, '2022-06-09', '2022-06-09', NULL, '1', 0, 'PEN', 0.00, 17.50, 0.00, 0.00, 17.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'wo2uoFgMNc2Nb01al5kRb+kJMVg=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (367, 1, '99', 'NV02', 00000011, '2022-06-09', '2022-06-09', NULL, '1', 0, 'PEN', 0.00, 35.45, 0.00, 0.00, 35.45, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (368, 1, '03', 'B001', 00000032, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 246.62, 0.00, 0.00, 246.62, '01117739', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'f2+0EU9SWfTbFqwOFcdT2RqygTo=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (369, 1, '01', 'F001', 00000030, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 61.00, 0.00, 0.00, 61.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '3pQoai2p17jVumIGHtUiCAfrHvY=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (370, 1, '01', 'F001', 00000031, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 26.00, 0.00, 0.00, 26.00, '20600680570', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '1ZznClePprsn/rJyMVkykFNPwEk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (371, 1, '03', 'B002', 00000020, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 13.00, 0.00, 0.00, 13.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'AkhGLxB3KzvBzs07xeHUO2s2puY=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (372, 1, '03', 'B002', 00000021, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 36.90, 0.00, 0.00, 36.90, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'd/zDG8mqCFy/zQP4H7pgltYuPLY=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (373, 1, '03', 'B002', 00000022, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 39.20, 0.00, 0.00, 39.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'j+scIcw6trsoQUE54LGBZEU7Kms=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (374, 1, '03', 'B002', 00000023, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 77.50, 0.00, 0.00, 77.50, '01117210', 2, '0109', 'El sistema no puede responder su solicitud. (El servicio de autenticación no está disponible) - Detalle: ', NULL, NULL, NULL, '9mQjVKW+G/v9MXjnHZYvVdX9TnA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (375, 1, '03', 'B002', 00000024, '2022-06-10', '2022-06-10', NULL, '1', 0, 'PEN', 0.00, 127.90, 0.00, 0.00, 127.90, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'RiHPn081sf+3VUJfXgcycpyj/LE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (376, 1, '03', 'B001', 00000033, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 31.00, 0.00, 0.00, 31.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'g3EGscWVMWGMrp2PE36nZoCCdzc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (377, 1, '03', 'B001', 00000034, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 16.50, 0.00, 0.00, 16.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '+xnPAwb2+87T6sSdg+xE3hexv0w=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (378, 1, '03', 'B001', 00000035, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 43.50, 0.00, 0.00, 43.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'FnjoSPcsPz0iktWce08iTzbTXaw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (379, 1, '03', 'B001', 00000036, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 10.00, 0.00, 0.00, 10.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'qlDvv9+5QgQwhRD8IpMKTT/fB3k=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (380, 1, '03', 'B001', 00000037, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 31.50, 0.00, 0.00, 31.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'jw8fqWP/shDFwrvHSWDcxzl7dag=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (381, 1, '03', 'B002', 00000025, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 31.00, 0.00, 0.00, 31.00, '99999999', 3, '', '', NULL, NULL, NULL, 'EE78+r593yyWZemvydcEB+HfgWA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (382, 1, '03', 'B002', 00000025, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 31.00, 0.00, 0.00, 31.00, '99999999', 3, '', '', NULL, NULL, NULL, 'EE78+r593yyWZemvydcEB+HfgWA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (383, 1, '03', 'B002', 00000025, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 31.00, 0.00, 0.00, 31.00, '99999999', 2, '0200', 'No se pudo procesar su solicitud. (Ocurrio un error en el batch) - Detalle: xxx.xxx.xxx value=\'ticket: 202209371128742 error: Se ha producido un error inesperado.\'', NULL, NULL, NULL, 'EE78+r593yyWZemvydcEB+HfgWA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (384, 1, '03', 'B002', 00000026, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 172.00, 0.00, 0.00, 172.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '9b4QEGL5SrV/jA75NEMhrCDl4gc=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (385, 1, '03', 'B002', 00000027, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 47.00, 0.00, 0.00, 47.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'RuS0smCSC9otkudf14dIgs/5h3Q=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (386, 1, '03', 'B002', 00000028, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 32.50, 0.00, 0.00, 32.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '4MSY3bQKPLPlCo52jyuwGx9tjAI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (387, 1, '03', 'B002', 00000029, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 21.75, 0.00, 0.00, 21.75, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '4KECwr2DA6LjxecHyLsp8PGM07s=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (388, 1, '03', 'B002', 00000030, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 49.00, 0.00, 0.00, 49.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'yljFsvMD4jEXGIMHigyK0M7qH0U=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (389, 1, '03', 'B002', 00000031, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 210.77, 0.00, 0.00, 210.77, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '7/42RX9OdvP4k/F4txCdcItOx30=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (390, 1, '99', 'NV02', 00000012, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 32.00, 0.00, 0.00, 32.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (391, 1, '99', 'NV02', 00000013, '2022-06-11', '2022-06-11', NULL, '1', 0, 'PEN', 0.00, 68.50, 0.00, 0.00, 68.50, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (392, 1, '01', 'F001', 00000032, '2022-06-12', '2022-06-12', NULL, '1', 0, 'PEN', 0.00, 100.00, 0.00, 0.00, 100.00, '20102361939', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '+XEC+akGFP9gCXNekX6taDxxIQM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (393, 1, '01', 'F001', 00000033, '2022-06-12', '2022-06-12', NULL, '1', 0, 'PEN', 0.00, 44.00, 0.00, 0.00, 44.00, '10010780956', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'JFqYIWyajJlN15mmvuJkWijoID4=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (394, 1, '03', 'B001', 00000038, '2022-06-12', '2022-06-12', NULL, '1', 0, 'PEN', 0.00, 25.50, 0.00, 0.00, 25.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '29YPn1l4tHZxqZkCXAAJQcg04uo=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (395, 1, '03', 'B001', 00000039, '2022-06-12', '2022-06-12', NULL, '1', 0, 'PEN', 0.00, 31.50, 0.00, 0.00, 31.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'xXsw9ZDYFObvbjaRJ3eHWePYWh0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (396, 1, '01', 'F001', 00000034, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 92.99, 0.00, 0.00, 92.99, '20602902821', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'uwPxo/gzKJV4ZL2g6vw5Dvf2gsc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (397, 1, '01', 'F001', 00000035, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 9.50, 0.00, 0.00, 9.50, '20602902821', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'mO8A8bj4SohvoNa2cGG0Tz8Zumc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (398, 1, '03', 'B001', 00000040, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 50.00, 0.00, 0.00, 50.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '9a9blEeDaxv7tTBbKfTmsjsoF2A=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (399, 1, '01', 'F001', 00000036, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 76.00, 0.00, 0.00, 76.00, '20600528263', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'JypsyZqY2ZfQK/Xc7EHAFqDCALc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (400, 1, '03', 'B002', 00000032, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 51.50, 0.00, 0.00, 51.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Er6Ikt/dDKA8BiZtPE1+oc0ydFo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (401, 1, '03', 'B002', 00000033, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 83.04, 0.00, 0.00, 83.04, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'FjjhRTFIirtEWkjKSNHfknn4heI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (402, 1, '03', 'B002', 00000034, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 571.90, 0.00, 0.00, 571.90, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'IljXFsCLumipL47fWRFcbd8+SbA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (403, 1, '03', 'B002', 00000035, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 109.50, 0.00, 0.00, 109.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'DmBqXYZzqc6po8mLXl0YmAhengI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (404, 1, '99', 'NV02', 00000014, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 9.00, 0.00, 0.00, 9.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (405, 1, '99', 'NV02', 00000015, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 33.80, 0.00, 0.00, 33.80, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (406, 1, '99', 'NV02', 00000016, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (407, 1, '99', 'NV02', 00000017, '2022-06-13', '2022-06-13', NULL, '1', 0, 'PEN', 0.00, 11.80, 0.00, 0.00, 11.80, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (408, 1, '03', 'B001', 00000041, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 5.63, 0.00, 0.00, 5.63, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'TVn2TFmbXd0GqWa6asHIx6TdeCY=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (409, 1, '03', 'B001', 00000042, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 21.00, 0.00, 0.00, 21.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'rFA+QlojnBIH1AifBFSsqTfbmNE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (410, 1, '03', 'B001', 00000043, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 7.00, 0.00, 0.00, 7.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'SfFejQH2neQ2fmXHm3UKE7s3++I=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (411, 1, '03', 'B001', 00000044, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 33.05, 0.00, 0.00, 33.05, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '/04nVgbYd06GyvYptrWJ/bMeMOM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (412, 1, '03', 'B001', 00000045, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 45.00, 0.00, 0.00, 45.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'RgtdvmIgbP5cVFMdhj3TKL1aDuc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (413, 1, '03', 'B001', 00000046, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 29.00, 0.00, 0.00, 29.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'a4riC8ha9OsuowG3ux3hZJmTyv8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (414, 1, '99', 'NV02', 00000018, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 53.50, 0.00, 0.00, 53.50, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (415, 1, '03', 'B002', 00000036, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 41.00, 0.00, 0.00, 41.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'fLQv54Ls/uE3/M1WhhwJrvXNsWw=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (416, 1, '99', 'NV02', 00000019, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 5.00, 0.00, 0.00, 5.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (417, 1, '99', 'NV02', 00000020, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 33.10, 0.00, 0.00, 33.10, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (418, 1, '03', 'B002', 00000037, '2022-06-14', '2022-06-14', NULL, '1', 0, 'PEN', 0.00, 81.03, 0.00, 0.00, 81.03, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'xvWFn2r9W573ogyN5BHIq7AsLuk=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (419, 1, '03', 'B001', 00000047, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 12.00, 0.00, 0.00, 12.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'iDqVEqxvOUUVq6krCN16dyoCcLA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (420, 1, '03', 'B001', 00000048, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 49.20, 0.00, 0.00, 49.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '8z535k2sbEvcmiUSd4RTNxZkeNk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (421, 1, '03', 'B001', 00000049, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 42.00, 0.00, 0.00, 42.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'b3XeQudxyoTeeg9sBUb8GZHYwx0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (422, 1, '03', 'B001', 00000050, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 135.75, 0.00, 0.00, 135.75, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'hu8/1Xm1YawOtqe5nrejFS+mQnE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (423, 1, '03', 'B001', 00000051, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 14.90, 0.00, 0.00, 14.90, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'wQdBoMYGs/sCVeQKXo2xW0cRXG8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (424, 1, '03', 'B001', 00000052, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 78.00, 0.00, 0.00, 78.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'P/nu9OtuoTkhr5BDprHTeiaV/4I=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (425, 1, '03', 'B001', 00000053, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 28.00, 0.00, 0.00, 28.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'yYEm+LyqcZDa6fDTGL9MvrqOir8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (426, 1, '03', 'B001', 00000054, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 5.50, 0.00, 0.00, 5.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'jyYp7kvyIIh5RAcb58L4YGJntJc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (427, 1, '03', 'B001', 00000055, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 3.50, 0.00, 0.00, 3.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'W2hjekeva2/xXRryXmMHiXAnORw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (428, 1, '03', 'B001', 00000056, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 383.47, 0.00, 0.00, 383.47, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'QN5/L0ZaoaY3736DPbpyUiy/SBs=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (429, 1, '03', 'B001', 00000057, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 51.00, 0.00, 0.00, 51.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'EeVxTCqC4lkhgmdK33NZ5zPH+fg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (430, 1, '03', 'B001', 00000058, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 54.00, 0.00, 0.00, 54.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'bJPdWKPeLoxNw7mHRhI89zS33bc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (431, 1, '03', 'B002', 00000038, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 53.00, 0.00, 0.00, 53.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Cwr0alerQxq8PDP+OEJpA+ps8Po=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (432, 1, '99', 'NV02', 00000021, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 13.75, 0.00, 0.00, 13.75, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (433, 1, '03', 'B002', 00000039, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 31.50, 0.00, 0.00, 31.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'hwKxPCZUDetqV2Tbug0GXGcs0Ok=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (434, 1, '03', 'B002', 00000040, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 28.20, 0.00, 0.00, 28.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'naKfEioubl1yqOp2k8vRRJaA+kQ=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (435, 1, '03', 'B002', 00000041, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 60.18, 0.00, 0.00, 60.17, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'LgDb0G0TkbONXiqR1quDxLpfoao=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (436, 1, '99', 'NV02', 00000022, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 8.00, 0.00, 0.00, 8.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (437, 1, '99', 'NV02', 00000023, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 44.00, 0.00, 0.00, 44.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (438, 1, '99', 'NV02', 00000024, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 19.00, 0.00, 0.00, 19.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (439, 1, '99', 'NV02', 00000025, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 11.25, 0.00, 0.00, 11.25, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (440, 1, '03', 'B002', 00000042, '2022-06-15', '2022-06-15', NULL, '1', 0, 'PEN', 0.00, 21.50, 0.00, 0.00, 21.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'AWSZixvhTtYgPFkYS5L4CaTs1cM=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (441, 1, '03', 'B001', 00000059, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 17.00, 0.00, 0.00, 17.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Did3Ln4YsF9P0ELJcLWUsDok6pw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (442, 1, '03', 'B001', 00000060, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 41.00, 0.00, 0.00, 41.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '6b5EBs3ToUz9Sy7h+NwMFT4DWbw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (443, 1, '03', 'B001', 00000061, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 28.50, 0.00, 0.00, 28.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '5RxK5YHyuKlmGXJGdbDOS+UktwY=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (444, 1, '03', 'B001', 00000062, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 48.20, 0.00, 0.00, 48.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Dwur8AUvUKQNBGq6SBZX6e9+caw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (445, 1, '03', 'B001', 00000063, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 33.00, 0.00, 0.00, 33.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'KgRcmm4BmSEshaGdGkqES2SQ8OA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (446, 1, '03', 'B001', 00000064, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 15.50, 0.00, 0.00, 15.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'oBxEr5uK4h6KrjAW4vPNmOUrS/s=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (447, 1, '03', 'B001', 00000065, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 28.50, 0.00, 0.00, 28.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'aGIrbNLyPem0JxOMyPXOq8G0dJg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (448, 1, '03', 'B001', 00000066, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '9RgKBsSRpoac/mSajNUYYhF9mlA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (449, 1, '03', 'B002', 00000043, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 22.30, 0.00, 0.00, 22.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '3rDezFfI7yKdoapdDD46kGk+Cqo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (450, 1, '03', 'B002', 00000044, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 29.45, 0.00, 0.00, 29.45, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'CeLsB3WJaDnOId9WeJhS82LBtKs=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (451, 1, '03', 'B002', 00000045, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 84.50, 0.00, 0.00, 84.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '+lUXlOqhPMVzeNSO/EMsPdHTaFE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (452, 1, '03', 'B002', 00000046, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 75.12, 0.00, 0.00, 75.12, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Drm//oiZYHBmulLFXW+qBDf4qVg=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (453, 1, '03', 'B002', 00000047, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 31.00, 0.00, 0.00, 31.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Xrvf+w95La7mRzgN5VrOJt7qeVc=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (454, 1, '99', 'NV02', 00000026, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 15.00, 0.00, 0.00, 15.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (455, 1, '99', 'NV02', 00000027, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 25.30, 0.00, 0.00, 25.30, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (456, 1, '03', 'B002', 00000048, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 112.00, 0.00, 0.00, 112.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'W4YCfanr6wnHNhSR9ooqo36PVmo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (457, 1, '03', 'B002', 00000049, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 20.00, 0.00, 0.00, 20.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'TfI6RdOga116JhIoK1jzVO8LJLk=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (458, 1, '03', 'B002', 00000050, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 13.63, 0.00, 0.00, 13.63, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'zo1cxN0ZgZDVrNwlEqwleZBEZ1E=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (459, 1, '03', 'B001', 00000067, '2022-06-16', '2022-06-16', NULL, '1', 0, 'PEN', 0.00, 58.50, 0.00, 0.00, 58.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'MurCG/8r2PdrkAu1+Mo99z6X3ok=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (460, 1, '03', 'B001', 00000068, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 20.50, 0.00, 0.00, 20.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'QiKjhG8YVWT5IBbvmZl61XK1fCE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (461, 1, '03', 'B001', 00000069, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 28.60, 0.00, 0.00, 28.60, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '8FzRG0kewV2nzpLRL9OSr+j1M0s=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (462, 1, '03', 'B001', 00000070, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 20.00, 0.00, 0.00, 20.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '+8qUcYBcsRh6wCGZK2kiycp5658=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (463, 1, '01', 'F001', 00000037, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 79.00, 0.00, 0.00, 79.00, '20531420285', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'kkWG0SmwCnhWJG5DcvBzdF4yMog=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (464, 1, '03', 'B001', 00000071, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 72.50, 0.00, 0.00, 72.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'X5NeRdUgC5moBtVFS6pL6sMQOEk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (465, 1, '03', 'B001', 00000072, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 50.30, 0.00, 0.00, 50.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '8gmBNkZBEaNhtOkJzwF84rzeqK8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (466, 1, '03', 'B001', 00000073, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 9.00, 0.00, 0.00, 9.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'uNO8K6I6R5/HuZfyJnsR0NnF6jc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (467, 1, '03', 'B001', 00000074, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 8.60, 0.00, 0.00, 8.60, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'nHCyvJ4ktf0JykHyqzi2KNIOpzk=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (468, 1, '99', 'NV02', 00000028, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 38.75, 0.00, 0.00, 38.75, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (469, 1, '03', 'B002', 00000051, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 11.73, 0.00, 0.00, 11.72, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'gxOy1i6ZOLRYpEhYE1XSOcECEZo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (470, 1, '03', 'B002', 00000052, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 6.50, 0.00, 0.00, 6.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'JbVfHsWcC8L/KpqzfmRlnwTBdUk=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (471, 1, '03', 'B002', 00000053, '2022-06-17', '2022-06-17', NULL, '1', 0, 'PEN', 0.00, 25.30, 0.00, 0.00, 25.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'H/hqqXJt6ZWVe/2op1nYjwXWi9A=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (472, 1, '03', 'B001', 00000075, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 62.00, 0.00, 0.00, 62.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'stTn3jOfotP1ffnFu79WCoDuJZA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (473, 1, '03', 'B001', 00000076, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'OzeB05W0j8UO638tVixOafM+ne8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (474, 1, '03', 'B002', 00000054, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 30.00, 0.00, 0.00, 30.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '0UsD3F4uYeEJ7XVvkPnDmZe3y7Q=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (475, 1, '03', 'B002', 00000055, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 23.00, 0.00, 0.00, 23.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ipSUXyTbvPenGpclElzR030kas4=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (476, 1, '99', 'NV02', 00000029, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 19.87, 0.00, 0.00, 19.87, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (477, 1, '01', 'F002', 00000001, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 85.00, 0.00, 0.00, 85.00, '20404344707', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'weGvWPOTLFDqf+S7qWSljJwMNeI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (478, 1, '99', 'NV02', 00000030, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 7.50, 0.00, 0.00, 7.50, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (479, 1, '03', 'B002', 00000056, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 28.00, 0.00, 0.00, 28.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'l9OxnsIhHcdR1nCk56Z22t8L5vA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (480, 1, '03', 'B002', 00000057, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 145.00, 0.00, 0.00, 145.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '9k/IHpQzBq9MRg2fuplVg5Ub7RA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (481, 1, '99', 'NV02', 00000031, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 18.30, 0.00, 0.00, 18.30, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (482, 1, '03', 'B002', 00000058, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 150.25, 0.00, 0.00, 150.25, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'IpWdCu9XmohXVTEzACIxUYssIrw=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (483, 1, '99', 'NV02', 00000032, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 38.20, 0.00, 0.00, 38.20, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (484, 1, '03', 'B002', 00000059, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 55.64, 0.00, 0.00, 55.64, '99999999', 3, '', '', NULL, NULL, NULL, 'BVrtu3MI6ndS9qP6G/aQFSvr97Y=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (486, 1, '03', 'B002', 00000060, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 9.20, 0.00, 0.00, 9.20, '99999999', 3, '', '', NULL, NULL, NULL, 'R3cquObgN8dq7sgbwrExuKb/exI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (487, 1, '99', 'NV02', 00000033, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 19.50, 0.00, 0.00, 19.50, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (488, 1, '03', 'B002', 00000061, '2022-06-18', '2022-06-18', NULL, '1', 0, 'PEN', 0.00, 88.00, 0.00, 0.00, 88.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'FvsOt9ea6G8iT4pYCd2KfhspUOM=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (489, 1, '03', 'B001', 00000077, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 20.00, 0.00, 0.00, 20.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'BcRTYMTzabpUGUNxR6u1JwCiA0I=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (490, 1, '01', 'F001', 00000038, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 34.00, 0.00, 0.00, 34.00, '10010780956', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '2xLUS89r4sG5zn4CLCW3WISPdyg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (491, 1, '03', 'B001', 00000078, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 4.30, 0.00, 0.00, 4.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'qFQrTGyUxFc8qmTRUkVjTcYn7nE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (492, 1, '03', 'B001', 00000079, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 308.98, 0.00, 0.00, 308.98, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'QZkcWabLlFza5FwCgRhhZufnbhM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (493, 1, '03', 'B001', 00000080, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 46.85, 0.00, 0.00, 46.85, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'kn6guBBlx8eh2QBVWw6uUgUouYw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (494, 1, '03', 'B002', 00000062, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 29.00, 0.00, 0.00, 29.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'E98ZONYR6Gt+oU2ha34LDbcbn3Q=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (495, 1, '03', 'B002', 00000063, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 41.75, 0.00, 0.00, 41.75, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'KJptlMt89o1rMBAWf1JTIW6Oa8I=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (496, 1, '03', 'B002', 00000064, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 21.25, 0.00, 0.00, 21.25, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'nQd8jFYNV2BCoeB2GpP1Z6nROBM=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (497, 1, '03', 'B002', 00000065, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 30.70, 0.00, 0.00, 30.70, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'mThphrDgQ3to53oocloAjD41OE0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (498, 1, '03', 'B002', 00000066, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 24.00, 0.00, 0.00, 24.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'XSOlkYR5jLQ+VfwnUwBeLvsD9RM=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (499, 1, '03', 'B002', 00000067, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 36.75, 0.00, 0.00, 36.75, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'vw976CCw3zktBC1/WrFkMZJE2n4=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (500, 1, '03', 'B002', 00000068, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 30.50, 0.00, 0.00, 30.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'PNdt7yxig7oUD7nl7rTxvXo/nvY=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (501, 1, '03', 'B002', 00000069, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 18.41, 0.00, 0.00, 18.41, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'qArkwg4VCg1U1CJqoFDS5QXXjtk=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (502, 1, '99', 'NV02', 00000034, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 20.74, 0.00, 0.00, 20.74, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (503, 1, '99', 'NV02', 00000035, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 21.00, 0.00, 0.00, 21.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (504, 1, '01', 'F002', 00000002, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 21.50, 0.00, 0.00, 21.50, '20606084456', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'hepA48AfIJDC7uKJ0GsvKruycEE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (505, 1, '99', 'NV02', 00000036, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 14.00, 0.00, 0.00, 14.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (506, 1, '03', 'B002', 00000070, '2022-06-20', '2022-06-20', NULL, '1', 0, 'PEN', 0.00, 28.50, 0.00, 0.00, 28.50, '99999999', 2, '0109', 'El sistema no puede responder su solicitud. (El servicio de autenticación no está disponible) - Detalle: ', NULL, NULL, NULL, 'E4R6Ze8JxeEwCcHcaqhagSDZXuU=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (507, 1, '03', 'B001', 00000081, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 25.50, 0.00, 0.00, 25.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'jwQ4xb/U9Pu8KaNSFwI6lrbQRRg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (508, 1, '03', 'B002', 00000071, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 31.65, 0.00, 0.00, 31.65, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'OP3wxOYEcUsYzYt/nUKeVAzjHgg=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (509, 1, '03', 'B002', 00000072, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 15.50, 0.00, 0.00, 15.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'FqtNIA8vC+WHjVdYOlAtVUSCoiQ=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (510, 1, '03', 'B002', 00000073, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 45.55, 0.00, 0.00, 45.55, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ZgYZz7xsnjUnOpH69O6qOX6yIz0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (511, 1, '03', 'B002', 00000074, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 30.41, 0.00, 0.00, 30.41, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ir81PbE/5JjrgrDM5pWwz7uRTJ8=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (512, 1, '03', 'B002', 00000075, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 28.00, 0.00, 0.00, 28.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ptPnDZedYhAgcy+ralsbamaUvGo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (513, 1, '03', 'B002', 00000076, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 82.50, 0.00, 0.00, 82.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'E67IcM2MeyoDbI2/24saXwpNQOo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (514, 1, '99', 'NV02', 00000037, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 18.00, 0.00, 0.00, 18.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (515, 1, '99', 'NV02', 00000038, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (516, 1, '03', 'B002', 00000077, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 34.00, 0.00, 0.00, 34.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '7QtPdZlcHlM+ZNvG7LNJWzwjUsE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (517, 1, '03', 'B002', 00000078, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 23.80, 0.00, 0.00, 23.80, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'TVsOKIjH4KA6iNNkPxj/G/V1P1s=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (518, 1, '03', 'B002', 00000079, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 83.00, 0.00, 0.00, 83.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'UYJiRy8LgCudhg4YmWAHgsQibc0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (519, 1, '99', 'NV02', 00000039, '2022-06-21', '2022-06-21', NULL, '1', 0, 'PEN', 0.00, 7.88, 0.00, 0.00, 7.88, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (520, 1, '03', 'B001', 00000082, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 20.00, 0.00, 0.00, 20.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'HU1XhjIJrgxMJUhxVmGpb5UrU+s=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (521, 1, '03', 'B001', 00000083, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 26.50, 0.00, 0.00, 26.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '91lirLoI5yC2MrP5/PNRIvODHKY=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (522, 1, '03', 'B001', 00000084, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 41.50, 0.00, 0.00, 41.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'qvWg0F7gS2p66XF3Hpy7BsSWZ3o=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (523, 1, '03', 'B001', 00000085, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 20.80, 0.00, 0.00, 20.80, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Mw6bs1VOt/dGN8f4YOTDegkIOXU=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (524, 1, '03', 'B001', 00000086, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 20.00, 0.00, 0.00, 20.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'tFuSJmeqZnO27MFAeDo5wcUCdCc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (525, 1, '01', 'F001', 00000039, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 41.50, 0.00, 0.00, 41.50, '20600680570', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'JibMmCdQgH++wTXBPNrJMr+z8Sg=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (526, 1, '03', 'B001', 00000087, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 150.00, 0.00, 0.00, 150.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'bAw9p4yZDu9ah21YfGf38rANReM=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (527, 1, '03', 'B001', 00000088, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 148.20, 0.00, 0.00, 148.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'fuBv6eY26b1492NXdGRujhBBWxA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (528, 1, '03', 'B002', 00000080, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 75.00, 0.00, 0.00, 75.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'hegzxOEzqx2Fct8ryqPUUNatleI=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (529, 1, '03', 'B002', 00000081, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 7.50, 0.00, 0.00, 7.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '0Khn6Z5TRtfmvFI5+eEm48D24mo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (530, 1, '03', 'B002', 00000082, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 82.13, 0.00, 0.00, 82.13, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ZZxi6/ifkm+bju+zk+U12miO/aA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (531, 1, '03', 'B002', 00000083, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 29.30, 0.00, 0.00, 29.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'VHfV7y+AmdW8myfSBRmwrrYOwHE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (532, 1, '99', 'NV02', 00000040, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 29.25, 0.00, 0.00, 29.25, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (533, 1, '03', 'B002', 00000084, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 23.80, 0.00, 0.00, 23.80, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'x/FfXAlpNEsj+mYBFMgHxQv3hB0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (534, 1, '03', 'B002', 00000085, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 42.00, 0.00, 0.00, 42.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'HaT3K/oG3AOJS3lxaWHbyX/r4KY=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (535, 1, '03', 'B002', 00000086, '2022-06-22', '2022-06-22', NULL, '1', 0, 'PEN', 0.00, 23.51, 0.00, 0.00, 23.51, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '4iTnKdFGpFXyCfsEnz366Zj8Ji4=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (536, 1, '99', 'NV02', 00000041, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 7.00, 0.00, 0.00, 7.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (537, 1, '03', 'B002', 00000087, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '89G5ZlSn6661v2+6w2cbWHeLhU4=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (538, 1, '03', 'B002', 00000088, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 18.60, 0.00, 0.00, 18.60, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'mA7Ne3pCki/61UUWoHNlJBlF2BQ=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (539, 1, '03', 'B002', 00000089, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 22.20, 0.00, 0.00, 22.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '3dd+Xjwn3HMX32thLbnRDBCy6OE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (540, 1, '03', 'B002', 00000090, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 18.50, 0.00, 0.00, 18.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'E4DcW7RMS9NmEumQdzrH1G+BYOw=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (541, 1, '03', 'B002', 00000091, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 21.80, 0.00, 0.00, 21.80, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'HHMj+mhtrtouKyYYVZQIylJ5Z6A=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (542, 1, '03', 'B002', 00000092, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 10.50, 0.00, 0.00, 10.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'M/fny77fmz9PKY8Op/af7wQJEJw=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (543, 1, '03', 'B002', 00000093, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 74.63, 0.00, 0.00, 74.63, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'rkt0xUX4b5sJw4b9dkHcmzHPkE0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (544, 1, '03', 'B002', 00000094, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 15.50, 0.00, 0.00, 15.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'TEFoKVQhbMyLO/0Ubz+BZG71tv4=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (545, 1, '03', 'B002', 00000095, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '868ZG1RYmZH5lcxEsa5ztDAHq0U=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (546, 1, '99', 'NV02', 00000042, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 28.13, 0.00, 0.00, 28.13, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (547, 1, '99', 'NV02', 00000043, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 42.00, 0.00, 0.00, 42.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (548, 1, '99', 'NV02', 00000044, '2022-06-23', '2022-06-23', NULL, '1', 0, 'PEN', 0.00, 14.20, 0.00, 0.00, 14.20, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (549, 1, '01', 'F001', 00000040, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 18.00, 0.00, 0.00, 18.00, '20531420285', 3, '', '', NULL, NULL, NULL, 'J9OvvPimN5suzj7uiZb1L3cO1k4=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (550, 1, '01', 'F001', 00000041, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 36.00, 0.00, 0.00, 36.00, '10010780956', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ceR4Go1ZEslYuACwLhyKKIBCc+s=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (551, 1, '03', 'B001', 00000089, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 48.25, 0.00, 0.00, 48.25, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'iTWXNRnZhuTXhz1r0fjqhbWkP+c=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (552, 1, '03', 'B001', 00000090, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 108.01, 0.00, 0.00, 108.01, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'jImAKUus2SgW28C1HD+l+PKBIE4=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (553, 1, '03', 'B001', 00000091, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 268.47, 0.00, 0.00, 268.47, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'cmPDCpvWOSSbu6xTEzzv5bl19Vo=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (554, 1, '03', 'B001', 00000092, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 39.00, 0.00, 0.00, 39.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'FwrxV2hGYXukwhSxdilQPJesJCA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (555, 1, '03', 'B002', 00000096, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 44.00, 0.00, 0.00, 44.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '5rpfNowR1/cXrGXB5Ik3X1r0Vys=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (556, 1, '03', 'B002', 00000097, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 85.40, 0.00, 0.00, 85.40, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'yRgztlEhIzNp2I2sbckGafYZ2FE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (557, 1, '03', 'B002', 00000098, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 27.90, 0.00, 0.00, 27.90, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '10SqdXVuxEOsNORTSmi6XwhIeFw=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (558, 1, '03', 'B002', 00000099, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 20.60, 0.00, 0.00, 20.60, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'h0RuMLwwEBUcnzSue3DL8FeXvYo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (559, 1, '03', 'B002', 00000100, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 76.00, 0.00, 0.00, 76.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'QnpGY+Us99eKGtUlDrROhJ80+Lo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (560, 1, '03', 'B002', 00000101, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 14.50, 0.00, 0.00, 14.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'WdUnO+8Y/2RJcpfC1SSgS1gHjt0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (561, 1, '99', 'NV02', 00000045, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 24.54, 0.00, 0.00, 24.54, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (562, 1, '99', 'NV02', 00000046, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 29.50, 0.00, 0.00, 29.50, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (563, 1, '99', 'NV02', 00000047, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 12.00, 0.00, 0.00, 12.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (564, 1, '03', 'B002', 00000102, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 60.50, 0.00, 0.00, 60.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'dhclvKQSl2r3IP3M4OWQhUB1Zec=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (565, 1, '01', 'F002', 00000003, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 26.00, 0.00, 0.00, 26.00, '10762972218', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Bn+hEKC0ZgOBjcfmdy7k2ANnp0E=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (566, 1, '03', 'B002', 00000103, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 19.00, 0.00, 0.00, 19.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '0tf5zGejOxZUXSaMLQMu2usaAI0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (567, 1, '03', 'B002', 00000104, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 69.90, 0.00, 0.00, 69.90, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'aLNSZcq0551aQTpecWhRdQ6mISk=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (568, 1, '03', 'B002', 00000105, '2022-06-25', '2022-06-25', NULL, '1', 0, 'PEN', 0.00, 18.00, 0.00, 0.00, 18.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'zkr/Y1Oc9648M3BtdUHQ8ta3k+I=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (569, 1, '03', 'B001', 00000093, '2022-06-26', '2022-06-26', NULL, '1', 0, 'PEN', 0.00, 46.00, 0.00, 0.00, 46.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'GDRIfHhKJPcjJiJ0LMVZqq42K/4=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (570, 1, '03', 'B001', 00000094, '2022-06-26', '2022-06-26', NULL, '1', 0, 'PEN', 0.00, 15.20, 0.00, 0.00, 15.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '9ASNQwqabI9PvhH8eJg8qI6acFA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (571, 1, '03', 'B001', 00000095, '2022-06-26', '2022-06-26', NULL, '1', 0, 'PEN', 0.00, 132.75, 0.00, 0.00, 132.75, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '8mUGgpeoYIKNe04ATu9spxqnCyY=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (572, 1, '03', 'B001', 00000096, '2022-06-26', '2022-06-26', NULL, '1', 0, 'PEN', 0.00, 30.00, 0.00, 0.00, 30.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'RCxFHiBcG954BcBIWz/KwcuJfno=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (573, 1, '03', 'B001', 00000097, '2022-06-26', '2022-06-26', NULL, '1', 0, 'PEN', 0.00, 93.40, 0.00, 0.00, 93.40, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Mr3/cTaJnn2pb/sVN4FznYZszHA=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (574, 1, '03', 'B001', 00000098, '2022-06-26', '2022-06-26', NULL, '1', 0, 'PEN', 0.00, 178.00, 0.00, 0.00, 178.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'el7oU9FMcRpZnxJQafPwpx3vzoQ=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (575, 1, '03', 'B001', 00000099, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 20.00, 0.00, 0.00, 20.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'mkyTQhbyWhLzfSbDyYqQGqDBmis=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (576, 1, '03', 'B001', 00000100, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 144.50, 0.00, 0.00, 144.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'W+VkDIh2SgVpx+d84/cFqhFyd7I=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (577, 1, '01', 'F001', 00000042, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 80.00, 0.00, 0.00, 80.00, '20600716167', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '2JTQfn2BmR/nHNQ/g6FIhSzqpFQ=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (578, 1, '03', 'B001', 00000101, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 76.00, 0.00, 0.00, 76.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '9giDWvV51BfmLvyyRVuL6dSnn5E=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (579, 1, '03', 'B001', 00000102, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 145.00, 0.00, 0.00, 145.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '5CyuvS1FuBtv/aPlEDwkw1r5kvE=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (580, 1, '03', 'B001', 00000103, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 75.30, 0.00, 0.00, 75.30, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Evn6j2wXwm9X99R3ClfKofaVlS8=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (581, 1, '03', 'B001', 00000104, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 521.95, 0.00, 0.00, 521.95, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'WbDmejlgTsw6IVbuzDYi1JgZqAw=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (582, 1, '03', 'B001', 00000105, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 23.42, 0.00, 0.00, 23.42, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'b0N5Fyaerbj6jXPLAwqetWaCs9c=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (583, 1, '03', 'B002', 00000106, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 20.50, 0.00, 0.00, 20.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '6nqidc4Y9syQQi+nAUAIw6EFJW0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (584, 1, '03', 'B002', 00000107, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 85.00, 0.00, 0.00, 85.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'SHngvJDDdxukZVRBaaHHU8Atu04=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (585, 1, '03', 'B002', 00000108, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 39.50, 0.00, 0.00, 39.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Hah/eG3X83oZce+4ATpzLbx9vbM=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (586, 1, '01', 'F002', 00000004, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 46.00, 0.00, 0.00, 46.00, '20404344707', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '14C6FTtlqHW7Td8ho8/76Xq4ES8=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (587, 1, '03', 'B002', 00000109, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 32.01, 0.00, 0.00, 32.01, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ox39JjEF1eM5QAFCrGevDRAnr2k=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (588, 1, '03', 'B002', 00000110, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 34.20, 0.00, 0.00, 34.20, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '+szrGfuuVhKLL3QAUhXKIHG2iRg=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (589, 1, '99', 'NV02', 00000048, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 12.50, 0.00, 0.00, 12.50, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (590, 1, '03', 'B002', 00000111, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 53.00, 0.00, 0.00, 53.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'fBv1hSNRt6VPs4RyNxeg1yGn9/I=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (591, 1, '03', 'B002', 00000112, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 34.50, 0.00, 0.00, 34.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '37EkXGHOYJ6Ei+b22KzA8at8wTQ=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (592, 1, '03', 'B002', 00000113, '2022-06-27', '2022-06-27', NULL, '1', 0, 'PEN', 0.00, 27.00, 0.00, 0.00, 27.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'I49cRy8Cami3+mv5bQTlW5sGwvY=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (593, 1, '03', 'B001', 00000106, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 56.60, 0.00, 0.00, 56.60, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '3SOXmRI3ssgmR7fsvqIPsfDGyts=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (594, 1, '03', 'B001', 00000107, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 28.00, 0.00, 0.00, 28.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ue/lYrgYGaz36NjPzi9g3wdmQyc=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (595, 1, '03', 'B001', 00000108, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 21.50, 0.00, 0.00, 21.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Mloj1HBwtlKGqWzLdSO+lKtgCp0=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (596, 1, '03', 'B002', 00000114, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 26.45, 0.00, 0.00, 26.45, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'eWLE/poypRs18dL11j/bU1cJij0=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (597, 1, '03', 'B002', 00000115, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 17.01, 0.00, 0.00, 17.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '65sa1aIH2pRXkCHq5qnS4PThGmE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (598, 1, '03', 'B002', 00000116, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 10.00, 0.00, 0.00, 10.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'LwrjgjZwJcPyC5CIwfDW5yb5GTU=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (599, 1, '03', 'B002', 00000117, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 38.50, 0.00, 0.00, 38.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'D9hdNkzRQZqHMsou/DXQcEWoaeE=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (600, 1, '03', 'B002', 00000118, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 72.00, 0.00, 0.00, 72.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'xPhDzn4IvlqbbkdGba+On7wvolQ=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (601, 1, '03', 'B002', 00000119, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 145.00, 0.00, 0.00, 145.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'wIXGHIppiDXUoerh2aNLVJpRHW8=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (602, 1, '03', 'B002', 00000120, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 79.53, 0.00, 0.00, 79.53, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 's4hoyPsO4SlG12BGJVv2PBVwOHo=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (603, 1, '03', 'B002', 00000121, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 104.50, 0.00, 0.00, 104.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'FRrE7sIq9/3p9Ii3I6mdmwu6Sec=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (604, 1, '03', 'B002', 00000122, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 211.50, 0.00, 0.00, 211.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'dLNO7Afe+oafe7aT/simmJpi/Do=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (605, 1, '03', 'B002', 00000123, '2022-06-28', '2022-06-28', NULL, '1', 0, 'PEN', 0.00, 9.75, 0.00, 0.00, 9.75, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'acj0eoDy3bBarQNXqCNL4CvfJIs=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (606, 1, '03', 'B001', 00000109, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 34.50, 0.00, 0.00, 34.50, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'WxYQYJEXq6ZbDCpIlx9MSNWb+tU=', NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_venta_cab` VALUES (607, 1, '03', 'B002', 00000124, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 15.00, 0.00, 0.00, 15.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'PjsjN7uyiaic9nPbeDvoM9Sq4Ho=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (608, 1, '03', 'B002', 00000125, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 94.90, 0.00, 0.00, 94.90, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'qT8hN/ZV0TJVKmc+KN/4o0ZT0Oc=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (609, 1, '03', 'B002', 00000126, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 27.00, 0.00, 0.00, 27.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, '0vCfNVfP7BUbV9DPyMeGV0GEMKQ=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (610, 1, '03', 'B002', 00000127, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 75.00, 0.00, 0.00, 75.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'm/XvDi2IeTkB2noU7EBeVj+QMhA=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (611, 1, '03', 'B002', 00000128, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 43.00, 0.00, 0.00, 43.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'bsiCovglYU6+J1JEummB2GIV2xk=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (612, 1, '99', 'NV02', 00000049, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 0.00, 0.00, 0.00, 0.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 5);
INSERT INTO `tbl_venta_cab` VALUES (613, 1, '03', 'B002', 00000129, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 21.00, 0.00, 0.00, 21.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'zzt4w/wNqbiElitWxwVxlLhKr9E=', NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (614, 1, '99', 'NV02', 00000050, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 8.00, 0.00, 0.00, 8.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (615, 1, '99', 'NV02', 00000051, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 22.00, 0.00, 0.00, 22.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `tbl_venta_cab` VALUES (616, 1, '99', 'NV02', 00000052, '2022-06-29', '2022-06-29', NULL, '1', 0, 'PEN', 0.00, 34.95, 0.00, 0.00, 34.95, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 5);

-- ----------------------------
-- Table structure for tbl_venta_det
-- ----------------------------
DROP TABLE IF EXISTS `tbl_venta_det`;
CREATE TABLE `tbl_venta_det`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idventa` int(11) NULL DEFAULT NULL,
  `item` int(11) NULL DEFAULT NULL,
  `idproducto` int(11) NULL DEFAULT NULL,
  `cantidad_factor` decimal(11, 2) NULL DEFAULT NULL,
  `factor` int(11) NULL DEFAULT NULL,
  `cantidad_unitario` decimal(11, 2) NULL DEFAULT NULL,
  `cantidad` decimal(11, 2) NULL DEFAULT NULL,
  `valor_unitario` decimal(11, 2) NULL DEFAULT NULL,
  `precio_unitario` decimal(11, 2) NULL DEFAULT NULL,
  `igv` decimal(11, 2) NULL DEFAULT NULL,
  `porcentaje_igv` decimal(11, 2) NULL DEFAULT NULL,
  `valor_total` decimal(11, 2) NULL DEFAULT NULL,
  `importe_total` decimal(11, 2) NULL DEFAULT NULL,
  `costo` decimal(11, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_venta`(`idventa`) USING BTREE,
  INDEX `fk_producto`(`idproducto`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1607 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_venta_det
-- ----------------------------
INSERT INTO `tbl_venta_det` VALUES (365, 256, 1, 179, 0.00, 0, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.67);
INSERT INTO `tbl_venta_det` VALUES (366, 257, 1, 179, 0.00, 0, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (367, 258, 1, 176, 0.00, 0, 0.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (368, 259, 1, 176, 0.00, 0, 0.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (369, 260, 1, 178, 0.00, 0, 0.00, 3.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (370, 261, 1, 178, 0.00, 0, 0.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (371, 262, 1, 179, 0.00, 0, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (372, 263, 1, 176, 0.00, 0, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (373, 264, 1, 200, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 45.60);
INSERT INTO `tbl_venta_det` VALUES (374, 264, 2, 199, 0.00, 1, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (375, 264, 3, 203, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 21.00);
INSERT INTO `tbl_venta_det` VALUES (376, 265, 1, 204, 0.00, 1, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 10.00);
INSERT INTO `tbl_venta_det` VALUES (378, 267, 1, 207, 1.00, 12, 0.00, 12.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (379, 267, 2, 206, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 17.71);
INSERT INTO `tbl_venta_det` VALUES (380, 267, 3, 208, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 10.00);
INSERT INTO `tbl_venta_det` VALUES (381, 267, 4, 205, 0.00, 15, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (385, 269, 1, 200, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 45.60);
INSERT INTO `tbl_venta_det` VALUES (386, 269, 2, 203, 2.00, 24, 0.00, 48.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (387, 269, 3, 199, 1.00, 1, 1.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (388, 270, 1, 203, 2.00, 24, 0.00, 48.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (389, 270, 2, 200, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 45.60);
INSERT INTO `tbl_venta_det` VALUES (390, 270, 3, 199, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (391, 271, 1, 223, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 75.00);
INSERT INTO `tbl_venta_det` VALUES (392, 272, 1, 200, NULL, NULL, NULL, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (393, 272, 1, 203, NULL, NULL, NULL, 48.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (394, 272, 1, 199, NULL, NULL, NULL, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (395, 273, 1, 226, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 16.50);
INSERT INTO `tbl_venta_det` VALUES (396, 273, 2, 224, 0.00, 1, 3.00, 3.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (397, 273, 3, 225, 0.00, 1, 6.00, 6.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 2.50);
INSERT INTO `tbl_venta_det` VALUES (398, 274, 1, 227, 2.00, 1, 0.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 15.50);
INSERT INTO `tbl_venta_det` VALUES (399, 275, 1, 227, 2.00, 1, 0.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 15.50);
INSERT INTO `tbl_venta_det` VALUES (400, 275, 2, 233, 0.00, 1, 6.00, 6.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 3.20);
INSERT INTO `tbl_venta_det` VALUES (401, 276, 1, 228, 0.00, 24, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 2.50);
INSERT INTO `tbl_venta_det` VALUES (402, 276, 2, 229, 0.00, 36, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 2.39);
INSERT INTO `tbl_venta_det` VALUES (403, 276, 3, 231, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 11.00);
INSERT INTO `tbl_venta_det` VALUES (404, 276, 4, 218, 0.00, 40, 3.00, 3.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 1.35);
INSERT INTO `tbl_venta_det` VALUES (405, 276, 5, 234, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 5.30);
INSERT INTO `tbl_venta_det` VALUES (406, 276, 6, 236, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 13.50);
INSERT INTO `tbl_venta_det` VALUES (407, 276, 7, 237, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 2.50);
INSERT INTO `tbl_venta_det` VALUES (408, 276, 8, 230, 0.00, 1, 6.00, 6.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 1.74);
INSERT INTO `tbl_venta_det` VALUES (409, 276, 9, 235, 0.00, 1, 8.00, 8.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (410, 277, 2, 208, 0.00, 4, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 10.00);
INSERT INTO `tbl_venta_det` VALUES (411, 277, 3, 238, 15.00, 15, 0.00, 225.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (419, 284, 1, 208, NULL, NULL, NULL, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (420, 284, 1, 238, NULL, NULL, NULL, 225.00, 6.00, 6.00, 0.00, 18.00, 1350.00, 1350.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (421, 285, 1, 208, 1.00, 1, 0.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.00);
INSERT INTO `tbl_venta_det` VALUES (422, 285, 2, 238, 1.00, 1, 0.00, 1.00, 76.00, 76.00, 0.00, 18.00, 76.00, 76.00, 71.00);
INSERT INTO `tbl_venta_det` VALUES (423, 286, 1, 200, 1.00, 1, 0.00, 1.00, 50.00, 50.00, 0.00, 18.00, 50.00, 50.00, 45.60);
INSERT INTO `tbl_venta_det` VALUES (424, 286, 2, 203, 1.00, 24, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (425, 286, 3, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (426, 287, 1, 239, 0.00, 50, 25.00, 25.00, 2.80, 2.80, 0.00, 18.00, 70.00, 70.00, 2.60);
INSERT INTO `tbl_venta_det` VALUES (427, 287, 2, 240, 2.00, 12, 0.00, 24.00, 1.50, 1.50, 0.00, 18.00, 36.00, 36.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (428, 287, 3, 241, 1.00, 24, 0.00, 24.00, 0.92, 0.92, 0.00, 18.00, 22.00, 22.00, 0.81);
INSERT INTO `tbl_venta_det` VALUES (429, 287, 4, 242, 2.00, 10, 5.00, 25.00, 1.85, 1.85, 0.00, 18.00, 46.25, 46.25, 1.75);
INSERT INTO `tbl_venta_det` VALUES (430, 287, 5, 243, 1.00, 1, 0.00, 1.00, 6.50, 6.50, 0.00, 18.00, 6.50, 6.50, 5.50);
INSERT INTO `tbl_venta_det` VALUES (431, 287, 6, 244, 1.00, 1, 0.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (432, 287, 7, 245, 2.00, 12, 0.00, 24.00, 1.42, 1.42, 0.00, 18.00, 34.00, 34.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (433, 287, 8, 246, 1.00, 24, 0.00, 24.00, 1.25, 1.25, 0.00, 18.00, 30.00, 30.00, 1.19);
INSERT INTO `tbl_venta_det` VALUES (434, 287, 9, 247, 0.00, 48, 24.00, 24.00, 5.33, 5.33, 0.00, 18.00, 128.00, 128.00, 4.80);
INSERT INTO `tbl_venta_det` VALUES (435, 288, 3, 239, 0.00, 50, 25.00, 25.00, 3.00, 3.00, 0.00, 18.00, 75.01, 75.01, 2.60);
INSERT INTO `tbl_venta_det` VALUES (436, 288, 4, 248, 0.00, 50, 25.00, 25.00, 4.20, 4.20, 0.00, 18.00, 105.00, 105.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (437, 288, 5, 249, 0.00, 20, 13.00, 13.00, 9.00, 9.00, 0.00, 18.00, 117.00, 117.00, 8.50);
INSERT INTO `tbl_venta_det` VALUES (438, 288, 6, 250, 1.00, 20, 6.00, 26.00, 2.60, 2.60, 0.00, 18.00, 67.60, 67.60, 2.43);
INSERT INTO `tbl_venta_det` VALUES (439, 288, 7, 251, 1.00, 24, 2.00, 26.00, 3.33, 3.33, 0.00, 18.00, 86.67, 86.67, 3.00);
INSERT INTO `tbl_venta_det` VALUES (440, 288, 8, 252, 0.00, 48, 26.00, 26.00, 5.67, 5.67, 0.00, 18.00, 147.34, 147.34, 5.00);
INSERT INTO `tbl_venta_det` VALUES (441, 288, 10, 253, 2.00, 12, 2.00, 26.00, 2.17, 2.17, 0.00, 18.00, 56.33, 56.33, 1.80);
INSERT INTO `tbl_venta_det` VALUES (442, 288, 11, 242, 1.00, 10, 3.00, 13.00, 2.00, 2.00, 0.00, 18.00, 26.00, 26.00, 1.75);
INSERT INTO `tbl_venta_det` VALUES (443, 288, 12, 176, 0.00, 25, 13.00, 13.00, 1.50, 1.50, 0.00, 18.00, 19.50, 19.50, 1.07);
INSERT INTO `tbl_venta_det` VALUES (444, 288, 13, 254, 0.00, 1, 13.00, 13.00, 5.00, 5.00, 0.00, 18.00, 65.00, 65.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (445, 288, 14, 207, 1.00, 12, 1.00, 13.00, 2.50, 2.50, 0.00, 18.00, 32.50, 32.50, 1.95);
INSERT INTO `tbl_venta_det` VALUES (446, 288, 15, 255, 1.00, 20, 6.00, 26.00, 1.05, 1.05, 0.00, 18.00, 27.30, 27.30, 0.93);
INSERT INTO `tbl_venta_det` VALUES (447, 288, 16, 229, 0.00, 36, 13.00, 13.00, 3.00, 3.00, 0.00, 18.00, 39.00, 39.00, 2.39);
INSERT INTO `tbl_venta_det` VALUES (448, 288, 17, 216, 0.00, 24, 13.00, 13.00, 1.50, 1.50, 0.00, 18.00, 19.50, 19.50, 1.14);
INSERT INTO `tbl_venta_det` VALUES (449, 288, 18, 234, 0.00, 1, 13.00, 13.00, 6.00, 6.00, 0.00, 18.00, 78.00, 78.00, 5.30);
INSERT INTO `tbl_venta_det` VALUES (450, 288, 19, 256, 0.00, 1, 13.00, 13.00, 2.50, 2.50, 0.00, 18.00, 32.50, 32.50, 2.00);
INSERT INTO `tbl_venta_det` VALUES (451, 288, 20, 257, 0.00, 1, 13.00, 13.00, 3.00, 3.00, 0.00, 18.00, 39.00, 39.00, 2.50);
INSERT INTO `tbl_venta_det` VALUES (452, 288, 22, 258, 0.00, 1, 13.00, 13.00, 4.50, 4.50, 0.00, 18.00, 58.50, 58.50, 4.25);
INSERT INTO `tbl_venta_det` VALUES (453, 289, 1, 215, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.03);
INSERT INTO `tbl_venta_det` VALUES (454, 289, 2, 227, 2.00, 1, 0.00, 2.00, 18.00, 18.00, 0.00, 18.00, 36.00, 36.00, 15.50);
INSERT INTO `tbl_venta_det` VALUES (455, 290, 1, 259, 1.00, 1, 0.00, 1.00, 105.00, 105.00, 0.00, 18.00, 105.00, 105.00, 100.00);
INSERT INTO `tbl_venta_det` VALUES (456, 290, 2, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (457, 291, 1, 261, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (458, 291, 2, 215, 1.00, 12, 0.00, 12.00, 2.13, 2.13, 0.00, 18.00, 25.50, 25.50, 2.03);
INSERT INTO `tbl_venta_det` VALUES (459, 291, 3, 260, 1.00, 1, 0.00, 1.00, 15.50, 15.50, 0.00, 18.00, 15.50, 15.50, 13.60);
INSERT INTO `tbl_venta_det` VALUES (460, 292, 1, 238, 1.00, 1, 0.00, 1.00, 76.00, 76.00, 0.00, 18.00, 76.00, 76.00, 71.00);
INSERT INTO `tbl_venta_det` VALUES (461, 293, 1, 203, 2.00, 24, 0.00, 48.00, 1.04, 1.04, 0.00, 18.00, 50.00, 50.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (462, 293, 2, 200, 1.00, 1, 0.00, 1.00, 50.00, 50.00, 0.00, 18.00, 50.00, 50.00, 45.60);
INSERT INTO `tbl_venta_det` VALUES (463, 293, 3, 199, 2.00, 1, 0.00, 2.00, 18.00, 18.00, 0.00, 18.00, 36.00, 36.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (464, 294, 1, 238, 1.00, 1, 0.00, 1.00, 75.97, 75.97, 0.00, 18.00, 75.97, 75.97, 71.00);
INSERT INTO `tbl_venta_det` VALUES (465, 295, 1, 199, 2.00, 1, 0.00, 2.00, 18.00, 18.00, 0.00, 18.00, 36.00, 36.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (466, 295, 2, 340, 1.00, 1, 0.00, 1.00, 22.00, 22.00, 0.00, 18.00, 22.00, 22.00, 18.80);
INSERT INTO `tbl_venta_det` VALUES (471, 298, 1, 224, 0.00, 1, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (472, 298, 2, 325, 0.00, 4, 2.00, 2.00, 3.00, 3.00, 0.00, 18.00, 24.00, 6.00, 2.38);
INSERT INTO `tbl_venta_det` VALUES (473, 299, 1, 229, 0.00, 36, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 108.00, 3.00, 2.39);
INSERT INTO `tbl_venta_det` VALUES (474, 299, 2, 268, 0.00, 55, 4.00, 4.00, 0.50, 0.50, 0.00, 18.00, 110.00, 2.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (475, 299, 5, 241, 0.00, 24, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 24.00, 1.00, 0.81);
INSERT INTO `tbl_venta_det` VALUES (476, 299, 6, 245, 0.00, 12, 1.00, 1.00, 1.50, 1.50, 0.00, 18.00, 18.00, 1.50, 1.29);
INSERT INTO `tbl_venta_det` VALUES (477, 299, 7, 299, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.38);
INSERT INTO `tbl_venta_det` VALUES (478, 299, 8, 261, 0.00, 1, 4.00, 4.00, 6.00, 6.00, 0.00, 18.00, 24.00, 24.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (479, 299, 9, 289, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 12.00, 1.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (480, 299, 10, 303, 0.00, 1, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 1.95);
INSERT INTO `tbl_venta_det` VALUES (481, 300, 1, 273, 0.00, 15, 3.00, 3.00, 2.00, 2.00, 0.00, 18.00, 6.00, 6.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (482, 300, 2, 280, 0.00, 30, 2.00, 2.00, 4.00, 4.00, 0.00, 18.00, 8.00, 8.00, 3.34);
INSERT INTO `tbl_venta_det` VALUES (483, 301, 2, 316, 1.00, 1, 0.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.31);
INSERT INTO `tbl_venta_det` VALUES (484, 301, 3, 318, 1.00, 1, 0.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.81);
INSERT INTO `tbl_venta_det` VALUES (486, 302, 1, 239, 0.00, 50, 5.00, 5.00, 3.20, 3.20, 0.00, 18.00, 16.00, 16.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (487, 302, 2, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (488, 302, 3, 348, 0.00, 1, 1.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.47);
INSERT INTO `tbl_venta_det` VALUES (489, 303, 1, 260, 2.00, 10, 0.00, 20.00, 1.55, 1.55, 0.00, 18.00, 310.00, 31.00, 1.44);
INSERT INTO `tbl_venta_det` VALUES (490, 303, 2, 209, 0.00, 24, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 240.00, 10.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (491, 304, 1, 192, 0.00, 48, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 480.03, 10.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (492, 304, 3, 306, 0.00, 10, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 35.00, 3.50, 2.70);
INSERT INTO `tbl_venta_det` VALUES (493, 304, 4, 273, 0.00, 15, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 30.00, 2.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (494, 304, 5, 278, 0.00, 24, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 67.20, 2.80, 2.50);
INSERT INTO `tbl_venta_det` VALUES (495, 304, 6, 307, 0.00, 1, 1.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.00);
INSERT INTO `tbl_venta_det` VALUES (496, 305, 1, 201, 0.00, 12, 3.00, 3.00, 1.50, 1.50, 0.00, 18.00, 4.50, 4.50, 1.29);
INSERT INTO `tbl_venta_det` VALUES (497, 306, 1, 266, 0.00, 12, 2.00, 2.00, 8.00, 8.00, 0.00, 18.00, 16.00, 16.00, 7.54);
INSERT INTO `tbl_venta_det` VALUES (498, 307, 1, 242, 1.00, 10, 0.00, 10.00, 1.85, 1.85, 0.00, 18.00, 18.50, 18.50, 1.70);
INSERT INTO `tbl_venta_det` VALUES (499, 307, 2, 286, 4.00, 40, 0.00, 160.00, 0.24, 0.24, 0.00, 18.00, 38.00, 38.00, 0.21);
INSERT INTO `tbl_venta_det` VALUES (500, 307, 3, 285, 3.00, 40, 0.00, 120.00, 0.24, 0.24, 0.00, 18.00, 28.50, 28.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (501, 307, 4, 332, 2.00, 12, 0.00, 24.00, 0.83, 0.83, 0.00, 18.00, 20.00, 20.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (502, 307, 5, 267, 1.00, 20, 0.00, 20.00, 1.03, 1.03, 0.00, 18.00, 20.50, 20.50, 0.93);
INSERT INTO `tbl_venta_det` VALUES (503, 307, 6, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (504, 307, 7, 203, 1.00, 24, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (505, 307, 8, 350, 2.00, 20, 0.00, 40.00, 1.05, 1.05, 0.00, 18.00, 42.00, 42.00, 0.96);
INSERT INTO `tbl_venta_det` VALUES (506, 307, 10, 352, 1.00, 1, 0.00, 1.00, 26.50, 26.50, 0.00, 18.00, 26.50, 26.50, 24.01);
INSERT INTO `tbl_venta_det` VALUES (507, 308, 1, 201, NULL, NULL, NULL, 3.00, 1.50, 1.50, 0.00, 18.00, 4.50, 4.50, 0.00);
INSERT INTO `tbl_venta_det` VALUES (508, 309, 1, 200, 1.00, 60, 0.00, 60.00, 0.87, 0.87, 0.00, 18.00, 52.00, 52.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (509, 309, 2, 203, 1.00, 24, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (510, 310, 1, 364, 1.00, 24, 0.00, 24.00, 1.21, 1.21, 0.00, 18.00, 29.00, 29.00, 1.13);
INSERT INTO `tbl_venta_det` VALUES (511, 310, 2, 365, 1.00, 12, 0.00, 12.00, 2.42, 2.42, 0.00, 18.00, 29.00, 29.00, 2.25);
INSERT INTO `tbl_venta_det` VALUES (512, 310, 3, 368, 1.00, 12, 0.00, 12.00, 1.67, 1.67, 0.00, 18.00, 20.00, 20.00, 1.50);
INSERT INTO `tbl_venta_det` VALUES (513, 310, 4, 366, 2.00, 15, 0.00, 30.00, 1.60, 1.60, 0.00, 18.00, 48.00, 48.00, 1.37);
INSERT INTO `tbl_venta_det` VALUES (514, 310, 5, 367, 2.00, 24, 0.00, 48.00, 0.88, 0.88, 0.00, 18.00, 42.00, 42.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (515, 310, 6, 369, 1.00, 20, 0.00, 20.00, 0.50, 0.50, 0.00, 18.00, 10.00, 10.00, 0.43);
INSERT INTO `tbl_venta_det` VALUES (516, 311, 1, 200, 0.00, 60, 24.00, 24.00, 0.87, 0.87, 0.00, 18.00, 20.80, 20.80, 0.80);
INSERT INTO `tbl_venta_det` VALUES (517, 311, 2, 326, 1.00, 10, 0.00, 10.00, 1.00, 1.00, 0.00, 18.00, 10.00, 10.00, 0.94);
INSERT INTO `tbl_venta_det` VALUES (518, 311, 3, 297, 1.00, 20, 0.00, 20.00, 1.65, 1.65, 0.00, 18.00, 33.00, 33.00, 1.46);
INSERT INTO `tbl_venta_det` VALUES (519, 311, 4, 244, 1.00, 1, 0.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (520, 312, 1, 357, 2.00, 12, 0.00, 24.00, 0.88, 0.88, 0.00, 18.00, 252.00, 21.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (521, 313, 1, 285, 2.00, 40, 0.00, 80.00, 0.24, 0.24, 0.00, 18.00, 760.00, 19.00, 0.21);
INSERT INTO `tbl_venta_det` VALUES (522, 313, 4, 315, 0.00, 60, 6.00, 6.00, 1.22, 1.22, 0.00, 18.00, 438.00, 7.30, 1.15);
INSERT INTO `tbl_venta_det` VALUES (523, 314, 1, 238, 1.00, 1, 0.00, 1.00, 76.00, 76.00, 0.00, 18.00, 76.00, 76.00, 71.00);
INSERT INTO `tbl_venta_det` VALUES (524, 316, 1, 332, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 120.00, 10.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (525, 317, 1, 332, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 120.00, 10.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (526, 317, 2, 252, 0.00, 48, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 288.00, 6.00, 5.00);
INSERT INTO `tbl_venta_det` VALUES (527, 317, 3, 354, 1.00, 12, 0.00, 12.00, 0.29, 0.29, 0.00, 18.00, 42.00, 3.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (528, 317, 4, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 1000.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (529, 317, 5, 285, 0.00, 40, 3.00, 3.00, 0.31, 0.31, 0.00, 18.00, 37.50, 0.94, 0.21);
INSERT INTO `tbl_venta_det` VALUES (530, 317, 6, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 66.00, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (531, 317, 7, 201, 0.00, 12, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 21.60, 1.80, 1.29);
INSERT INTO `tbl_venta_det` VALUES (532, 317, 8, 287, 0.00, 40, 1.00, 1.00, 1.40, 1.40, 0.00, 18.00, 56.00, 1.40, 1.25);
INSERT INTO `tbl_venta_det` VALUES (533, 317, 9, 270, 0.00, 1, 2.00, 2.00, 1.20, 1.20, 0.00, 18.00, 2.40, 2.40, 1.00);
INSERT INTO `tbl_venta_det` VALUES (534, 318, 1, 239, 0.00, 50, 1.00, 1.00, 3.20, 3.20, 0.00, 18.00, 3.20, 3.20, 2.76);
INSERT INTO `tbl_venta_det` VALUES (535, 319, 1, 299, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.38);
INSERT INTO `tbl_venta_det` VALUES (536, 320, 1, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (537, 320, 2, 375, 2.00, 1, 0.00, 2.00, 3.00, 3.00, 0.00, 18.00, 6.00, 6.00, 2.50);
INSERT INTO `tbl_venta_det` VALUES (538, 321, 1, 373, 0.00, 48, 4.00, 4.00, 2.20, 2.20, 0.00, 18.00, 8.80, 8.80, 2.00);
INSERT INTO `tbl_venta_det` VALUES (539, 322, 1, 343, 1.00, 1, 0.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.82);
INSERT INTO `tbl_venta_det` VALUES (540, 322, 2, 182, 0.00, 24, 1.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 3.95);
INSERT INTO `tbl_venta_det` VALUES (541, 322, 3, 271, 0.00, 1, 2.00, 2.00, 3.50, 3.50, 0.00, 18.00, 7.00, 7.00, 3.03);
INSERT INTO `tbl_venta_det` VALUES (542, 322, 4, 209, 0.00, 24, 2.00, 2.00, 3.50, 3.50, 0.00, 18.00, 7.00, 7.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (543, 323, 1, 259, 1.00, 1, 0.00, 1.00, 107.99, 107.99, 0.00, 18.00, 107.99, 107.99, 104.90);
INSERT INTO `tbl_venta_det` VALUES (544, 323, 2, 376, 1.00, 1, 0.00, 1.00, 28.00, 28.00, 0.00, 18.00, 28.00, 28.00, 22.00);
INSERT INTO `tbl_venta_det` VALUES (545, 323, 3, 222, 0.00, 48, 2.00, 2.00, 2.80, 2.80, 0.00, 18.00, 5.60, 5.60, 2.38);
INSERT INTO `tbl_venta_det` VALUES (546, 324, 1, 323, 0.00, 24, 12.00, 12.00, 3.08, 3.08, 0.00, 18.00, 37.00, 37.00, 2.85);
INSERT INTO `tbl_venta_det` VALUES (547, 325, 1, 256, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.01);
INSERT INTO `tbl_venta_det` VALUES (548, 325, 2, 293, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.01);
INSERT INTO `tbl_venta_det` VALUES (549, 326, 1, 341, 0.00, 24, 1.00, 1.00, 2.70, 2.70, 0.00, 18.00, 2.70, 2.70, 2.33);
INSERT INTO `tbl_venta_det` VALUES (550, 327, 1, 258, 0.00, 1, 6.00, 6.00, 4.58, 4.58, 0.00, 18.00, 27.48, 27.48, 4.16);
INSERT INTO `tbl_venta_det` VALUES (551, 327, 2, 355, 1.00, 12, 0.00, 12.00, 0.29, 0.29, 0.00, 18.00, 3.50, 3.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (552, 328, 1, 261, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (553, 329, 1, 248, 0.00, 50, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (554, 330, 1, 278, 0.00, 24, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.50);
INSERT INTO `tbl_venta_det` VALUES (555, 331, 1, 238, 1.00, 1, 0.00, 1.00, 76.00, 76.00, 0.00, 18.00, 76.00, 76.00, 71.00);
INSERT INTO `tbl_venta_det` VALUES (556, 332, 1, 267, 1.00, 20, 0.00, 20.00, 1.03, 1.03, 0.00, 18.00, 20.50, 20.50, 0.93);
INSERT INTO `tbl_venta_det` VALUES (557, 332, 2, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (558, 332, 3, 289, 0.00, 12, 12.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (559, 332, 4, 389, 0.00, 12, 12.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (560, 332, 5, 321, 0.00, 12, 12.00, 12.00, 0.96, 0.96, 0.00, 18.00, 11.50, 11.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (561, 332, 6, 251, 0.00, 24, 6.00, 6.00, 3.33, 3.33, 0.00, 18.00, 20.00, 20.00, 3.00);
INSERT INTO `tbl_venta_det` VALUES (562, 332, 7, 274, 0.00, 60, 12.00, 12.00, 2.33, 2.33, 0.00, 18.00, 28.00, 28.00, 2.08);
INSERT INTO `tbl_venta_det` VALUES (563, 332, 8, 327, 0.00, 10, 10.00, 10.00, 1.00, 1.00, 0.00, 18.00, 10.00, 10.00, 0.94);
INSERT INTO `tbl_venta_det` VALUES (564, 332, 9, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (565, 332, 10, 252, 0.00, 48, 12.00, 12.00, 5.67, 5.67, 0.00, 18.00, 68.01, 68.01, 5.00);
INSERT INTO `tbl_venta_det` VALUES (566, 332, 11, 241, 1.00, 24, 0.00, 24.00, 0.92, 0.92, 0.00, 18.00, 22.00, 22.00, 0.81);
INSERT INTO `tbl_venta_det` VALUES (567, 332, 12, 235, 1.00, 40, 0.00, 40.00, 0.38, 0.38, 0.00, 18.00, 15.00, 15.00, 0.34);
INSERT INTO `tbl_venta_det` VALUES (568, 333, 4, 273, 0.00, 15, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 30.00, 2.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (569, 333, 5, 230, 0.00, 1, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.74);
INSERT INTO `tbl_venta_det` VALUES (570, 333, 6, 377, 0.00, 18, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 36.00, 2.00, 0.92);
INSERT INTO `tbl_venta_det` VALUES (571, 333, 7, 398, 0.00, 1, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.73);
INSERT INTO `tbl_venta_det` VALUES (572, 333, 8, 201, 0.00, 12, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 21.60, 1.80, 1.29);
INSERT INTO `tbl_venta_det` VALUES (573, 333, 9, 304, 0.00, 1, 2.00, 2.00, 5.00, 5.00, 0.00, 18.00, 10.00, 10.00, 3.91);
INSERT INTO `tbl_venta_det` VALUES (574, 333, 10, 200, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 648.00, 10.80, 0.83);
INSERT INTO `tbl_venta_det` VALUES (575, 333, 11, 341, 0.00, 24, 1.00, 1.00, 2.70, 2.70, 0.00, 18.00, 64.80, 2.70, 2.33);
INSERT INTO `tbl_venta_det` VALUES (576, 333, 12, 339, 0.00, 1, 0.50, 0.50, 3.97, 3.97, 0.00, 18.00, 1.99, 1.99, 3.80);
INSERT INTO `tbl_venta_det` VALUES (577, 333, 13, 239, 0.00, 50, 2.00, 2.00, 3.20, 3.20, 0.00, 18.00, 320.00, 6.40, 2.76);
INSERT INTO `tbl_venta_det` VALUES (578, 333, 14, 297, 0.00, 20, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 40.00, 2.00, 1.46);
INSERT INTO `tbl_venta_det` VALUES (579, 333, 15, 337, 0.00, 1, 0.50, 0.50, 5.50, 5.50, 0.00, 18.00, 2.75, 2.75, 4.44);
INSERT INTO `tbl_venta_det` VALUES (580, 333, 17, 262, 1.00, 1, 0.00, 1.00, 8.00, 8.00, 0.00, 18.00, 8.00, 8.00, 6.80);
INSERT INTO `tbl_venta_det` VALUES (581, 333, 18, 374, 0.00, 12, 6.00, 6.00, 0.92, 0.92, 0.00, 18.00, 66.00, 5.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (582, 334, 1, 218, 0.00, 40, 6.00, 6.00, 1.55, 1.55, 0.00, 18.00, 372.00, 9.30, 1.35);
INSERT INTO `tbl_venta_det` VALUES (583, 334, 2, 194, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.37);
INSERT INTO `tbl_venta_det` VALUES (584, 334, 3, 192, 0.00, 48, 3.00, 3.00, 3.50, 3.50, 0.00, 18.00, 504.03, 10.50, 3.02);
INSERT INTO `tbl_venta_det` VALUES (585, 334, 4, 246, 0.00, 24, 1.00, 1.00, 1.50, 1.50, 0.00, 18.00, 36.00, 1.50, 1.16);
INSERT INTO `tbl_venta_det` VALUES (586, 334, 5, 240, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 216.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (587, 334, 6, 365, 0.00, 12, 6.00, 6.00, 2.42, 2.42, 0.00, 18.00, 174.00, 14.50, 2.25);
INSERT INTO `tbl_venta_det` VALUES (588, 335, 1, 266, 1.00, 12, 0.00, 12.00, 7.92, 7.92, 0.00, 18.00, 95.00, 95.00, 7.54);
INSERT INTO `tbl_venta_det` VALUES (589, 336, 1, 190, 0.00, 48, 9.00, 9.00, 1.67, 1.67, 0.00, 18.00, 15.00, 15.00, 1.54);
INSERT INTO `tbl_venta_det` VALUES (590, 337, 1, 399, 8.00, 10, 0.00, 80.00, 0.19, 0.19, 0.00, 18.00, 15.52, 15.52, 0.18);
INSERT INTO `tbl_venta_det` VALUES (591, 338, 1, 200, 0.00, 60, 30.00, 30.00, 0.90, 0.90, 0.00, 18.00, 27.00, 27.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (592, 338, 2, 230, 0.00, 1, 2.00, 2.00, 2.00, 2.00, 0.00, 18.00, 4.00, 4.00, 1.74);
INSERT INTO `tbl_venta_det` VALUES (593, 338, 3, 228, 0.00, 24, 3.00, 3.00, 3.00, 3.00, 0.00, 18.00, 9.00, 9.00, 2.63);
INSERT INTO `tbl_venta_det` VALUES (594, 338, 4, 387, 0.00, 12, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 3.00, 3.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (595, 338, 5, 234, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 5.14);
INSERT INTO `tbl_venta_det` VALUES (596, 339, 1, 349, 0.00, 1, 1.00, 1.00, 29.00, 29.00, 0.00, 18.00, 29.00, 29.00, 25.99);
INSERT INTO `tbl_venta_det` VALUES (597, 339, 2, 207, 0.00, 12, 6.00, 6.00, 2.17, 2.17, 0.00, 18.00, 13.00, 13.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (598, 339, 3, 346, 0.00, 1, 1.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 4.50);
INSERT INTO `tbl_venta_det` VALUES (599, 339, 4, 312, 0.00, 48, 3.00, 3.00, 2.50, 2.50, 0.00, 18.00, 7.50, 7.50, 2.27);
INSERT INTO `tbl_venta_det` VALUES (600, 340, 3, 334, 0.00, 1, 2.00, 2.00, 7.00, 7.00, 0.00, 18.00, 14.00, 14.00, 6.00);
INSERT INTO `tbl_venta_det` VALUES (601, 340, 4, 338, 0.00, 1, 2.00, 2.00, 9.00, 9.00, 0.00, 18.00, 18.00, 18.00, 8.00);
INSERT INTO `tbl_venta_det` VALUES (602, 341, 1, 325, 0.00, 4, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 3.00, 3.00, 2.38);
INSERT INTO `tbl_venta_det` VALUES (603, 341, 2, 315, 0.00, 60, 6.00, 6.00, 1.22, 1.22, 0.00, 18.00, 7.30, 7.30, 1.15);
INSERT INTO `tbl_venta_det` VALUES (604, 341, 3, 388, 0.00, 12, 6.00, 6.00, 0.83, 0.83, 0.00, 18.00, 5.00, 5.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (605, 341, 5, 350, 0.00, 20, 5.00, 5.00, 1.05, 1.05, 0.00, 18.00, 5.25, 5.25, 0.96);
INSERT INTO `tbl_venta_det` VALUES (606, 341, 6, 198, 0.00, 1, 6.00, 6.00, 0.83, 0.83, 0.00, 18.00, 4.98, 4.98, 0.74);
INSERT INTO `tbl_venta_det` VALUES (607, 341, 8, 286, 0.00, 40, 20.00, 20.00, 0.24, 0.24, 0.00, 18.00, 4.75, 4.75, 0.21);
INSERT INTO `tbl_venta_det` VALUES (608, 341, 10, 299, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.38);
INSERT INTO `tbl_venta_det` VALUES (609, 341, 11, 224, 0.00, 1, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (610, 341, 12, 192, 0.00, 48, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 10.00, 10.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (611, 342, 1, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (612, 342, 2, 399, 0.00, 10, 6.00, 6.00, 0.25, 0.25, 0.00, 18.00, 1.50, 1.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (613, 342, 3, 203, 0.00, 24, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (614, 342, 4, 250, 0.00, 20, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.43);
INSERT INTO `tbl_venta_det` VALUES (615, 342, 5, 252, 0.00, 48, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 12.00, 12.00, 5.00);
INSERT INTO `tbl_venta_det` VALUES (616, 342, 6, 176, 0.00, 25, 1.00, 1.00, 1.50, 1.50, 0.00, 18.00, 1.50, 1.50, 1.07);
INSERT INTO `tbl_venta_det` VALUES (617, 343, 1, 328, 0.00, 1, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.08);
INSERT INTO `tbl_venta_det` VALUES (618, 343, 4, 186, 1.00, 1, 6.00, 7.00, 3.75, 3.75, 0.00, 18.00, 26.25, 26.25, 3.42);
INSERT INTO `tbl_venta_det` VALUES (619, 343, 5, 209, 0.00, 24, 6.00, 6.00, 3.33, 3.33, 0.00, 18.00, 20.00, 20.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (620, 343, 6, 290, 0.00, 48, 6.00, 6.00, 1.96, 1.96, 0.00, 18.00, 11.75, 11.75, 1.80);
INSERT INTO `tbl_venta_det` VALUES (621, 343, 7, 277, 0.00, 48, 6.00, 6.00, 1.63, 1.63, 0.00, 18.00, 9.75, 9.75, 1.52);
INSERT INTO `tbl_venta_det` VALUES (622, 343, 8, 278, 1.00, 24, 6.00, 30.00, 2.71, 2.71, 0.00, 18.00, 81.25, 81.25, 2.50);
INSERT INTO `tbl_venta_det` VALUES (623, 344, 1, 315, 0.00, 60, 9.00, 9.00, 1.22, 1.22, 0.00, 18.00, 10.95, 10.95, 1.15);
INSERT INTO `tbl_venta_det` VALUES (624, 345, 1, 215, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 2.03);
INSERT INTO `tbl_venta_det` VALUES (625, 345, 2, 362, 0.00, 1, 1.00, 1.00, 6.50, 6.50, 0.00, 18.00, 6.50, 6.50, 6.00);
INSERT INTO `tbl_venta_det` VALUES (626, 346, 1, 298, 0.00, 24, 3.00, 3.00, 3.67, 3.67, 0.00, 18.00, 11.00, 11.00, 3.44);
INSERT INTO `tbl_venta_det` VALUES (627, 346, 2, 271, 0.00, 1, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 9.99, 9.99, 3.03);
INSERT INTO `tbl_venta_det` VALUES (628, 346, 3, 248, 0.00, 50, 2.00, 2.00, 4.00, 4.00, 0.00, 18.00, 8.00, 8.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (629, 346, 4, 249, 0.00, 20, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (630, 346, 5, 239, 0.00, 50, 1.00, 1.00, 3.20, 3.20, 0.00, 18.00, 3.20, 3.20, 2.76);
INSERT INTO `tbl_venta_det` VALUES (631, 347, 1, 349, 1.00, 1, 0.00, 1.00, 29.00, 29.00, 0.00, 18.00, 29.00, 29.00, 25.99);
INSERT INTO `tbl_venta_det` VALUES (632, 348, 1, 372, 2.00, 16, 0.00, 32.00, 1.00, 1.00, 0.00, 18.00, 32.00, 32.00, 0.93);
INSERT INTO `tbl_venta_det` VALUES (633, 349, 1, 209, 1.00, 24, 0.00, 24.00, 3.33, 3.33, 0.00, 18.00, 80.00, 80.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (634, 349, 2, 287, 1.00, 40, 0.00, 40.00, 1.38, 1.38, 0.00, 18.00, 55.00, 55.00, 1.25);
INSERT INTO `tbl_venta_det` VALUES (635, 349, 3, 297, 1.00, 20, 0.00, 20.00, 1.65, 1.65, 0.00, 18.00, 33.00, 33.00, 1.46);
INSERT INTO `tbl_venta_det` VALUES (636, 349, 4, 195, 1.00, 20, 0.00, 20.00, 2.15, 2.15, 0.00, 18.00, 43.00, 43.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (637, 350, 1, 399, 16.00, 10, 0.00, 160.00, 0.19, 0.19, 0.00, 18.00, 31.04, 31.04, 0.18);
INSERT INTO `tbl_venta_det` VALUES (638, 350, 2, 184, 1.00, 24, 0.00, 24.00, 3.75, 3.75, 0.00, 18.00, 90.00, 90.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (639, 350, 3, 268, 1.00, 55, 0.00, 55.00, 0.42, 0.42, 0.00, 18.00, 23.00, 23.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (640, 350, 4, 266, 2.00, 12, 0.00, 24.00, 7.92, 7.92, 0.00, 18.00, 190.00, 190.00, 7.54);
INSERT INTO `tbl_venta_det` VALUES (641, 350, 5, 351, 3.00, 1, 0.00, 3.00, 9.50, 9.50, 0.00, 18.00, 28.50, 28.50, 8.50);
INSERT INTO `tbl_venta_det` VALUES (642, 351, 1, 367, 2.00, 24, 0.00, 48.00, 0.88, 0.88, 0.00, 18.00, 42.00, 42.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (643, 351, 2, 308, 5.00, 1, 0.00, 5.00, 13.00, 13.00, 0.00, 18.00, 65.00, 65.00, 11.00);
INSERT INTO `tbl_venta_det` VALUES (644, 351, 3, 248, 1.00, 50, 0.00, 50.00, 3.54, 3.54, 0.00, 18.00, 177.00, 177.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (645, 351, 4, 260, 2.00, 10, 0.00, 20.00, 1.55, 1.55, 0.00, 18.00, 31.00, 31.00, 1.44);
INSERT INTO `tbl_venta_det` VALUES (646, 351, 5, 306, 1.00, 10, 0.00, 10.00, 3.00, 3.00, 0.00, 18.00, 30.00, 30.00, 2.70);
INSERT INTO `tbl_venta_det` VALUES (647, 352, 1, 417, 1.00, 1, 0.00, 1.00, 22.00, 22.00, 0.00, 18.00, 22.00, 22.00, 20.00);
INSERT INTO `tbl_venta_det` VALUES (648, 353, 1, 374, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (649, 353, 2, 297, 0.00, 20, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.46);
INSERT INTO `tbl_venta_det` VALUES (650, 353, 3, 312, 0.00, 48, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.27);
INSERT INTO `tbl_venta_det` VALUES (651, 353, 4, 266, 0.00, 12, 2.00, 2.00, 8.00, 8.00, 0.00, 18.00, 16.00, 16.00, 7.54);
INSERT INTO `tbl_venta_det` VALUES (652, 353, 5, 207, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 1.95);
INSERT INTO `tbl_venta_det` VALUES (653, 353, 6, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (654, 353, 7, 201, 0.00, 12, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 1.80, 1.80, 1.29);
INSERT INTO `tbl_venta_det` VALUES (655, 353, 8, 338, 0.00, 1, 0.50, 0.50, 9.00, 9.00, 0.00, 18.00, 4.50, 4.50, 8.00);
INSERT INTO `tbl_venta_det` VALUES (656, 353, 9, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (657, 353, 11, 240, 0.00, 12, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (658, 353, 12, 214, 0.00, 24, 6.00, 6.00, 3.67, 3.67, 0.00, 18.00, 22.00, 22.00, 3.44);
INSERT INTO `tbl_venta_det` VALUES (659, 354, 1, 370, 0.00, 1, 1.00, 1.00, 31.00, 31.00, 0.00, 18.00, 31.00, 31.00, 27.80);
INSERT INTO `tbl_venta_det` VALUES (660, 355, 1, 239, 0.00, 50, 2.00, 2.00, 3.20, 3.20, 0.00, 18.00, 6.40, 6.40, 2.76);
INSERT INTO `tbl_venta_det` VALUES (661, 356, 1, 209, 1.00, 24, 0.00, 24.00, 3.33, 3.33, 0.00, 18.00, 80.00, 80.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (662, 356, 3, 219, 0.00, 6, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.95);
INSERT INTO `tbl_venta_det` VALUES (663, 357, 1, 197, 1.00, 1, 0.00, 1.00, 85.00, 85.00, 0.00, 18.00, 85.00, 85.00, 81.00);
INSERT INTO `tbl_venta_det` VALUES (664, 358, 1, 315, 0.00, 60, 12.00, 12.00, 1.25, 1.25, 0.00, 18.00, 15.00, 15.00, 1.15);
INSERT INTO `tbl_venta_det` VALUES (665, 358, 2, 186, 1.00, 1, 0.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.50);
INSERT INTO `tbl_venta_det` VALUES (666, 358, 3, 321, 1.00, 12, 0.00, 12.00, 0.96, 0.96, 0.00, 18.00, 11.50, 11.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (667, 359, 1, 312, 0.00, 48, 3.00, 3.00, 2.80, 2.80, 0.00, 18.00, 8.40, 8.40, 2.27);
INSERT INTO `tbl_venta_det` VALUES (668, 359, 3, 326, 0.00, 10, 3.00, 3.00, 1.20, 1.20, 0.00, 18.00, 3.60, 3.60, 0.94);
INSERT INTO `tbl_venta_det` VALUES (669, 360, 1, 260, 2.00, 10, 0.00, 20.00, 1.55, 1.55, 0.00, 18.00, 31.00, 31.00, 1.44);
INSERT INTO `tbl_venta_det` VALUES (670, 360, 2, 285, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (671, 361, 1, 239, 0.00, 50, 25.00, 25.00, 2.90, 2.90, 0.00, 18.00, 72.50, 72.50, 2.76);
INSERT INTO `tbl_venta_det` VALUES (672, 361, 2, 255, 1.00, 20, 1.00, 21.00, 0.95, 0.95, 0.00, 18.00, 19.95, 19.95, 0.86);
INSERT INTO `tbl_venta_det` VALUES (673, 361, 3, 228, 0.00, 24, 12.00, 12.00, 2.75, 2.75, 0.00, 18.00, 33.00, 33.00, 2.63);
INSERT INTO `tbl_venta_det` VALUES (674, 361, 4, 227, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 15.50);
INSERT INTO `tbl_venta_det` VALUES (675, 361, 5, 286, 2.00, 40, 0.00, 80.00, 0.24, 0.24, 0.00, 18.00, 19.00, 19.00, 0.21);
INSERT INTO `tbl_venta_det` VALUES (676, 361, 6, 303, 0.00, 1, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 1.95);
INSERT INTO `tbl_venta_det` VALUES (677, 361, 7, 285, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (678, 361, 8, 258, 0.00, 1, 1.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 4.16);
INSERT INTO `tbl_venta_det` VALUES (679, 361, 9, 332, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (680, 362, 2, 268, 0.00, 55, 12.00, 12.00, 0.42, 0.42, 0.00, 18.00, 5.02, 5.02, 0.39);
INSERT INTO `tbl_venta_det` VALUES (681, 362, 3, 428, 0.00, 100, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 1.00, 1.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (682, 362, 4, 372, 0.00, 16, 1.00, 1.00, 1.20, 1.20, 0.00, 18.00, 1.20, 1.20, 0.93);
INSERT INTO `tbl_venta_det` VALUES (683, 362, 5, 286, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (684, 362, 7, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (685, 362, 8, 301, 3.00, 1, 0.00, 3.00, 15.00, 15.00, 0.00, 18.00, 45.00, 45.00, 13.03);
INSERT INTO `tbl_venta_det` VALUES (686, 362, 9, 378, 0.00, 12, 6.00, 6.00, 0.79, 0.79, 0.00, 18.00, 4.75, 4.75, 0.67);
INSERT INTO `tbl_venta_det` VALUES (687, 362, 10, 332, 0.00, 12, 6.00, 6.00, 0.83, 0.83, 0.00, 18.00, 5.00, 5.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (688, 363, 1, 315, 0.00, 60, 8.00, 8.00, 1.25, 1.25, 0.00, 18.00, 10.00, 10.00, 1.15);
INSERT INTO `tbl_venta_det` VALUES (689, 363, 2, 200, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 10.80, 10.80, 0.83);
INSERT INTO `tbl_venta_det` VALUES (690, 363, 3, 405, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.67);
INSERT INTO `tbl_venta_det` VALUES (691, 364, 1, 285, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (692, 364, 2, 240, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (693, 365, 1, 340, 0.00, 1, 1.00, 1.00, 22.00, 22.00, 0.00, 18.00, 22.00, 22.00, 18.80);
INSERT INTO `tbl_venta_det` VALUES (694, 366, 2, 377, 1.00, 18, 0.00, 18.00, 0.97, 0.97, 0.00, 18.00, 17.50, 17.50, 0.92);
INSERT INTO `tbl_venta_det` VALUES (695, 367, 1, 433, 0.00, 20, 2.00, 2.00, 0.60, 0.60, 0.00, 18.00, 24.00, 1.20, 0.46);
INSERT INTO `tbl_venta_det` VALUES (696, 367, 2, 215, 0.00, 12, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 60.00, 5.00, 2.03);
INSERT INTO `tbl_venta_det` VALUES (697, 367, 3, 435, 0.00, 60, 3.00, 3.00, 1.83, 1.83, 0.00, 18.00, 329.97, 5.50, 1.63);
INSERT INTO `tbl_venta_det` VALUES (698, 367, 4, 221, 0.00, 60, 3.00, 3.00, 1.58, 1.58, 0.00, 18.00, 284.97, 4.75, 1.40);
INSERT INTO `tbl_venta_det` VALUES (699, 367, 5, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 155.00, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (700, 367, 6, 237, 0.00, 1, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.50);
INSERT INTO `tbl_venta_det` VALUES (701, 368, 1, 200, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 10.80, 10.80, 0.83);
INSERT INTO `tbl_venta_det` VALUES (702, 368, 2, 289, 0.00, 12, 12.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (703, 368, 3, 267, 0.00, 20, 10.00, 10.00, 1.03, 1.03, 0.00, 18.00, 10.25, 10.25, 0.93);
INSERT INTO `tbl_venta_det` VALUES (704, 368, 4, 311, 0.00, 48, 4.00, 4.00, 2.60, 2.60, 0.00, 18.00, 10.42, 10.42, 2.40);
INSERT INTO `tbl_venta_det` VALUES (705, 368, 6, 342, 0.00, 40, 3.00, 3.00, 2.05, 2.05, 0.00, 18.00, 6.15, 6.15, 1.95);
INSERT INTO `tbl_venta_det` VALUES (706, 368, 7, 435, 0.00, 60, 6.00, 6.00, 1.83, 1.83, 0.00, 18.00, 11.00, 11.00, 1.63);
INSERT INTO `tbl_venta_det` VALUES (707, 368, 8, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (708, 368, 9, 195, 0.00, 20, 3.00, 3.00, 2.50, 2.50, 0.00, 18.00, 7.50, 7.50, 1.95);
INSERT INTO `tbl_venta_det` VALUES (709, 368, 10, 401, 1.00, 12, 0.00, 12.00, 0.50, 0.50, 0.00, 18.00, 6.00, 6.00, 0.42);
INSERT INTO `tbl_venta_det` VALUES (710, 368, 11, 429, 1.00, 15, 0.00, 15.00, 1.20, 1.20, 0.00, 18.00, 18.00, 18.00, 1.11);
INSERT INTO `tbl_venta_det` VALUES (711, 368, 12, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (712, 368, 13, 239, 0.00, 50, 10.00, 10.00, 3.20, 3.20, 0.00, 18.00, 32.00, 32.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (713, 368, 14, 433, 1.00, 20, 0.00, 20.00, 0.53, 0.53, 0.00, 18.00, 10.50, 10.50, 0.46);
INSERT INTO `tbl_venta_det` VALUES (714, 368, 15, 432, 1.00, 30, 0.00, 30.00, 0.40, 0.40, 0.00, 18.00, 12.00, 12.00, 0.35);
INSERT INTO `tbl_venta_det` VALUES (715, 368, 16, 235, 1.00, 40, 0.00, 40.00, 0.38, 0.38, 0.00, 18.00, 15.00, 15.00, 0.34);
INSERT INTO `tbl_venta_det` VALUES (716, 368, 17, 290, 0.00, 48, 12.00, 12.00, 1.96, 1.96, 0.00, 18.00, 23.50, 23.50, 1.80);
INSERT INTO `tbl_venta_det` VALUES (717, 368, 19, 249, 0.00, 20, 2.00, 2.00, 9.00, 9.00, 0.00, 18.00, 18.00, 18.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (718, 368, 20, 326, 0.00, 10, 10.00, 10.00, 1.00, 1.00, 0.00, 18.00, 10.00, 10.00, 0.94);
INSERT INTO `tbl_venta_det` VALUES (719, 368, 21, 327, 0.00, 10, 10.00, 10.00, 1.00, 1.00, 0.00, 18.00, 10.00, 10.00, 0.94);
INSERT INTO `tbl_venta_det` VALUES (720, 369, 1, 199, 2.00, 1, 0.00, 2.00, 18.00, 18.00, 0.00, 18.00, 36.00, 36.00, 15.00);
INSERT INTO `tbl_venta_det` VALUES (721, 369, 2, 203, 1.00, 24, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (722, 370, 1, 215, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 2.03);
INSERT INTO `tbl_venta_det` VALUES (723, 371, 1, 215, 0.00, 12, 6.00, 6.00, 2.17, 2.17, 0.00, 18.00, 13.00, 13.00, 2.03);
INSERT INTO `tbl_venta_det` VALUES (724, 372, 1, 393, 0.00, 1, 1.00, 1.00, 17.00, 17.00, 0.00, 18.00, 17.00, 17.00, 15.45);
INSERT INTO `tbl_venta_det` VALUES (725, 372, 2, 224, 0.00, 12, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (726, 372, 3, 194, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.37);
INSERT INTO `tbl_venta_det` VALUES (727, 372, 4, 281, 0.00, 30, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.19);
INSERT INTO `tbl_venta_det` VALUES (728, 372, 5, 218, 0.00, 40, 2.00, 2.00, 1.70, 1.70, 0.00, 18.00, 3.40, 3.40, 1.35);
INSERT INTO `tbl_venta_det` VALUES (729, 373, 2, 239, 0.00, 50, 5.00, 5.00, 3.20, 3.20, 0.00, 18.00, 16.00, 16.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (730, 373, 3, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (731, 373, 4, 323, 0.00, 24, 1.00, 1.00, 3.20, 3.20, 0.00, 18.00, 3.20, 3.20, 2.85);
INSERT INTO `tbl_venta_det` VALUES (732, 374, 1, 260, 5.00, 10, 0.00, 50.00, 1.55, 1.55, 0.00, 18.00, 77.50, 77.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (733, 375, 1, 201, 0.00, 12, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 1.80, 1.80, 1.29);
INSERT INTO `tbl_venta_det` VALUES (734, 375, 2, 357, 1.00, 12, 0.00, 12.00, 0.88, 0.88, 0.00, 18.00, 10.50, 10.50, 0.80);
INSERT INTO `tbl_venta_det` VALUES (735, 375, 3, 243, 0.00, 1, 1.00, 1.00, 6.50, 6.50, 0.00, 18.00, 6.50, 6.50, 5.50);
INSERT INTO `tbl_venta_det` VALUES (736, 375, 4, 207, 0.00, 12, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (737, 375, 5, 446, 0.00, 12, 1.00, 1.00, 9.50, 9.50, 0.00, 18.00, 9.50, 9.50, 8.75);
INSERT INTO `tbl_venta_det` VALUES (738, 375, 6, 311, 0.00, 48, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.40);
INSERT INTO `tbl_venta_det` VALUES (739, 375, 7, 205, 1.00, 15, 0.00, 15.00, 5.00, 5.00, 0.00, 18.00, 75.00, 75.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (740, 375, 8, 285, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (741, 375, 9, 401, 0.00, 12, 1.00, 1.00, 0.50, 0.50, 0.00, 18.00, 0.50, 0.50, 0.42);
INSERT INTO `tbl_venta_det` VALUES (742, 375, 10, 200, 0.00, 60, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (743, 375, 11, 287, 0.00, 40, 2.00, 2.00, 1.40, 1.40, 0.00, 18.00, 2.80, 2.80, 1.25);
INSERT INTO `tbl_venta_det` VALUES (744, 375, 12, 242, 0.00, 10, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.70);
INSERT INTO `tbl_venta_det` VALUES (745, 376, 1, 260, 2.00, 10, 0.00, 20.00, 1.55, 1.55, 0.00, 18.00, 31.00, 31.00, 1.44);
INSERT INTO `tbl_venta_det` VALUES (746, 377, 1, 297, 0.00, 20, 10.00, 10.00, 1.65, 1.65, 0.00, 18.00, 16.50, 16.50, 1.46);
INSERT INTO `tbl_venta_det` VALUES (747, 378, 1, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (748, 378, 2, 209, 0.00, 24, 4.00, 4.00, 3.50, 3.50, 0.00, 18.00, 14.00, 14.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (749, 378, 3, 446, 0.00, 12, 1.00, 1.00, 9.50, 9.50, 0.00, 18.00, 9.50, 9.50, 8.75);
INSERT INTO `tbl_venta_det` VALUES (750, 379, 1, 387, 0.00, 12, 12.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (751, 380, 1, 190, 0.00, 48, 9.00, 9.00, 1.67, 1.67, 0.00, 18.00, 15.00, 15.00, 1.54);
INSERT INTO `tbl_venta_det` VALUES (752, 380, 2, 231, 0.00, 1, 1.00, 1.00, 12.50, 12.50, 0.00, 18.00, 12.50, 12.50, 11.00);
INSERT INTO `tbl_venta_det` VALUES (753, 380, 3, 248, 0.00, 50, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (754, 381, 1, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.12);
INSERT INTO `tbl_venta_det` VALUES (755, 381, 2, 207, 0.00, 12, 6.00, 6.00, 2.17, 2.17, 0.00, 18.00, 13.00, 13.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (756, 382, 1, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.12);
INSERT INTO `tbl_venta_det` VALUES (757, 382, 2, 207, 0.00, 12, 6.00, 6.00, 2.17, 2.17, 0.00, 18.00, 13.00, 13.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (758, 383, 1, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.12);
INSERT INTO `tbl_venta_det` VALUES (759, 383, 2, 207, 0.00, 12, 6.00, 6.00, 2.17, 2.17, 0.00, 18.00, 13.00, 13.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (760, 384, 1, 266, 1.00, 12, 0.00, 12.00, 8.29, 8.29, 0.00, 18.00, 99.50, 99.50, 7.89);
INSERT INTO `tbl_venta_det` VALUES (761, 384, 2, 211, 0.00, 1, 1.00, 1.00, 7.50, 7.50, 0.00, 18.00, 7.50, 7.50, 6.37);
INSERT INTO `tbl_venta_det` VALUES (762, 384, 3, 207, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (763, 384, 4, 454, 1.00, 6, 0.00, 6.00, 6.50, 6.50, 0.00, 18.00, 39.00, 39.00, 6.04);
INSERT INTO `tbl_venta_det` VALUES (764, 385, 1, 290, 0.00, 48, 24.00, 24.00, 1.96, 1.96, 0.00, 18.00, 47.00, 47.00, 1.80);
INSERT INTO `tbl_venta_det` VALUES (765, 386, 1, 294, 1.00, 1, 0.00, 1.00, 13.50, 13.50, 0.00, 18.00, 13.50, 13.50, 12.19);
INSERT INTO `tbl_venta_det` VALUES (766, 386, 2, 389, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (767, 386, 3, 249, 0.00, 20, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (768, 387, 3, 305, 0.00, 12, 6.00, 6.00, 1.04, 1.04, 0.00, 18.00, 6.25, 6.25, 0.99);
INSERT INTO `tbl_venta_det` VALUES (769, 387, 4, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (770, 388, 1, 467, 3.00, 1, 0.00, 3.00, 7.00, 7.00, 0.00, 18.00, 21.00, 21.00, 6.50);
INSERT INTO `tbl_venta_det` VALUES (771, 388, 2, 468, 4.00, 1, 0.00, 4.00, 7.00, 7.00, 0.00, 18.00, 28.00, 28.00, 6.50);
INSERT INTO `tbl_venta_det` VALUES (772, 389, 1, 238, 1.00, 1, 0.00, 1.00, 76.00, 76.00, 0.00, 18.00, 76.00, 76.00, 71.00);
INSERT INTO `tbl_venta_det` VALUES (773, 389, 2, 209, 1.00, 24, 0.00, 24.00, 3.33, 3.33, 0.00, 18.00, 80.00, 80.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (774, 389, 3, 203, 1.00, 24, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (775, 389, 4, 217, 0.00, 12, 3.00, 3.00, 3.25, 3.25, 0.00, 18.00, 9.75, 9.75, 2.96);
INSERT INTO `tbl_venta_det` VALUES (776, 389, 5, 230, 0.00, 1, 6.00, 6.00, 1.92, 1.92, 0.00, 18.00, 11.52, 11.52, 1.74);
INSERT INTO `tbl_venta_det` VALUES (777, 389, 6, 282, 0.00, 15, 1.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.87);
INSERT INTO `tbl_venta_det` VALUES (778, 390, 2, 219, 1.00, 6, 0.00, 6.00, 5.33, 5.33, 0.00, 18.00, 192.00, 32.00, 4.95);
INSERT INTO `tbl_venta_det` VALUES (779, 391, 1, 369, 0.00, 20, 1.00, 1.00, 0.60, 0.60, 0.00, 18.00, 12.00, 0.60, 0.43);
INSERT INTO `tbl_venta_det` VALUES (780, 391, 2, 399, 0.00, 10, 4.00, 4.00, 0.25, 0.25, 0.00, 18.00, 10.00, 1.00, 0.18);
INSERT INTO `tbl_venta_det` VALUES (781, 391, 3, 305, 0.00, 12, 3.00, 3.00, 1.20, 1.20, 0.00, 18.00, 43.20, 3.60, 0.99);
INSERT INTO `tbl_venta_det` VALUES (782, 391, 5, 224, 0.00, 12, 2.00, 2.00, 9.00, 9.00, 0.00, 18.00, 216.00, 18.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (783, 391, 6, 208, 0.00, 1, 1.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.00);
INSERT INTO `tbl_venta_det` VALUES (784, 391, 7, 377, 0.00, 18, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 18.00, 1.00, 0.92);
INSERT INTO `tbl_venta_det` VALUES (785, 391, 8, 281, 0.00, 30, 2.00, 2.00, 3.50, 3.50, 0.00, 18.00, 210.00, 7.00, 3.19);
INSERT INTO `tbl_venta_det` VALUES (786, 391, 9, 453, 1.00, 6, 0.00, 6.00, 1.42, 1.42, 0.00, 18.00, 51.00, 8.50, 1.28);
INSERT INTO `tbl_venta_det` VALUES (787, 391, 10, 343, 0.00, 1, 1.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.82);
INSERT INTO `tbl_venta_det` VALUES (788, 391, 11, 314, 0.00, 48, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 134.40, 2.80, 2.40);
INSERT INTO `tbl_venta_det` VALUES (789, 391, 12, 273, 0.00, 15, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 30.00, 2.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (790, 392, 1, 209, 1.00, 24, 6.00, 30.00, 3.33, 3.33, 0.00, 18.00, 100.00, 100.00, 3.16);
INSERT INTO `tbl_venta_det` VALUES (791, 393, 1, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.12);
INSERT INTO `tbl_venta_det` VALUES (792, 393, 2, 207, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (793, 394, 1, 418, 0.00, 48, 12.00, 12.00, 2.13, 2.13, 0.00, 18.00, 25.50, 25.50, 2.00);
INSERT INTO `tbl_venta_det` VALUES (794, 395, 1, 273, 0.00, 15, 2.00, 2.00, 2.00, 2.00, 0.00, 18.00, 4.00, 4.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (795, 395, 2, 387, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (796, 395, 3, 411, 1.00, 1, 0.00, 1.00, 26.50, 26.50, 0.00, 18.00, 26.50, 26.50, 23.81);
INSERT INTO `tbl_venta_det` VALUES (797, 396, 1, 480, 1.00, 1, 0.00, 1.00, 25.99, 25.99, 0.00, 18.00, 25.99, 25.99, 23.00);
INSERT INTO `tbl_venta_det` VALUES (798, 396, 2, 478, 0.00, 12, 12.00, 12.00, 1.92, 1.92, 0.00, 18.00, 23.00, 23.00, 1.50);
INSERT INTO `tbl_venta_det` VALUES (799, 396, 3, 326, 1.00, 10, 0.00, 10.00, 1.00, 1.00, 0.00, 18.00, 10.00, 10.00, 0.94);
INSERT INTO `tbl_venta_det` VALUES (800, 396, 4, 479, 1.00, 1, 0.00, 1.00, 14.00, 14.00, 0.00, 18.00, 14.00, 14.00, 12.00);
INSERT INTO `tbl_venta_det` VALUES (801, 396, 5, 368, 0.00, 12, 12.00, 12.00, 1.67, 1.67, 0.00, 18.00, 20.00, 20.00, 1.50);
INSERT INTO `tbl_venta_det` VALUES (802, 397, 1, 378, 0.00, 12, 12.00, 12.00, 0.79, 0.79, 0.00, 18.00, 9.50, 9.50, 0.67);
INSERT INTO `tbl_venta_det` VALUES (803, 398, 1, 482, 2.00, 12, 0.00, 24.00, 1.33, 1.33, 0.00, 18.00, 32.00, 32.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (804, 398, 2, 240, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (805, 399, 1, 238, 1.00, 1, 0.00, 1.00, 76.00, 76.00, 0.00, 18.00, 76.00, 76.00, 71.00);
INSERT INTO `tbl_venta_det` VALUES (806, 400, 1, 279, 1.00, 20, 0.00, 20.00, 0.93, 0.93, 0.00, 18.00, 18.50, 18.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (807, 400, 2, 297, 1.00, 20, 0.00, 20.00, 1.65, 1.65, 0.00, 18.00, 33.00, 33.00, 1.46);
INSERT INTO `tbl_venta_det` VALUES (808, 401, 1, 207, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (809, 401, 2, 230, 12.00, 1, 0.00, 12.00, 1.92, 1.92, 0.00, 18.00, 23.04, 23.04, 1.74);
INSERT INTO `tbl_venta_det` VALUES (810, 401, 4, 263, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 5.26);
INSERT INTO `tbl_venta_det` VALUES (811, 401, 6, 182, 0.00, 24, 2.00, 2.00, 5.00, 5.00, 0.00, 18.00, 10.00, 10.00, 3.95);
INSERT INTO `tbl_venta_det` VALUES (812, 401, 7, 473, 0.00, 1, 1.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (813, 401, 8, 413, 0.00, 1, 1.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 4.00);
INSERT INTO `tbl_venta_det` VALUES (814, 401, 9, 338, 0.00, 1, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 8.00);
INSERT INTO `tbl_venta_det` VALUES (815, 402, 1, 290, 0.00, 48, 12.00, 12.00, 1.96, 1.96, 0.00, 18.00, 23.50, 23.50, 1.80);
INSERT INTO `tbl_venta_det` VALUES (816, 402, 2, 352, 1.00, 1, 0.00, 1.00, 26.50, 26.50, 0.00, 18.00, 26.50, 26.50, 24.01);
INSERT INTO `tbl_venta_det` VALUES (817, 402, 3, 424, 1.00, 24, 0.00, 24.00, 1.25, 1.25, 0.00, 18.00, 30.00, 30.00, 1.16);
INSERT INTO `tbl_venta_det` VALUES (818, 402, 4, 189, 1.00, 18, 0.00, 18.00, 0.72, 0.72, 0.00, 18.00, 13.00, 13.00, 0.66);
INSERT INTO `tbl_venta_det` VALUES (819, 402, 5, 481, 1.00, 12, 0.00, 12.00, 4.42, 4.42, 0.00, 18.00, 53.00, 53.00, 3.99);
INSERT INTO `tbl_venta_det` VALUES (820, 402, 6, 260, 2.00, 10, 0.00, 20.00, 1.55, 1.55, 0.00, 18.00, 31.00, 31.00, 1.44);
INSERT INTO `tbl_venta_det` VALUES (821, 402, 7, 307, 1.00, 1, 0.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.80);
INSERT INTO `tbl_venta_det` VALUES (822, 402, 8, 271, 0.00, 1, 6.00, 6.00, 3.33, 3.33, 0.00, 18.00, 19.98, 19.98, 3.03);
INSERT INTO `tbl_venta_det` VALUES (823, 402, 9, 184, 0.00, 24, 6.00, 6.00, 3.75, 3.75, 0.00, 18.00, 22.50, 22.50, 3.42);
INSERT INTO `tbl_venta_det` VALUES (824, 402, 10, 178, 1.00, 24, 0.00, 24.00, 0.75, 0.75, 0.00, 18.00, 18.00, 18.00, 0.66);
INSERT INTO `tbl_venta_det` VALUES (825, 402, 11, 475, 1.00, 1, 0.00, 1.00, 15.50, 15.50, 0.00, 18.00, 15.50, 15.50, 14.00);
INSERT INTO `tbl_venta_det` VALUES (826, 402, 12, 207, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (827, 402, 13, 242, 1.00, 10, 0.00, 10.00, 1.85, 1.85, 0.00, 18.00, 18.50, 18.50, 1.70);
INSERT INTO `tbl_venta_det` VALUES (828, 402, 14, 458, 1.00, 1, 0.00, 1.00, 42.00, 42.00, 0.00, 18.00, 42.00, 42.00, 37.90);
INSERT INTO `tbl_venta_det` VALUES (829, 402, 15, 449, 0.00, 40, 12.00, 12.00, 1.88, 1.88, 0.00, 18.00, 22.50, 22.50, 1.75);
INSERT INTO `tbl_venta_det` VALUES (830, 402, 16, 200, 1.00, 60, 0.00, 60.00, 0.90, 0.90, 0.00, 18.00, 54.00, 54.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (831, 402, 17, 331, 0.00, 12, 6.00, 6.00, 5.17, 5.17, 0.00, 18.00, 31.00, 31.00, 4.83);
INSERT INTO `tbl_venta_det` VALUES (832, 402, 18, 366, 1.00, 15, 0.00, 15.00, 1.60, 1.60, 0.00, 18.00, 24.00, 24.00, 1.37);
INSERT INTO `tbl_venta_det` VALUES (833, 402, 19, 267, 1.00, 20, 0.00, 20.00, 1.03, 1.03, 0.00, 18.00, 20.50, 20.50, 0.93);
INSERT INTO `tbl_venta_det` VALUES (834, 402, 20, 233, 0.00, 1, 12.00, 12.00, 3.66, 3.66, 0.00, 18.00, 43.92, 43.92, 3.20);
INSERT INTO `tbl_venta_det` VALUES (835, 402, 21, 222, 1.00, 12, 0.00, 12.00, 0.67, 0.67, 0.00, 18.00, 8.00, 8.00, 0.56);
INSERT INTO `tbl_venta_det` VALUES (836, 402, 22, 349, 1.00, 1, 0.00, 1.00, 28.50, 28.50, 0.00, 18.00, 28.50, 28.50, 25.99);
INSERT INTO `tbl_venta_det` VALUES (837, 403, 1, 266, 1.00, 12, 0.00, 12.00, 8.29, 8.29, 0.00, 18.00, 99.50, 99.50, 7.89);
INSERT INTO `tbl_venta_det` VALUES (838, 403, 2, 326, 1.00, 10, 0.00, 10.00, 1.00, 1.00, 0.00, 18.00, 10.00, 10.00, 0.94);
INSERT INTO `tbl_venta_det` VALUES (839, 404, 1, 451, 0.00, 24, 6.00, 6.00, 1.50, 1.50, 0.00, 18.00, 216.00, 9.00, 1.36);
INSERT INTO `tbl_venta_det` VALUES (840, 405, 1, 448, 0.00, 40, 4.00, 4.00, 1.70, 1.70, 0.00, 18.00, 272.00, 6.80, 1.45);
INSERT INTO `tbl_venta_det` VALUES (841, 405, 2, 365, 0.00, 12, 2.00, 2.00, 3.00, 3.00, 0.00, 18.00, 72.00, 6.00, 2.25);
INSERT INTO `tbl_venta_det` VALUES (842, 405, 3, 200, 0.00, 60, 6.00, 6.00, 0.90, 0.90, 0.00, 18.00, 324.00, 5.40, 0.83);
INSERT INTO `tbl_venta_det` VALUES (843, 405, 4, 373, 0.00, 48, 3.00, 3.00, 2.20, 2.20, 0.00, 18.00, 316.80, 6.60, 2.00);
INSERT INTO `tbl_venta_det` VALUES (844, 405, 5, 319, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (845, 405, 6, 241, 0.00, 24, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 72.00, 3.00, 0.81);
INSERT INTO `tbl_venta_det` VALUES (846, 406, 1, 417, 0.00, 1, 1.00, 1.00, 22.00, 22.00, 0.00, 18.00, 22.00, 22.00, 20.00);
INSERT INTO `tbl_venta_det` VALUES (847, 407, 1, 377, 0.00, 18, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 36.00, 2.00, 0.92);
INSERT INTO `tbl_venta_det` VALUES (848, 407, 2, 428, 0.00, 100, 4.00, 4.00, 0.50, 0.50, 0.00, 18.00, 200.00, 2.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (849, 407, 3, 384, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 12.00, 1.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (850, 407, 4, 449, 0.00, 40, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 80.00, 2.00, 1.75);
INSERT INTO `tbl_venta_det` VALUES (851, 407, 5, 201, 0.00, 12, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 21.60, 1.80, 1.29);
INSERT INTO `tbl_venta_det` VALUES (852, 407, 6, 205, 0.00, 15, 0.50, 0.50, 6.00, 6.00, 0.00, 18.00, 45.00, 3.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (853, 408, 1, 449, 0.00, 40, 3.00, 3.00, 1.88, 1.88, 0.00, 18.00, 5.63, 5.63, 1.75);
INSERT INTO `tbl_venta_det` VALUES (854, 409, 1, 371, 0.00, 24, 18.00, 18.00, 1.17, 1.17, 0.00, 18.00, 21.00, 21.00, 1.04);
INSERT INTO `tbl_venta_det` VALUES (855, 410, 1, 371, 0.00, 24, 6.00, 6.00, 1.17, 1.17, 0.00, 18.00, 7.00, 7.00, 1.04);
INSERT INTO `tbl_venta_det` VALUES (856, 411, 1, 500, 0.00, 12, 6.00, 6.00, 2.04, 2.04, 0.00, 18.00, 12.25, 12.25, 1.80);
INSERT INTO `tbl_venta_det` VALUES (857, 411, 2, 387, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (858, 411, 3, 200, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 10.80, 10.80, 0.83);
INSERT INTO `tbl_venta_det` VALUES (859, 412, 1, 241, 1.00, 24, 0.00, 24.00, 0.92, 0.92, 0.00, 18.00, 22.00, 22.00, 0.81);
INSERT INTO `tbl_venta_det` VALUES (860, 412, 2, 515, 1.00, 48, 0.00, 48.00, 0.48, 0.48, 0.00, 18.00, 23.00, 23.00, 0.43);
INSERT INTO `tbl_venta_det` VALUES (861, 413, 2, 205, 0.00, 15, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 12.00, 12.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (862, 413, 3, 391, 1.00, 1, 0.00, 1.00, 17.00, 17.00, 0.00, 18.00, 17.00, 17.00, 15.45);
INSERT INTO `tbl_venta_det` VALUES (863, 414, 1, 483, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 66.00, 5.50, 4.27);
INSERT INTO `tbl_venta_det` VALUES (864, 414, 3, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 155.00, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (865, 414, 4, 340, 1.00, 1, 0.00, 1.00, 22.00, 22.00, 0.00, 18.00, 22.00, 22.00, 18.80);
INSERT INTO `tbl_venta_det` VALUES (866, 414, 5, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 66.00, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (867, 414, 6, 516, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 30.00, 2.50, 1.90);
INSERT INTO `tbl_venta_det` VALUES (868, 414, 7, 400, 0.00, 1, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.00);
INSERT INTO `tbl_venta_det` VALUES (869, 415, 1, 273, 1.00, 15, 0.00, 15.00, 1.87, 1.87, 0.00, 18.00, 28.00, 28.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (870, 415, 3, 455, 0.00, 6, 2.00, 2.00, 6.50, 6.50, 0.00, 18.00, 13.00, 13.00, 6.05);
INSERT INTO `tbl_venta_det` VALUES (871, 416, 1, 499, 0.00, 1, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 2.20);
INSERT INTO `tbl_venta_det` VALUES (872, 417, 1, 433, 0.00, 20, 1.00, 1.00, 0.60, 0.60, 0.00, 18.00, 12.00, 0.60, 0.46);
INSERT INTO `tbl_venta_det` VALUES (873, 417, 2, 310, 0.00, 8, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 8.00, 1.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (874, 417, 3, 508, 0.00, 24, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 24.00, 1.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (875, 417, 4, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 155.00, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (876, 417, 5, 319, 0.00, 1, 0.50, 0.50, 6.00, 6.00, 0.00, 18.00, 3.00, 3.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (877, 417, 6, 205, 0.00, 15, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 180.00, 12.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (878, 418, 1, 330, 2.00, 8, 0.00, 16.00, 0.94, 0.94, 0.00, 18.00, 15.00, 15.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (879, 418, 2, 315, 0.00, 60, 6.00, 6.00, 1.25, 1.25, 0.00, 18.00, 7.50, 7.50, 1.15);
INSERT INTO `tbl_venta_det` VALUES (880, 418, 3, 200, 0.00, 60, 6.00, 6.00, 0.90, 0.90, 0.00, 18.00, 5.40, 5.40, 0.83);
INSERT INTO `tbl_venta_det` VALUES (881, 418, 5, 290, 0.00, 48, 6.00, 6.00, 1.96, 1.96, 0.00, 18.00, 11.75, 11.75, 1.80);
INSERT INTO `tbl_venta_det` VALUES (882, 418, 6, 266, 0.00, 12, 3.00, 3.00, 8.29, 8.29, 0.00, 18.00, 24.88, 24.88, 7.89);
INSERT INTO `tbl_venta_det` VALUES (883, 418, 7, 508, 0.00, 24, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 1.00, 1.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (884, 418, 9, 248, 0.00, 50, 3.00, 3.00, 4.00, 4.00, 0.00, 18.00, 12.00, 12.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (885, 418, 11, 336, 0.00, 1, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.80);
INSERT INTO `tbl_venta_det` VALUES (886, 419, 1, 205, 0.00, 15, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (887, 419, 2, 289, 0.00, 12, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 3.00, 3.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (888, 419, 3, 200, 0.00, 60, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (889, 419, 4, 399, 0.00, 10, 4.00, 4.00, 0.25, 0.25, 0.00, 18.00, 1.00, 1.00, 0.18);
INSERT INTO `tbl_venta_det` VALUES (890, 420, 1, 190, 0.00, 48, 12.00, 12.00, 1.67, 1.67, 0.00, 18.00, 20.00, 20.00, 1.54);
INSERT INTO `tbl_venta_det` VALUES (891, 420, 2, 347, 1.00, 1, 1.00, 2.00, 10.00, 10.00, 0.00, 18.00, 20.00, 20.00, 8.97);
INSERT INTO `tbl_venta_det` VALUES (892, 420, 4, 373, 0.00, 48, 4.00, 4.00, 2.30, 2.30, 0.00, 18.00, 9.20, 9.20, 2.18);
INSERT INTO `tbl_venta_det` VALUES (893, 421, 1, 224, 0.00, 12, 3.00, 3.00, 9.00, 9.00, 0.00, 18.00, 27.00, 27.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (894, 421, 2, 194, 0.00, 1, 3.00, 3.00, 4.00, 4.00, 0.00, 18.00, 12.00, 12.00, 3.37);
INSERT INTO `tbl_venta_det` VALUES (895, 421, 3, 453, 0.00, 6, 2.00, 2.00, 1.50, 1.50, 0.00, 18.00, 3.00, 3.00, 1.28);
INSERT INTO `tbl_venta_det` VALUES (896, 422, 1, 239, 0.00, 50, 15.00, 15.00, 3.20, 3.20, 0.00, 18.00, 48.00, 48.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (897, 422, 2, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (898, 422, 3, 266, 0.00, 12, 6.00, 6.00, 8.29, 8.29, 0.00, 18.00, 49.75, 49.75, 7.89);
INSERT INTO `tbl_venta_det` VALUES (899, 422, 4, 207, 0.00, 12, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (900, 422, 5, 362, 0.00, 1, 2.00, 2.00, 6.50, 6.50, 0.00, 18.00, 13.00, 13.00, 6.00);
INSERT INTO `tbl_venta_det` VALUES (901, 423, 1, 239, 0.00, 50, 2.00, 2.00, 3.20, 3.20, 0.00, 18.00, 6.40, 6.40, 2.76);
INSERT INTO `tbl_venta_det` VALUES (902, 423, 2, 266, 0.00, 12, 1.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.89);
INSERT INTO `tbl_venta_det` VALUES (903, 424, 1, 446, 0.00, 12, 3.00, 3.00, 9.33, 9.33, 0.00, 18.00, 28.00, 28.00, 8.75);
INSERT INTO `tbl_venta_det` VALUES (904, 424, 2, 239, 0.00, 50, 10.00, 10.00, 3.20, 3.20, 0.00, 18.00, 32.00, 32.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (905, 424, 3, 227, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 15.50);
INSERT INTO `tbl_venta_det` VALUES (906, 425, 1, 497, 1.00, 15, 0.00, 15.00, 0.73, 0.73, 0.00, 18.00, 11.00, 11.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (907, 425, 2, 379, 1.00, 12, 0.00, 12.00, 0.79, 0.79, 0.00, 18.00, 9.50, 9.50, 0.67);
INSERT INTO `tbl_venta_det` VALUES (908, 425, 3, 330, 1.00, 8, 0.00, 8.00, 0.94, 0.94, 0.00, 18.00, 7.50, 7.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (909, 426, 1, 374, 0.00, 12, 6.00, 6.00, 0.92, 0.92, 0.00, 18.00, 5.50, 5.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (910, 427, 1, 176, 0.00, 25, 1.00, 1.00, 1.50, 1.50, 0.00, 18.00, 1.50, 1.50, 1.07);
INSERT INTO `tbl_venta_det` VALUES (911, 427, 2, 283, 0.00, 40, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.86);
INSERT INTO `tbl_venta_det` VALUES (912, 428, 1, 483, 0.00, 12, 6.00, 6.00, 4.71, 4.71, 0.00, 18.00, 28.25, 28.25, 4.27);
INSERT INTO `tbl_venta_det` VALUES (913, 428, 2, 274, 0.00, 60, 12.00, 12.00, 2.33, 2.33, 0.00, 18.00, 28.00, 28.00, 2.08);
INSERT INTO `tbl_venta_det` VALUES (914, 428, 3, 290, 0.00, 48, 12.00, 12.00, 1.96, 1.96, 0.00, 18.00, 23.50, 23.50, 1.80);
INSERT INTO `tbl_venta_det` VALUES (915, 428, 4, 445, 0.00, 24, 6.00, 6.00, 5.33, 5.33, 0.00, 18.00, 32.00, 32.00, 5.03);
INSERT INTO `tbl_venta_det` VALUES (916, 428, 5, 431, 0.00, 12, 6.00, 6.00, 4.33, 4.33, 0.00, 18.00, 26.00, 26.00, 3.90);
INSERT INTO `tbl_venta_det` VALUES (917, 428, 6, 184, 0.00, 24, 6.00, 6.00, 3.75, 3.75, 0.00, 18.00, 22.50, 22.50, 3.42);
INSERT INTO `tbl_venta_det` VALUES (918, 428, 7, 399, 8.00, 10, 0.00, 80.00, 0.19, 0.19, 0.00, 18.00, 15.52, 15.52, 0.18);
INSERT INTO `tbl_venta_det` VALUES (919, 428, 8, 364, 0.00, 24, 12.00, 12.00, 1.21, 1.21, 0.00, 18.00, 14.50, 14.50, 1.13);
INSERT INTO `tbl_venta_det` VALUES (920, 428, 9, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (921, 428, 10, 436, 0.00, 60, 12.00, 12.00, 2.38, 2.38, 0.00, 18.00, 28.50, 28.50, 2.17);
INSERT INTO `tbl_venta_det` VALUES (922, 428, 11, 200, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 10.80, 10.80, 0.83);
INSERT INTO `tbl_venta_det` VALUES (923, 428, 12, 462, 0.00, 60, 12.00, 12.00, 1.12, 1.12, 0.00, 18.00, 13.40, 13.40, 1.05);
INSERT INTO `tbl_venta_det` VALUES (924, 428, 13, 287, 0.00, 40, 12.00, 12.00, 1.38, 1.38, 0.00, 18.00, 16.50, 16.50, 1.25);
INSERT INTO `tbl_venta_det` VALUES (925, 428, 14, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (926, 428, 15, 460, 1.00, 1, 0.00, 1.00, 15.00, 15.00, 0.00, 18.00, 15.00, 15.00, 13.35);
INSERT INTO `tbl_venta_det` VALUES (927, 428, 16, 321, 1.00, 12, 0.00, 12.00, 0.96, 0.96, 0.00, 18.00, 11.50, 11.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (928, 428, 17, 387, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (929, 428, 18, 370, 1.00, 1, 0.00, 1.00, 31.00, 31.00, 0.00, 18.00, 31.00, 31.00, 27.80);
INSERT INTO `tbl_venta_det` VALUES (930, 428, 19, 478, 0.00, 12, 12.00, 12.00, 1.92, 1.92, 0.00, 18.00, 23.00, 23.00, 1.50);
INSERT INTO `tbl_venta_det` VALUES (931, 429, 1, 372, 1.00, 16, 0.00, 16.00, 1.00, 1.00, 0.00, 18.00, 16.00, 16.00, 0.93);
INSERT INTO `tbl_venta_det` VALUES (932, 429, 2, 304, 1.00, 1, 0.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 3.91);
INSERT INTO `tbl_venta_det` VALUES (933, 429, 3, 482, 1.00, 12, 0.00, 12.00, 1.33, 1.33, 0.00, 18.00, 16.00, 16.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (934, 429, 5, 229, 0.00, 216, 12.00, 12.00, 0.50, 0.50, 0.00, 18.00, 6.00, 6.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (935, 429, 6, 262, 1.00, 1, 0.00, 1.00, 8.00, 8.00, 0.00, 18.00, 8.00, 8.00, 6.80);
INSERT INTO `tbl_venta_det` VALUES (936, 430, 1, 339, 5.00, 1, 0.00, 5.00, 4.50, 4.50, 0.00, 18.00, 22.50, 22.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (937, 430, 2, 412, 4.00, 1, 0.00, 4.00, 5.00, 5.00, 0.00, 18.00, 20.00, 20.00, 4.75);
INSERT INTO `tbl_venta_det` VALUES (938, 430, 3, 515, 0.00, 48, 24.00, 24.00, 0.48, 0.48, 0.00, 18.00, 11.50, 11.50, 0.43);
INSERT INTO `tbl_venta_det` VALUES (939, 431, 1, 192, 0.00, 48, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 10.00, 10.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (940, 431, 2, 501, 0.00, 1, 2.00, 2.00, 8.50, 8.50, 0.00, 18.00, 17.00, 17.00, 7.77);
INSERT INTO `tbl_venta_det` VALUES (941, 431, 5, 353, 0.00, 20, 3.00, 3.00, 2.00, 2.00, 0.00, 18.00, 6.00, 6.00, 1.65);
INSERT INTO `tbl_venta_det` VALUES (942, 431, 6, 283, 0.00, 40, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 3.00, 3.00, 0.86);
INSERT INTO `tbl_venta_det` VALUES (943, 431, 7, 392, 0.00, 1, 1.00, 1.00, 17.00, 17.00, 0.00, 18.00, 17.00, 17.00, 15.45);
INSERT INTO `tbl_venta_det` VALUES (944, 432, 3, 443, 0.00, 12, 3.00, 3.00, 4.58, 4.58, 0.00, 18.00, 165.00, 13.75, 4.33);
INSERT INTO `tbl_venta_det` VALUES (945, 433, 1, 281, 0.00, 30, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.19);
INSERT INTO `tbl_venta_det` VALUES (946, 433, 2, 321, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (947, 433, 3, 200, 0.00, 60, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (948, 433, 4, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (949, 433, 5, 271, 0.00, 1, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.03);
INSERT INTO `tbl_venta_det` VALUES (950, 433, 6, 216, 0.00, 24, 1.00, 1.00, 1.50, 1.50, 0.00, 18.00, 1.50, 1.50, 1.14);
INSERT INTO `tbl_venta_det` VALUES (951, 433, 7, 353, 0.00, 20, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.65);
INSERT INTO `tbl_venta_det` VALUES (952, 434, 1, 299, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.38);
INSERT INTO `tbl_venta_det` VALUES (953, 434, 2, 440, 0.00, 1, 1.00, 1.00, 11.00, 11.00, 0.00, 18.00, 11.00, 11.00, 9.82);
INSERT INTO `tbl_venta_det` VALUES (954, 434, 3, 433, 0.00, 20, 4.00, 4.00, 0.60, 0.60, 0.00, 18.00, 2.40, 2.40, 0.46);
INSERT INTO `tbl_venta_det` VALUES (955, 434, 4, 298, 0.00, 24, 1.00, 1.00, 3.80, 3.80, 0.00, 18.00, 3.80, 3.80, 3.44);
INSERT INTO `tbl_venta_det` VALUES (956, 434, 5, 275, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.42);
INSERT INTO `tbl_venta_det` VALUES (957, 434, 6, 508, 0.00, 24, 1.00, 1.00, 0.50, 0.50, 0.00, 18.00, 0.50, 0.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (958, 434, 7, 384, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (959, 434, 9, 497, 0.00, 15, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (960, 435, 1, 331, 0.00, 12, 3.00, 3.00, 5.17, 5.17, 0.00, 18.00, 15.50, 15.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (961, 435, 2, 311, 0.00, 48, 6.00, 6.00, 2.60, 2.60, 0.00, 18.00, 15.63, 15.63, 2.40);
INSERT INTO `tbl_venta_det` VALUES (962, 435, 3, 342, 0.00, 40, 6.00, 6.00, 2.05, 2.05, 0.00, 18.00, 12.30, 12.30, 1.95);
INSERT INTO `tbl_venta_det` VALUES (963, 435, 4, 500, 0.00, 12, 6.00, 6.00, 2.04, 2.04, 0.00, 18.00, 12.25, 12.25, 1.80);
INSERT INTO `tbl_venta_det` VALUES (964, 435, 5, 434, 0.00, 1, 0.50, 0.50, 9.00, 9.00, 0.00, 18.00, 4.50, 4.50, 7.20);
INSERT INTO `tbl_venta_det` VALUES (965, 436, 2, 316, 0.00, 1, 2.00, 2.00, 4.00, 4.00, 0.00, 18.00, 8.00, 8.00, 3.31);
INSERT INTO `tbl_venta_det` VALUES (966, 437, 1, 340, 1.00, 1, 1.00, 2.00, 22.00, 22.00, 0.00, 18.00, 44.00, 44.00, 18.80);
INSERT INTO `tbl_venta_det` VALUES (967, 438, 1, 286, 2.00, 40, 0.00, 80.00, 0.24, 0.24, 0.00, 18.00, 760.00, 19.00, 0.21);
INSERT INTO `tbl_venta_det` VALUES (968, 439, 1, 420, 0.00, 5, 1.50, 1.50, 7.50, 7.50, 0.00, 18.00, 56.25, 11.25, 6.67);
INSERT INTO `tbl_venta_det` VALUES (969, 440, 3, 508, 1.00, 24, 0.00, 24.00, 0.27, 0.27, 0.00, 18.00, 6.50, 6.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (970, 440, 4, 308, 1.00, 1, 0.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.00);
INSERT INTO `tbl_venta_det` VALUES (971, 440, 5, 380, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.67);
INSERT INTO `tbl_venta_det` VALUES (972, 440, 7, 497, 0.00, 15, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (973, 441, 1, 430, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.10);
INSERT INTO `tbl_venta_det` VALUES (974, 441, 2, 239, 0.00, 50, 5.00, 5.00, 2.90, 2.90, 0.00, 18.00, 14.50, 14.50, 2.76);
INSERT INTO `tbl_venta_det` VALUES (975, 442, 1, 342, 0.00, 40, 20.00, 20.00, 2.05, 2.05, 0.00, 18.00, 41.00, 41.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (976, 443, 1, 349, 1.00, 1, 0.00, 1.00, 28.50, 28.50, 0.00, 18.00, 28.50, 28.50, 25.99);
INSERT INTO `tbl_venta_det` VALUES (977, 444, 1, 249, 0.00, 20, 1.00, 1.00, 8.90, 8.90, 0.00, 18.00, 8.90, 8.90, 8.57);
INSERT INTO `tbl_venta_det` VALUES (978, 444, 2, 405, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.67);
INSERT INTO `tbl_venta_det` VALUES (979, 444, 3, 229, 0.00, 216, 6.00, 6.00, 0.50, 0.50, 0.00, 18.00, 3.00, 3.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (980, 444, 4, 428, 0.00, 100, 9.00, 9.00, 0.50, 0.50, 0.00, 18.00, 4.50, 4.50, 0.39);
INSERT INTO `tbl_venta_det` VALUES (981, 444, 5, 286, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (982, 444, 6, 250, 0.00, 20, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.43);
INSERT INTO `tbl_venta_det` VALUES (983, 444, 7, 239, 0.00, 50, 5.00, 5.00, 3.20, 3.20, 0.00, 18.00, 16.00, 16.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (984, 445, 1, 297, 1.00, 20, 0.00, 20.00, 1.65, 1.65, 0.00, 18.00, 33.00, 33.00, 1.46);
INSERT INTO `tbl_venta_det` VALUES (985, 446, 1, 525, 1.00, 1, 0.00, 1.00, 15.50, 15.50, 0.00, 18.00, 15.50, 15.50, 13.50);
INSERT INTO `tbl_venta_det` VALUES (986, 447, 1, 349, 1.00, 1, 0.00, 1.00, 28.50, 28.50, 0.00, 18.00, 28.50, 28.50, 25.99);
INSERT INTO `tbl_venta_det` VALUES (987, 448, 1, 214, 0.00, 24, 6.00, 6.00, 3.67, 3.67, 0.00, 18.00, 22.00, 22.00, 3.44);
INSERT INTO `tbl_venta_det` VALUES (988, 449, 3, 315, 0.00, 60, 6.00, 6.00, 1.25, 1.25, 0.00, 18.00, 7.50, 7.50, 1.15);
INSERT INTO `tbl_venta_det` VALUES (989, 449, 4, 388, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (990, 449, 5, 350, 0.00, 20, 4.00, 4.00, 1.20, 1.20, 0.00, 18.00, 4.80, 4.80, 0.96);
INSERT INTO `tbl_venta_det` VALUES (991, 450, 1, 402, 1.00, 1, 0.00, 1.00, 20.00, 20.00, 0.00, 18.00, 20.00, 20.00, 17.71);
INSERT INTO `tbl_venta_det` VALUES (992, 450, 3, 448, 0.00, 40, 6.00, 6.00, 1.58, 1.58, 0.00, 18.00, 9.45, 9.45, 1.45);
INSERT INTO `tbl_venta_det` VALUES (993, 451, 1, 190, 0.00, 48, 12.00, 12.00, 1.67, 1.67, 0.00, 18.00, 20.00, 20.00, 1.54);
INSERT INTO `tbl_venta_det` VALUES (994, 451, 3, 192, 0.00, 48, 6.00, 6.00, 3.33, 3.33, 0.00, 18.00, 20.00, 20.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (995, 451, 5, 182, 0.00, 24, 6.00, 6.00, 4.58, 4.58, 0.00, 18.00, 27.50, 27.50, 3.95);
INSERT INTO `tbl_venta_det` VALUES (996, 451, 6, 484, 0.00, 12, 6.00, 6.00, 2.83, 2.83, 0.00, 18.00, 17.00, 17.00, 2.56);
INSERT INTO `tbl_venta_det` VALUES (997, 452, 2, 372, 0.00, 16, 3.00, 3.00, 1.20, 1.20, 0.00, 18.00, 3.60, 3.60, 0.93);
INSERT INTO `tbl_venta_det` VALUES (998, 452, 3, 497, 0.00, 15, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (999, 452, 4, 340, 1.00, 1, 0.00, 1.00, 22.00, 22.00, 0.00, 18.00, 22.00, 22.00, 18.80);
INSERT INTO `tbl_venta_det` VALUES (1000, 452, 5, 325, 0.00, 4, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 3.00, 3.00, 2.38);
INSERT INTO `tbl_venta_det` VALUES (1001, 452, 6, 484, 0.00, 12, 2.00, 2.00, 3.00, 3.00, 0.00, 18.00, 6.00, 6.00, 2.56);
INSERT INTO `tbl_venta_det` VALUES (1002, 452, 8, 436, 0.00, 60, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 2.17);
INSERT INTO `tbl_venta_det` VALUES (1003, 452, 9, 357, 0.00, 12, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 3.00, 3.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1004, 452, 10, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1005, 452, 11, 230, 0.00, 1, 6.00, 6.00, 1.92, 1.92, 0.00, 18.00, 11.52, 11.52, 1.74);
INSERT INTO `tbl_venta_det` VALUES (1006, 453, 1, 341, 0.00, 24, 12.00, 12.00, 2.58, 2.58, 0.00, 18.00, 31.00, 31.00, 2.33);
INSERT INTO `tbl_venta_det` VALUES (1007, 454, 1, 477, 1.00, 18, 0.00, 18.00, 0.53, 0.53, 0.00, 18.00, 171.00, 9.50, 0.40);
INSERT INTO `tbl_venta_det` VALUES (1008, 454, 2, 318, 1.00, 1, 0.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.81);
INSERT INTO `tbl_venta_det` VALUES (1009, 455, 1, 508, 0.00, 24, 1.00, 1.00, 0.50, 0.50, 0.00, 18.00, 12.00, 0.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1010, 455, 2, 200, 0.00, 60, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 120.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1011, 455, 3, 234, 2.00, 1, 0.00, 2.00, 6.00, 6.00, 0.00, 18.00, 12.00, 12.00, 5.14);
INSERT INTO `tbl_venta_det` VALUES (1012, 455, 4, 200, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 648.00, 10.80, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1013, 456, 5, 462, 1.00, 60, 0.00, 60.00, 1.12, 1.12, 0.00, 18.00, 67.00, 67.00, 1.05);
INSERT INTO `tbl_venta_det` VALUES (1014, 456, 6, 289, 2.00, 12, 0.00, 24.00, 0.83, 0.83, 0.00, 18.00, 20.00, 20.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1015, 456, 7, 203, 1.00, 24, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (1016, 457, 1, 190, 0.00, 48, 12.00, 12.00, 1.67, 1.67, 0.00, 18.00, 20.00, 20.00, 1.54);
INSERT INTO `tbl_venta_det` VALUES (1017, 458, 1, 373, 0.00, 48, 6.00, 6.00, 2.27, 2.27, 0.00, 18.00, 13.63, 13.63, 2.18);
INSERT INTO `tbl_venta_det` VALUES (1018, 459, 1, 255, 0.00, 20, 10.00, 10.00, 1.90, 1.90, 0.00, 18.00, 19.00, 19.00, 1.72);
INSERT INTO `tbl_venta_det` VALUES (1019, 459, 2, 284, 0.00, 20, 10.00, 10.00, 0.95, 0.95, 0.00, 18.00, 9.50, 9.50, 0.86);
INSERT INTO `tbl_venta_det` VALUES (1020, 459, 3, 327, 1.00, 10, 0.00, 10.00, 1.00, 1.00, 0.00, 18.00, 10.00, 10.00, 0.94);
INSERT INTO `tbl_venta_det` VALUES (1021, 459, 4, 289, 2.00, 12, 0.00, 24.00, 0.83, 0.83, 0.00, 18.00, 20.00, 20.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1022, 460, 1, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1023, 460, 2, 200, 0.00, 60, 5.00, 5.00, 1.00, 1.00, 0.00, 18.00, 5.00, 5.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1024, 461, 1, 445, 0.00, 24, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 5.03);
INSERT INTO `tbl_venta_det` VALUES (1025, 461, 2, 399, 0.00, 10, 6.00, 6.00, 0.25, 0.25, 0.00, 18.00, 1.50, 1.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1026, 461, 3, 248, 0.00, 50, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1027, 461, 4, 239, 0.00, 50, 4.00, 4.00, 3.20, 3.20, 0.00, 18.00, 12.80, 12.80, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1028, 461, 5, 250, 0.00, 20, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.43);
INSERT INTO `tbl_venta_det` VALUES (1029, 461, 6, 200, 0.00, 60, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1030, 461, 7, 203, 0.00, 24, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (1031, 462, 2, 332, 2.00, 12, 0.00, 24.00, 0.83, 0.83, 0.00, 18.00, 20.00, 20.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (1032, 463, 2, 200, 1.00, 60, 0.00, 60.00, 0.90, 0.90, 0.00, 18.00, 54.00, 54.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1033, 463, 3, 203, 1.00, 24, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (1034, 464, 1, 239, 0.00, 50, 25.00, 25.00, 2.90, 2.90, 0.00, 18.00, 72.50, 72.50, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1035, 465, 2, 211, 1.00, 1, 0.00, 1.00, 7.50, 7.50, 0.00, 18.00, 7.50, 7.50, 6.37);
INSERT INTO `tbl_venta_det` VALUES (1036, 465, 3, 462, 0.00, 60, 24.00, 24.00, 1.12, 1.12, 0.00, 18.00, 26.80, 26.80, 1.05);
INSERT INTO `tbl_venta_det` VALUES (1037, 465, 4, 296, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 1.56);
INSERT INTO `tbl_venta_det` VALUES (1038, 465, 5, 375, 1.00, 1, 0.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.69);
INSERT INTO `tbl_venta_det` VALUES (1039, 465, 6, 369, 1.00, 20, 0.00, 20.00, 0.50, 0.50, 0.00, 18.00, 10.00, 10.00, 0.43);
INSERT INTO `tbl_venta_det` VALUES (1040, 466, 1, 472, 1.00, 1, 1.00, 2.00, 4.50, 4.50, 0.00, 18.00, 9.00, 9.00, 3.80);
INSERT INTO `tbl_venta_det` VALUES (1041, 467, 1, 399, 2.00, 10, 0.00, 20.00, 0.25, 0.25, 0.00, 18.00, 5.00, 5.00, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1042, 467, 2, 350, 0.00, 20, 3.00, 3.00, 1.20, 1.20, 0.00, 18.00, 3.60, 3.60, 0.96);
INSERT INTO `tbl_venta_det` VALUES (1043, 468, 1, 453, 0.00, 6, 6.00, 6.00, 1.42, 1.42, 0.00, 18.00, 51.00, 8.50, 1.28);
INSERT INTO `tbl_venta_det` VALUES (1044, 468, 2, 337, 0.00, 1, 0.50, 0.50, 5.50, 5.50, 0.00, 18.00, 2.75, 2.75, 4.44);
INSERT INTO `tbl_venta_det` VALUES (1045, 468, 3, 499, 0.00, 1, 9.00, 9.00, 2.50, 2.50, 0.00, 18.00, 22.50, 22.50, 2.20);
INSERT INTO `tbl_venta_det` VALUES (1046, 468, 4, 481, 0.00, 12, 1.00, 1.00, 5.00, 5.00, 0.00, 18.00, 60.00, 5.00, 3.99);
INSERT INTO `tbl_venta_det` VALUES (1047, 469, 1, 448, 0.00, 40, 3.00, 3.00, 1.58, 1.58, 0.00, 18.00, 4.73, 4.73, 1.45);
INSERT INTO `tbl_venta_det` VALUES (1048, 469, 2, 521, 1.00, 1, 0.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.00);
INSERT INTO `tbl_venta_det` VALUES (1049, 469, 4, 508, 0.00, 24, 1.00, 1.00, 0.50, 0.50, 0.00, 18.00, 0.50, 0.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1050, 469, 5, 228, 0.00, 24, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 3.00, 3.00, 2.63);
INSERT INTO `tbl_venta_det` VALUES (1051, 470, 1, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1052, 470, 2, 497, 0.00, 15, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (1053, 471, 1, 482, 1.00, 12, 0.00, 12.00, 1.33, 1.33, 0.00, 18.00, 16.00, 16.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (1054, 471, 2, 268, 0.00, 55, 3.00, 3.00, 0.50, 0.50, 0.00, 18.00, 1.50, 1.50, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1055, 471, 3, 416, 0.00, 50, 1.00, 1.00, 0.50, 0.50, 0.00, 18.00, 0.50, 0.50, 0.41);
INSERT INTO `tbl_venta_det` VALUES (1056, 471, 5, 498, 0.00, 1, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 2.20);
INSERT INTO `tbl_venta_det` VALUES (1057, 471, 6, 364, 0.00, 24, 1.00, 1.00, 1.30, 1.30, 0.00, 18.00, 1.30, 1.30, 1.13);
INSERT INTO `tbl_venta_det` VALUES (1058, 471, 7, 497, 0.00, 15, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (1059, 472, 1, 331, 1.00, 12, 0.00, 12.00, 5.17, 5.17, 0.00, 18.00, 62.00, 62.00, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1060, 473, 2, 372, 1.00, 16, 0.00, 16.00, 1.00, 1.00, 0.00, 18.00, 16.00, 16.00, 0.93);
INSERT INTO `tbl_venta_det` VALUES (1061, 473, 3, 432, 0.00, 30, 15.00, 15.00, 0.40, 0.40, 0.00, 18.00, 6.00, 6.00, 0.35);
INSERT INTO `tbl_venta_det` VALUES (1062, 474, 1, 208, 0.00, 1, 1.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.00);
INSERT INTO `tbl_venta_det` VALUES (1063, 474, 2, 348, 0.00, 1, 1.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.47);
INSERT INTO `tbl_venta_det` VALUES (1064, 475, 1, 286, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1065, 475, 2, 229, 0.00, 216, 18.00, 18.00, 0.50, 0.50, 0.00, 18.00, 9.00, 9.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1066, 475, 3, 295, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.78);
INSERT INTO `tbl_venta_det` VALUES (1067, 475, 4, 202, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.33);
INSERT INTO `tbl_venta_det` VALUES (1068, 476, 1, 315, 0.00, 60, 3.00, 3.00, 1.25, 1.25, 0.00, 18.00, 225.00, 3.75, 1.15);
INSERT INTO `tbl_venta_det` VALUES (1069, 476, 2, 200, 0.00, 60, 3.00, 3.00, 0.90, 0.90, 0.00, 18.00, 162.00, 2.70, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1070, 476, 3, 221, 0.00, 60, 3.00, 3.00, 1.58, 1.58, 0.00, 18.00, 284.97, 4.75, 1.40);
INSERT INTO `tbl_venta_det` VALUES (1071, 476, 4, 273, 0.00, 15, 3.00, 3.00, 1.87, 1.87, 0.00, 18.00, 84.00, 5.60, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1072, 476, 5, 267, 0.00, 20, 3.00, 3.00, 1.03, 1.03, 0.00, 18.00, 61.50, 3.08, 0.93);
INSERT INTO `tbl_venta_det` VALUES (1073, 477, 1, 197, 1.00, 1, 0.00, 1.00, 85.00, 85.00, 0.00, 18.00, 85.00, 85.00, 81.00);
INSERT INTO `tbl_venta_det` VALUES (1074, 478, 4, 332, 0.00, 12, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 36.00, 3.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (1075, 478, 5, 246, 0.00, 24, 3.00, 3.00, 1.50, 1.50, 0.00, 18.00, 108.00, 4.50, 1.16);
INSERT INTO `tbl_venta_det` VALUES (1076, 479, 1, 192, 0.00, 48, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 10.00, 10.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (1077, 479, 2, 319, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (1078, 479, 3, 238, 0.00, 15, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 12.00, 12.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1079, 480, 1, 239, 1.00, 50, 0.00, 50.00, 2.90, 2.90, 0.00, 18.00, 145.00, 145.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1080, 481, 1, 273, 0.00, 15, 2.00, 2.00, 2.00, 2.00, 0.00, 18.00, 60.00, 4.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1081, 481, 2, 315, 0.00, 60, 1.00, 1.00, 1.50, 1.50, 0.00, 18.00, 90.00, 1.50, 1.15);
INSERT INTO `tbl_venta_det` VALUES (1082, 481, 3, 468, 0.00, 1, 1.00, 1.00, 7.00, 7.00, 0.00, 18.00, 7.00, 7.00, 6.50);
INSERT INTO `tbl_venta_det` VALUES (1083, 481, 4, 387, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 24.00, 2.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1084, 481, 5, 289, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 24.00, 2.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1085, 481, 6, 277, 0.00, 48, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 86.40, 1.80, 1.52);
INSERT INTO `tbl_venta_det` VALUES (1086, 482, 1, 255, 0.00, 20, 4.00, 4.00, 2.00, 2.00, 0.00, 18.00, 8.00, 8.00, 1.72);
INSERT INTO `tbl_venta_det` VALUES (1087, 482, 2, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1088, 482, 3, 239, 0.00, 50, 25.00, 25.00, 2.90, 2.90, 0.00, 18.00, 72.50, 72.50, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1089, 482, 4, 266, 0.00, 12, 6.00, 6.00, 8.29, 8.29, 0.00, 18.00, 49.75, 49.75, 7.89);
INSERT INTO `tbl_venta_det` VALUES (1090, 483, 1, 299, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.38);
INSERT INTO `tbl_venta_det` VALUES (1091, 483, 2, 508, 0.00, 24, 3.00, 3.00, 0.50, 0.50, 0.00, 18.00, 36.00, 1.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1092, 483, 3, 305, 0.00, 12, 1.00, 1.00, 1.20, 1.20, 0.00, 18.00, 14.40, 1.20, 0.99);
INSERT INTO `tbl_venta_det` VALUES (1093, 483, 4, 214, 0.00, 24, 6.00, 6.00, 3.67, 3.67, 0.00, 18.00, 528.00, 22.00, 3.44);
INSERT INTO `tbl_venta_det` VALUES (1094, 483, 6, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 66.00, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1095, 483, 7, 497, 0.00, 15, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 15.00, 1.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (1096, 483, 8, 235, 0.00, 40, 8.00, 8.00, 0.38, 0.38, 0.00, 18.00, 120.00, 3.00, 0.34);
INSERT INTO `tbl_venta_det` VALUES (1097, 484, 1, 221, 0.00, 60, 6.00, 6.00, 1.58, 1.58, 0.00, 18.00, 9.50, 9.50, 1.40);
INSERT INTO `tbl_venta_det` VALUES (1098, 484, 4, 230, 0.00, 1, 6.00, 6.00, 1.92, 1.92, 0.00, 18.00, 11.52, 11.52, 1.74);
INSERT INTO `tbl_venta_det` VALUES (1099, 484, 5, 434, 0.00, 1, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 7.20);
INSERT INTO `tbl_venta_det` VALUES (1100, 484, 6, 278, 0.00, 24, 3.00, 3.00, 2.88, 2.88, 0.00, 18.00, 8.63, 8.63, 2.67);
INSERT INTO `tbl_venta_det` VALUES (1101, 484, 7, 319, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (1102, 484, 8, 248, 0.00, 50, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1103, 484, 10, 405, 0.00, 12, 2.00, 2.00, 3.50, 3.50, 0.00, 18.00, 7.00, 7.00, 2.67);
INSERT INTO `tbl_venta_det` VALUES (1104, 485, 1, 221, 0.00, 60, 6.00, 6.00, 1.58, 1.58, 0.00, 18.00, 9.50, 9.50, 1.40);
INSERT INTO `tbl_venta_det` VALUES (1105, 485, 4, 230, 0.00, 1, 6.00, 6.00, 1.92, 1.92, 0.00, 18.00, 11.52, 11.52, 1.74);
INSERT INTO `tbl_venta_det` VALUES (1106, 485, 5, 434, 0.00, 1, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 7.20);
INSERT INTO `tbl_venta_det` VALUES (1107, 485, 6, 278, 0.00, 24, 3.00, 3.00, 2.88, 2.88, 0.00, 18.00, 8.63, 8.63, 2.67);
INSERT INTO `tbl_venta_det` VALUES (1108, 485, 7, 319, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (1109, 485, 8, 248, 0.00, 50, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1110, 485, 10, 405, 0.00, 12, 2.00, 2.00, 3.50, 3.50, 0.00, 18.00, 7.00, 7.00, 2.67);
INSERT INTO `tbl_venta_det` VALUES (1111, 486, 1, 462, 0.00, 60, 6.00, 6.00, 1.12, 1.12, 0.00, 18.00, 6.70, 6.70, 1.05);
INSERT INTO `tbl_venta_det` VALUES (1112, 486, 2, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1113, 487, 2, 230, 1.00, 1, 0.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.74);
INSERT INTO `tbl_venta_det` VALUES (1114, 487, 3, 400, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1115, 487, 4, 456, 0.00, 12, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 48.00, 4.00, 3.25);
INSERT INTO `tbl_venta_det` VALUES (1116, 487, 5, 266, 0.00, 12, 1.00, 1.00, 8.50, 8.50, 0.00, 18.00, 102.00, 8.50, 7.89);
INSERT INTO `tbl_venta_det` VALUES (1117, 487, 7, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 25.00, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1118, 488, 1, 214, 1.00, 24, 0.00, 24.00, 3.67, 3.67, 0.00, 18.00, 88.00, 88.00, 3.44);
INSERT INTO `tbl_venta_det` VALUES (1119, 489, 1, 273, 0.00, 15, 6.00, 6.00, 2.00, 2.00, 0.00, 18.00, 12.00, 12.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1120, 489, 2, 200, 0.00, 60, 8.00, 8.00, 1.00, 1.00, 0.00, 18.00, 8.00, 8.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1121, 490, 1, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.12);
INSERT INTO `tbl_venta_det` VALUES (1122, 490, 2, 410, 1.00, 1, 0.00, 1.00, 16.00, 16.00, 0.00, 18.00, 16.00, 16.00, 14.45);
INSERT INTO `tbl_venta_det` VALUES (1123, 491, 1, 277, 0.00, 48, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 1.80, 1.80, 1.52);
INSERT INTO `tbl_venta_det` VALUES (1124, 491, 2, 268, 0.00, 55, 1.00, 1.00, 0.50, 0.50, 0.00, 18.00, 0.50, 0.50, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1125, 491, 3, 241, 0.00, 24, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.81);
INSERT INTO `tbl_venta_det` VALUES (1126, 492, 1, 209, 0.00, 24, 6.00, 6.00, 3.54, 3.54, 0.00, 18.00, 21.25, 21.25, 3.35);
INSERT INTO `tbl_venta_det` VALUES (1127, 492, 2, 290, 0.00, 48, 12.00, 12.00, 1.96, 1.96, 0.00, 18.00, 23.50, 23.50, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1128, 492, 3, 258, 0.00, 1, 6.00, 6.00, 4.58, 4.58, 0.00, 18.00, 27.48, 27.48, 4.16);
INSERT INTO `tbl_venta_det` VALUES (1129, 492, 5, 261, 0.00, 60, 12.00, 12.00, 1.25, 1.25, 0.00, 18.00, 15.00, 15.00, 1.15);
INSERT INTO `tbl_venta_det` VALUES (1130, 492, 6, 436, 0.00, 60, 6.00, 6.00, 2.38, 2.38, 0.00, 18.00, 14.25, 14.25, 2.17);
INSERT INTO `tbl_venta_det` VALUES (1131, 492, 7, 274, 0.00, 60, 6.00, 6.00, 2.33, 2.33, 0.00, 18.00, 14.00, 14.00, 2.08);
INSERT INTO `tbl_venta_det` VALUES (1132, 492, 8, 513, 1.00, 12, 0.00, 12.00, 0.46, 0.46, 0.00, 18.00, 5.50, 5.50, 0.38);
INSERT INTO `tbl_venta_det` VALUES (1133, 492, 9, 332, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (1134, 492, 10, 239, 0.00, 50, 25.00, 25.00, 2.90, 2.90, 0.00, 18.00, 72.50, 72.50, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1135, 492, 11, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (1136, 492, 12, 240, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (1137, 492, 13, 286, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1138, 492, 14, 285, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1139, 492, 15, 265, 1.00, 1, 0.00, 1.00, 17.50, 17.50, 0.00, 18.00, 17.50, 17.50, 15.68);
INSERT INTO `tbl_venta_det` VALUES (1140, 492, 16, 508, 1.00, 24, 0.00, 24.00, 0.27, 0.27, 0.00, 18.00, 6.50, 6.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1141, 492, 18, 244, 1.00, 1, 0.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (1142, 492, 19, 497, 2.00, 15, 0.00, 30.00, 0.73, 0.73, 0.00, 18.00, 22.00, 22.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (1143, 493, 1, 200, 0.00, 60, 24.00, 24.00, 0.90, 0.90, 0.00, 18.00, 21.60, 21.60, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1144, 493, 2, 435, 0.00, 60, 6.00, 6.00, 1.83, 1.83, 0.00, 18.00, 11.00, 11.00, 1.63);
INSERT INTO `tbl_venta_det` VALUES (1145, 493, 3, 436, 0.00, 60, 6.00, 6.00, 2.38, 2.38, 0.00, 18.00, 14.25, 14.25, 2.17);
INSERT INTO `tbl_venta_det` VALUES (1146, 494, 1, 364, 1.00, 24, 0.00, 24.00, 1.21, 1.21, 0.00, 18.00, 29.00, 29.00, 1.13);
INSERT INTO `tbl_venta_det` VALUES (1147, 495, 1, 207, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1148, 495, 2, 450, 0.00, 48, 6.00, 6.00, 2.63, 2.63, 0.00, 18.00, 15.75, 15.75, 2.39);
INSERT INTO `tbl_venta_det` VALUES (1149, 496, 1, 449, 0.00, 40, 6.00, 6.00, 1.88, 1.88, 0.00, 18.00, 11.25, 11.25, 1.75);
INSERT INTO `tbl_venta_det` VALUES (1150, 496, 2, 192, 0.00, 48, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 10.00, 10.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (1151, 497, 1, 447, 0.00, 40, 6.00, 6.00, 2.05, 2.05, 0.00, 18.00, 12.30, 12.30, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1152, 497, 2, 200, 0.00, 60, 6.00, 6.00, 0.90, 0.90, 0.00, 18.00, 5.40, 5.40, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1153, 497, 3, 308, 1.00, 1, 0.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.00);
INSERT INTO `tbl_venta_det` VALUES (1154, 498, 1, 525, 1.00, 1, 0.00, 1.00, 15.50, 15.50, 0.00, 18.00, 15.50, 15.50, 13.50);
INSERT INTO `tbl_venta_det` VALUES (1155, 498, 2, 186, 1.00, 1, 0.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.50);
INSERT INTO `tbl_venta_det` VALUES (1156, 499, 1, 302, 1.00, 6, 0.00, 6.00, 0.83, 0.83, 0.00, 18.00, 5.00, 5.00, 0.68);
INSERT INTO `tbl_venta_det` VALUES (1157, 499, 2, 248, 0.00, 50, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1158, 499, 3, 420, 0.00, 5, 1.00, 1.00, 7.50, 7.50, 0.00, 18.00, 7.50, 7.50, 6.67);
INSERT INTO `tbl_venta_det` VALUES (1159, 499, 4, 471, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.12);
INSERT INTO `tbl_venta_det` VALUES (1160, 499, 5, 176, 0.00, 25, 2.00, 2.00, 1.50, 1.50, 0.00, 18.00, 3.00, 3.00, 1.07);
INSERT INTO `tbl_venta_det` VALUES (1161, 499, 6, 260, 0.00, 10, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1162, 499, 7, 314, 0.00, 48, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.40);
INSERT INTO `tbl_venta_det` VALUES (1163, 499, 8, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1164, 499, 10, 200, 0.00, 60, 3.00, 3.00, 0.90, 0.90, 0.00, 18.00, 2.70, 2.70, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1165, 499, 11, 221, 0.00, 60, 3.00, 3.00, 1.58, 1.58, 0.00, 18.00, 4.75, 4.75, 1.40);
INSERT INTO `tbl_venta_det` VALUES (1166, 500, 1, 214, 0.00, 24, 6.00, 6.00, 3.67, 3.67, 0.00, 18.00, 22.00, 22.00, 3.44);
INSERT INTO `tbl_venta_det` VALUES (1167, 500, 2, 186, 1.00, 1, 0.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.50);
INSERT INTO `tbl_venta_det` VALUES (1168, 501, 2, 200, 0.00, 60, 6.00, 6.00, 0.90, 0.90, 0.00, 18.00, 5.40, 5.40, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1169, 501, 3, 246, 0.00, 24, 6.00, 6.00, 1.25, 1.25, 0.00, 18.00, 7.50, 7.50, 1.16);
INSERT INTO `tbl_venta_det` VALUES (1170, 501, 4, 268, 0.00, 55, 6.00, 6.00, 0.42, 0.42, 0.00, 18.00, 2.51, 2.51, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1171, 501, 5, 238, 0.00, 15, 0.50, 0.50, 6.00, 6.00, 0.00, 18.00, 3.00, 3.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1172, 502, 2, 435, 0.00, 60, 3.00, 3.00, 1.83, 1.83, 0.00, 18.00, 329.97, 5.50, 1.63);
INSERT INTO `tbl_venta_det` VALUES (1173, 502, 3, 377, 0.00, 18, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 18.00, 1.00, 0.92);
INSERT INTO `tbl_venta_det` VALUES (1174, 502, 4, 382, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 12.00, 1.00, 0.67);
INSERT INTO `tbl_venta_det` VALUES (1175, 502, 5, 180, 0.00, 25, 12.00, 12.00, 0.72, 0.72, 0.00, 18.00, 216.00, 8.64, 0.66);
INSERT INTO `tbl_venta_det` VALUES (1176, 502, 6, 433, 0.00, 20, 1.00, 1.00, 0.60, 0.60, 0.00, 18.00, 12.00, 0.60, 0.46);
INSERT INTO `tbl_venta_det` VALUES (1177, 502, 7, 299, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.38);
INSERT INTO `tbl_venta_det` VALUES (1178, 503, 2, 350, 1.00, 20, 0.00, 20.00, 1.05, 1.05, 0.00, 18.00, 420.00, 21.00, 0.96);
INSERT INTO `tbl_venta_det` VALUES (1179, 504, 1, 459, 1.00, 6, 0.00, 6.00, 3.58, 3.58, 0.00, 18.00, 21.50, 21.50, 3.28);
INSERT INTO `tbl_venta_det` VALUES (1180, 505, 1, 272, 2.00, 1, 0.00, 2.00, 7.00, 7.00, 0.00, 18.00, 14.00, 14.00, 6.52);
INSERT INTO `tbl_venta_det` VALUES (1181, 506, 1, 349, 1.00, 1, 0.00, 1.00, 28.50, 28.50, 0.00, 18.00, 28.50, 28.50, 25.99);
INSERT INTO `tbl_venta_det` VALUES (1182, 507, 2, 502, 0.00, 12, 1.00, 1.00, 7.50, 7.50, 0.00, 18.00, 7.50, 7.50, 6.80);
INSERT INTO `tbl_venta_det` VALUES (1183, 507, 3, 314, 0.00, 48, 3.00, 3.00, 2.80, 2.80, 0.00, 18.00, 8.40, 8.40, 2.40);
INSERT INTO `tbl_venta_det` VALUES (1184, 507, 4, 239, 0.00, 50, 3.00, 3.00, 3.20, 3.20, 0.00, 18.00, 9.60, 9.60, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1185, 508, 1, 360, 1.00, 12, 0.00, 12.00, 0.88, 0.88, 0.00, 18.00, 10.50, 10.50, 0.78);
INSERT INTO `tbl_venta_det` VALUES (1186, 508, 2, 449, 0.00, 40, 3.00, 3.00, 1.88, 1.88, 0.00, 18.00, 5.63, 5.63, 1.75);
INSERT INTO `tbl_venta_det` VALUES (1187, 508, 3, 342, 0.00, 40, 3.00, 3.00, 2.05, 2.05, 0.00, 18.00, 6.15, 6.15, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1188, 508, 4, 419, 0.00, 12, 3.00, 3.00, 1.13, 1.13, 0.00, 18.00, 3.38, 3.38, 0.99);
INSERT INTO `tbl_venta_det` VALUES (1189, 508, 5, 319, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (1190, 509, 1, 238, 0.00, 15, 2.00, 2.00, 6.00, 6.00, 0.00, 18.00, 12.00, 12.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1191, 509, 3, 202, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.33);
INSERT INTO `tbl_venta_det` VALUES (1192, 510, 1, 411, 1.00, 1, 0.00, 1.00, 26.50, 26.50, 0.00, 18.00, 26.50, 26.50, 23.81);
INSERT INTO `tbl_venta_det` VALUES (1193, 510, 2, 217, 0.00, 12, 3.00, 3.00, 3.25, 3.25, 0.00, 18.00, 9.75, 9.75, 2.96);
INSERT INTO `tbl_venta_det` VALUES (1194, 510, 4, 232, 0.00, 40, 6.00, 6.00, 1.55, 1.55, 0.00, 18.00, 9.30, 9.30, 1.35);
INSERT INTO `tbl_venta_det` VALUES (1195, 511, 1, 312, 0.00, 48, 1.00, 1.00, 2.80, 2.80, 0.00, 18.00, 2.80, 2.80, 2.40);
INSERT INTO `tbl_venta_det` VALUES (1196, 511, 2, 285, 0.00, 40, 1.00, 1.00, 0.31, 0.31, 0.00, 18.00, 0.31, 0.31, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1197, 511, 3, 306, 0.00, 10, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.70);
INSERT INTO `tbl_venta_det` VALUES (1198, 511, 5, 509, 1.00, 20, 0.00, 20.00, 0.89, 0.89, 0.00, 18.00, 17.80, 17.80, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1199, 511, 7, 230, 2.00, 1, 0.00, 2.00, 2.00, 2.00, 0.00, 18.00, 4.00, 4.00, 1.74);
INSERT INTO `tbl_venta_det` VALUES (1200, 511, 8, 321, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1201, 512, 1, 497, 0.00, 15, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 3.00, 3.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (1202, 512, 2, 377, 0.00, 18, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.92);
INSERT INTO `tbl_venta_det` VALUES (1203, 512, 3, 246, 0.00, 24, 2.00, 2.00, 1.50, 1.50, 0.00, 18.00, 3.00, 3.00, 1.16);
INSERT INTO `tbl_venta_det` VALUES (1204, 512, 4, 229, 0.00, 216, 12.00, 12.00, 0.50, 0.50, 0.00, 18.00, 6.00, 6.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1205, 512, 5, 290, 0.00, 48, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1206, 512, 6, 330, 0.00, 8, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1207, 512, 7, 256, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.01);
INSERT INTO `tbl_venta_det` VALUES (1208, 512, 8, 508, 1.00, 24, 0.00, 24.00, 0.27, 0.27, 0.00, 18.00, 6.50, 6.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1209, 512, 9, 242, 0.00, 10, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.70);
INSERT INTO `tbl_venta_det` VALUES (1210, 513, 1, 239, 0.00, 50, 15.00, 15.00, 2.90, 2.90, 0.00, 18.00, 43.50, 43.50, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1211, 513, 2, 238, 0.00, 15, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1212, 513, 3, 321, 1.00, 12, 0.00, 12.00, 0.96, 0.96, 0.00, 18.00, 11.50, 11.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1213, 513, 4, 317, 1.00, 1, 0.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (1214, 513, 5, 343, 1.00, 1, 0.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.82);
INSERT INTO `tbl_venta_det` VALUES (1215, 513, 6, 399, 2.00, 10, 0.00, 20.00, 0.25, 0.25, 0.00, 18.00, 5.00, 5.00, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1216, 514, 1, 308, 1.00, 1, 0.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.00);
INSERT INTO `tbl_venta_det` VALUES (1217, 514, 3, 490, 1.00, 1, 0.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 3.77);
INSERT INTO `tbl_venta_det` VALUES (1218, 515, 1, 358, 0.00, 12, 1.00, 1.00, 13.00, 13.00, 0.00, 18.00, 156.01, 13.00, 11.51);
INSERT INTO `tbl_venta_det` VALUES (1219, 515, 2, 354, 1.00, 12, 0.00, 12.00, 0.29, 0.29, 0.00, 18.00, 42.00, 3.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1220, 515, 3, 355, 1.00, 12, 0.00, 12.00, 0.29, 0.29, 0.00, 18.00, 42.00, 3.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1221, 515, 4, 356, 1.00, 12, 0.00, 12.00, 0.17, 0.17, 0.00, 18.00, 24.00, 2.00, 0.13);
INSERT INTO `tbl_venta_det` VALUES (1222, 516, 1, 401, 0.00, 12, 5.00, 5.00, 0.50, 0.50, 0.00, 18.00, 2.50, 2.50, 0.42);
INSERT INTO `tbl_venta_det` VALUES (1223, 516, 2, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1224, 516, 3, 282, 0.00, 15, 1.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.87);
INSERT INTO `tbl_venta_det` VALUES (1225, 516, 4, 202, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.33);
INSERT INTO `tbl_venta_det` VALUES (1226, 516, 5, 275, 0.00, 12, 2.00, 2.00, 3.50, 3.50, 0.00, 18.00, 7.00, 7.00, 2.42);
INSERT INTO `tbl_venta_det` VALUES (1227, 516, 6, 383, 0.00, 12, 6.00, 6.00, 0.83, 0.83, 0.00, 18.00, 5.00, 5.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1228, 516, 7, 389, 0.00, 12, 6.00, 6.00, 0.83, 0.83, 0.00, 18.00, 5.00, 5.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1229, 517, 2, 273, 0.00, 15, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1230, 517, 3, 406, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.82);
INSERT INTO `tbl_venta_det` VALUES (1231, 517, 4, 501, 1.00, 1, 0.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.77);
INSERT INTO `tbl_venta_det` VALUES (1232, 517, 5, 474, 0.00, 6, 1.00, 1.00, 6.80, 6.80, 0.00, 18.00, 6.80, 6.80, 6.05);
INSERT INTO `tbl_venta_det` VALUES (1233, 517, 6, 330, 0.00, 8, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1234, 518, 1, 422, 1.00, 1, 0.00, 1.00, 40.00, 40.00, 0.00, 18.00, 40.00, 40.00, 36.77);
INSERT INTO `tbl_venta_det` VALUES (1235, 518, 2, 407, 1.00, 1, 0.00, 1.00, 26.00, 26.00, 0.00, 18.00, 26.00, 26.00, 23.80);
INSERT INTO `tbl_venta_det` VALUES (1236, 518, 3, 393, 1.00, 1, 0.00, 1.00, 17.00, 17.00, 0.00, 18.00, 17.00, 17.00, 15.45);
INSERT INTO `tbl_venta_det` VALUES (1237, 519, 1, 176, 0.00, 25, 3.00, 3.00, 1.50, 1.50, 0.00, 18.00, 112.50, 4.50, 1.07);
INSERT INTO `tbl_venta_det` VALUES (1238, 519, 4, 286, 0.00, 40, 10.00, 10.00, 0.24, 0.24, 0.00, 18.00, 95.00, 2.38, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1239, 519, 5, 509, 0.00, 20, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 20.00, 1.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1240, 520, 1, 273, 0.00, 15, 6.00, 6.00, 2.00, 2.00, 0.00, 18.00, 12.00, 12.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1241, 520, 2, 200, 0.00, 60, 8.00, 8.00, 1.00, 1.00, 0.00, 18.00, 8.00, 8.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1242, 521, 1, 286, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1243, 521, 2, 392, 1.00, 1, 0.00, 1.00, 17.00, 17.00, 0.00, 18.00, 17.00, 17.00, 15.45);
INSERT INTO `tbl_venta_det` VALUES (1244, 522, 2, 249, 0.00, 20, 3.00, 3.00, 9.00, 9.00, 0.00, 18.00, 27.00, 27.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (1245, 522, 3, 248, 0.00, 50, 3.00, 3.00, 4.00, 4.00, 0.00, 18.00, 12.00, 12.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1246, 522, 5, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1247, 523, 1, 239, 0.00, 50, 5.00, 5.00, 3.20, 3.20, 0.00, 18.00, 16.00, 16.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1248, 523, 2, 443, 0.00, 12, 1.00, 1.00, 4.80, 4.80, 0.00, 18.00, 4.80, 4.80, 4.33);
INSERT INTO `tbl_venta_det` VALUES (1249, 524, 1, 304, 0.00, 1, 4.00, 4.00, 5.00, 5.00, 0.00, 18.00, 20.00, 20.00, 3.91);
INSERT INTO `tbl_venta_det` VALUES (1250, 525, 1, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1251, 525, 2, 215, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 2.03);
INSERT INTO `tbl_venta_det` VALUES (1252, 526, 1, 202, 1.00, 12, 0.00, 12.00, 3.00, 3.00, 0.00, 18.00, 36.00, 36.00, 2.33);
INSERT INTO `tbl_venta_det` VALUES (1253, 526, 2, 250, 1.00, 20, 0.00, 20.00, 2.60, 2.60, 0.00, 18.00, 52.00, 52.00, 2.43);
INSERT INTO `tbl_venta_det` VALUES (1254, 526, 3, 331, 1.00, 12, 0.00, 12.00, 5.17, 5.17, 0.00, 18.00, 62.00, 62.00, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1255, 527, 1, 523, 1.00, 24, 0.00, 24.00, 3.83, 3.83, 0.00, 18.00, 92.00, 92.00, 3.63);
INSERT INTO `tbl_venta_det` VALUES (1256, 527, 2, 251, 0.00, 24, 6.00, 6.00, 3.42, 3.42, 0.00, 18.00, 20.50, 20.50, 3.22);
INSERT INTO `tbl_venta_det` VALUES (1257, 527, 3, 210, 1.00, 1, 1.00, 2.00, 4.00, 4.00, 0.00, 18.00, 8.00, 8.00, 3.30);
INSERT INTO `tbl_venta_det` VALUES (1258, 527, 4, 207, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1259, 527, 5, 192, 0.00, 48, 6.00, 6.00, 3.50, 3.50, 0.00, 18.00, 21.00, 21.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (1260, 527, 6, 242, 0.00, 10, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.70);
INSERT INTO `tbl_venta_det` VALUES (1261, 527, 7, 342, 0.00, 40, 1.00, 1.00, 2.20, 2.20, 0.00, 18.00, 2.20, 2.20, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1262, 528, 1, 205, 1.00, 15, 0.00, 15.00, 5.00, 5.00, 0.00, 18.00, 75.00, 75.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1263, 529, 1, 330, 1.00, 8, 0.00, 8.00, 0.94, 0.94, 0.00, 18.00, 7.50, 7.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1264, 530, 1, 482, 1.00, 12, 0.00, 12.00, 1.33, 1.33, 0.00, 18.00, 16.00, 16.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (1265, 530, 2, 214, 0.00, 24, 6.00, 6.00, 3.67, 3.67, 0.00, 18.00, 22.00, 22.00, 3.44);
INSERT INTO `tbl_venta_det` VALUES (1266, 530, 4, 475, 1.00, 1, 0.00, 1.00, 15.50, 15.50, 0.00, 18.00, 15.50, 15.50, 14.00);
INSERT INTO `tbl_venta_det` VALUES (1267, 530, 5, 538, 0.00, 15, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.62);
INSERT INTO `tbl_venta_det` VALUES (1268, 530, 6, 382, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.67);
INSERT INTO `tbl_venta_det` VALUES (1269, 530, 7, 373, 0.00, 48, 6.00, 6.00, 2.27, 2.27, 0.00, 18.00, 13.63, 13.63, 2.18);
INSERT INTO `tbl_venta_det` VALUES (1270, 530, 8, 207, 0.00, 12, 6.00, 6.00, 2.17, 2.17, 0.00, 18.00, 13.00, 13.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1271, 531, 1, 384, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1272, 531, 2, 239, 0.00, 50, 5.00, 5.00, 3.20, 3.20, 0.00, 18.00, 16.00, 16.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1273, 531, 3, 209, 0.00, 24, 1.00, 1.00, 3.60, 3.60, 0.00, 18.00, 3.60, 3.60, 3.35);
INSERT INTO `tbl_venta_det` VALUES (1274, 531, 4, 428, 0.00, 100, 4.00, 4.00, 0.50, 0.50, 0.00, 18.00, 2.00, 2.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1275, 531, 5, 341, 0.00, 24, 1.00, 1.00, 2.70, 2.70, 0.00, 18.00, 2.70, 2.70, 2.33);
INSERT INTO `tbl_venta_det` VALUES (1276, 531, 6, 188, 0.00, 18, 4.00, 4.00, 1.00, 1.00, 0.00, 18.00, 4.00, 4.00, 0.87);
INSERT INTO `tbl_venta_det` VALUES (1277, 532, 1, 287, 0.00, 40, 10.00, 10.00, 1.38, 1.38, 0.00, 18.00, 550.00, 13.75, 1.25);
INSERT INTO `tbl_venta_det` VALUES (1278, 532, 2, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 155.00, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1279, 533, 1, 239, 0.00, 50, 4.00, 4.00, 3.20, 3.20, 0.00, 18.00, 12.80, 12.80, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1280, 533, 2, 266, 0.00, 12, 1.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.89);
INSERT INTO `tbl_venta_det` VALUES (1281, 533, 3, 185, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1282, 534, 1, 401, 0.00, 12, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 1.00, 1.00, 0.42);
INSERT INTO `tbl_venta_det` VALUES (1283, 534, 2, 239, 0.00, 50, 5.00, 5.00, 3.20, 3.20, 0.00, 18.00, 16.00, 16.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1284, 534, 3, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1285, 534, 4, 266, 0.00, 12, 2.00, 2.00, 8.50, 8.50, 0.00, 18.00, 17.00, 17.00, 7.89);
INSERT INTO `tbl_venta_det` VALUES (1286, 534, 5, 193, 0.00, 6, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.85);
INSERT INTO `tbl_venta_det` VALUES (1287, 535, 3, 358, 0.00, 12, 1.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.51);
INSERT INTO `tbl_venta_det` VALUES (1288, 535, 5, 350, 0.00, 20, 1.00, 1.00, 1.20, 1.20, 0.00, 18.00, 1.20, 1.20, 0.96);
INSERT INTO `tbl_venta_det` VALUES (1289, 535, 6, 240, 0.00, 12, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (1290, 535, 7, 456, 0.00, 12, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.25);
INSERT INTO `tbl_venta_det` VALUES (1291, 535, 8, 285, 0.00, 40, 3.00, 3.00, 0.31, 0.31, 0.00, 18.00, 0.94, 0.94, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1292, 535, 9, 321, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1293, 535, 10, 235, 0.00, 40, 1.00, 1.00, 0.38, 0.38, 0.00, 18.00, 0.38, 0.38, 0.34);
INSERT INTO `tbl_venta_det` VALUES (1294, 536, 1, 258, 1.00, 1, 0.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 4.16);
INSERT INTO `tbl_venta_det` VALUES (1295, 536, 4, 480, 0.00, 14, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 28.00, 2.00, 1.64);
INSERT INTO `tbl_venta_det` VALUES (1296, 537, 1, 417, 1.00, 1, 0.00, 1.00, 22.00, 22.00, 0.00, 18.00, 22.00, 22.00, 20.00);
INSERT INTO `tbl_venta_det` VALUES (1297, 538, 1, 308, 1.00, 1, 0.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.00);
INSERT INTO `tbl_venta_det` VALUES (1298, 538, 2, 241, 0.00, 24, 1.00, 1.00, 1.20, 1.20, 0.00, 18.00, 1.20, 1.20, 0.91);
INSERT INTO `tbl_venta_det` VALUES (1299, 538, 3, 524, 0.00, 48, 2.00, 2.00, 2.20, 2.20, 0.00, 18.00, 4.40, 4.40, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1300, 539, 1, 448, 0.00, 40, 1.00, 1.00, 1.70, 1.70, 0.00, 18.00, 1.70, 1.70, 1.45);
INSERT INTO `tbl_venta_det` VALUES (1301, 539, 2, 332, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (1302, 539, 3, 513, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.38);
INSERT INTO `tbl_venta_det` VALUES (1303, 539, 4, 410, 1.00, 1, 0.00, 1.00, 16.00, 16.00, 0.00, 18.00, 16.00, 16.00, 14.45);
INSERT INTO `tbl_venta_det` VALUES (1304, 539, 5, 303, 1.00, 1, 0.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1305, 540, 1, 242, 1.00, 10, 0.00, 10.00, 1.85, 1.85, 0.00, 18.00, 18.50, 18.50, 1.70);
INSERT INTO `tbl_venta_det` VALUES (1306, 541, 1, 339, 0.00, 1, 1.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (1307, 541, 2, 320, 0.00, 50, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 3.00, 3.00, 2.70);
INSERT INTO `tbl_venta_det` VALUES (1308, 541, 3, 335, 0.00, 1, 0.50, 0.50, 5.00, 5.00, 0.00, 18.00, 2.50, 2.50, 4.44);
INSERT INTO `tbl_venta_det` VALUES (1309, 541, 4, 334, 0.00, 1, 0.50, 0.50, 7.00, 7.00, 0.00, 18.00, 3.50, 3.50, 6.00);
INSERT INTO `tbl_venta_det` VALUES (1310, 541, 5, 443, 0.00, 12, 1.00, 1.00, 4.80, 4.80, 0.00, 18.00, 4.80, 4.80, 4.33);
INSERT INTO `tbl_venta_det` VALUES (1311, 541, 6, 238, 0.00, 15, 0.50, 0.50, 6.00, 6.00, 0.00, 18.00, 3.00, 3.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1312, 541, 7, 399, 0.00, 10, 2.00, 2.00, 0.25, 0.25, 0.00, 18.00, 0.50, 0.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1313, 542, 1, 357, 1.00, 12, 0.00, 12.00, 0.88, 0.88, 0.00, 18.00, 10.50, 10.50, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1314, 543, 1, 192, 0.00, 48, 6.00, 6.00, 3.33, 3.33, 0.00, 18.00, 20.00, 20.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (1315, 543, 2, 255, 0.00, 20, 2.00, 2.00, 2.00, 2.00, 0.00, 18.00, 4.00, 4.00, 1.72);
INSERT INTO `tbl_venta_det` VALUES (1316, 543, 3, 284, 0.00, 20, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.86);
INSERT INTO `tbl_venta_det` VALUES (1317, 543, 5, 257, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.85);
INSERT INTO `tbl_venta_det` VALUES (1318, 543, 6, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1319, 543, 7, 238, 0.00, 15, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1320, 543, 8, 300, 0.00, 20, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.17);
INSERT INTO `tbl_venta_det` VALUES (1321, 543, 9, 373, 0.00, 48, 6.00, 6.00, 2.27, 2.27, 0.00, 18.00, 13.63, 13.63, 2.18);
INSERT INTO `tbl_venta_det` VALUES (1322, 543, 10, 322, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.17);
INSERT INTO `tbl_venta_det` VALUES (1323, 543, 11, 304, 0.00, 1, 1.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 3.91);
INSERT INTO `tbl_venta_det` VALUES (1324, 544, 1, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1325, 545, 1, 538, 2.00, 15, 0.00, 30.00, 0.73, 0.73, 0.00, 18.00, 22.00, 22.00, 0.62);
INSERT INTO `tbl_venta_det` VALUES (1326, 546, 1, 275, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 42.00, 3.50, 2.42);
INSERT INTO `tbl_venta_det` VALUES (1327, 546, 2, 420, 0.00, 5, 0.50, 0.50, 7.50, 7.50, 0.00, 18.00, 18.75, 3.75, 6.67);
INSERT INTO `tbl_venta_det` VALUES (1328, 546, 3, 401, 1.00, 12, 0.00, 12.00, 0.50, 0.50, 0.00, 18.00, 72.00, 6.00, 0.42);
INSERT INTO `tbl_venta_det` VALUES (1329, 546, 4, 291, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 66.00, 5.50, 4.71);
INSERT INTO `tbl_venta_det` VALUES (1330, 546, 5, 235, 0.00, 40, 1.00, 1.00, 0.38, 0.38, 0.00, 18.00, 15.00, 0.38, 0.34);
INSERT INTO `tbl_venta_det` VALUES (1331, 546, 6, 249, 0.00, 20, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 180.00, 9.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (1332, 547, 1, 366, 0.00, 15, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 30.00, 2.00, 1.37);
INSERT INTO `tbl_venta_det` VALUES (1333, 547, 2, 377, 0.00, 18, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 18.00, 1.00, 0.92);
INSERT INTO `tbl_venta_det` VALUES (1334, 547, 3, 282, 0.00, 1, 1.00, 1.00, 9.50, 9.50, 0.00, 18.00, 9.50, 9.50, 8.60);
INSERT INTO `tbl_venta_det` VALUES (1335, 547, 4, 433, 0.00, 20, 1.00, 1.00, 0.60, 0.60, 0.00, 18.00, 12.00, 0.60, 0.46);
INSERT INTO `tbl_venta_det` VALUES (1336, 547, 5, 356, 1.00, 12, 0.00, 12.00, 0.17, 0.17, 0.00, 18.00, 24.00, 2.00, 0.13);
INSERT INTO `tbl_venta_det` VALUES (1337, 547, 6, 381, 1.00, 12, 0.00, 12.00, 0.79, 0.79, 0.00, 18.00, 114.00, 9.50, 0.67);
INSERT INTO `tbl_venta_det` VALUES (1338, 547, 7, 508, 2.00, 24, 0.00, 48.00, 0.27, 0.27, 0.00, 18.00, 312.00, 13.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1339, 547, 8, 305, 0.00, 12, 2.00, 2.00, 1.20, 1.20, 0.00, 18.00, 28.80, 2.40, 0.99);
INSERT INTO `tbl_venta_det` VALUES (1340, 547, 9, 428, 0.00, 100, 4.00, 4.00, 0.50, 0.50, 0.00, 18.00, 200.00, 2.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1341, 548, 1, 406, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 66.00, 5.50, 4.82);
INSERT INTO `tbl_venta_det` VALUES (1342, 548, 2, 273, 0.00, 15, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 30.00, 2.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1343, 548, 3, 462, 0.00, 60, 6.00, 6.00, 1.12, 1.12, 0.00, 18.00, 402.00, 6.70, 1.05);
INSERT INTO `tbl_venta_det` VALUES (1344, 549, 1, 199, 1.00, 1, 0.00, 1.00, 18.00, 18.00, 0.00, 18.00, 18.00, 18.00, 16.12);
INSERT INTO `tbl_venta_det` VALUES (1345, 550, 1, 199, 2.00, 1, 0.00, 2.00, 18.00, 18.00, 0.00, 18.00, 36.00, 36.00, 16.12);
INSERT INTO `tbl_venta_det` VALUES (1346, 551, 1, 379, 1.00, 12, 0.00, 12.00, 0.79, 0.79, 0.00, 18.00, 9.50, 9.50, 0.67);
INSERT INTO `tbl_venta_det` VALUES (1347, 551, 2, 377, 1.00, 18, 0.00, 18.00, 0.97, 0.97, 0.00, 18.00, 17.50, 17.50, 0.92);
INSERT INTO `tbl_venta_det` VALUES (1348, 551, 3, 209, 0.00, 24, 6.00, 6.00, 3.54, 3.54, 0.00, 18.00, 21.25, 21.25, 3.35);
INSERT INTO `tbl_venta_det` VALUES (1349, 552, 1, 259, 1.00, 1, 0.00, 1.00, 108.01, 108.01, 0.00, 18.00, 108.01, 108.01, 104.90);
INSERT INTO `tbl_venta_det` VALUES (1350, 553, 1, 238, 1.00, 15, 1.00, 16.00, 5.07, 5.07, 0.00, 18.00, 81.07, 81.07, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1351, 553, 2, 249, 0.00, 20, 6.00, 6.00, 8.90, 8.90, 0.00, 18.00, 53.40, 53.40, 8.57);
INSERT INTO `tbl_venta_det` VALUES (1352, 553, 3, 248, 0.00, 50, 10.00, 10.00, 4.00, 4.00, 0.00, 18.00, 40.00, 40.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1353, 553, 4, 273, 1.00, 15, 0.00, 15.00, 1.87, 1.87, 0.00, 18.00, 28.00, 28.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1354, 553, 5, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.31);
INSERT INTO `tbl_venta_det` VALUES (1355, 553, 7, 300, 1.00, 20, 0.00, 20.00, 2.40, 2.40, 0.00, 18.00, 48.00, 48.00, 2.17);
INSERT INTO `tbl_venta_det` VALUES (1356, 554, 1, 454, 1.00, 6, 0.00, 6.00, 6.50, 6.50, 0.00, 18.00, 39.00, 39.00, 6.04);
INSERT INTO `tbl_venta_det` VALUES (1357, 555, 1, 207, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1358, 555, 2, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.31);
INSERT INTO `tbl_venta_det` VALUES (1359, 556, 1, 302, 1.00, 6, 0.00, 6.00, 0.83, 0.83, 0.00, 18.00, 5.00, 5.00, 0.68);
INSERT INTO `tbl_venta_det` VALUES (1360, 556, 2, 374, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1361, 556, 4, 501, 2.00, 1, 0.00, 2.00, 8.50, 8.50, 0.00, 18.00, 17.00, 17.00, 7.77);
INSERT INTO `tbl_venta_det` VALUES (1362, 556, 5, 255, 0.00, 20, 3.00, 3.00, 2.00, 2.00, 0.00, 18.00, 6.00, 6.00, 1.72);
INSERT INTO `tbl_venta_det` VALUES (1363, 556, 6, 249, 0.00, 20, 2.00, 2.00, 9.00, 9.00, 0.00, 18.00, 18.00, 18.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (1364, 556, 8, 209, 0.00, 24, 6.00, 6.00, 3.54, 3.54, 0.00, 18.00, 21.25, 21.25, 3.35);
INSERT INTO `tbl_venta_det` VALUES (1365, 556, 9, 290, 0.00, 48, 6.00, 6.00, 1.96, 1.96, 0.00, 18.00, 11.75, 11.75, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1366, 556, 11, 200, 0.00, 60, 6.00, 6.00, 0.90, 0.90, 0.00, 18.00, 5.40, 5.40, 0.84);
INSERT INTO `tbl_venta_det` VALUES (1367, 557, 1, 342, 0.00, 40, 2.00, 2.00, 2.20, 2.20, 0.00, 18.00, 4.40, 4.40, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1368, 557, 2, 406, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.82);
INSERT INTO `tbl_venta_det` VALUES (1369, 557, 3, 203, 0.00, 24, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.79);
INSERT INTO `tbl_venta_det` VALUES (1370, 557, 4, 200, 0.00, 60, 4.00, 4.00, 1.00, 1.00, 0.00, 18.00, 4.00, 4.00, 0.84);
INSERT INTO `tbl_venta_det` VALUES (1371, 557, 5, 456, 0.00, 12, 2.00, 2.00, 4.00, 4.00, 0.00, 18.00, 8.00, 8.00, 3.25);
INSERT INTO `tbl_venta_det` VALUES (1372, 557, 6, 332, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (1373, 557, 7, 238, 0.00, 15, 0.50, 0.50, 6.00, 6.00, 0.00, 18.00, 3.00, 3.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1374, 558, 2, 481, 0.00, 12, 1.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 3.99);
INSERT INTO `tbl_venta_det` VALUES (1375, 558, 3, 498, 2.00, 1, 0.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 2.20);
INSERT INTO `tbl_venta_det` VALUES (1376, 558, 4, 224, 0.00, 12, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (1377, 558, 5, 433, 0.00, 20, 1.00, 1.00, 0.60, 0.60, 0.00, 18.00, 0.60, 0.60, 0.46);
INSERT INTO `tbl_venta_det` VALUES (1378, 558, 6, 508, 0.00, 24, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 1.00, 1.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1379, 559, 1, 238, 1.00, 15, 0.00, 15.00, 5.07, 5.07, 0.00, 18.00, 76.00, 76.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1380, 560, 1, 289, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1381, 560, 2, 560, 0.00, 12, 1.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 3.80);
INSERT INTO `tbl_venta_det` VALUES (1382, 561, 1, 228, 0.00, 24, 2.00, 2.00, 3.00, 3.00, 0.00, 18.00, 144.00, 6.00, 2.63);
INSERT INTO `tbl_venta_det` VALUES (1383, 561, 2, 372, 0.00, 16, 1.00, 1.00, 1.20, 1.20, 0.00, 18.00, 19.20, 1.20, 0.93);
INSERT INTO `tbl_venta_det` VALUES (1384, 561, 3, 285, 0.00, 40, 3.00, 3.00, 0.31, 0.31, 0.00, 18.00, 37.50, 0.94, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1385, 561, 4, 229, 0.00, 216, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 216.00, 1.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1386, 561, 5, 337, 0.00, 1, 0.30, 0.30, 5.50, 5.50, 0.00, 18.00, 1.65, 1.65, 4.44);
INSERT INTO `tbl_venta_det` VALUES (1387, 561, 6, 420, 0.00, 5, 0.50, 0.50, 7.50, 7.50, 0.00, 18.00, 18.75, 3.75, 6.67);
INSERT INTO `tbl_venta_det` VALUES (1388, 561, 7, 347, 0.00, 1, 1.00, 1.00, 10.00, 10.00, 0.00, 18.00, 10.00, 10.00, 8.97);
INSERT INTO `tbl_venta_det` VALUES (1389, 562, 1, 523, 0.00, 24, 6.00, 6.00, 3.83, 3.83, 0.00, 18.00, 552.00, 23.00, 3.63);
INSERT INTO `tbl_venta_det` VALUES (1390, 562, 2, 543, 0.00, 1, 1.00, 1.00, 6.50, 6.50, 0.00, 18.00, 6.50, 6.50, 5.80);
INSERT INTO `tbl_venta_det` VALUES (1391, 563, 1, 248, 0.00, 50, 3.00, 3.00, 4.00, 4.00, 0.00, 18.00, 600.00, 12.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1392, 564, 1, 287, 0.00, 40, 12.00, 12.00, 1.38, 1.38, 0.00, 18.00, 16.50, 16.50, 1.25);
INSERT INTO `tbl_venta_det` VALUES (1393, 564, 2, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1394, 564, 3, 320, 0.00, 50, 8.00, 8.00, 3.00, 3.00, 0.00, 18.00, 24.00, 24.00, 2.70);
INSERT INTO `tbl_venta_det` VALUES (1395, 565, 1, 402, 1.00, 1, 0.00, 1.00, 20.00, 20.00, 0.00, 18.00, 20.00, 20.00, 17.71);
INSERT INTO `tbl_venta_det` VALUES (1396, 565, 2, 238, 0.00, 15, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1397, 566, 1, 501, 0.00, 1, 2.00, 2.00, 8.50, 8.50, 0.00, 18.00, 17.00, 17.00, 7.77);
INSERT INTO `tbl_venta_det` VALUES (1398, 566, 2, 538, 0.00, 15, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.62);
INSERT INTO `tbl_venta_det` VALUES (1399, 567, 1, 320, 0.00, 50, 5.00, 5.00, 3.00, 3.00, 0.00, 18.00, 15.00, 15.00, 2.70);
INSERT INTO `tbl_venta_det` VALUES (1400, 567, 2, 248, 0.00, 50, 2.00, 2.00, 4.00, 4.00, 0.00, 18.00, 8.00, 8.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1401, 567, 4, 218, 0.00, 40, 2.00, 2.00, 1.80, 1.80, 0.00, 18.00, 3.60, 3.60, 1.51);
INSERT INTO `tbl_venta_det` VALUES (1402, 567, 5, 266, 0.00, 12, 1.00, 1.00, 8.50, 8.50, 0.00, 18.00, 8.50, 8.50, 7.89);
INSERT INTO `tbl_venta_det` VALUES (1403, 567, 6, 446, 0.00, 12, 1.00, 1.00, 9.50, 9.50, 0.00, 18.00, 9.50, 9.50, 8.75);
INSERT INTO `tbl_venta_det` VALUES (1404, 567, 7, 185, 0.00, 1, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1405, 567, 8, 253, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.12);
INSERT INTO `tbl_venta_det` VALUES (1406, 567, 9, 287, 0.00, 40, 4.00, 4.00, 1.40, 1.40, 0.00, 18.00, 5.60, 5.60, 1.25);
INSERT INTO `tbl_venta_det` VALUES (1407, 567, 10, 323, 0.00, 24, 1.00, 1.00, 3.20, 3.20, 0.00, 18.00, 3.20, 3.20, 2.94);
INSERT INTO `tbl_venta_det` VALUES (1408, 567, 11, 363, 0.00, 24, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 3.00, 3.00, 2.68);
INSERT INTO `tbl_venta_det` VALUES (1409, 567, 13, 315, 0.00, 60, 2.00, 2.00, 1.50, 1.50, 0.00, 18.00, 3.00, 3.00, 1.15);
INSERT INTO `tbl_venta_det` VALUES (1410, 567, 14, 198, 0.00, 60, 3.00, 3.00, 1.00, 1.00, 0.00, 18.00, 3.00, 3.00, 0.82);
INSERT INTO `tbl_venta_det` VALUES (1411, 568, 2, 201, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.31);
INSERT INTO `tbl_venta_det` VALUES (1412, 569, 1, 240, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (1413, 569, 2, 242, 1.00, 10, 0.00, 10.00, 1.85, 1.85, 0.00, 18.00, 18.50, 18.50, 1.70);
INSERT INTO `tbl_venta_det` VALUES (1414, 569, 3, 285, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1415, 570, 2, 198, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 10.80, 10.80, 0.82);
INSERT INTO `tbl_venta_det` VALUES (1416, 570, 3, 342, 0.00, 40, 2.00, 2.00, 2.20, 2.20, 0.00, 18.00, 4.40, 4.40, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1417, 571, 1, 290, 0.00, 48, 6.00, 6.00, 1.96, 1.96, 0.00, 18.00, 11.75, 11.75, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1418, 571, 2, 240, 1.00, 12, 0.00, 12.00, 1.50, 1.50, 0.00, 18.00, 18.00, 18.00, 1.29);
INSERT INTO `tbl_venta_det` VALUES (1419, 571, 3, 319, 1.00, 1, 0.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (1420, 571, 4, 337, 1.00, 1, 0.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.44);
INSERT INTO `tbl_venta_det` VALUES (1421, 571, 5, 192, 0.00, 48, 6.00, 6.00, 3.33, 3.33, 0.00, 18.00, 20.00, 20.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (1422, 571, 6, 247, 0.00, 48, 6.00, 6.00, 5.33, 5.33, 0.00, 18.00, 32.00, 32.00, 4.80);
INSERT INTO `tbl_venta_det` VALUES (1423, 571, 7, 246, 0.00, 24, 12.00, 12.00, 1.25, 1.25, 0.00, 18.00, 15.00, 15.00, 1.16);
INSERT INTO `tbl_venta_det` VALUES (1424, 571, 8, 284, 1.00, 20, 0.00, 20.00, 0.95, 0.95, 0.00, 18.00, 19.00, 19.00, 0.86);
INSERT INTO `tbl_venta_det` VALUES (1425, 571, 9, 318, 0.00, 1, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.81);
INSERT INTO `tbl_venta_det` VALUES (1426, 572, 1, 238, 0.00, 15, 5.00, 5.00, 6.00, 6.00, 0.00, 18.00, 30.00, 30.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1427, 573, 1, 455, 1.00, 6, 0.00, 6.00, 6.50, 6.50, 0.00, 18.00, 39.00, 39.00, 6.05);
INSERT INTO `tbl_venta_det` VALUES (1428, 573, 2, 202, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.33);
INSERT INTO `tbl_venta_det` VALUES (1429, 573, 3, 462, 0.00, 60, 12.00, 12.00, 1.12, 1.12, 0.00, 18.00, 13.40, 13.40, 1.05);
INSERT INTO `tbl_venta_det` VALUES (1430, 573, 5, 335, 0.00, 1, 0.30, 0.30, 5.00, 5.00, 0.00, 18.00, 1.50, 1.50, 4.44);
INSERT INTO `tbl_venta_det` VALUES (1431, 573, 6, 275, 0.00, 12, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 2.42);
INSERT INTO `tbl_venta_det` VALUES (1432, 573, 7, 334, 0.00, 1, 0.21, 0.21, 7.00, 7.00, 0.00, 18.00, 1.50, 1.50, 6.00);
INSERT INTO `tbl_venta_det` VALUES (1433, 573, 8, 343, 0.00, 1, 1.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.82);
INSERT INTO `tbl_venta_det` VALUES (1434, 573, 9, 399, 1.00, 10, 0.00, 10.00, 0.25, 0.25, 0.00, 18.00, 2.50, 2.50, 0.18);
INSERT INTO `tbl_venta_det` VALUES (1435, 573, 11, 358, 0.00, 12, 1.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.51);
INSERT INTO `tbl_venta_det` VALUES (1436, 573, 12, 328, 0.00, 1, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.08);
INSERT INTO `tbl_venta_det` VALUES (1437, 574, 1, 249, 1.00, 20, 0.00, 20.00, 8.90, 8.90, 0.00, 18.00, 178.00, 178.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (1438, 575, 1, 273, 0.00, 15, 6.00, 6.00, 2.00, 2.00, 0.00, 18.00, 12.00, 12.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1439, 575, 2, 200, 0.00, 60, 8.00, 8.00, 1.00, 1.00, 0.00, 18.00, 8.00, 8.00, 0.84);
INSERT INTO `tbl_venta_det` VALUES (1440, 576, 1, 330, 2.00, 8, 0.00, 16.00, 0.94, 0.94, 0.00, 18.00, 15.00, 15.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1441, 576, 2, 235, 1.00, 40, 0.00, 40.00, 0.38, 0.38, 0.00, 18.00, 15.00, 15.00, 0.34);
INSERT INTO `tbl_venta_det` VALUES (1442, 576, 3, 377, 1.00, 18, 0.00, 18.00, 0.97, 0.97, 0.00, 18.00, 17.50, 17.50, 0.92);
INSERT INTO `tbl_venta_det` VALUES (1443, 576, 4, 456, 1.00, 12, 0.00, 12.00, 3.58, 3.58, 0.00, 18.00, 43.00, 43.00, 3.25);
INSERT INTO `tbl_venta_det` VALUES (1444, 576, 5, 429, 1.00, 15, 0.00, 15.00, 1.20, 1.20, 0.00, 18.00, 18.00, 18.00, 1.11);
INSERT INTO `tbl_venta_det` VALUES (1445, 576, 6, 275, 1.00, 12, 0.00, 12.00, 3.00, 3.00, 0.00, 18.00, 36.00, 36.00, 2.42);
INSERT INTO `tbl_venta_det` VALUES (1446, 577, 1, 205, 1.00, 15, 1.00, 16.00, 5.00, 5.00, 0.00, 18.00, 80.00, 80.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1447, 578, 1, 238, 1.00, 15, 0.00, 15.00, 5.07, 5.07, 0.00, 18.00, 76.00, 76.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1448, 579, 4, 239, 1.00, 50, 0.00, 50.00, 2.90, 2.90, 0.00, 18.00, 145.00, 145.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1449, 580, 1, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1450, 580, 2, 239, 0.00, 50, 5.00, 5.00, 3.20, 3.20, 0.00, 18.00, 16.00, 16.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1451, 580, 3, 206, 1.00, 1, 0.00, 1.00, 20.00, 20.00, 0.00, 18.00, 20.00, 20.00, 17.71);
INSERT INTO `tbl_venta_det` VALUES (1452, 580, 5, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1453, 580, 6, 201, 0.00, 12, 1.00, 1.00, 1.80, 1.80, 0.00, 18.00, 1.80, 1.80, 1.31);
INSERT INTO `tbl_venta_det` VALUES (1454, 580, 7, 238, 0.00, 15, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.73);
INSERT INTO `tbl_venta_det` VALUES (1455, 580, 8, 234, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 5.14);
INSERT INTO `tbl_venta_det` VALUES (1456, 581, 1, 419, 1.00, 12, 0.00, 12.00, 1.13, 1.13, 0.00, 18.00, 13.50, 13.50, 0.99);
INSERT INTO `tbl_venta_det` VALUES (1457, 581, 2, 525, 1.00, 1, 0.00, 1.00, 15.50, 15.50, 0.00, 18.00, 15.50, 15.50, 13.50);
INSERT INTO `tbl_venta_det` VALUES (1458, 581, 3, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1459, 581, 4, 207, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1460, 581, 5, 200, 0.00, 60, 12.00, 12.00, 0.90, 0.90, 0.00, 18.00, 10.80, 10.80, 0.84);
INSERT INTO `tbl_venta_det` VALUES (1461, 581, 6, 462, 0.00, 60, 12.00, 12.00, 1.12, 1.12, 0.00, 18.00, 13.40, 13.40, 1.05);
INSERT INTO `tbl_venta_det` VALUES (1462, 581, 7, 314, 0.00, 48, 6.00, 6.00, 2.60, 2.60, 0.00, 18.00, 15.63, 15.63, 2.40);
INSERT INTO `tbl_venta_det` VALUES (1463, 581, 8, 194, 0.00, 1, 6.00, 6.00, 3.71, 3.71, 0.00, 18.00, 22.26, 22.26, 3.37);
INSERT INTO `tbl_venta_det` VALUES (1464, 581, 9, 295, 1.00, 12, 0.00, 12.00, 0.88, 0.88, 0.00, 18.00, 10.50, 10.50, 0.78);
INSERT INTO `tbl_venta_det` VALUES (1465, 581, 10, 361, 1.00, 6, 0.00, 6.00, 1.25, 1.25, 0.00, 18.00, 7.50, 7.50, 1.13);
INSERT INTO `tbl_venta_det` VALUES (1466, 581, 11, 319, 0.00, 1, 1.00, 1.00, 6.00, 6.00, 0.00, 18.00, 6.00, 6.00, 4.00);
INSERT INTO `tbl_venta_det` VALUES (1467, 581, 12, 359, 0.00, 12, 12.00, 12.00, 2.92, 2.92, 0.00, 18.00, 35.00, 35.00, 2.62);
INSERT INTO `tbl_venta_det` VALUES (1468, 581, 14, 274, 0.00, 60, 12.00, 12.00, 2.33, 2.33, 0.00, 18.00, 28.00, 28.00, 2.08);
INSERT INTO `tbl_venta_det` VALUES (1469, 581, 15, 184, 0.00, 24, 6.00, 6.00, 3.75, 3.75, 0.00, 18.00, 22.50, 22.50, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1470, 581, 16, 249, 0.00, 20, 3.00, 3.00, 8.90, 8.90, 0.00, 18.00, 26.70, 26.70, 8.57);
INSERT INTO `tbl_venta_det` VALUES (1471, 581, 17, 418, 0.00, 48, 6.00, 6.00, 2.13, 2.13, 0.00, 18.00, 12.75, 12.75, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1472, 581, 18, 290, 0.00, 48, 12.00, 12.00, 1.96, 1.96, 0.00, 18.00, 23.50, 23.50, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1473, 581, 19, 524, 0.00, 48, 6.00, 6.00, 2.13, 2.13, 0.00, 18.00, 12.75, 12.75, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1474, 581, 20, 178, 1.00, 24, 0.00, 24.00, 0.75, 0.75, 0.00, 18.00, 18.00, 18.00, 0.66);
INSERT INTO `tbl_venta_det` VALUES (1475, 581, 21, 321, 1.00, 12, 0.00, 12.00, 0.96, 0.96, 0.00, 18.00, 11.50, 11.50, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1476, 581, 22, 289, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1477, 581, 23, 331, 1.00, 12, 1.00, 13.00, 5.17, 5.17, 0.00, 18.00, 67.17, 67.17, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1478, 581, 24, 331, 0.00, 12, 6.00, 6.00, 5.17, 5.17, 0.00, 18.00, 31.00, 31.00, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1479, 581, 25, 369, 1.00, 20, 0.00, 20.00, 0.50, 0.50, 0.00, 18.00, 10.00, 10.00, 0.45);
INSERT INTO `tbl_venta_det` VALUES (1480, 581, 26, 330, 2.00, 8, 0.00, 16.00, 0.94, 0.94, 0.00, 18.00, 15.00, 15.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1481, 581, 27, 378, 1.00, 12, 0.00, 12.00, 0.79, 0.79, 0.00, 18.00, 9.50, 9.50, 0.67);
INSERT INTO `tbl_venta_det` VALUES (1482, 581, 28, 380, 1.00, 12, 0.00, 12.00, 0.79, 0.79, 0.00, 18.00, 9.50, 9.50, 0.67);
INSERT INTO `tbl_venta_det` VALUES (1483, 581, 29, 302, 2.00, 6, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.68);
INSERT INTO `tbl_venta_det` VALUES (1484, 581, 30, 305, 1.00, 12, 0.00, 12.00, 1.04, 1.04, 0.00, 18.00, 12.50, 12.50, 0.99);
INSERT INTO `tbl_venta_det` VALUES (1485, 582, 1, 268, 1.00, 55, 1.00, 56.00, 0.42, 0.42, 0.00, 18.00, 23.42, 23.42, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1486, 583, 1, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1487, 583, 2, 207, 0.00, 12, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1488, 584, 1, 197, 1.00, 1, 0.00, 1.00, 85.00, 85.00, 0.00, 18.00, 85.00, 85.00, 81.00);
INSERT INTO `tbl_venta_det` VALUES (1489, 585, 1, 215, 1.00, 12, 0.00, 12.00, 2.17, 2.17, 0.00, 18.00, 26.00, 26.00, 2.03);
INSERT INTO `tbl_venta_det` VALUES (1490, 585, 2, 273, 0.00, 15, 4.00, 4.00, 2.00, 2.00, 0.00, 18.00, 8.00, 8.00, 1.71);
INSERT INTO `tbl_venta_det` VALUES (1491, 585, 3, 291, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.71);
INSERT INTO `tbl_venta_det` VALUES (1492, 586, 1, 208, 4.00, 1, 0.00, 4.00, 11.50, 11.50, 0.00, 18.00, 46.00, 46.00, 10.00);
INSERT INTO `tbl_venta_det` VALUES (1493, 587, 1, 193, 1.00, 6, 0.00, 6.00, 5.34, 5.34, 0.00, 18.00, 32.01, 32.01, 4.85);
INSERT INTO `tbl_venta_det` VALUES (1494, 588, 1, 454, 0.00, 6, 1.00, 1.00, 6.80, 6.80, 0.00, 18.00, 6.80, 6.80, 6.04);
INSERT INTO `tbl_venta_det` VALUES (1495, 588, 2, 354, 1.00, 12, 0.00, 12.00, 0.29, 0.29, 0.00, 18.00, 3.50, 3.50, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1496, 588, 3, 295, 1.00, 12, 0.00, 12.00, 0.88, 0.88, 0.00, 18.00, 10.50, 10.50, 0.78);
INSERT INTO `tbl_venta_det` VALUES (1497, 588, 5, 500, 0.00, 12, 2.00, 2.00, 2.20, 2.20, 0.00, 18.00, 4.40, 4.40, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1498, 588, 6, 281, 0.00, 30, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.19);
INSERT INTO `tbl_venta_det` VALUES (1499, 588, 7, 331, 0.00, 12, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.83);
INSERT INTO `tbl_venta_det` VALUES (1500, 589, 1, 499, 5.00, 1, 0.00, 5.00, 2.50, 2.50, 0.00, 18.00, 12.50, 12.50, 2.20);
INSERT INTO `tbl_venta_det` VALUES (1501, 590, 2, 203, 0.00, 24, 12.00, 12.00, 1.04, 1.04, 0.00, 18.00, 12.50, 12.50, 0.79);
INSERT INTO `tbl_venta_det` VALUES (1502, 590, 3, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1503, 590, 4, 305, 2.00, 12, 0.00, 24.00, 1.04, 1.04, 0.00, 18.00, 25.00, 25.00, 0.99);
INSERT INTO `tbl_venta_det` VALUES (1504, 591, 1, 231, 0.00, 1, 1.00, 1.00, 12.50, 12.50, 0.00, 18.00, 12.50, 12.50, 11.00);
INSERT INTO `tbl_venta_det` VALUES (1505, 591, 2, 471, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.12);
INSERT INTO `tbl_venta_det` VALUES (1506, 591, 3, 434, 0.00, 1, 0.50, 0.50, 9.00, 9.00, 0.00, 18.00, 4.50, 4.50, 7.20);
INSERT INTO `tbl_venta_det` VALUES (1507, 591, 4, 224, 0.00, 12, 1.00, 1.00, 9.00, 9.00, 0.00, 18.00, 9.00, 9.00, 7.50);
INSERT INTO `tbl_venta_det` VALUES (1508, 591, 5, 456, 0.00, 12, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.25);
INSERT INTO `tbl_venta_det` VALUES (1509, 591, 6, 248, 0.00, 50, 0.50, 0.50, 4.00, 4.00, 0.00, 18.00, 2.00, 2.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1510, 592, 1, 249, 0.00, 20, 3.00, 3.00, 9.00, 9.00, 0.00, 18.00, 27.00, 27.00, 8.57);
INSERT INTO `tbl_venta_det` VALUES (1511, 593, 1, 290, 0.00, 48, 6.00, 6.00, 1.96, 1.96, 0.00, 18.00, 11.75, 11.75, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1512, 593, 2, 373, 0.00, 48, 12.00, 12.00, 2.27, 2.27, 0.00, 18.00, 27.25, 27.25, 2.18);
INSERT INTO `tbl_venta_det` VALUES (1513, 593, 3, 578, 0.00, 12, 2.00, 2.00, 5.50, 5.50, 0.00, 18.00, 11.00, 11.00, 4.85);
INSERT INTO `tbl_venta_det` VALUES (1514, 593, 4, 255, 0.00, 20, 2.00, 2.00, 2.20, 2.20, 0.00, 18.00, 4.40, 4.40, 1.90);
INSERT INTO `tbl_venta_det` VALUES (1515, 593, 5, 283, 0.00, 40, 2.00, 2.00, 1.10, 1.10, 0.00, 18.00, 2.20, 2.20, 0.95);
INSERT INTO `tbl_venta_det` VALUES (1516, 594, 1, 276, 0.00, 12, 3.00, 3.00, 4.67, 4.67, 0.00, 18.00, 14.00, 14.00, 4.32);
INSERT INTO `tbl_venta_det` VALUES (1517, 594, 2, 253, 0.00, 12, 6.00, 6.00, 2.33, 2.33, 0.00, 18.00, 14.00, 14.00, 2.12);
INSERT INTO `tbl_venta_det` VALUES (1518, 595, 2, 459, 1.00, 6, 0.00, 6.00, 3.58, 3.58, 0.00, 18.00, 21.50, 21.50, 3.28);
INSERT INTO `tbl_venta_det` VALUES (1519, 596, 1, 248, 0.00, 50, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1520, 596, 2, 336, 0.00, 1, 0.50, 0.50, 3.50, 3.50, 0.00, 18.00, 1.75, 1.75, 2.80);
INSERT INTO `tbl_venta_det` VALUES (1521, 596, 3, 323, 0.00, 24, 1.00, 1.00, 3.20, 3.20, 0.00, 18.00, 3.20, 3.20, 2.94);
INSERT INTO `tbl_venta_det` VALUES (1522, 596, 4, 228, 0.00, 24, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 3.00, 3.00, 2.63);
INSERT INTO `tbl_venta_det` VALUES (1523, 596, 5, 258, 1.00, 1, 0.00, 1.00, 5.00, 5.00, 0.00, 18.00, 5.00, 5.00, 4.16);
INSERT INTO `tbl_venta_det` VALUES (1524, 596, 6, 380, 1.00, 12, 0.00, 12.00, 0.79, 0.79, 0.00, 18.00, 9.50, 9.50, 0.67);
INSERT INTO `tbl_venta_det` VALUES (1525, 597, 1, 253, 0.00, 12, 3.00, 3.00, 2.50, 2.50, 0.00, 18.00, 7.51, 7.51, 2.12);
INSERT INTO `tbl_venta_det` VALUES (1526, 597, 2, 286, 1.00, 40, 0.00, 40.00, 0.24, 0.24, 0.00, 18.00, 9.50, 9.50, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1527, 598, 1, 192, 0.00, 48, 3.00, 3.00, 3.33, 3.33, 0.00, 18.00, 10.00, 10.00, 3.02);
INSERT INTO `tbl_venta_det` VALUES (1528, 599, 1, 268, 1.00, 55, 0.00, 55.00, 0.42, 0.42, 0.00, 18.00, 23.00, 23.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1529, 599, 2, 260, 1.00, 10, 0.00, 10.00, 1.55, 1.55, 0.00, 18.00, 15.50, 15.50, 1.44);
INSERT INTO `tbl_venta_det` VALUES (1530, 600, 1, 294, 2.00, 1, 0.00, 2.00, 13.50, 13.50, 0.00, 18.00, 27.00, 27.00, 12.19);
INSERT INTO `tbl_venta_det` VALUES (1531, 600, 2, 235, 1.00, 40, 0.00, 40.00, 0.38, 0.38, 0.00, 18.00, 15.00, 15.00, 0.34);
INSERT INTO `tbl_venta_det` VALUES (1532, 600, 4, 246, 1.00, 24, 0.00, 24.00, 1.25, 1.25, 0.00, 18.00, 30.00, 30.00, 1.16);
INSERT INTO `tbl_venta_det` VALUES (1533, 601, 1, 239, 1.00, 50, 0.00, 50.00, 2.90, 2.90, 0.00, 18.00, 145.00, 145.00, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1534, 602, 1, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1535, 602, 2, 585, 0.00, 48, 6.00, 6.00, 1.98, 1.98, 0.00, 18.00, 11.88, 11.88, 1.79);
INSERT INTO `tbl_venta_det` VALUES (1536, 602, 3, 277, 0.00, 48, 6.00, 6.00, 1.63, 1.63, 0.00, 18.00, 9.75, 9.75, 1.52);
INSERT INTO `tbl_venta_det` VALUES (1537, 602, 4, 529, 0.00, 20, 4.00, 4.00, 1.00, 1.00, 0.00, 18.00, 4.00, 4.00, 0.84);
INSERT INTO `tbl_venta_det` VALUES (1538, 602, 5, 193, 0.00, 6, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.85);
INSERT INTO `tbl_venta_det` VALUES (1539, 602, 6, 343, 0.00, 1, 1.00, 1.00, 12.00, 12.00, 0.00, 18.00, 12.00, 12.00, 10.82);
INSERT INTO `tbl_venta_det` VALUES (1540, 602, 7, 261, 0.00, 60, 3.00, 3.00, 1.25, 1.25, 0.00, 18.00, 3.75, 3.75, 1.15);
INSERT INTO `tbl_venta_det` VALUES (1541, 602, 8, 534, 0.00, 40, 3.00, 3.00, 1.55, 1.55, 0.00, 18.00, 4.65, 4.65, 1.42);
INSERT INTO `tbl_venta_det` VALUES (1542, 602, 9, 195, 0.00, 20, 2.00, 2.00, 2.50, 2.50, 0.00, 18.00, 5.00, 5.00, 1.95);
INSERT INTO `tbl_venta_det` VALUES (1543, 602, 10, 242, 0.00, 10, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.70);
INSERT INTO `tbl_venta_det` VALUES (1544, 602, 11, 508, 0.00, 24, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 1.00, 1.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1545, 603, 1, 248, 0.00, 50, 5.00, 5.00, 4.00, 4.00, 0.00, 18.00, 20.00, 20.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1546, 603, 2, 473, 0.00, 1, 1.00, 1.00, 4.50, 4.50, 0.00, 18.00, 4.50, 4.50, 4.00);
INSERT INTO `tbl_venta_det` VALUES (1547, 603, 3, 420, 0.00, 5, 1.00, 1.00, 7.50, 7.50, 0.00, 18.00, 7.50, 7.50, 6.67);
INSERT INTO `tbl_venta_det` VALUES (1548, 603, 4, 239, 0.00, 50, 25.00, 25.00, 2.90, 2.90, 0.00, 18.00, 72.50, 72.50, 2.76);
INSERT INTO `tbl_venta_det` VALUES (1549, 604, 1, 248, 1.00, 50, 0.00, 50.00, 3.54, 3.54, 0.00, 18.00, 177.00, 177.00, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1550, 604, 2, 370, 1.00, 1, 0.00, 1.00, 31.00, 31.00, 0.00, 18.00, 31.00, 31.00, 27.80);
INSERT INTO `tbl_venta_det` VALUES (1551, 604, 3, 328, 1.00, 1, 0.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.08);
INSERT INTO `tbl_venta_det` VALUES (1552, 605, 2, 277, 0.00, 48, 6.00, 6.00, 1.63, 1.63, 0.00, 18.00, 9.75, 9.75, 1.52);
INSERT INTO `tbl_venta_det` VALUES (1553, 606, 1, 286, 2.00, 40, 0.00, 80.00, 0.24, 0.24, 0.00, 18.00, 19.00, 19.00, 0.21);
INSERT INTO `tbl_venta_det` VALUES (1554, 606, 2, 513, 1.00, 12, 0.00, 12.00, 0.46, 0.46, 0.00, 18.00, 5.50, 5.50, 0.38);
INSERT INTO `tbl_venta_det` VALUES (1555, 606, 3, 332, 1.00, 12, 0.00, 12.00, 0.83, 0.83, 0.00, 18.00, 10.00, 10.00, 0.77);
INSERT INTO `tbl_venta_det` VALUES (1556, 607, 1, 299, 0.00, 1, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 4.00, 4.00, 3.38);
INSERT INTO `tbl_venta_det` VALUES (1557, 607, 2, 320, 0.00, 50, 1.00, 1.00, 3.00, 3.00, 0.00, 18.00, 3.00, 3.00, 2.70);
INSERT INTO `tbl_venta_det` VALUES (1558, 607, 3, 240, 0.00, 12, 2.00, 2.00, 2.00, 2.00, 0.00, 18.00, 4.00, 4.00, 1.39);
INSERT INTO `tbl_venta_det` VALUES (1559, 607, 4, 242, 0.00, 10, 1.00, 1.00, 2.00, 2.00, 0.00, 18.00, 2.00, 2.00, 1.70);
INSERT INTO `tbl_venta_det` VALUES (1560, 607, 5, 428, 0.00, 100, 4.00, 4.00, 0.50, 0.50, 0.00, 18.00, 2.00, 2.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1561, 608, 1, 534, 0.00, 40, 6.00, 6.00, 1.55, 1.55, 0.00, 18.00, 9.30, 9.30, 1.42);
INSERT INTO `tbl_venta_det` VALUES (1562, 608, 2, 550, 0.00, 1, 1.00, 1.00, 46.00, 46.00, 0.00, 18.00, 46.00, 46.00, 41.23);
INSERT INTO `tbl_venta_det` VALUES (1563, 608, 3, 311, 0.00, 48, 2.00, 2.00, 2.80, 2.80, 0.00, 18.00, 5.60, 5.60, 2.40);
INSERT INTO `tbl_venta_det` VALUES (1564, 608, 4, 471, 0.00, 12, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.12);
INSERT INTO `tbl_venta_det` VALUES (1565, 608, 5, 318, 0.00, 1, 1.00, 1.00, 5.50, 5.50, 0.00, 18.00, 5.50, 5.50, 4.81);
INSERT INTO `tbl_venta_det` VALUES (1566, 608, 6, 256, 0.00, 1, 1.00, 1.00, 2.50, 2.50, 0.00, 18.00, 2.50, 2.50, 2.01);
INSERT INTO `tbl_venta_det` VALUES (1567, 608, 7, 497, 0.00, 15, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 2.00, 2.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (1568, 608, 10, 290, 0.00, 48, 6.00, 6.00, 1.96, 1.96, 0.00, 18.00, 11.75, 11.75, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1569, 608, 11, 277, 0.00, 48, 6.00, 6.00, 1.63, 1.63, 0.00, 18.00, 9.75, 9.75, 1.52);
INSERT INTO `tbl_venta_det` VALUES (1570, 609, 1, 229, 0.00, 216, 12.00, 12.00, 0.50, 0.50, 0.00, 18.00, 6.00, 6.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1571, 609, 2, 235, 0.00, 40, 16.00, 16.00, 0.38, 0.38, 0.00, 18.00, 6.00, 6.00, 0.34);
INSERT INTO `tbl_venta_det` VALUES (1572, 609, 3, 211, 1.00, 1, 0.00, 1.00, 7.50, 7.50, 0.00, 18.00, 7.50, 7.50, 6.37);
INSERT INTO `tbl_venta_det` VALUES (1573, 609, 4, 212, 1.00, 1, 0.00, 1.00, 7.50, 7.50, 0.00, 18.00, 7.50, 7.50, 6.37);
INSERT INTO `tbl_venta_det` VALUES (1574, 610, 1, 182, 0.00, 24, 6.00, 6.00, 4.58, 4.58, 0.00, 18.00, 27.50, 27.50, 3.95);
INSERT INTO `tbl_venta_det` VALUES (1575, 610, 2, 184, 0.00, 24, 6.00, 6.00, 3.75, 3.75, 0.00, 18.00, 22.50, 22.50, 3.42);
INSERT INTO `tbl_venta_det` VALUES (1576, 610, 3, 584, 0.00, 48, 12.00, 12.00, 2.08, 2.08, 0.00, 18.00, 25.00, 25.00, 1.88);
INSERT INTO `tbl_venta_det` VALUES (1577, 611, 1, 354, 4.00, 12, 0.00, 48.00, 0.29, 0.29, 0.00, 18.00, 14.00, 14.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1578, 611, 2, 176, 1.00, 25, 0.00, 25.00, 1.16, 1.16, 0.00, 18.00, 29.00, 29.00, 1.07);
INSERT INTO `tbl_venta_det` VALUES (1590, 613, 1, 281, 0.00, 30, 2.00, 2.00, 3.50, 3.50, 0.00, 18.00, 7.00, 7.00, 3.19);
INSERT INTO `tbl_venta_det` VALUES (1591, 613, 2, 289, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 1.00, 1.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1592, 613, 3, 358, 0.00, 12, 1.00, 1.00, 13.00, 13.00, 0.00, 18.00, 13.00, 13.00, 11.51);
INSERT INTO `tbl_venta_det` VALUES (1593, 614, 1, 480, 0.00, 14, 4.00, 4.00, 2.00, 2.00, 0.00, 18.00, 112.00, 8.00, 1.64);
INSERT INTO `tbl_venta_det` VALUES (1594, 615, 1, 209, 0.00, 24, 4.00, 4.00, 3.54, 3.54, 0.00, 18.00, 340.00, 14.17, 3.35);
INSERT INTO `tbl_venta_det` VALUES (1595, 615, 3, 290, 0.00, 48, 4.00, 4.00, 1.96, 1.96, 0.00, 18.00, 376.00, 7.83, 1.80);
INSERT INTO `tbl_venta_det` VALUES (1596, 616, 1, 509, 0.00, 20, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 20.00, 1.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1597, 616, 2, 268, 0.00, 55, 2.00, 2.00, 0.50, 0.50, 0.00, 18.00, 55.00, 1.00, 0.39);
INSERT INTO `tbl_venta_det` VALUES (1598, 616, 3, 497, 0.00, 15, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 30.00, 2.00, 0.63);
INSERT INTO `tbl_venta_det` VALUES (1599, 616, 4, 189, 1.00, 18, 0.00, 18.00, 0.72, 0.72, 0.00, 18.00, 234.00, 13.00, 0.66);
INSERT INTO `tbl_venta_det` VALUES (1600, 616, 5, 456, 0.00, 12, 1.00, 1.00, 4.00, 4.00, 0.00, 18.00, 48.00, 4.00, 3.25);
INSERT INTO `tbl_venta_det` VALUES (1601, 616, 6, 534, 0.00, 40, 1.00, 1.00, 1.70, 1.70, 0.00, 18.00, 68.00, 1.70, 1.42);
INSERT INTO `tbl_venta_det` VALUES (1602, 616, 7, 321, 0.00, 12, 2.00, 2.00, 1.00, 1.00, 0.00, 18.00, 24.00, 2.00, 0.83);
INSERT INTO `tbl_venta_det` VALUES (1603, 616, 8, 420, 0.00, 5, 0.50, 0.50, 7.50, 7.50, 0.00, 18.00, 18.75, 3.75, 6.67);
INSERT INTO `tbl_venta_det` VALUES (1604, 616, 9, 508, 0.00, 24, 4.00, 4.00, 0.50, 0.50, 0.00, 18.00, 48.00, 2.00, 0.25);
INSERT INTO `tbl_venta_det` VALUES (1605, 616, 11, 383, 0.00, 12, 1.00, 1.00, 1.00, 1.00, 0.00, 18.00, 12.00, 1.00, 0.75);
INSERT INTO `tbl_venta_det` VALUES (1606, 616, 12, 520, 0.00, 1, 1.00, 1.00, 3.50, 3.50, 0.00, 18.00, 3.50, 3.50, 3.00);

-- ----------------------------
-- View structure for vw_tbl_compra_cab
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_compra_cab`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_compra_cab` AS select `vc`.`id` AS `id`,`vc`.`idempresa` AS `idempresa`,`vc`.`tipocomp` AS `tipocomp`,`vc`.`serie` AS `serie`,`vc`.`correlativo` AS `correlativo`,`vc`.`fecha_emision` AS `fecha_emision`,`vc`.`fecha_vencimiento` AS `fecha_vencimiento`,`vc`.`orden_compra` AS `orden_compra`,`vc`.`condicion_venta` AS `condicion_venta`,`vc`.`cuotas_credito` AS `cuotas_credito`,`vc`.`codmoneda` AS `codmoneda`,`vc`.`op_gravadas` AS `op_gravadas`,`vc`.`op_exoneradas` AS `op_exoneradas`,`vc`.`op_inafectas` AS `op_inafectas`,`vc`.`igv` AS `igv`,`vc`.`total` AS `total`,`vc`.`codcliente` AS `codcliente`,`vc`.`feestado` AS `feestado`,`vc`.`fecodigoerror` AS `fecodigoerror`,`vc`.`femensajesunat` AS `femensajesunat`,`vc`.`nombrexml` AS `nombrexml`,`vc`.`xmlbase64` AS `xmlbase64`,`vc`.`cdrbase64` AS `cdrbase64`,`vc`.`hash` AS `hash`,`vc`.`tipocomp_ref` AS `tipocomp_ref`,`vc`.`serie_ref` AS `serie_ref`,`vc`.`correlativo_ref` AS `correlativo_ref`,`vc`.`cod_motivo` AS `cod_motivo`,`vc`.`des_motivo` AS `des_motivo`,`vc`.`estado` AS `estado`,`vc`.`vendedor` AS `vendedor`,`tc`.`id_persona` AS `id_persona`,`tc`.`nombre_persona` AS `nombre_persona`,`tc`.`direccion_persona` AS `direccion_persona`,`tc`.`distrito` AS `distrito`,`tc`.`provincia` AS `provincia`,`tc`.`departamento` AS `departamento`,`tc`.`tipo_doc` AS `tipo_doc`,`tc`.`num_doc` AS `num_doc`,`tc`.`correo` AS `correo`,`tc`.`empresa` AS `empresa`,`tc`.`clave` AS `clave`,`tc`.`servidor_cpe` AS `servidor_cpe`,`tc`.`envio_automatico` AS `envio_automatico`,`tc`.`envio_resumen` AS `envio_resumen` from (`tbl_compra_cab` `vc` left join `tbl_contribuyente` `tc` on((`vc`.`codcliente` = `tc`.`num_doc`)));

-- ----------------------------
-- View structure for vw_tbl_compra_det
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_compra_det`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_compra_det` AS select `d`.`idventa` AS `idventa`,`d`.`item` AS `item`,`d`.`idproducto` AS `codigo`,`p`.`nombre` AS `descripcion`,`d`.`cantidad` AS `cantidad`,`d`.`valor_unitario` AS `valor_unitario`,`d`.`precio_unitario` AS `precio_unitario`,'01' AS `tipo_precio`,`d`.`igv` AS `igv`,`d`.`porcentaje_igv` AS `porcentaje_igv`,`d`.`valor_total` AS `valor_total`,`d`.`importe_total` AS `importe_total`,`p`.`unidad` AS `unidad`,`a`.`codigo` AS `codigo_afectacion_alt`,`a`.`codigo_afectacion` AS `codigo_afectacion`,`a`.`nombre_afectacion` AS `nombre_afectacion`,`a`.`cod_int` AS `tipo_afectacion` from ((`tbl_compra_det` `d` left join `tbl_productos` `p` on((`d`.`idproducto` = `p`.`id`))) left join `vw_tbl_tipo_afectacion` `a` on((`p`.`afectacion` = `a`.`codigo`)));

-- ----------------------------
-- View structure for vw_tbl_serie_usuario
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_serie_usuario`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_serie_usuario` AS select `c`.`id` AS `cod_doc`,`c`.`nombre` AS `nombre`,`s`.`serie` AS `serie`,`s`.`correlativo` AS `numero`,`x`.`id_usuario` AS `usuario`,`s`.`id_empresa` AS `empresa` from (((`tbl_tipo_documento` `c` left join `tbl_series` `s` on((`c`.`id` = `s`.`id_td`))) left join `tbl_series_usuarios` `u` on((`s`.`id` = `u`.`id_serie`))) left join `tbl_usuarios` `x` on((`u`.`id_usuario` = `x`.`id_usuario`))) where (`c`.`id` in ('01','03','07','08','99'));

-- ----------------------------
-- View structure for vw_tbl_tipo_afectacion
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_tipo_afectacion`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_tipo_afectacion` AS select `ta`.`codigo` AS `codigo`,`ta`.`descripcion` AS `descripcion`,`ct`.`codigo` AS `codigo_afectacion`,`ct`.`codigo_internacional` AS `cod_int`,`ct`.`nombre` AS `nombre_afectacion` from (`tbl_tipo_afectacion` `ta` left join `tbl_tipo_tributo` `ct` on((`ta`.`codigo_tributo` = `ct`.`codigo`)));

-- ----------------------------
-- View structure for vw_tbl_usuarios
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_usuarios`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_usuarios` AS select `u`.`id_usuario` AS `id`,`u`.`usuario` AS `usuario`,`u`.`clave` AS `clave`,`u`.`perfil` AS `perfil`,concat(`u`.`nombre_personal`,' ',`u`.`apellido_personal`) AS `nombre`,`e`.`ruc` AS `ruc`,`e`.`razon_social` AS `empresa`,`e`.`id_empresa` AS `id_empresa`,`e`.`clave_certificado` AS `clave_certificado`,`e`.`clave_sol` AS `clave_sol`,`e`.`correo` AS `correo`,`e`.`departamento` AS `departamento`,`e`.`direccion` AS `direccion`,`e`.`distrito` AS `distrito`,`e`.`fecha_vencimiento` AS `fecha_vencimiento`,`e`.`provincia` AS `provincia`,`e`.`ubigeo` AS `ubigeo`,`e`.`usuario_sol` AS `usuario_sol` from (`tbl_usuarios` `u` left join `tbl_empresas` `e` on((`u`.`id_empresa` = `e`.`id_empresa`)));

-- ----------------------------
-- View structure for vw_tbl_ventas_diarias
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_ventas_diarias`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_ventas_diarias` AS select `tbl_venta_cab`.`vendedor` AS `vendedor`,`tbl_venta_cab`.`fecha_emision` AS `fecha`,`tbl_venta_cab`.`tipocomp` AS `tipocomp`,`tbl_venta_cab`.`serie` AS `serie`,min(`tbl_venta_cab`.`correlativo`) AS `desde`,max(`tbl_venta_cab`.`correlativo`) AS `hasta`,cast(sum(`tbl_venta_cab`.`op_gravadas`) as decimal(10,2)) AS `op_gravadas`,cast(sum(`tbl_venta_cab`.`op_inafectas`) as decimal(10,2)) AS `op_inafectas`,cast(sum(`tbl_venta_cab`.`op_exoneradas`) as decimal(10,2)) AS `op_exoneradas`,cast(sum(`tbl_venta_cab`.`igv`) as decimal(10,2)) AS `igv`,cast((((sum(`tbl_venta_cab`.`op_gravadas`) + sum(`tbl_venta_cab`.`op_inafectas`)) + sum(`tbl_venta_cab`.`op_exoneradas`)) + sum(`tbl_venta_cab`.`igv`)) as decimal(10,2)) AS `total` from `tbl_venta_cab` group by `tbl_venta_cab`.`vendedor`,`tbl_venta_cab`.`fecha_emision`,`tbl_venta_cab`.`tipocomp`;

-- ----------------------------
-- View structure for vw_tbl_ventas_sunat
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_ventas_sunat`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_ventas_sunat` AS select `vc`.`fecha_emision` AS `fecha_emision`,`vc`.`fecha_vencimiento` AS `fecha_vencimiento`,if((`vc`.`tipocomp` = '01'),'FACTUTA',if((`vc`.`tipocomp` = '03'),'BOLETA DE VENTA',if((`vc`.`tipocomp` = '99'),'NOTA DE VENTA','NOTA DE CREDITO'))) AS `nomdoc`,`vc`.`tipocomp` AS `td`,`vc`.`serie` AS `serie`,`vc`.`correlativo` AS `numero`,`co`.`tipo_doc` AS `doc`,`co`.`num_doc` AS `num_cli`,0.00 AS `valor_exportacion`,cast(`vc`.`op_gravadas` as decimal(10,2)) AS `op_gravadas`,cast(`vc`.`op_exoneradas` as decimal(10,2)) AS `op_exoneradas`,cast(`vc`.`op_inafectas` as decimal(10,2)) AS `op_inafectas`,0.00 AS `isc`,cast(`vc`.`igv` as decimal(10,2)) AS `igv`,0.00 AS `icbper`,0.00 AS `oth`,cast((((`vc`.`op_gravadas` + `vc`.`op_exoneradas`) + `vc`.`op_inafectas`) + `vc`.`igv`) as decimal(10,2)) AS `total`,`vc`.`tipocomp_ref` AS `tipo_ref`,`vc`.`serie_ref` AS `serie_ref`,`vc`.`correlativo_ref` AS `correlativo_ref`,`vc`.`idempresa` AS `empresa` from (`tbl_venta_cab` `vc` left join `tbl_contribuyente` `co` on((`vc`.`codcliente` = `co`.`num_doc`)));

-- ----------------------------
-- View structure for vw_tbl_venta_cab
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_venta_cab`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_venta_cab` AS select `vc`.`id` AS `id`,`vc`.`idempresa` AS `idempresa`,`vc`.`tipocomp` AS `tipocomp`,if((`vc`.`tipocomp` = '01'),'FACTURA ELECTRONICA',if((`vc`.`tipocomp` = '03'),'BOLETA DE VENTA ELECTRONICA','NOTA DE CREDITO')) AS `nomdoc`,`vc`.`serie` AS `serie`,`vc`.`correlativo` AS `correlativo`,`vc`.`fecha_emision` AS `fecha_emision`,`vc`.`fecha_vencimiento` AS `fecha_vencimiento`,`vc`.`orden_compra` AS `orden_compra`,`vc`.`condicion_venta` AS `condicion_venta`,`vc`.`cuotas_credito` AS `cuotas_credito`,`vc`.`codmoneda` AS `codmoneda`,`vc`.`op_gravadas` AS `op_gravadas`,`vc`.`op_exoneradas` AS `op_exoneradas`,`vc`.`op_inafectas` AS `op_inafectas`,`vc`.`igv` AS `igv`,`vc`.`total` AS `total`,`vc`.`codcliente` AS `codcliente`,`vc`.`feestado` AS `feestado`,`vc`.`fecodigoerror` AS `fecodigoerror`,`vc`.`femensajesunat` AS `femensajesunat`,`vc`.`nombrexml` AS `nombrexml`,`vc`.`xmlbase64` AS `xmlbase64`,`vc`.`cdrbase64` AS `cdrbase64`,`vc`.`hash` AS `hash`,`vc`.`tipocomp_ref` AS `tipocomp_ref`,`vc`.`serie_ref` AS `serie_ref`,`vc`.`correlativo_ref` AS `correlativo_ref`,`vc`.`cod_motivo` AS `cod_motivo`,`vc`.`des_motivo` AS `des_motivo`,`vc`.`estado` AS `estado`,`vc`.`vendedor` AS `vendedor`,`tc`.`id_persona` AS `id_persona`,`tc`.`nombre_persona` AS `nombre_persona`,`tc`.`direccion_persona` AS `direccion_persona`,`tc`.`distrito` AS `distrito`,`tc`.`provincia` AS `provincia`,`tc`.`departamento` AS `departamento`,`tc`.`tipo_doc` AS `tipo_doc`,`tc`.`num_doc` AS `num_doc`,`tc`.`correo` AS `correo`,`tc`.`empresa` AS `empresa`,`tc`.`clave` AS `clave`,`tc`.`servidor_cpe` AS `servidor_cpe`,`tc`.`envio_automatico` AS `envio_automatico`,`tc`.`envio_resumen` AS `envio_resumen` from (`tbl_venta_cab` `vc` left join `tbl_contribuyente` `tc` on((`vc`.`codcliente` = `tc`.`num_doc`)));

-- ----------------------------
-- View structure for vw_tbl_venta_det
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_venta_det`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_venta_det` AS select `d`.`idventa` AS `idventa`,`d`.`item` AS `item`,`d`.`idproducto` AS `codigo`,`p`.`nombre` AS `descripcion`,`d`.`cantidad` AS `cantidad`,`p`.`factor` AS `factor`,`d`.`cantidad_factor` AS `cantidad_factor`,`d`.`cantidad_unitario` AS `cantidad_unitario`,`d`.`valor_unitario` AS `valor_unitario`,`d`.`precio_unitario` AS `precio_unitario`,'01' AS `tipo_precio`,`d`.`igv` AS `igv`,`d`.`porcentaje_igv` AS `porcentaje_igv`,`d`.`valor_total` AS `valor_total`,`d`.`importe_total` AS `importe_total`,`p`.`unidad` AS `unidad`,`a`.`codigo` AS `codigo_afectacion_alt`,`a`.`codigo_afectacion` AS `codigo_afectacion`,`a`.`nombre_afectacion` AS `nombre_afectacion`,`a`.`cod_int` AS `tipo_afectacion` from ((`tbl_venta_det` `d` left join `tbl_productos` `p` on((`d`.`idproducto` = `p`.`id`))) left join `vw_tbl_tipo_afectacion` `a` on((`p`.`afectacion` = `a`.`codigo`)));

SET FOREIGN_KEY_CHECKS = 1;
