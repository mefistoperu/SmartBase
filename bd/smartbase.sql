/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50560
 Source Host           : localhost:3306
 Source Schema         : smartbase

 Target Server Type    : MySQL
 Target Server Version : 50560
 File Encoding         : 65001

 Date: 11/02/2023 23:05:36
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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_almacen
-- ----------------------------
INSERT INTO `tbl_almacen` VALUES (14, 'ALMACEN TACNA', '-', 1, '1');

-- ----------------------------
-- Table structure for tbl_categorias
-- ----------------------------
DROP TABLE IF EXISTS `tbl_categorias`;
CREATE TABLE `tbl_categorias`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `cuenta_venta` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `cuenta_compra` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '1',
  `empresa` int(5) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_categorias
-- ----------------------------
INSERT INTO `tbl_categorias` VALUES (6, 'POP CORN', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (7, 'SNACK', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (8, 'COMBO 01', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (9, 'COMBO 02', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (10, 'COMBO 03', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (11, 'COMBO 04', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (12, 'COMBO 05', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (13, 'GASEOSA CHICA', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (14, 'GASEOSA MEDIANA', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (15, 'GASEOSA GRANDE', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (16, 'BEBIDAS FRIAS', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (17, 'BEBIDAS CALIENTES', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (18, 'GOLOSINAS', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (19, 'ADICIONALES', '7011111', '6011111', '1', 1);
INSERT INTO `tbl_categorias` VALUES (20, 'INSUMOS', '7011111', '6011111', '1', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_compra_cab
-- ----------------------------
INSERT INTO `tbl_compra_cab` VALUES (1, 1, '03', 'INV', 00000001, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 16.95000, 0.00000, 0.00000, 3.05000, 20.00000, '44168916', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_compra_cab` VALUES (2, 1, '03', 'INV', 00000002, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 8.47000, 0.00000, 0.00000, 1.52000, 10.00000, '01117739', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_compra_cab` VALUES (3, 1, '03', '0001', 00011111, '2023-02-06', '2023-02-06', NULL, '1', 0, 'PEN', 211.86000, 0.00000, 0.00000, 38.13000, 250.00000, '00001', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_compra_cab` VALUES (4, 1, '01', 'F001', 00000123, '2023-02-11', '2023-02-11', NULL, '1', 0, 'PEN', 10.17000, 0.00000, 0.00000, 1.83000, 12.00000, '20548960771', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1);
INSERT INTO `tbl_compra_cab` VALUES (5, 1, '01', 'F012', 00001254, '2023-02-11', '2023-02-11', NULL, '1', 0, 'PEN', 15.25000, 0.00000, 0.00000, 2.75000, 18.00000, '20600716167', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_compra_det
-- ----------------------------
INSERT INTO `tbl_compra_det` VALUES (1, 1, 1, 605, 10.00, 1.69492, 2.00000, 0.30508, 18.00, 16.94915, 20.00);
INSERT INTO `tbl_compra_det` VALUES (2, 2, 1, 605, 5.00, 1.69492, 2.00000, 0.30508, 18.00, 8.47458, 10.00);
INSERT INTO `tbl_compra_det` VALUES (3, 3, 1, 603, 10.00, 21.18644, 25.00000, 3.81356, 18.00, 211.86441, 250.00);
INSERT INTO `tbl_compra_det` VALUES (4, 4, 1, 607, 100.00, 0.10169, 0.12000, 0.01831, 18.00, 10.16949, 12.00);
INSERT INTO `tbl_compra_det` VALUES (5, 5, 1, 608, 100.00, 0.15254, 0.18000, 0.02746, 18.00, 15.25424, 18.00);

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
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_contribuyente
-- ----------------------------
INSERT INTO `tbl_contribuyente` VALUES (44, 'CLIENTE FINAL', 'TARAPOTO01', 'TARAPOTO', 'SAN MARTIN', 'SAN MARTIN', '0', '99999999', 'demo@demo.com', 1, NULL, NULL, NULL, NULL, 'ef775988943825d2871e1cfa75473ec0');
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
INSERT INTO `tbl_contribuyente` VALUES (73, 'ZULUETA VASQUEZ NOEMI', '-', 'LIMA', 'LIMA', 'LIMA', '1', '45819485', 's@g.com', 1, NULL, NULL, NULL, NULL, '920e9e844726c54f51deb6840798cbb1');
INSERT INTO `tbl_contribuyente` VALUES (74, 'MACROSS SERVICE E.I.R.L.', 'JR. YAVARI NRO. 348 LORETO MAYNAS IQUITOS', 'IQUITOS', 'MAYNAS', 'LORETO', '6', '20493434340', 'jmvalverdec@gmail.com', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_contribuyente` VALUES (75, 'VALVERDE CASTILLO JUAN MIGUEL', 'G', 'D', 'D', 'D', '6', '10441689166', 'd@d.com', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_contribuyente` VALUES (76, 'ROSITA', '', '', '', '', '0', '00001', '', 1, NULL, NULL, NULL, NULL, '4c68cea7e58591b579fd074bcdaff740');
INSERT INTO `tbl_contribuyente` VALUES (77, 'PENTARAMA EL PACIFICO S.A.', 'AV. JOSE PARDO NRO. 121 LIMA LIMA MIRAFLORES', 'MIRAFLORES', 'LIMA', 'LIMA', '6', '20548960771', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_contribuyente` VALUES (78, 'TRANSPACIFIC INVESTMENT SRL', 'JR. ARICA NRO. 258 LORETO MAYNAS IQUITOS', 'IQUITOS', 'MAYNAS', 'LORETO', '6', '20493223641', '', 1, NULL, NULL, NULL, NULL, '5f01c558e622d56011307c9124d1807a');

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
) ENGINE = InnoDB AUTO_INCREMENT = 627 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_cta_cobrar
-- ----------------------------
INSERT INTO `tbl_cta_cobrar` VALUES (601, '1', '99999999', '03', 'B001', '00000147', 21.00000, '2022-12-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (602, '2', '99999999', '03', 'B001', '00000147', 21.00000, '2022-12-27', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (603, '2', '99999999', '99', 'NV01', '00000006', 35.00000, '2023-02-02', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (604, '2', '99999999', '99', 'NV01', '00000007', 2.20000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (605, '2', '99999999', '99', 'NV01', '00000007', 2.20000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (606, '2', '00001', '99', 'NV01', '00000008', 66.00000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (607, '1', '44168916', '03', 'B001', '00000148', 10.80000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (608, '2', '44168916', '03', 'B001', '00000148', 10.80000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (609, '1', '99999999', '03', 'B001', '00000149', 22.00000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (610, '2', '99999999', '03', 'B001', '00000149', 22.00000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (611, '2', '00001', '99', 'NV01', '00000009', 28.00000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (612, '1', '99999999', '03', 'B001', '00000150', 110.00000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (613, '2', '99999999', '03', 'B001', '00000150', 110.00000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (614, '1', '99999999', '03', 'B001', '00000150', 110.00000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (615, '2', '99999999', '03', 'B001', '00000150', 110.00000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (616, '2', '99999999', '99', 'NV01', '00000010', 270.00000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (617, '2', '99999999', '99', 'NV01', '00000011', 4.32000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (618, '2', '99999999', '99', 'NV01', '00000011', 4.32000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (619, '1', '00001', '03', 'B001', '00000151', 46.67000, '2023-02-09', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (620, '2', '00001', '03', 'B001', '00000151', 46.67000, '2023-02-09', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (621, '1', '20494191637', '01', 'F001', '00000052', 1.00000, '2023-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (622, '2', '20494191637', '01', 'F001', '00000052', 1.00000, '2023-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (623, '1', '00001', '03', 'B001', '00000152', 20.00000, '2023-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (624, '2', '00001', '03', 'B001', '00000152', 20.00000, '2023-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (625, '1', '20493223641', '01', 'F001', '00000053', 4.41000, '2023-02-11', NULL, 1);
INSERT INTO `tbl_cta_cobrar` VALUES (626, '2', '20493223641', '01', 'F001', '00000053', 4.41000, '2023-02-11', NULL, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_cta_pagar
-- ----------------------------
INSERT INTO `tbl_cta_pagar` VALUES (1, '1', '44168916', '03', 'INV', '001', 20.00000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (2, '1', '01117739', '03', 'INV', '0002', 10.00000, '2023-02-03', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (3, '1', '00001', '03', '0001', '11111', 250.00000, '2023-02-06', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (4, '1', '20548960771', '01', 'F001', '123', 12.00000, '2023-02-11', NULL, 1);
INSERT INTO `tbl_cta_pagar` VALUES (5, '1', '20600716167', '01', 'F012', '1254', 18.00000, '2023-02-11', NULL, 1);

-- ----------------------------
-- Table structure for tbl_documento_identidad
-- ----------------------------
DROP TABLE IF EXISTS `tbl_documento_identidad`;
CREATE TABLE `tbl_documento_identidad`  (
  `id_tdi` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descruipcion_tdi` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tdi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
  `nombre_comercial` char(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `direccion` char(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `distrito` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `provincia` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `departamento` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `ubigeo` char(6) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `celular` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `telefono` char(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
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
  `comentario` char(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `correo_envio` char(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `clave_correo` char(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `smtp` char(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `puerto` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `venta_por_mayor` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT 'SI',
  `top1` int(3) NULL DEFAULT NULL,
  `top2` int(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empresa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_empresas
-- ----------------------------
INSERT INTO `tbl_empresas` VALUES (1, '10452424423', 'COMERCIAL SMARTCITO', '-', 'JR. SMART SOLUTIONS 2702', 'ATE', 'LIMA', 'LIMA', '221101', '', '', 'jmvalverdec@gmail.com', 'FACTURA12', 'A12345678a', '10452424423.pfx', 'Ajjm2123', '40111', '40111', '42121', '42122', '12121', '12122', '02', '03', '01', '04', 18.00, '12345', '2021-12-29', '2022-09-08', 'logo_hayda.jpeg', 1, 'SI', 'NO', 'bcp: 1234 5678 9123 4567<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />\r\nbbva: 9876 5432 1987 6543', '', '', '', '', 'SI', 3, 2);

-- ----------------------------
-- Table structure for tbl_error
-- ----------------------------
DROP TABLE IF EXISTS `tbl_error`;
CREATE TABLE `tbl_error`  (
  `cod` char(4) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre` char(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_forma_pago
-- ----------------------------
INSERT INTO `tbl_forma_pago` VALUES ('CR', 'CREDITO', '2', 0);
INSERT INTO `tbl_forma_pago` VALUES ('EF', 'CONTADO', '1', 0);

-- ----------------------------
-- Table structure for tbl_guia_cab
-- ----------------------------
DROP TABLE IF EXISTS `tbl_guia_cab`;
CREATE TABLE `tbl_guia_cab`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `i_s` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tipocomp` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `serie` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `numero` int(8) UNSIGNED ZEROFILL NOT NULL,
  `fecha_emi` date NOT NULL,
  `fecha_traslado` date NOT NULL,
  `tipo_mov` int(5) NOT NULL,
  `contribuyente` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `moneda` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tc` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `almacen` int(5) NOT NULL,
  `vendedor` int(5) NOT NULL,
  `observacion` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion_partida` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion_llegada` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mod_transportes` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transportista` int(5) NOT NULL,
  `vehiculo` int(5) NOT NULL,
  `totalitems` int(5) NOT NULL,
  `peso` decimal(10, 3) NOT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_guia_cab
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_guia_det
-- ----------------------------
DROP TABLE IF EXISTS `tbl_guia_det`;
CREATE TABLE `tbl_guia_det`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_guia` int(10) NOT NULL,
  `item` int(5) NOT NULL,
  `id_producto` int(10) NOT NULL,
  `cantidad` decimal(10, 2) NOT NULL,
  `costo_unitario` decimal(10, 2) NOT NULL,
  `costo_total` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_guia_det
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_marcas
-- ----------------------------
INSERT INTO `tbl_marcas` VALUES (158, 'NESTLE', '0', 1);
INSERT INTO `tbl_marcas` VALUES (159, 'SIN MARCA', '1', 1);
INSERT INTO `tbl_marcas` VALUES (160, 'LINDLEY', '1', 1);
INSERT INTO `tbl_marcas` VALUES (161, 'MARCA DEMO', '1', 1);

-- ----------------------------
-- Table structure for tbl_medio_pago
-- ----------------------------
DROP TABLE IF EXISTS `tbl_medio_pago`;
CREATE TABLE `tbl_medio_pago`  (
  `id_mdp` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_mdp` char(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_mdp`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
-- Table structure for tbl_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_menu`;
CREATE TABLE `tbl_menu`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `nombre` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nivel` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `padre` int(5) NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `link` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_menu
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
-- Table structure for tbl_plan_cuenta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_cuenta`;
CREATE TABLE `tbl_plan_cuenta`  (
  `cuenta` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `cuenta2` char(7) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `nombre` char(70) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `nivel` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `analisis` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT '0',
  `clase` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `destino` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `moneda` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `cc` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`cuenta`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_plan_cuenta
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_plan_cuenta_clase
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_cuenta_clase`;
CREATE TABLE `tbl_plan_cuenta_clase`  (
  `codigo` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `descripcion` char(30) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_plan_cuenta_clase
-- ----------------------------
INSERT INTO `tbl_plan_cuenta_clase` VALUES ('01', 'INVENTARIO');
INSERT INTO `tbl_plan_cuenta_clase` VALUES ('02', 'MAYOR');
INSERT INTO `tbl_plan_cuenta_clase` VALUES ('03', 'FUNCION');
INSERT INTO `tbl_plan_cuenta_clase` VALUES ('04', 'NATURALEZA');
INSERT INTO `tbl_plan_cuenta_clase` VALUES ('05', 'RESULTADO');

-- ----------------------------
-- Table structure for tbl_plan_cuenta_destino
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_cuenta_destino`;
CREATE TABLE `tbl_plan_cuenta_destino`  (
  `cuenta` char(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cuenta_cargo` char(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.00',
  `cuenta_abono` char(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `porcentaje` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`cuenta`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_plan_cuenta_destino
-- ----------------------------

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
  `unidadu` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
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
  `sku` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `imagen` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `venta` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL DEFAULT 'SI',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_unidad_insumo`(`unidad`) USING BTREE,
  CONSTRAINT `tbl_productos_ibfk_1` FOREIGN KEY (`unidad`) REFERENCES `tbl_unidad` (`cod`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 609 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_productos
-- ----------------------------
INSERT INTO `tbl_productos` VALUES (596, 'CAJA CHICA', '', 159, 'NIU', NULL, 1, 0.01, 0.00, 0.01, 0.00, 0.01, '10', '1', 1, -11.00, 'CCH', '', 'NO');
INSERT INTO `tbl_productos` VALUES (597, 'CAJA MEDIANA', '', 159, 'NIU', NULL, 1, 0.02, 0.00, 0.02, 0.00, 0.02, '10', '1', 1, 0.00, 'CME', '', 'NO');
INSERT INTO `tbl_productos` VALUES (598, 'CAJA GRANDE', '', 159, 'NIU', NULL, 1, 0.03, 0.00, 0.03, 0.00, 0.03, '10', '1', 1, 0.00, 'CGR', '', 'NO');
INSERT INTO `tbl_productos` VALUES (599, 'VASO CHICO', '', 159, 'NIU', NULL, 1, 0.00, 0.00, 0.00, 0.00, 0.00, '10', '1', 1, -11.00, 'VCH', '', 'NO');
INSERT INTO `tbl_productos` VALUES (600, 'VASO MEDIANO', '', 159, 'NIU', NULL, 1, 0.00, 0.00, 0.00, 0.00, 0.00, '10', '1', 1, 0.00, 'VME', '', 'NO');
INSERT INTO `tbl_productos` VALUES (601, 'VASO GRANDE', '', 159, 'NIU', NULL, 1, 0.00, 0.00, 0.00, 0.00, 0.00, '10', '1', 1, 0.00, 'VGR', '', 'NO');
INSERT INTO `tbl_productos` VALUES (602, 'COCA COLA', '', 160, 'CAJ', NULL, 4112, 1.00, 0.00, 4112.00, 0.00, 4112.00, '10', '1', 1, -352.00, 'CAJCOC', '', 'NO');
INSERT INTO `tbl_productos` VALUES (603, 'MAIZ', '', 159, 'BLS', NULL, 22, 25.00, 0.00, 550.00, 0.00, 550.00, '10', '1', 1, 10.00, 'MAIZ', '', 'NO');
INSERT INTO `tbl_productos` VALUES (604, 'COMBO 01', '', 159, 'NIU', NULL, 12, 7.00, 0.00, 70.00, 0.00, 70.00, '10', '1', 1, -9.00, '77', '', 'SI');
INSERT INTO `tbl_productos` VALUES (605, 'PRODUCTO DE PRUEBA', '', 159, 'CAJ', NULL, 6, 2.00, 10.00, 2.20, 8.00, 2.16, '10', '1', 1, -17.00, '-', '', 'SI');
INSERT INTO `tbl_productos` VALUES (606, 'FSDGFDSG', '', 159, 'BLI', 'GRA', 25, 2.00, 10.00, 55.00, 8.00, 54.00, '10', '1', 1, -244.00, '-', '', 'SI');
INSERT INTO `tbl_productos` VALUES (607, 'PASTILLA ASPIRINA', '', 159, 'BLI', 'NIU', 10, 0.12, 20.00, 2.00, 0.00, 1.20, '10', '1', 1, -5.00, '-', '', 'SI');
INSERT INTO `tbl_productos` VALUES (608, 'PASTILLA', '', 159, 'BLI', 'NIU', 10, 0.18, 20.00, 2.10, 0.00, 2.10, '10', '1', 1, 79.00, '-', '', 'SI');

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
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_recetas
-- ----------------------------
INSERT INTO `tbl_recetas` VALUES (15, 604, 596, 1.00);
INSERT INTO `tbl_recetas` VALUES (16, 604, 599, 1.00);
INSERT INTO `tbl_recetas` VALUES (17, 604, 602, 32.00);

-- ----------------------------
-- Table structure for tbl_series
-- ----------------------------
DROP TABLE IF EXISTS `tbl_series`;
CREATE TABLE `tbl_series`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_td` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `id_doc` int(5) NULL DEFAULT NULL,
  `serie` char(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `correlativo` int(8) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `id_empresa` int(5) NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '1',
  `flat` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_serie`(`id_td`) USING BTREE,
  CONSTRAINT `fk_serie` FOREIGN KEY (`id_td`) REFERENCES `tbl_tipo_documento` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_series
-- ----------------------------
INSERT INTO `tbl_series` VALUES (15, '01', 2, 'F001', 00000054, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (16, '03', 4, 'B001', 00000153, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (17, '01', 2, 'F002', 00000005, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (18, '07', 8, 'FC01', 00000007, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (19, '07', 60, 'BC01', 00000007, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (20, '99', 48, 'NV01', 00000012, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (21, '03', 4, 'B002', 00000130, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (22, '07', 60, 'BC02', 00000001, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (23, '01', 2, 'F002', 00000005, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (24, '99', 48, 'NV02', 00000053, 1, '1', '0');
INSERT INTO `tbl_series` VALUES (25, '01', 4, 'BO01', 00000005, 1, '0', '0');
INSERT INTO `tbl_series` VALUES (26, '07', 60, 'BC02', 00000001, 1, '1', '1');
INSERT INTO `tbl_series` VALUES (27, '07', 60, 'BC04', 00000001, 1, '1', '0');

-- ----------------------------
-- Table structure for tbl_series_usuarios
-- ----------------------------
DROP TABLE IF EXISTS `tbl_series_usuarios`;
CREATE TABLE `tbl_series_usuarios`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(5) NULL DEFAULT NULL,
  `id_serie` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
INSERT INTO `tbl_series_usuarios` VALUES (25, 1, 26);

-- ----------------------------
-- Table structure for tbl_servidor
-- ----------------------------
DROP TABLE IF EXISTS `tbl_servidor`;
CREATE TABLE `tbl_servidor`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `link` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `nombre` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tipo` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_servidor
-- ----------------------------
INSERT INTO `tbl_servidor` VALUES (1, 'https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService', 'BETA', 'SUNAT', '1');
INSERT INTO `tbl_servidor` VALUES (2, 'https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService?wsdl', 'PRODUCCION', 'SUNAT', '1');

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
INSERT INTO `tbl_tipo_documento` VALUES (8, '07', 'NOTA DE CREDITO FACTURA', '1');
INSERT INTO `tbl_tipo_documento` VALUES (9, '08', 'NOTA DE DEBITO DE FACTURA', '1');
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
INSERT INTO `tbl_tipo_documento` VALUES (60, '07', 'NOTA DE CREDITO BOLETA', '1');
INSERT INTO `tbl_tipo_documento` VALUES (61, '08', 'NOTA DE DEBITO DE BOLETA', '1');
INSERT INTO `tbl_tipo_documento` VALUES (62, 'RC', 'RESUMEN DE COMPROBANTES', '1');

-- ----------------------------
-- Table structure for tbl_tipo_moneda
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_moneda`;
CREATE TABLE `tbl_tipo_moneda`  (
  `id_mon` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_mon` char(40) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_mon`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_tipo_moneda
-- ----------------------------
INSERT INTO `tbl_tipo_moneda` VALUES ('1', 'NUEVOS SOLES');
INSERT INTO `tbl_tipo_moneda` VALUES ('2', 'DÓLARES AMERICANOS');
INSERT INTO `tbl_tipo_moneda` VALUES ('9', 'OTRA MONEDA (ESPECIFICAR)');

-- ----------------------------
-- Table structure for tbl_tipo_movimiento
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_movimiento`;
CREATE TABLE `tbl_tipo_movimiento`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `codigo` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripcion` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_tipo_movimiento
-- ----------------------------
INSERT INTO `tbl_tipo_movimiento` VALUES (1, 'I001', 'INVENTARIO INICIAL', '1');
INSERT INTO `tbl_tipo_movimiento` VALUES (2, 'I002', 'COMPRAS', '1');
INSERT INTO `tbl_tipo_movimiento` VALUES (3, 'I003', 'DEVOLUCION DE VENTAS', '1');
INSERT INTO `tbl_tipo_movimiento` VALUES (4, 'I004', 'GUIA DE INGRESO', '1');
INSERT INTO `tbl_tipo_movimiento` VALUES (5, 'S001', 'VENTAS', '2');
INSERT INTO `tbl_tipo_movimiento` VALUES (6, 'S002', 'DEVOLUCION DE COMPRA', '2');
INSERT INTO `tbl_tipo_movimiento` VALUES (7, 'S003', 'GUIA DE SALIDA', '2');

-- ----------------------------
-- Table structure for tbl_tipo_operacion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_operacion`;
CREATE TABLE `tbl_tipo_operacion`  (
  `id` char(2) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
-- Table structure for tbl_tipo_pago
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_pago`;
CREATE TABLE `tbl_tipo_pago`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mpago` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_tipo_pago
-- ----------------------------
INSERT INTO `tbl_tipo_pago` VALUES (1, 'EFECTIVO', '009');
INSERT INTO `tbl_tipo_pago` VALUES (2, 'VISA DEBITO', '005');
INSERT INTO `tbl_tipo_pago` VALUES (3, 'VISA CREDITO', '006');
INSERT INTO `tbl_tipo_pago` VALUES (4, 'YAPE', '003');
INSERT INTO `tbl_tipo_pago` VALUES (5, 'PLIN', '003');
INSERT INTO `tbl_tipo_pago` VALUES (6, 'TRANSFERENCIA', '003');

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_unidad
-- ----------------------------
INSERT INTO `tbl_unidad` VALUES ('BLI', 'BLISTER', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('BLS', 'BOLSA', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('CAJ', 'CAJAS', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('DOC', 'DOCENA', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('GRA', 'GARMOS', 'NIU');
INSERT INTO `tbl_unidad` VALUES ('JGO', 'JUEGO', 'NIU');
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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_usuarios
-- ----------------------------
INSERT INTO `tbl_usuarios` VALUES (1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'ADMINISTRADOR', 'SMART', 1, '1', 8, 1);
INSERT INTO `tbl_usuarios` VALUES (5, 'VENTA', '81dc9bdb52d04dc20036dbd8313ed055', 'VENTAS', 'VENTAS', 1, '1', 8, 3);
INSERT INTO `tbl_usuarios` VALUES (6, 'CONTROL', 'b0baee9d279d34fa1dfd71aadb908c3f', 'USUARIO01', 'CONTROL', 1, '0', 8, 2);

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
  `dias` int(2) NOT NULL DEFAULT 0,
  `serie_resumen` char(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `numero_resumen` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `ticket` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `obs` char(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tipcomp`(`tipocomp`) USING BTREE,
  INDEX `fk_moneda`(`codmoneda`) USING BTREE,
  INDEX `fk_cliente`(`codcliente`) USING BTREE,
  INDEX `fk_emisor`(`idempresa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 699 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_venta_cab
-- ----------------------------
INSERT INTO `tbl_venta_cab` VALUES (670, 1, '03', 'B001', 00000139, '2022-09-09', '2022-09-09', NULL, '2', 0, 'PEN', 8.47, 15.00, 0.00, 1.52, 25.00, '99999999', 2, '', '', NULL, NULL, NULL, 'i6P30CwWGK9Egi0eaE+9cgbWuVU=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (671, 1, '03', 'B001', 00000140, '2022-09-09', '2022-09-09', NULL, '2', 0, 'PEN', 8.47, 15.00, 0.00, 1.52, 25.00, '44168916', 0, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'nhMzl+j7dDU2CSQ1TeUJpAbzSgo=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (672, 1, '07', 'BC01', 00000006, '2022-09-09', '2022-09-09', NULL, '2', 0, 'PEN', 8.47, 15.00, 0.00, 1.52, 25.00, '44168916', 0, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'qXb40y7ugIAkdwjP8lOMhP/LjkY=', '03', 'B001', 00000140, '01', 'ANULACION DE LA OPERACION', '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (673, 1, '99', 'NV01', 00000003, '2022-09-12', '2022-09-12', NULL, '2', 0, 'PEN', 8.47, 15.00, 0.00, 1.52, 25.00, '01117739', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (674, 1, '03', 'B001', 00000141, '2022-09-14', '2022-09-14', NULL, '0', 0, 'PEN', 8.47, 7.50, 0.00, 1.52, 17.50, '44168916', 1, '', 'Aceptado por SUNAT', NULL, NULL, NULL, 'qz8pVbkf/BTrSQWqEdWvlFyDZEc=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, '20220921', '2', '1663794699152', NULL);
INSERT INTO `tbl_venta_cab` VALUES (675, 1, '03', 'B001', 00000142, '2022-09-14', '2022-09-14', NULL, '0', 0, 'PEN', 8.47, 0.00, 0.00, 1.52, 10.00, '44168916', 1, '', 'Aceptado por SUNAT', NULL, NULL, NULL, 'qz8pVbkf/BTrSQWqEdWvlFyDZEc=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, '20220921', '2', '1663794699152', NULL);
INSERT INTO `tbl_venta_cab` VALUES (676, 1, '99', 'NV01', 00000004, '2022-09-14', '2022-09-14', NULL, '1', 0, 'PEN', 0.00, 15.00, 0.00, 0.00, 15.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (677, 1, '99', 'NV01', 00000005, '2022-09-14', '2022-09-14', NULL, '1', 0, 'PEN', 8.47, 0.00, 0.00, 1.52, 10.00, '44168916', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (678, 1, '03', 'B001', 00000143, '2022-09-21', '2022-09-21', NULL, '1', 0, 'PEN', 4.24, 0.00, 0.00, 0.76, 5.00, '44168916', 0, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'm2gdl6V4pGqadzuRqEmXWVxlnAU=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (679, 1, '03', 'B001', 00000144, '2022-09-27', '2022-09-27', NULL, '1', 0, 'PEN', 1.36, 0.00, 0.00, 0.24, 1.60, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'p0Xn8d+KU+h59wxd7pr+cbECu9s=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (680, 1, '03', 'B001', 00000145, '2022-09-27', '2022-09-27', NULL, '1', 0, 'PEN', 2.54, 0.00, 0.00, 0.46, 3.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Isb4OgUmeEMfhqB8TGbTO7W7QUE=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (681, 1, '03', 'B001', 00000146, '2022-11-15', '2022-11-15', NULL, '1', 0, 'PEN', 7.63, 0.00, 0.00, 1.37, 9.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'S64u9/pFrcMByZ9Erwl7Z9//akc=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (682, 1, '03', 'B001', 00000147, '2022-12-27', '2022-12-27', NULL, '1', 0, 'PEN', 17.80, 0.00, 0.00, 3.20, 21.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'f27LaRteieBpO6ZwVFUuIss95lU=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (683, 1, '99', 'NV01', 00000006, '2023-02-02', '2023-02-02', NULL, '2', 0, 'PEN', 29.66, 0.00, 0.00, 5.34, 35.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (684, 1, '99', 'NV01', 00000007, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 1.86, 0.00, 0.00, 0.33, 2.20, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (685, 1, '99', 'NV01', 00000007, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 1.86, 0.00, 0.00, 0.33, 2.20, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (686, 1, '99', 'NV01', 00000008, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 55.93, 0.00, 0.00, 10.07, 66.00, '00001', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (687, 1, '03', 'B001', 00000148, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 9.15, 0.00, 0.00, 1.65, 10.80, '44168916', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'wDMTa36febVpxNHzJKMx7hwCEhc=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (688, 1, '03', 'B001', 00000149, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 18.64, 0.00, 0.00, 3.36, 22.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'Fu+b/MZ25g17KzuomEDnQwTbEMs=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, 'JOSE');
INSERT INTO `tbl_venta_cab` VALUES (689, 1, '99', 'NV01', 00000009, '2023-02-03', '2023-02-03', NULL, '1', 0, 'PEN', 23.73, 0.00, 0.00, 4.27, 28.00, '00001', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (690, 1, '03', 'B001', 00000150, '2023-02-06', '2023-02-06', NULL, '1', 0, 'PEN', 93.22, 0.00, 0.00, 16.78, 110.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, 'SEBASTIAN');
INSERT INTO `tbl_venta_cab` VALUES (691, 1, '03', 'B001', 00000150, '2023-02-06', '2023-02-06', NULL, '1', 0, 'PEN', 93.22, 0.00, 0.00, 16.78, 110.00, '99999999', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'BnyktcEyvhpoC06lXR1sVr8xk44=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, 'SEBASTIAN');
INSERT INTO `tbl_venta_cab` VALUES (692, 1, '99', 'NV01', 00000010, '2023-02-06', '2023-02-06', NULL, '1', 0, 'PEN', 228.81, 0.00, 0.00, 41.19, 270.00, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (693, 1, '99', 'NV01', 00000011, '2023-02-06', '2023-02-06', NULL, '1', 0, 'PEN', 3.66, 0.00, 0.00, 0.66, 4.32, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_venta_cab` VALUES (694, 1, '99', 'NV01', 00000011, '2023-02-06', '2023-02-06', NULL, '1', 0, 'PEN', 3.66, 0.00, 0.00, 0.66, 4.32, '99999999', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, 'JUAN');
INSERT INTO `tbl_venta_cab` VALUES (695, 1, '03', 'B001', 00000151, '2023-02-09', '2023-02-09', NULL, '1', 0, 'PEN', 39.55, 0.00, 0.00, 7.12, 46.67, '00001', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'NsKlSMMJ8VQIt0XmokAp5qLPGHw=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, '');
INSERT INTO `tbl_venta_cab` VALUES (696, 1, '01', 'F001', 00000052, '2023-02-11', '2023-02-11', NULL, '1', 0, 'PEN', 0.85, 0.00, 0.00, 0.15, 1.00, '20494191637', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'ZvmWsZb3xmM3i3f08xxowiwhE9o=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, '');
INSERT INTO `tbl_venta_cab` VALUES (697, 1, '03', 'B001', 00000152, '2023-02-11', '2023-02-11', NULL, '1', 0, 'PEN', 16.95, 0.00, 0.00, 3.05, 20.00, '00001', 1, '', 'Aceptado por SUNAT', NULL, NULL, NULL, 'tFDJDzF0SZCRwAObKDHcaPdmIMw=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, '20230211', '2', '1676170081548', '');
INSERT INTO `tbl_venta_cab` VALUES (698, 1, '01', 'F001', 00000053, '2023-02-11', '2023-02-11', NULL, '1', 0, 'PEN', 3.74, 0.00, 0.00, 0.67, 4.41, '20493223641', 1, '', ' ha sido Aceptada por SUNAT', NULL, NULL, NULL, 'QwRwUl25TsBUM9OOngZeuvJWhzw=', NULL, NULL, NULL, NULL, NULL, '1', 1, 0, NULL, NULL, NULL, '');

-- ----------------------------
-- Table structure for tbl_venta_cuota
-- ----------------------------
DROP TABLE IF EXISTS `tbl_venta_cuota`;
CREATE TABLE `tbl_venta_cuota`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_venta` int(5) NULL DEFAULT NULL,
  `num_cuota` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `importe_cuota` decimal(10, 2) NULL DEFAULT NULL,
  `fecha_cuota` date NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_venta_cuota
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1724 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_venta_det
-- ----------------------------
INSERT INTO `tbl_venta_det` VALUES (1689, 670, 1, 590, 10.00, 1, 0.00, 10.00, 0.85, 1.00, 1.53, 18.00, 8.47, 10.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1690, 670, 2, 591, 10.00, 1, 0.00, 10.00, 1.50, 1.50, 0.00, 18.00, 15.00, 15.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (1691, 671, 1, 590, 10.00, 1, 0.00, 10.00, 0.85, 1.00, 1.53, 18.00, 8.47, 10.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1692, 671, 2, 591, 10.00, 1, 0.00, 10.00, 1.50, 1.50, 0.00, 18.00, 15.00, 15.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (1693, 672, 1, 590, NULL, NULL, NULL, 10.00, 0.85, 1.00, 1.53, 18.00, 8.47, 10.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (1694, 672, 2, 591, NULL, NULL, NULL, 10.00, 1.50, 1.50, 0.00, 18.00, 15.00, 15.00, 0.00);
INSERT INTO `tbl_venta_det` VALUES (1695, 673, 1, 590, 10.00, 1, 0.00, 10.00, 1.00, 1.00, 1.53, 18.00, 10.00, 10.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1696, 673, 2, 591, 10.00, 1, 0.00, 10.00, 1.50, 1.50, 0.00, 18.00, 15.00, 15.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (1697, 674, 1, 590, 0.00, 1, 10.00, 10.00, 0.85, 1.00, 1.53, 18.00, 8.47, 10.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1698, 674, 2, 591, 0.00, 1, 5.00, 5.00, 1.50, 1.50, 0.00, 18.00, 7.50, 7.50, 1.20);
INSERT INTO `tbl_venta_det` VALUES (1699, 675, 1, 590, 0.00, 1, 10.00, 10.00, 0.85, 1.00, 1.53, 18.00, 8.47, 10.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1700, 676, 1, 591, 0.00, 1, 10.00, 10.00, 1.50, 1.50, 0.00, 18.00, 15.00, 15.00, 1.20);
INSERT INTO `tbl_venta_det` VALUES (1701, 677, 1, 590, 0.00, 1, 10.00, 10.00, 0.85, 1.00, 1.53, 18.00, 8.47, 10.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1702, 678, 1, 590, 0.00, 1, 5.00, 5.00, 0.85, 1.00, 0.76, 18.00, 4.24, 5.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1703, 679, 1, 595, 0.00, 1, 1.00, 1.00, 0.51, 0.60, 0.09, 18.00, 0.51, 0.60, 0.50);
INSERT INTO `tbl_venta_det` VALUES (1704, 679, 2, 590, 0.00, 1, 1.00, 1.00, 0.85, 1.00, 0.15, 18.00, 0.85, 1.00, 0.80);
INSERT INTO `tbl_venta_det` VALUES (1705, 680, 1, 595, 0.00, 1, 5.00, 5.00, 0.51, 0.60, 0.46, 18.00, 2.54, 3.00, 0.50);
INSERT INTO `tbl_venta_det` VALUES (1706, 681, 1, 592, 0.00, 1, 3.00, 3.00, 2.54, 3.00, 1.37, 18.00, 7.63, 9.00, 3.00);
INSERT INTO `tbl_venta_det` VALUES (1707, 682, 1, 604, 0.00, 1, 3.00, 3.00, 5.93, 7.00, 3.20, 18.00, 17.80, 21.00, 7.00);
INSERT INTO `tbl_venta_det` VALUES (1708, 683, 2, 604, 0.00, 1, 5.00, 5.00, 7.00, 7.00, 5.34, 18.00, 35.00, 35.00, 7.00);
INSERT INTO `tbl_venta_det` VALUES (1709, 684, 1, 605, 0.00, 6, 1.00, 1.00, 2.20, 2.20, 0.34, 18.00, 13.20, 2.20, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1710, 685, 1, 605, 0.00, 6, 1.00, 1.00, 2.20, 2.20, 0.34, 18.00, 13.20, 2.20, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1711, 686, 2, 605, 5.00, 6, 0.00, 30.00, 2.20, 2.20, 10.07, 18.00, 396.00, 66.00, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1712, 687, 1, 606, 0.00, 25, 5.00, 5.00, 1.83, 2.16, 1.65, 18.00, 9.15, 10.80, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1713, 688, 2, 606, 0.00, 25, 10.00, 10.00, 1.86, 2.20, 3.36, 18.00, 18.64, 22.00, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1714, 689, 1, 604, 0.00, 1, 4.00, 4.00, 7.00, 7.00, 4.27, 18.00, 28.00, 28.00, 7.00);
INSERT INTO `tbl_venta_det` VALUES (1715, 690, 1, 606, 2.00, 25, 0.00, 50.00, 1.86, 2.20, 16.78, 18.00, 93.22, 110.00, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1716, 691, 1, 606, 2.00, 25, 0.00, 50.00, 1.86, 2.20, 16.78, 18.00, 93.22, 110.00, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1717, 692, 1, 606, 5.00, 25, 0.00, 125.00, 2.16, 2.16, 41.19, 18.00, 6750.00, 270.00, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1718, 693, 1, 606, 0.00, 25, 2.00, 2.00, 2.16, 2.16, 0.66, 18.00, 108.00, 4.32, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1719, 694, 1, 606, 0.00, 25, 2.00, 2.00, 2.16, 2.16, 0.66, 18.00, 108.00, 4.32, 2.00);
INSERT INTO `tbl_venta_det` VALUES (1720, 695, 1, 604, 0.00, 12, 8.00, 8.00, 4.94, 5.83, 7.12, 18.00, 39.55, 46.67, 7.00);
INSERT INTO `tbl_venta_det` VALUES (1721, 696, 1, 607, 0.00, 10, 5.00, 5.00, 0.17, 0.20, 0.15, 18.00, 0.85, 1.00, 0.12);
INSERT INTO `tbl_venta_det` VALUES (1722, 697, 1, 607, 10.00, 10, 0.00, 100.00, 0.17, 0.20, 3.05, 18.00, 16.95, 20.00, 0.12);
INSERT INTO `tbl_venta_det` VALUES (1723, 698, 1, 608, 2.00, 10, 1.00, 21.00, 0.18, 0.21, 0.67, 18.00, 3.74, 4.41, 0.18);

-- ----------------------------
-- Table structure for tbl_venta_pago
-- ----------------------------
DROP TABLE IF EXISTS `tbl_venta_pago`;
CREATE TABLE `tbl_venta_pago`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_venta` int(5) NULL DEFAULT NULL,
  `fdp` int(5) NULL DEFAULT NULL,
  `importe_pago` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tbl_venta_pago
-- ----------------------------
INSERT INTO `tbl_venta_pago` VALUES (41, 670, 2, 20.00);
INSERT INTO `tbl_venta_pago` VALUES (42, 670, 1, 5.00);
INSERT INTO `tbl_venta_pago` VALUES (43, 671, 1, 50.00);
INSERT INTO `tbl_venta_pago` VALUES (44, 673, 1, 30.00);
INSERT INTO `tbl_venta_pago` VALUES (45, 674, 1, 20.00);
INSERT INTO `tbl_venta_pago` VALUES (46, 675, 1, 20.00);
INSERT INTO `tbl_venta_pago` VALUES (47, 676, 1, 20.00);
INSERT INTO `tbl_venta_pago` VALUES (48, 677, 1, 20.00);
INSERT INTO `tbl_venta_pago` VALUES (49, 678, 1, 10.00);
INSERT INTO `tbl_venta_pago` VALUES (50, 679, 1, 2.00);
INSERT INTO `tbl_venta_pago` VALUES (51, 680, 1, 5.00);
INSERT INTO `tbl_venta_pago` VALUES (52, 681, 1, 10.00);
INSERT INTO `tbl_venta_pago` VALUES (53, 682, 1, 30.00);
INSERT INTO `tbl_venta_pago` VALUES (54, 683, 1, 40.00);
INSERT INTO `tbl_venta_pago` VALUES (55, 684, 1, 5.00);
INSERT INTO `tbl_venta_pago` VALUES (56, 685, 1, 5.00);
INSERT INTO `tbl_venta_pago` VALUES (57, 686, 1, 70.00);
INSERT INTO `tbl_venta_pago` VALUES (58, 687, 1, 20.00);
INSERT INTO `tbl_venta_pago` VALUES (59, 688, 1, 25.00);
INSERT INTO `tbl_venta_pago` VALUES (60, 689, 1, 30.00);
INSERT INTO `tbl_venta_pago` VALUES (61, 690, 1, 120.00);
INSERT INTO `tbl_venta_pago` VALUES (62, 691, 1, 120.00);
INSERT INTO `tbl_venta_pago` VALUES (63, 692, 1, 300.00);
INSERT INTO `tbl_venta_pago` VALUES (64, 693, 1, 5.00);
INSERT INTO `tbl_venta_pago` VALUES (65, 694, 1, 5.00);
INSERT INTO `tbl_venta_pago` VALUES (66, 695, 1, 50.00);
INSERT INTO `tbl_venta_pago` VALUES (67, 696, 1, 2.00);
INSERT INTO `tbl_venta_pago` VALUES (68, 697, 1, 50.00);
INSERT INTO `tbl_venta_pago` VALUES (69, 698, 2, 4.41);

-- ----------------------------
-- View structure for vw_tbl_alm_ing
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_alm_ing`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_alm_ing` AS select `tp`.`id` AS `codigo_producto`,`tp`.`nombre` AS `nombre_producto`,`vc`.`fecha_emision` AS `fecha`,'1' AS `tipo_movimiento`,`vc`.`tipocomp` AS `tipo_doc`,`vc`.`serie` AS `serie_doc`,`vc`.`correlativo` AS `num_doc`,`vd`.`cantidad` AS `cantidad`,`vd`.`valor_unitario` AS `costo_unitario`,cast((`vd`.`cantidad` * `vd`.`valor_unitario`) as decimal(10,2)) AS `total` from ((`tbl_compra_det` `vd` left join `tbl_productos` `tp` on((`vd`.`idproducto` = `tp`.`id`))) left join `tbl_compra_cab` `vc` on((`vd`.`idventa` = `vc`.`id`)));

-- ----------------------------
-- View structure for vw_tbl_alm_mov
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_alm_mov`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_alm_mov` AS (select `vw_tbl_alm_ing`.`codigo_producto` AS `codigo_producto`,`vw_tbl_alm_ing`.`nombre_producto` AS `nombre_producto`,`vw_tbl_alm_ing`.`fecha` AS `fecha`,`vw_tbl_alm_ing`.`tipo_movimiento` AS `tipo_movimiento`,`vw_tbl_alm_ing`.`tipo_doc` AS `tipo_doc`,`vw_tbl_alm_ing`.`serie_doc` AS `serie_doc`,`vw_tbl_alm_ing`.`num_doc` AS `num_doc`,`vw_tbl_alm_ing`.`cantidad` AS `cantidad`,`vw_tbl_alm_ing`.`costo_unitario` AS `costo_unitario`,`vw_tbl_alm_ing`.`total` AS `total` from `vw_tbl_alm_ing`) union (select `vw_tbl_alm_sal`.`codigo_producto` AS `codigo_producto`,`vw_tbl_alm_sal`.`nombre_producto` AS `nombre_producto`,`vw_tbl_alm_sal`.`fecha` AS `fecha`,`vw_tbl_alm_sal`.`tipo_movimiento` AS `tipo_movimiento`,`vw_tbl_alm_sal`.`tipo_doc` AS `tipo_doc`,`vw_tbl_alm_sal`.`serie_doc` AS `serie_doc`,`vw_tbl_alm_sal`.`num_doc` AS `num_doc`,`vw_tbl_alm_sal`.`cantidad` AS `cantidad`,`vw_tbl_alm_sal`.`costo_unitario` AS `costo_unitario`,`vw_tbl_alm_sal`.`total` AS `total` from `vw_tbl_alm_sal`);

-- ----------------------------
-- View structure for vw_tbl_alm_sal
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_alm_sal`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_alm_sal` AS select `tp`.`id` AS `codigo_producto`,`tp`.`nombre` AS `nombre_producto`,`vc`.`fecha_emision` AS `fecha`,'2' AS `tipo_movimiento`,`vc`.`tipocomp` AS `tipo_doc`,`vc`.`serie` AS `serie_doc`,`vc`.`correlativo` AS `num_doc`,`vd`.`cantidad` AS `cantidad`,`vd`.`costo` AS `costo_unitario`,cast((`vd`.`cantidad` * `vd`.`costo`) as decimal(10,2)) AS `total` from ((`tbl_venta_det` `vd` left join `tbl_productos` `tp` on((`vd`.`idproducto` = `tp`.`id`))) left join `tbl_venta_cab` `vc` on((`vd`.`idventa` = `vc`.`id`)));

-- ----------------------------
-- View structure for vw_tbl_compras_sunat
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_compras_sunat`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_compras_sunat` AS select `vc`.`fecha_emision` AS `fecha_emision`,`vc`.`fecha_vencimiento` AS `fecha_vencimiento`,if((`vc`.`tipocomp` = '01'),'FACTUTA',if((`vc`.`tipocomp` = '03'),'BOLETA DE VENTA',if((`vc`.`tipocomp` = '99'),'NOTA DE VENTA','NOTA DE CREDITO'))) AS `nomdoc`,`vc`.`tipocomp` AS `td`,`vc`.`serie` AS `serie`,`vc`.`correlativo` AS `numero`,`co`.`tipo_doc` AS `doc`,`co`.`num_doc` AS `num_cli`,0.00 AS `valor_exportacion`,cast(`vc`.`op_gravadas` as decimal(10,2)) AS `op_gravadas`,cast(`vc`.`op_exoneradas` as decimal(10,2)) AS `op_exoneradas`,cast(`vc`.`op_inafectas` as decimal(10,2)) AS `op_inafectas`,0.00 AS `isc`,cast(`vc`.`igv` as decimal(10,2)) AS `igv`,0.00 AS `icbper`,0.00 AS `oth`,cast((((`vc`.`op_gravadas` + `vc`.`op_exoneradas`) + `vc`.`op_inafectas`) + `vc`.`igv`) as decimal(10,2)) AS `total`,`vc`.`tipocomp_ref` AS `tipo_ref`,`vc`.`serie_ref` AS `serie_ref`,`vc`.`correlativo_ref` AS `correlativo_ref`,`vc`.`idempresa` AS `empresa` from (`tbl_compra_cab` `vc` left join `tbl_contribuyente` `co` on((`vc`.`codcliente` = `co`.`num_doc`))) where (`vc`.`tipocomp` in ('01','03','07','08'));

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
-- View structure for vw_tbl_resumen_cpe
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_resumen_cpe`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_resumen_cpe` AS select `tbl_venta_cab`.`id` AS `id`,`tbl_venta_cab`.`idempresa` AS `idempresa`,`tbl_venta_cab`.`fecha_emision` AS `fecha_emision`,`tbl_venta_cab`.`tipocomp` AS `tipodoc`,`tbl_venta_cab`.`serie` AS `serie`,`tbl_venta_cab`.`correlativo` AS `correlativo`,'1' AS `condicion`,`tbl_venta_cab`.`codmoneda` AS `moneda`,cast(`tbl_venta_cab`.`total` as decimal(10,2)) AS `importe_total`,(((`tbl_venta_cab`.`op_gravadas` + `tbl_venta_cab`.`op_exoneradas`) + `tbl_venta_cab`.`op_inafectas`) - `tbl_venta_cab`.`igv`) AS `valor_total`,`tbl_venta_cab`.`igv` AS `igv_total`,if((`tbl_venta_cab`.`igv` > 0),'01','02') AS `tipo_total`,if((`tbl_venta_cab`.`igv` > 0),'1000','9997') AS `codigo_afectacion`,if((`tbl_venta_cab`.`igv` > 0),'VAT','EXO') AS `nombre_afectacion`,'VAT' AS `tipo_afectacion` from `tbl_venta_cab` where ((`tbl_venta_cab`.`tipocomp` = '03') and (`tbl_venta_cab`.`feestado` = '0'));

-- ----------------------------
-- View structure for vw_tbl_serie_usuario
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_serie_usuario`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_serie_usuario` AS select `c`.`cod` AS `cod`,`s`.`id_doc` AS `id_doc`,`c`.`id` AS `cod_doc`,`c`.`nombre` AS `nombre`,`s`.`serie` AS `serie`,`s`.`correlativo` AS `numero`,`x`.`id_usuario` AS `usuario`,`s`.`id_empresa` AS `empresa` from (((`tbl_tipo_documento` `c` left join `tbl_series` `s` on((`c`.`cod` = `s`.`id_doc`))) left join `tbl_series_usuarios` `u` on((`s`.`id` = `u`.`id_serie`))) left join `tbl_usuarios` `x` on((`u`.`id_usuario` = `x`.`id_usuario`))) where (`c`.`id` in ('01','03','07','08','99'));

-- ----------------------------
-- View structure for vw_tbl_tipo_afectacion
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_tipo_afectacion`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_tipo_afectacion` AS select `ta`.`codigo` AS `codigo`,`ta`.`descripcion` AS `descripcion`,`ct`.`codigo` AS `codigo_afectacion`,`ct`.`codigo_internacional` AS `cod_int`,`ct`.`nombre` AS `nombre_afectacion` from (`tbl_tipo_afectacion` `ta` left join `tbl_tipo_tributo` `ct` on((`ta`.`codigo_tributo` = `ct`.`codigo`)));

-- ----------------------------
-- View structure for vw_tbl_usuarios
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_usuarios`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_usuarios` AS select `u`.`id_usuario` AS `id`,`u`.`usuario` AS `usuario`,`u`.`clave` AS `clave`,`u`.`perfil` AS `perfil`,`u`.`almacen` AS `almacen`,concat(`u`.`nombre_personal`,' ',`u`.`apellido_personal`) AS `nombre`,`e`.`ruc` AS `ruc`,`e`.`razon_social` AS `empresa`,`e`.`id_empresa` AS `id_empresa`,`e`.`clave_certificado` AS `clave_certificado`,`e`.`clave_sol` AS `clave_sol`,`e`.`correo` AS `correo`,`e`.`departamento` AS `departamento`,`e`.`direccion` AS `direccion`,`e`.`distrito` AS `distrito`,`e`.`fecha_vencimiento` AS `fecha_vencimiento`,`e`.`provincia` AS `provincia`,`e`.`ubigeo` AS `ubigeo`,`e`.`usuario_sol` AS `usuario_sol` from (`tbl_usuarios` `u` left join `tbl_empresas` `e` on((`u`.`id_empresa` = `e`.`id_empresa`)));

-- ----------------------------
-- View structure for vw_tbl_ventas_diarias
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_ventas_diarias`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_ventas_diarias` AS select `tbl_venta_cab`.`vendedor` AS `vendedor`,`tbl_venta_cab`.`fecha_emision` AS `fecha`,`tbl_venta_cab`.`tipocomp` AS `tipocomp`,`tbl_venta_cab`.`serie` AS `serie`,min(`tbl_venta_cab`.`correlativo`) AS `desde`,max(`tbl_venta_cab`.`correlativo`) AS `hasta`,cast(sum(`tbl_venta_cab`.`op_gravadas`) as decimal(10,2)) AS `op_gravadas`,cast(sum(`tbl_venta_cab`.`op_inafectas`) as decimal(10,2)) AS `op_inafectas`,cast(sum(`tbl_venta_cab`.`op_exoneradas`) as decimal(10,2)) AS `op_exoneradas`,cast(sum(`tbl_venta_cab`.`igv`) as decimal(10,2)) AS `igv`,cast((((sum(`tbl_venta_cab`.`op_gravadas`) + sum(`tbl_venta_cab`.`op_inafectas`)) + sum(`tbl_venta_cab`.`op_exoneradas`)) + sum(`tbl_venta_cab`.`igv`)) as decimal(10,2)) AS `total` from `tbl_venta_cab` group by `tbl_venta_cab`.`vendedor`,`tbl_venta_cab`.`fecha_emision`,`tbl_venta_cab`.`tipocomp`;

-- ----------------------------
-- View structure for vw_tbl_ventas_sunat
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_ventas_sunat`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_ventas_sunat` AS select `vc`.`fecha_emision` AS `fecha_emision`,`vc`.`fecha_vencimiento` AS `fecha_vencimiento`,if((`vc`.`tipocomp` = '01'),'FACTUTA',if((`vc`.`tipocomp` = '03'),'BOLETA DE VENTA',if((`vc`.`tipocomp` = '99'),'NOTA DE VENTA','NOTA DE CREDITO'))) AS `nomdoc`,`vc`.`tipocomp` AS `td`,`vc`.`serie` AS `serie`,`vc`.`correlativo` AS `numero`,`co`.`tipo_doc` AS `doc`,`co`.`num_doc` AS `num_cli`,0.00 AS `valor_exportacion`,cast(`vc`.`op_gravadas` as decimal(10,2)) AS `op_gravadas`,cast(`vc`.`op_exoneradas` as decimal(10,2)) AS `op_exoneradas`,cast(`vc`.`op_inafectas` as decimal(10,2)) AS `op_inafectas`,0.00 AS `isc`,cast(`vc`.`igv` as decimal(10,2)) AS `igv`,0.00 AS `icbper`,0.00 AS `oth`,cast((((`vc`.`op_gravadas` + `vc`.`op_exoneradas`) + `vc`.`op_inafectas`) + `vc`.`igv`) as decimal(10,2)) AS `total`,`vc`.`tipocomp_ref` AS `tipo_ref`,`vc`.`serie_ref` AS `serie_ref`,`vc`.`correlativo_ref` AS `correlativo_ref`,`vc`.`idempresa` AS `empresa` from (`tbl_venta_cab` `vc` left join `tbl_contribuyente` `co` on((`vc`.`codcliente` = `co`.`num_doc`))) where (`vc`.`tipocomp` in ('01','03','07','08'));

-- ----------------------------
-- View structure for vw_tbl_venta_cab
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_venta_cab`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_venta_cab` AS select `vc`.`id` AS `id`,`vc`.`idempresa` AS `idempresa`,`vc`.`tipocomp` AS `tipocomp`,if((`vc`.`tipocomp` = '01'),'FACTURA ELECTRONICA',if((`vc`.`tipocomp` = '03'),'BOLETA DE VENTA ELECTRONICA','NOTA DE CREDITO')) AS `nomdoc`,`vc`.`serie` AS `serie`,`vc`.`correlativo` AS `correlativo`,`vc`.`fecha_emision` AS `fecha_emision`,`vc`.`fecha_vencimiento` AS `fecha_vencimiento`,`vc`.`orden_compra` AS `orden_compra`,`vc`.`condicion_venta` AS `condicion_venta`,`vc`.`cuotas_credito` AS `cuotas_credito`,`vc`.`codmoneda` AS `codmoneda`,`vc`.`op_gravadas` AS `op_gravadas`,`vc`.`op_exoneradas` AS `op_exoneradas`,`vc`.`op_inafectas` AS `op_inafectas`,`vc`.`igv` AS `igv`,`vc`.`total` AS `total`,`vc`.`codcliente` AS `codcliente`,`vc`.`feestado` AS `feestado`,`vc`.`fecodigoerror` AS `fecodigoerror`,`vc`.`femensajesunat` AS `femensajesunat`,`vc`.`nombrexml` AS `nombrexml`,`vc`.`xmlbase64` AS `xmlbase64`,`vc`.`cdrbase64` AS `cdrbase64`,`vc`.`hash` AS `hash`,`vc`.`tipocomp_ref` AS `tipocomp_ref`,`vc`.`serie_ref` AS `serie_ref`,`vc`.`correlativo_ref` AS `correlativo_ref`,`vc`.`cod_motivo` AS `cod_motivo`,`vc`.`des_motivo` AS `des_motivo`,`vc`.`estado` AS `estado`,`vc`.`vendedor` AS `vendedor`,`tc`.`id_persona` AS `id_persona`,`tc`.`nombre_persona` AS `nombre_persona`,`tc`.`direccion_persona` AS `direccion_persona`,`tc`.`distrito` AS `distrito`,`tc`.`provincia` AS `provincia`,`tc`.`departamento` AS `departamento`,`tc`.`tipo_doc` AS `tipo_doc`,`tc`.`num_doc` AS `num_doc`,`tc`.`correo` AS `correo`,`tc`.`empresa` AS `empresa`,`tc`.`clave` AS `clave`,`tc`.`servidor_cpe` AS `servidor_cpe`,`tc`.`envio_automatico` AS `envio_automatico`,`tc`.`envio_resumen` AS `envio_resumen`,`vc`.`obs` AS `obs` from (`tbl_venta_cab` `vc` left join `tbl_contribuyente` `tc` on((`vc`.`codcliente` = `tc`.`num_doc`)));

-- ----------------------------
-- View structure for vw_tbl_venta_det
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_venta_det`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_venta_det` AS select `d`.`idventa` AS `idventa`,`d`.`item` AS `item`,`d`.`idproducto` AS `codigo`,`p`.`nombre` AS `descripcion`,`d`.`cantidad` AS `cantidad`,`p`.`factor` AS `factor`,`d`.`cantidad_factor` AS `cantidad_factor`,`d`.`cantidad_unitario` AS `cantidad_unitario`,`d`.`valor_unitario` AS `valor_unitario`,`d`.`precio_unitario` AS `precio_unitario`,'01' AS `tipo_precio`,`d`.`igv` AS `igv`,`d`.`porcentaje_igv` AS `porcentaje_igv`,`d`.`valor_total` AS `valor_total`,`d`.`importe_total` AS `importe_total`,`u`.`cod_SUNAT` AS `unidad`,`p`.`unidad` AS `unidadf`,`p`.`unidadu` AS `unidadu`,`a`.`codigo` AS `codigo_afectacion_alt`,`a`.`codigo_afectacion` AS `codigo_afectacion`,`a`.`nombre_afectacion` AS `nombre_afectacion`,`a`.`cod_int` AS `tipo_afectacion` from (((`tbl_venta_det` `d` left join `tbl_productos` `p` on((`d`.`idproducto` = `p`.`id`))) left join `vw_tbl_tipo_afectacion` `a` on((`p`.`afectacion` = `a`.`codigo`))) left join `tbl_unidad` `u` on((`p`.`unidad` = `u`.`cod`)));

-- ----------------------------
-- View structure for vw_tbl_venta_producto
-- ----------------------------
DROP VIEW IF EXISTS `vw_tbl_venta_producto`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_tbl_venta_producto` AS select `c`.`fecha_emision` AS `fecha`,`d`.`idproducto` AS `producto`,`p`.`nombre` AS `nombre`,`m`.`nombre` AS `marca`,`p`.`unidad` AS `unidad`,`d`.`cantidad` AS `cantidad`,`d`.`precio_unitario` AS `precio_unitario`,`d`.`importe_total` AS `total`,`c`.`idempresa` AS `empresa` from (((`tbl_venta_cab` `c` left join `tbl_venta_det` `d` on((`c`.`id` = `d`.`idventa`))) left join `tbl_productos` `p` on((`d`.`idproducto` = `p`.`id`))) left join `tbl_marcas` `m` on((`p`.`marca` = `m`.`id`)));

SET FOREIGN_KEY_CHECKS = 1;
