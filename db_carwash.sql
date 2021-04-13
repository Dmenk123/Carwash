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

 Date: 14/04/2021 05:01:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for m_item_trans
-- ----------------------------
DROP TABLE IF EXISTS `m_item_trans`;
CREATE TABLE `m_item_trans`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_jenis_trans` int(4) NULL DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `harga_awal` float(20, 2) NULL DEFAULT NULL,
  `harga` float(20, 2) NULL DEFAULT NULL COMMENT 'HARGA TERKINI (WAJIB UPDATE SETELAH ISI LOG HARGA)',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `id_jenis_counter` int(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_jenis_trans`(`id_jenis_trans`) USING BTREE,
  CONSTRAINT `m_item_trans_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_item_trans
-- ----------------------------
INSERT INTO `m_item_trans` VALUES (1, 1, 'Cuci Mobil', 'Cuci Mobil', 25000.00, 25000.00, '2021-03-27 19:44:12', NULL, NULL, 1);
INSERT INTO `m_item_trans` VALUES (2, 1, 'Cuci Motor', 'Cuci Motor', 10000.00, 10000.00, '2021-03-27 19:44:12', NULL, NULL, 2);
INSERT INTO `m_item_trans` VALUES (3, 1, 'Poles Mobil', 'Poles Mobil', 10000.00, 10000.00, '2021-03-27 19:44:12', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (4, 1, 'Poles Motor', 'Poles Motor', 5000.00, 5000.00, '2021-03-27 19:44:12', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for m_jenis_counter
-- ----------------------------
DROP TABLE IF EXISTS `m_jenis_counter`;
CREATE TABLE `m_jenis_counter`  (
  `id` int(4) NOT NULL,
  `jenis_counter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_jenis_counter
-- ----------------------------
INSERT INTO `m_jenis_counter` VALUES (1, 'Counter Mobil', '2021-04-13 22:06:45', NULL, NULL);
INSERT INTO `m_jenis_counter` VALUES (2, 'Counter Motor', '2021-04-13 22:06:45', NULL, NULL);

-- ----------------------------
-- Table structure for m_jenis_trans
-- ----------------------------
DROP TABLE IF EXISTS `m_jenis_trans`;
CREATE TABLE `m_jenis_trans`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama_jenis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode_jenis` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_jenis_trans
-- ----------------------------
INSERT INTO `m_jenis_trans` VALUES (1, 'Penjualan', 'A-01', 'Penjualan', '2021-03-27 19:42:00', NULL, NULL);

-- ----------------------------
-- Table structure for m_member
-- ----------------------------
DROP TABLE IF EXISTS `m_member`;
CREATE TABLE `m_member`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_member` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `jenis_kelamin` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'P/W',
  `img_foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'jika ada',
  `img_barcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'jika ada',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_member
-- ----------------------------
INSERT INTO `m_member` VALUES (1, 'M210328001', 'Masnur', 'Jalan Raya', 'masnur@masnur.com', '1212121', 'L', NULL, NULL, '2021-03-28 14:17:23', NULL, NULL);
INSERT INTO `m_member` VALUES (2, 'M210328002', 'Runsam', 'Ayar Nalaj', 'masnur@masnur.com', '78w7q8w7', 'P', NULL, NULL, '2021-03-28 14:17:23', NULL, NULL);

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
INSERT INTO `m_menu` VALUES (2, 0, 'Setting (Administrator)', 'Setting', NULL, 'flaticon2-gear', 1, 1, 5, 0, 0, 0);
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

