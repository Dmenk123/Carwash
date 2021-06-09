/*
 Navicat Premium Data Transfer

 Source Server         : local-mysql
 Source Server Type    : MySQL
 Source Server Version : 100413
 Source Host           : localhost:3306
 Source Schema         : db_carwash

 Target Server Type    : MySQL
 Target Server Version : 100413
 File Encoding         : 65001

 Date: 10/06/2021 02:19:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_log_laporan_det
-- ----------------------------
DROP TABLE IF EXISTS `t_log_laporan_det`;
CREATE TABLE `t_log_laporan_det`  (
  `id` int(64) NOT NULL,
  `id_log_laporan` int(64) NULL DEFAULT NULL,
  `harga_total` float(20, 2) NULL DEFAULT NULL,
  `id_jenis_trans` int(4) NULL DEFAULT NULL,
  `kode_trans` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `urut` int(4) NULL DEFAULT NULL,
  `penerimaan` float(20, 2) NULL DEFAULT NULL,
  `pengeluaran` float(20, 2) NULL DEFAULT NULL,
  `saldo_akhir` float(20, 2) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
