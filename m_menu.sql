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

 Date: 11/06/2021 02:49:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for m_menu
-- ----------------------------
DROP TABLE IF EXISTS `m_menu`;
CREATE TABLE `m_menu`  (
  `id` int(11) NOT NULL,
  `id_parent` int(11) NOT NULL,
  `nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `judul` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `aktif` int(1) NULL DEFAULT NULL,
  `tingkat` int(11) NULL DEFAULT NULL,
  `urutan` int(11) NULL DEFAULT NULL,
  `add_button` int(1) NULL DEFAULT NULL,
  `edit_button` int(1) NULL DEFAULT NULL,
  `delete_button` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of m_menu
-- ----------------------------
INSERT INTO `m_menu` VALUES (1, 0, 'Dashboard', 'Dashboard', 'home', 'flaticon2-architecture-and-city', 1, 1, 1, 0, 0, 0);
INSERT INTO `m_menu` VALUES (2, 0, 'Setting (Administrator)', 'Setting', '', 'flaticon2-gear', 1, 1, 100, 0, 0, 0);
INSERT INTO `m_menu` VALUES (3, 2, 'Setting Menu', 'Setting Menu', 'set_menu', 'flaticon-grid-menu', 1, 2, 2, 1, 1, 1);
INSERT INTO `m_menu` VALUES (4, 2, 'Setting Role', 'Setting Role', 'set_role', 'flaticon-network', 1, 2, 1, 1, 1, 1);
INSERT INTO `m_menu` VALUES (6, 0, 'Master', 'Master', '', 'flaticon-folder-1', 1, 1, 2, 0, 0, 0);
INSERT INTO `m_menu` VALUES (7, 6, 'Data User', 'Data User', 'master_user', 'flaticon-users', 1, 2, 1, 1, 1, 1);
INSERT INTO `m_menu` VALUES (8, 0, 'Transaksi', 'Transaksi', '', 'flaticon2-shopping-cart', 1, 1, 3, 0, 0, 0);
INSERT INTO `m_menu` VALUES (9, 8, 'Penjualan', 'Penjualan', 'penjualan', 'flaticon2-shopping-cart-1', 1, 2, 1, 1, 1, 1);
INSERT INTO `m_menu` VALUES (10, 6, 'Jenis Transaksi', 'Jenis Transaksi', 'master_jenis_trans', 'flaticon-folder-1', 1, 2, 1, 1, 1, 1);
INSERT INTO `m_menu` VALUES (11, 6, 'Item Transaksi', 'Item Transaksi', 'master_item_trans', 'flaticon-folder-1', 1, 2, 3, 1, 1, 1);
INSERT INTO `m_menu` VALUES (12, 6, 'Profil', 'Master Profil', 'master_profil', 'flaticon-profile', 1, 2, 5, 1, 1, 1);
INSERT INTO `m_menu` VALUES (13, 8, 'Daftar Penjualan', 'Daftar Penjualan', 'daftar_penjualan', 'flaticon-list', 1, 2, 2, 1, 1, 1);
INSERT INTO `m_menu` VALUES (14, 8, 'Transaksi Lain Lain', 'Form Transaksi Non Penjualan', 'trans_lain', 'flaticon-open-box', 1, 2, 3, 1, 1, 1);
INSERT INTO `m_menu` VALUES (15, 8, 'Daftar Transaksi Lain-Lain', 'Pengelolaan Transaksi Non Penjualan', 'daftar_transaksi_lain', 'flaticon-list-2', 1, 2, 4, 1, 1, 1);
INSERT INTO `m_menu` VALUES (16, 0, 'Laporan', 'Laporan', '', 'flaticon-line-graph', 1, 1, 4, 0, 0, 0);
INSERT INTO `m_menu` VALUES (17, 16, 'Laporan Transaksi', 'Laporan Transaksi', 'lap_transaksi', 'flaticon-graph', 1, 2, 2, 1, 1, 1);
INSERT INTO `m_menu` VALUES (18, 16, 'Laporan Keuangan', 'Laporan Keuangan', 'lap_keuangan', 'flaticon-coins', 1, 2, 3, 1, 1, 1);
INSERT INTO `m_menu` VALUES (19, 6, 'Master Supplier', 'Master Supplier', 'master_supplier', 'flaticon-support', 1, 2, 5, 1, 1, 1);
INSERT INTO `m_menu` VALUES (20, 16, 'Kunci Laporan', 'Kunci Laporan', 'kunci_lap', 'flaticon-lock', 1, 2, 1, 1, 1, 1);
INSERT INTO `m_menu` VALUES (21, 0, 'Log', 'Log', '', 'flaticon-calendar-with-a-clock-time-tools', 1, 1, 5, 0, 0, 0);
INSERT INTO `m_menu` VALUES (22, 21, 'Log Aktivitas', 'Log Aktivitas User', 'log_aktivitas', 'flaticon2-calendar-3', 1, 2, 1, 1, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;