-- ----------------------------
-- Table structure for m_profil
-- ----------------------------
DROP TABLE IF EXISTS `m_profil`;
CREATE TABLE `m_profil`  (
  `id` int(11) NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kelurahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kecamatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kota` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode_pos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `provinsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `telp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_dokter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gambar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of m_profil
-- ----------------------------
INSERT INTO `m_profil` VALUES (1, 'Wijaya Premium Car Wash', 'Jl. Raya Tubanan No. 34 RT 04 RW 09', 'Karangpoh', 'Tandes', 'Surabaya', '60188', 'Jawa timur', '081321425352', 'nurcahyono320@gmail.com', 'Cuci Mobil dengan standar Premium', NULL, 'jual-ban-motorpng.png', '2021-03-27 19:47:40', NULL, NULL);

-- ----------------------------
-- Table structure for m_profile_usaha
-- ----------------------------
DROP TABLE IF EXISTS `m_profile_usaha`;
CREATE TABLE `m_profile_usaha`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `telp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'bila ada catatan tambahan mengenai profil perusahaan',
  `logo_small` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'untuk logo icon di tab browser',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'untuk logo utama',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_profile_usaha
-- ----------------------------

-- ----------------------------
-- Table structure for m_role
-- ----------------------------
DROP TABLE IF EXISTS `m_role`;
CREATE TABLE `m_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `aktif` int(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of m_role
-- ----------------------------
INSERT INTO `m_role` VALUES (1, 'Superadmin', 'Level Super Admin', 1);
INSERT INTO `m_role` VALUES (2, 'Owner', 'Owner', 1);
INSERT INTO `m_role` VALUES (3, 'admin', 'admin', 1);

-- ----------------------------
-- Table structure for m_user
-- ----------------------------
DROP TABLE IF EXISTS `m_user`;
CREATE TABLE `m_user`  (
  `id` int(64) NOT NULL AUTO_INCREMENT,
  `id_role` int(64) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT NULL,
  `last_login` datetime(0) NULL DEFAULT NULL,
  `kode_user` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of m_user
-- ----------------------------
INSERT INTO `m_user` VALUES (1, 1, 'superadmin', 'SnIvSVV6c2UwdWhKS1ZKMDluUlp4dz09', 1, '2021-04-14 05:00:02', 'USR-00001', NULL, NULL, NULL, NULL, 'pemiliknya');
INSERT INTO `m_user` VALUES (2, 3, 'kasir', 'SnIvSVV6c2UwdWhKS1ZKMDluUlp4dz09', 1, '2021-04-13 20:11:35', 'USR-00002', 'kasir-1618157246.jpeg', '2021-04-11 23:07:26', NULL, NULL, 'mas kasir');

-- ----------------------------
-- Table structure for t_log_aktivitas
-- ----------------------------
DROP TABLE IF EXISTS `t_log_aktivitas`;
CREATE TABLE `t_log_aktivitas`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'uuid',
  `id_m_menu` int(11) NULL DEFAULT NULL,
  `id_m_user` int(64) NULL DEFAULT NULL,
  `aksi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'CREATE, UPDATE, DELETE, AKSI LAIN USER TSB',
  `old_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'json data lama',
  `new_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'json data baru',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_aktivitas
-- ----------------------------
INSERT INTO `t_log_aktivitas` VALUES ('438df55e-6d45-4ad3-90f8-cd5216478a26', 9, 1, 'CREATE', NULL, '{\"id\":\"41164dbe-7d6b-4344-8a9c-5c563d4b02fa\",\"id_transaksi\":\"58c87a01-69d4-4df7-996d-0c66bb5fd123\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-10 12:40:39\"}', '2021-04-10 12:40:39', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4d90ef86-ff41-4ddb-b66c-d4984845076b', 9, 2, 'CREATE', NULL, '{\"id\":\"a1cc944d-aafb-4022-864f-2a764946c4f0\",\"id_transaksi\":\"aed1554a-57d9-4baa-ac50-d2496619b5c3\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-11 23:08:58\"}', '2021-04-11 23:08:58', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('518a525e-bd9d-47fc-98ba-26b2c44170a3', 9, 2, 'CREATE', NULL, '{\"id\":\"01c3943a-e7ae-47f4-aa59-e2a84cd630f9\",\"id_transaksi\":\"c53b2e29-5983-494c-87aa-189d20e2ecfa\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-11 23:08:48\"}', '2021-04-11 23:08:48', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('5f5a4e84-3523-4b5d-9413-13ead0741c76', 9, 1, 'CREATE', NULL, '{\"id\":\"ccd705b9-3b4a-45a2-b775-0512163e6453\",\"id_transaksi\":\"3bf384cf-c2eb-4947-add7-8b547b90d5d7\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-10 09:13:17\"}', '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('6cea075e-c095-401f-89c1-d6cabb4f7c31', 9, 1, 'CREATE', NULL, '{\"id\":\"eac9f12c-a7eb-4d7a-8cc1-8adf155aae96\",\"id_transaksi\":\"0cb83009-a6ac-4399-ad69-5ee8c0b8c14d\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-10 09:12:16\"}', '2021-04-10 09:12:16', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('9d5a0d38-d2dc-4a1e-bbe3-b428a274ecf9', 9, 1, 'CREATE', NULL, '{\"id\":\"e23e0e15-1b59-4461-8af8-364dbcab1d19\",\"id_transaksi\":\"20af352e-ad3e-4b76-a552-b4510ca62dde\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-10 09:13:41\"}', '2021-04-10 09:13:41', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d83b49f6-4ee9-43ec-8edf-973e6f0c9ec0', 9, 1, 'CREATE', NULL, '{\"id\":\"3f589560-3627-46b9-9640-e2ac1a060c13\",\"id_transaksi\":\"56cd3383-73ca-428d-b2a5-cee4d392bcae\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-10 09:12:33\"}', '2021-04-10 09:12:33', NULL, NULL);

-- ----------------------------
-- Table structure for t_log_counter_member
-- ----------------------------
DROP TABLE IF EXISTS `t_log_counter_member`;
CREATE TABLE `t_log_counter_member`  (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'wajib melakukan pengecekan count dengan kondisi deleted_at is null sebelum insert ke tabel ini, jika counter sudah 10 maka kolom deleted_at wajib di isi timestamp now',
  `id_member` int(14) NULL DEFAULT NULL,
  `id_jenis_counter` int(4) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_member`(`id_member`) USING BTREE,
  CONSTRAINT `t_log_counter_member_ibfk_1` FOREIGN KEY (`id_member`) REFERENCES `m_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_counter_member
-- ----------------------------
INSERT INTO `t_log_counter_member` VALUES (1, 1, 1, '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (2, 1, 1, '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (3, 1, 2, '2021-04-10 09:13:17', NULL, NULL);

-- ----------------------------
-- Table structure for t_log_harga
-- ----------------------------
DROP TABLE IF EXISTS `t_log_harga`;
CREATE TABLE `t_log_harga`  (
  `id` int(14) NOT NULL AUTO_INCREMENT,
  `id_jenis_trans` int(14) NULL DEFAULT NULL,
  `id_item_trans` int(14) NULL DEFAULT NULL,
  `harga` float(20, 2) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_jenis_trans`(`id_jenis_trans`) USING BTREE,
  INDEX `id_item_trans`(`id_item_trans`) USING BTREE,
  CONSTRAINT `t_log_harga_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_jenis_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_log_harga_ibfk_2` FOREIGN KEY (`id_item_trans`) REFERENCES `m_item_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_harga
-- ----------------------------
INSERT INTO `t_log_harga` VALUES (1, 1, 1, 25000.00, '2021-03-27 19:48:56', NULL, NULL);
INSERT INTO `t_log_harga` VALUES (2, 1, 2, 10000.00, '2021-03-27 19:48:56', NULL, NULL);
INSERT INTO `t_log_harga` VALUES (3, 1, 3, 10000.00, '2021-03-27 19:48:56', NULL, NULL);
INSERT INTO `t_log_harga` VALUES (4, 1, 4, 5000.00, '2021-03-27 19:48:56', NULL, NULL);

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu`  (
  `id_menu` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  `add_button` int(1) NULL DEFAULT 0,
  `edit_button` int(1) NULL DEFAULT 0,
  `delete_button` int(1) NULL DEFAULT 0,
  INDEX `f_level_user`(`id_role`) USING BTREE,
  INDEX `id_menu`(`id_menu`) USING BTREE,
  CONSTRAINT `t_role_menu_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `m_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_role_menu_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `m_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES (1, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (6, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (7, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (10, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (11, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (12, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (8, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (9, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (13, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (2, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (4, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (3, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (1, 3, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (8, 3, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (9, 3, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (13, 3, 1, 1, 1);

-- ----------------------------
-- Table structure for t_transaksi
-- ----------------------------
DROP TABLE IF EXISTS `t_transaksi`;
CREATE TABLE `t_transaksi`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'uuid',
  `kode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_jenis_trans` int(4) NULL DEFAULT NULL,
  `id_member` int(14) NULL DEFAULT NULL,
  `harga_total` float(20, 2) NULL DEFAULT NULL,
  `id_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `harga_bayar` float(20, 2) NULL DEFAULT NULL,
  `harga_kembalian` float(20, 2) NULL DEFAULT NULL,
  `is_kunci` int(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_jenis_trans`(`id_jenis_trans`) USING BTREE,
  INDEX `id_member`(`id_member`) USING BTREE,
  CONSTRAINT `t_transaksi_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_jenis_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_transaksi_ibfk_2` FOREIGN KEY (`id_member`) REFERENCES `m_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_transaksi
-- ----------------------------
INSERT INTO `t_transaksi` VALUES ('0cb83009-a6ac-4399-ad69-5ee8c0b8c14d', 'INV-21041000001', 1, NULL, 15000.00, '1', '2021-04-10 09:12:16', NULL, NULL, 15000.00, 0.00, 0);
INSERT INTO `t_transaksi` VALUES ('20af352e-ad3e-4b76-a552-b4510ca62dde', 'INV-21041000004', 1, NULL, 15000.00, '1', '2021-04-10 09:13:41', NULL, NULL, 15000.00, 0.00, 1);
INSERT INTO `t_transaksi` VALUES ('3bf384cf-c2eb-4947-add7-8b547b90d5d7', 'INV-21041000003', 1, 1, 35000.00, '1', '2021-04-10 09:13:17', NULL, NULL, 40000.00, 5000.00, 0);
INSERT INTO `t_transaksi` VALUES ('56cd3383-73ca-428d-b2a5-cee4d392bcae', 'INV-21041000002', 1, NULL, 35000.00, '1', '2021-04-10 09:12:33', NULL, NULL, 35000.00, 0.00, 1);
INSERT INTO `t_transaksi` VALUES ('58c87a01-69d4-4df7-996d-0c66bb5fd123', 'INV-21041000005', 1, NULL, 15000.00, '1', '2021-04-10 12:40:39', NULL, NULL, 30000.00, 15000.00, 1);
INSERT INTO `t_transaksi` VALUES ('aed1554a-57d9-4baa-ac50-d2496619b5c3', 'INV-21041100007', 1, NULL, 10000.00, '2', '2021-04-11 23:08:58', NULL, NULL, 10000.00, 0.00, 1);
INSERT INTO `t_transaksi` VALUES ('c53b2e29-5983-494c-87aa-189d20e2ecfa', 'INV-21041100006', 1, NULL, 15000.00, '2', '2021-04-11 23:08:48', NULL, NULL, 20000.00, 5000.00, 1);

-- ----------------------------
-- Table structure for t_transaksi_det
-- ----------------------------
DROP TABLE IF EXISTS `t_transaksi_det`;
CREATE TABLE `t_transaksi_det`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'uuid',
  `id_transaksi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'uuid',
  `id_item_trans` int(11) NULL DEFAULT NULL,
  `harga_satuan` float(20, 2) NULL DEFAULT NULL,
  `is_disc_jual` int(1) NULL DEFAULT NULL COMMENT 'flag kalo ada potongan, misal boss e ulang tahun, maka dalam 1 row ketika ini diflag maka harga satuan dianggap diskon',
  `ket_disc_jual` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'misal : event ulang tahun boss e',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_transaksi`(`id_transaksi`) USING BTREE,
  INDEX `id_item_trans`(`id_item_trans`) USING BTREE,
  CONSTRAINT `t_transaksi_det_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `t_transaksi` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_transaksi_det_ibfk_2` FOREIGN KEY (`id_item_trans`) REFERENCES `m_item_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_transaksi_det
-- ----------------------------
INSERT INTO `t_transaksi_det` VALUES ('01c3943a-e7ae-47f4-aa59-e2a84cd630f9', 'c53b2e29-5983-494c-87aa-189d20e2ecfa', 4, 5000.00, NULL, NULL, '2021-04-11 23:08:48', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('26f9f711-b265-4c52-9e6a-e008594649e2', 'c53b2e29-5983-494c-87aa-189d20e2ecfa', 2, 10000.00, NULL, NULL, '2021-04-11 23:08:48', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('2d873e2b-9219-4583-8e94-c646b3a9ba61', '3bf384cf-c2eb-4947-add7-8b547b90d5d7', 1, 25000.00, NULL, NULL, '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('3f589560-3627-46b9-9640-e2ac1a060c13', '56cd3383-73ca-428d-b2a5-cee4d392bcae', 3, 10000.00, NULL, NULL, '2021-04-10 09:12:33', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('41164dbe-7d6b-4344-8a9c-5c563d4b02fa', '58c87a01-69d4-4df7-996d-0c66bb5fd123', 4, 5000.00, NULL, NULL, '2021-04-10 12:40:39', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('56c8b27b-ef71-4123-9c23-bcf5b48b328e', '0cb83009-a6ac-4399-ad69-5ee8c0b8c14d', 2, 10000.00, NULL, NULL, '2021-04-10 09:12:16', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('858480ea-ff5c-4c67-b6e4-0e1406fb2760', '58c87a01-69d4-4df7-996d-0c66bb5fd123', 3, 10000.00, NULL, NULL, '2021-04-10 12:40:39', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('a1cc944d-aafb-4022-864f-2a764946c4f0', 'aed1554a-57d9-4baa-ac50-d2496619b5c3', 3, 10000.00, NULL, NULL, '2021-04-11 23:08:58', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('bbb36ee8-fcfb-43aa-9d2c-0c501c3b469a', '20af352e-ad3e-4b76-a552-b4510ca62dde', 2, 10000.00, NULL, NULL, '2021-04-10 09:13:41', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('ccd705b9-3b4a-45a2-b775-0512163e6453', '3bf384cf-c2eb-4947-add7-8b547b90d5d7', 3, 10000.00, NULL, NULL, '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('e23e0e15-1b59-4461-8af8-364dbcab1d19', '20af352e-ad3e-4b76-a552-b4510ca62dde', 4, 5000.00, NULL, NULL, '2021-04-10 09:13:41', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('e51049aa-0a48-4d6a-a413-997390e1fe0c', '56cd3383-73ca-428d-b2a5-cee4d392bcae', 1, 25000.00, NULL, NULL, '2021-04-10 09:12:33', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('eac9f12c-a7eb-4d7a-8cc1-8adf155aae96', '0cb83009-a6ac-4399-ad69-5ee8c0b8c14d', 4, 5000.00, NULL, NULL, '2021-04-10 09:12:16', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
