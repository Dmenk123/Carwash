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

 Date: 21/04/2021 01:40:33
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
  INDEX `m_item_trans_ibfk_1`(`id_jenis_trans`) USING BTREE,
  CONSTRAINT `m_item_trans_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_item_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_item_trans
-- ----------------------------
INSERT INTO `m_item_trans` VALUES (1, 1, 'Cuci Mobil', 'Cuci Mobil', 25000.00, 25000.00, '2021-03-27 19:44:12', NULL, NULL, 1);
INSERT INTO `m_item_trans` VALUES (2, 1, 'Cuci Motor', 'Cuci Motor', 10000.00, 10000.00, '2021-03-27 19:44:12', NULL, NULL, 2);
INSERT INTO `m_item_trans` VALUES (3, 1, 'Poles Mobil', 'Poles Mobil', 10000.00, 10000.00, '2021-03-27 19:44:12', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (4, 1, 'Poles Motor', 'Poles Motor', 5000.00, 5000.00, '2021-03-27 19:44:12', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (5, 2, 'Sabun Mobil Wings', 'Sabun Mobil Wings', 50000.00, 50000.00, '2021-04-14 21:10:03', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (6, 3, 'Gaji Karyawan Bulanan', 'Gaji Karyawan Bulanan', 3000000.00, 3000000.00, '2021-04-14 21:10:53', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (7, 4, 'Investasi Pemilik Modal', 'Investasi Pemilik Modal', 0.00, 0.00, '2021-04-17 04:45:52', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (8, 4, 'Investasi dari Om Anton', 'Investasi dari Om Anton ', 0.00, 0.00, '2021-04-17 04:56:18', '2021-04-21 01:36:17', NULL, NULL);
INSERT INTO `m_item_trans` VALUES (12, 5, 'Biaya Listrik', 'Biaya Listrik', 1000000.00, 1000000.00, '2021-04-17 20:18:11', '2021-04-17 20:18:21', NULL, NULL);
INSERT INTO `m_item_trans` VALUES (13, 5, 'Biaya Air', 'Biaya Air', 400000.00, 400000.00, '2021-04-17 20:18:43', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (14, 6, 'SHODAQOH YATIM PIATU', 'SHODAQOH YATIM PIATU', 0.00, 0.00, '2021-04-17 22:53:58', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (15, 6, 'Beli Spanduk Iklan', 'Beli Spanduk Iklan', 45000.00, 45000.00, '2021-04-17 22:54:44', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (16, 7, 'Sumbangan Pak RT', 'Sumbangan Pak RT', 0.00, 0.00, '2021-04-17 23:30:27', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (17, 6, 'Tambal Ban Staff', 'Tambal Ban Staff', 15000.00, 15000.00, '2021-04-21 01:38:27', NULL, '2021-04-21 01:38:50', NULL);

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
  `cashflow` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_jenis_trans
-- ----------------------------
INSERT INTO `m_jenis_trans` VALUES (1, 'Penjualan', 'A-01', 'Penjualan', '2021-03-27 19:42:00', NULL, NULL, 'out', 'penjualan');
INSERT INTO `m_jenis_trans` VALUES (2, 'Pembelian', 'A-02', 'Pembelian', '2021-04-14 21:02:26', NULL, NULL, 'in', 'pembelian');
INSERT INTO `m_jenis_trans` VALUES (3, 'Penggajian', 'B-01', 'Penggajian', '2021-04-14 21:02:26', NULL, NULL, 'out', 'penggajian');
INSERT INTO `m_jenis_trans` VALUES (4, 'Investasi', 'C-01', 'Insvestasi Pemilik Usaha', '2021-04-14 21:02:26', NULL, NULL, 'in', 'investasi');
INSERT INTO `m_jenis_trans` VALUES (5, 'Operasional', 'D-01', 'Biaya Operasional', '2021-04-14 21:02:26', NULL, NULL, 'out', 'operasional');
INSERT INTO `m_jenis_trans` VALUES (6, 'Pengeluaran Lain-Lain', 'D-02', 'Pengeluaran Lain-Lain', '2021-04-14 21:02:26', NULL, NULL, 'out', 'pengeluaran-lain-lain');
INSERT INTO `m_jenis_trans` VALUES (7, 'Penerimaan Lain-Lain', 'D-03', 'Penerimaan Lain-Lain', '2021-04-14 21:02:26', NULL, NULL, 'in', 'penerimaan-lain-lain');

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
INSERT INTO `m_menu` VALUES (14, 8, 'Transaksi Lain Lain', 'Transaksi Lain Lain', 'trans_lain', 'flaticon-open-box', 1, 2, 3, 1, 1, 1);
INSERT INTO `m_menu` VALUES (15, 8, 'Daftar Transaksi Lain-Lain', 'Daftar Transaksi Lain-Lain', 'daftar_transaksi_lain', 'flaticon-list-2', 1, 2, 4, 1, 1, 1);

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
-- Table structure for m_supplier
-- ----------------------------
DROP TABLE IF EXISTS `m_supplier`;
CREATE TABLE `m_supplier`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat_supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `telp_supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_supplier
-- ----------------------------
INSERT INTO `m_supplier` VALUES (1, 'Mitra Usaha', 'Jalan ABC 1', '01281281', NULL, NULL, NULL);

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
INSERT INTO `m_user` VALUES (1, 1, 'superadmin', 'SnIvSVV6c2UwdWhKS1ZKMDluUlp4dz09', 1, '2021-04-21 01:35:19', 'USR-00001', NULL, NULL, NULL, NULL, 'pemiliknya');
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
INSERT INTO `t_log_aktivitas` VALUES ('0b0a9ddb-d36f-4426-b45a-86ddd65b1502', 14, 1, 'CREATE', NULL, '[{\"id\":\"ce242955-56b5-4d64-8c7f-094c7ce3501c\",\"id_transaksi\":\"19194dca-6305-46ca-9c69-9bb50f33f0b4\",\"id_item_trans\":\"16\",\"harga_satuan\":\"50000.00\",\"qty\":\"1\",\"created_at\":\"2021-04-21 01:21:46\"}]', '2021-04-21 01:21:46', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('0df4ce03-8574-4022-b4c6-10a2958256ac', 11, 1, 'DELETE', '{\"id\":\"17\",\"id_jenis_trans\":\"6\",\"nama\":\"Tambal Ban Staff\",\"keterangan\":\"Tambal Ban Staff\",\"harga_awal\":\"15000.00\",\"harga\":\"15000.00\",\"created_at\":\"2021-04-21 01:38:27\",\"updated_at\":null,\"deleted_at\":null,\"id_jenis_counter\":null}', NULL, '2021-04-21 01:38:50', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('12e72344-48f3-436c-9bfa-27b759ef31a4', 14, 1, 'CREATE', NULL, '[{\"id\":\"6ba24de9-ea07-4c42-8ea1-e70461e8e914\",\"id_transaksi\":\"e3376f76-0fb5-41e8-b287-93766b899de3\",\"id_item_trans\":\"6\",\"harga_satuan\":\"3000000.00\",\"qty\":1,\"created_at\":\"2021-04-21 00:13:06\"}]', '2021-04-21 00:13:06', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('2cb5fbac-e2a1-4df6-ba23-477c17ea4d63', NULL, 1, 'LOGOUT', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-20 22:00:24\",\"id_role\":\"1\",\"logged_in\":false}', '2021-04-21 00:58:16', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('3710ce29-80ef-4e04-8e0b-9b048c28be9c', NULL, 1, 'LOGIN', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-20 22:01:42\",\"id_role\":\"1\",\"logged_in\":true}', '2021-04-21 00:58:22', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('3a1624a4-0aa5-42cd-b958-7b02aae40447', NULL, 1, 'LOGIN', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-20 22:00:24\",\"id_role\":\"1\",\"logged_in\":true}', '2021-04-20 22:01:42', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('3f0f2bf0-3dc6-4b8f-989c-9cacd413c217', 14, 1, 'CREATE', NULL, '[{\"id\":\"0c8d0724-7ac5-4523-8015-1ee380e2c7ff\",\"id_transaksi\":\"e99468b3-e7e9-4a3f-8727-dc4b319edeb1\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"qty\":\"3\",\"created_at\":\"2021-04-20 23:42:57\"}]', '2021-04-20 23:42:57', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('44bec530-8607-4608-8c6b-cc0147ddca6b', 14, 1, 'DELETE', '[{\"id\":\"6ba24de9-ea07-4c42-8ea1-e70461e8e914\",\"id_transaksi\":\"e3376f76-0fb5-41e8-b287-93766b899de3\",\"id_item_trans\":\"6\",\"harga_satuan\":\"3000000.00\",\"is_disc_jual\":null,\"ket_disc_jual\":null,\"created_at\":\"2021-04-21 00:13:06\",\"updated_at\":null,\"deleted_at\":null,\"qty\":\"1.00\"}]', NULL, '2021-04-21 00:13:14', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('45878d40-ff52-40d4-8284-8731dfbb7262', 14, 1, 'CREATE', NULL, '[{\"id\":\"bcf1903b-cac6-4ccc-9529-dd8edba00a11\",\"id_transaksi\":\"7dc67df8-8fc0-4253-a903-422ad588010a\",\"id_item_trans\":\"6\",\"harga_satuan\":\"3000000.00\",\"qty\":1,\"created_at\":\"2021-04-21 00:12:43\"}]', '2021-04-21 00:12:43', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4c32c885-ac45-46c0-971f-a2a09ff5bbc8', 9, 1, 'CREATE', NULL, '[{\"id\":\"15fe7f17-3d6f-4927-b459-18c62f7d39ec\",\"id_transaksi\":\"3a31f80d-f7e2-4def-93c2-5e14475e1068\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-20 22:09:39\"}]', '2021-04-20 22:09:39', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('6d83c767-b9a9-451b-8aa4-ea8457cdaf73', 14, 1, 'DELETE', '[{\"id\":\"b8528f96-c18a-4022-89ac-f34bdc1c5253\",\"id_transaksi\":\"4d9cb4d0-3e75-41f8-9d0f-cd52139c41a8\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"is_disc_jual\":null,\"ket_disc_jual\":null,\"created_at\":\"2021-04-20 23:43:27\",\"updated_at\":null,\"deleted_at\":null,\"qty\":\"1.00\"}]', NULL, '2021-04-20 23:43:38', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('79e11a6a-23ea-47d3-8331-abcf35fc6603', 9, 1, 'CREATE', NULL, '[{\"id\":\"d0621b35-52af-4269-9ba7-dd24ab711022\",\"id_transaksi\":\"c85e7334-1d99-4fc4-8bb0-603357e9ba58\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-20 22:08:58\"}]', '2021-04-20 22:08:58', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('8eb3b88d-5eea-4b10-a444-f69d3f41f6d0', 14, 1, 'CREATE', NULL, '[{\"id\":\"bef50bab-f96f-405c-8ef6-efc789a4c1b2\",\"id_transaksi\":\"dad9de88-169a-4567-bb75-67e219bddb98\",\"id_item_trans\":\"8\",\"harga_satuan\":\"500000.00\",\"qty\":1,\"created_at\":\"2021-04-21 00:59:53\"}]', '2021-04-21 00:59:53', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('9713e067-4c34-4f3e-a92f-52bf26a8ba42', 14, 1, 'CREATE', NULL, '[{\"id\":\"ee824424-525d-4fd6-8687-b1e780691551\",\"id_transaksi\":\"80be6c8d-73f0-4f35-86f4-46dccd021a9d\",\"id_item_trans\":\"15\",\"harga_satuan\":\"45000.00\",\"qty\":\"5\",\"created_at\":\"2021-04-21 01:17:01\"}]', '2021-04-21 01:17:01', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('a0480cfb-df61-4187-9b3a-d5b330e35b7e', NULL, 1, 'LOGIN', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-21 00:58:22\",\"id_role\":\"1\",\"logged_in\":true}', '2021-04-21 01:35:19', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('b27a17b8-d812-441b-888e-02e5b79e7ce0', 11, 1, 'UPDATE', '{\"id\":\"8\",\"id_jenis_trans\":\"4\",\"nama\":\"Investasi dari Om Rudi\",\"keterangan\":\"Investasi dari Om Rudi\",\"harga_awal\":\"0.00\",\"harga\":\"0.00\",\"created_at\":\"2021-04-17 04:56:18\",\"updated_at\":null,\"deleted_at\":null,\"id_jenis_counter\":null}', '{\"id_jenis_trans\":\"4\",\"nama\":\"Investasi dari Om Anton\",\"harga_awal\":\"0.00\",\"harga\":\"0.00\",\"keterangan\":\"Investasi dari Om Anton \",\"updated_at\":\"2021-04-21 01:36:17\"}', '2021-04-21 01:36:17', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('ba6a5551-9ab3-4b8f-a845-89518bfb3d2f', 14, 1, 'CREATE', NULL, '[{\"id\":\"02ca65a0-1d30-4085-9c4d-4aee344c0110\",\"id_transaksi\":\"91643abb-6756-4de1-bf11-84f3bfd90b9b\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"qty\":\"1\",\"created_at\":\"2021-04-20 23:44:18\"}]', '2021-04-20 23:44:18', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('bece2bf2-6132-4adf-b3b2-a06134515cc7', 11, 1, 'CREATE', NULL, '{\"id_jenis_trans\":\"6\",\"nama\":\"Tambal Ban Staff\",\"harga_awal\":\"15000\",\"harga\":\"15000\",\"keterangan\":\"Tambal Ban Staff\",\"created_at\":\"2021-04-21 01:38:27\"}', '2021-04-21 01:38:27', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('c153ccf4-8a2e-41e9-bca8-676a7c7becb2', 14, 1, 'CREATE', NULL, '[{\"id\":\"b8528f96-c18a-4022-89ac-f34bdc1c5253\",\"id_transaksi\":\"4d9cb4d0-3e75-41f8-9d0f-cd52139c41a8\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"qty\":\"1\",\"created_at\":\"2021-04-20 23:43:27\"}]', '2021-04-20 23:43:27', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('cffc9e9b-104a-4e73-a488-db4857c75ead', 9, 1, 'CREATE', NULL, '[{\"id\":\"3eb40dd5-22b2-4788-af55-f490d4cc3de7\",\"id_transaksi\":\"4c99f265-6b58-4679-8c5d-aea47e1b6555\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"created_at\":\"2021-04-20 22:09:24\"},{\"id\":\"8e019612-252a-4526-ad08-1045737c4a31\",\"id_transaksi\":\"4c99f265-6b58-4679-8c5d-aea47e1b6555\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-20 22:09:24\"},{\"id\":\"3ea680b2-73f1-48de-9cd3-6c9b42865f09\",\"id_transaksi\":\"4c99f265-6b58-4679-8c5d-aea47e1b6555\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-20 22:09:24\"}]', '2021-04-20 22:09:24', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d20b600f-944f-471b-b21f-1391a46451dd', 14, 1, 'CREATE', NULL, '[{\"id\":\"0603c6dc-3336-4c23-9525-70f9116b155f\",\"id_transaksi\":\"d4ec18a5-5bc3-460a-850b-8b2b56137cad\",\"id_item_trans\":\"13\",\"harga_satuan\":\"400000.00\",\"qty\":1,\"created_at\":\"2021-04-21 01:12:35\"}]', '2021-04-21 01:12:35', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d50ea147-1983-4067-8be8-5c9a3413a184', 14, 1, 'CREATE', NULL, '[{\"id\":\"c3312c1d-1ccd-4a78-b0c2-76df5660bd06\",\"id_transaksi\":\"d9621c33-ee97-4887-bdf8-6515473e92e4\",\"id_item_trans\":\"12\",\"harga_satuan\":\"1000000.00\",\"qty\":1,\"created_at\":\"2021-04-21 01:12:44\"}]', '2021-04-21 01:12:44', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d9a49b0c-6ac2-44d2-b021-d7a1e3ec7b10', NULL, 1, 'LOGOUT', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-20 22:01:42\",\"id_role\":\"1\",\"logged_in\":false}', '2021-04-21 01:27:40', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('e9781ee7-7970-49fe-aad0-9136de1da582', 14, 1, 'CREATE', NULL, '[{\"id\":\"776af799-cc38-45f9-8e59-cded01386945\",\"id_transaksi\":\"40c15940-b9d3-41f7-8990-82f528caaad5\",\"id_item_trans\":\"7\",\"harga_satuan\":\"1000000.00\",\"qty\":1,\"created_at\":\"2021-04-21 01:00:56\"}]', '2021-04-21 01:00:56', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('ec68531e-d23d-47a2-8643-d50d97ec8926', 9, 1, 'CREATE', NULL, '[{\"id\":\"67f3ea22-d721-492a-bc7d-3765d43af54d\",\"id_transaksi\":\"58913444-e703-407e-9f52-78cce6f484db\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"created_at\":\"2021-04-20 22:10:11\"},{\"id\":\"c89e2bcc-dafa-4fe5-ba68-69f51c58dc48\",\"id_transaksi\":\"58913444-e703-407e-9f52-78cce6f484db\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-20 22:10:11\"}]', '2021-04-20 22:10:11', NULL, NULL);

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
INSERT INTO `t_log_counter_member` VALUES (1, 1, 1, '2021-04-20 22:09:24', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (2, 1, 2, '2021-04-20 22:09:24', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (3, 1, 2, '2021-04-20 22:09:39', NULL, NULL);

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
-- Table structure for t_log_kunci
-- ----------------------------
DROP TABLE IF EXISTS `t_log_kunci`;
CREATE TABLE `t_log_kunci`  (
  `id` int(64) NOT NULL AUTO_INCREMENT,
  `bulan` int(2) NULL DEFAULT NULL,
  `tahun` int(4) NULL DEFAULT NULL,
  `id_user` int(64) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_kunci
-- ----------------------------

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
INSERT INTO `t_role_menu` VALUES (1, 3, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (8, 3, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (9, 3, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (13, 3, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (1, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (6, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (7, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (10, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (11, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (12, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (8, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (9, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (13, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (14, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (15, 1, 1, 1, 0);
INSERT INTO `t_role_menu` VALUES (2, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (4, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (3, 1, 1, 1, 1);

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
  `id_supplier` int(14) NULL DEFAULT NULL,
  `bulan_trans` int(2) NULL DEFAULT NULL,
  `tahun_trans` int(4) NULL DEFAULT NULL,
  `tgl_trans` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_jenis_trans`(`id_jenis_trans`) USING BTREE,
  INDEX `id_member`(`id_member`) USING BTREE,
  CONSTRAINT `t_transaksi_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_jenis_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_transaksi_ibfk_2` FOREIGN KEY (`id_member`) REFERENCES `m_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_transaksi
-- ----------------------------
INSERT INTO `t_transaksi` VALUES ('19194dca-6305-46ca-9c69-9bb50f33f0b4', NULL, 7, NULL, 50000.00, '1', '2021-04-21 01:21:46', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-21');
INSERT INTO `t_transaksi` VALUES ('3a31f80d-f7e2-4def-93c2-5e14475e1068', 'INV-21042000003', 1, 1, 10000.00, '1', '2021-04-20 22:09:39', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-20');
INSERT INTO `t_transaksi` VALUES ('40c15940-b9d3-41f7-8990-82f528caaad5', NULL, 4, NULL, 1000000.00, '1', '2021-04-21 01:00:56', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-09');
INSERT INTO `t_transaksi` VALUES ('4c99f265-6b58-4679-8c5d-aea47e1b6555', 'INV-21042000002', 1, 1, 45000.00, '1', '2021-04-20 22:09:24', NULL, NULL, 50000.00, 5000.00, 1, NULL, 4, 2021, '2021-04-20');
INSERT INTO `t_transaksi` VALUES ('4d9cb4d0-3e75-41f8-9d0f-cd52139c41a8', NULL, 2, NULL, 50000.00, '1', '2021-04-20 23:43:27', NULL, '2021-04-20 23:43:38', NULL, NULL, 1, 1, 4, 2021, '2021-04-20');
INSERT INTO `t_transaksi` VALUES ('58913444-e703-407e-9f52-78cce6f484db', 'INV-21042000004', 1, NULL, 35000.00, '1', '2021-04-20 22:10:11', NULL, NULL, 50000.00, 15000.00, 1, NULL, 4, 2021, '2021-04-20');
INSERT INTO `t_transaksi` VALUES ('7dc67df8-8fc0-4253-a903-422ad588010a', NULL, 3, NULL, 3000000.00, '1', '2021-04-21 00:12:43', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-21');
INSERT INTO `t_transaksi` VALUES ('80be6c8d-73f0-4f35-86f4-46dccd021a9d', NULL, 6, NULL, 225000.00, '1', '2021-04-21 01:17:01', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-21');
INSERT INTO `t_transaksi` VALUES ('91643abb-6756-4de1-bf11-84f3bfd90b9b', NULL, 2, NULL, 50000.00, '1', '2021-04-20 23:44:18', NULL, NULL, NULL, NULL, 1, 1, 4, 2021, '2021-04-21');
INSERT INTO `t_transaksi` VALUES ('c85e7334-1d99-4fc4-8bb0-603357e9ba58', 'INV-21042000001', 1, NULL, 10000.00, '1', '2021-04-20 22:08:58', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-20');
INSERT INTO `t_transaksi` VALUES ('d4ec18a5-5bc3-460a-850b-8b2b56137cad', NULL, 5, NULL, 400000.00, '1', '2021-04-21 01:12:35', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-21');
INSERT INTO `t_transaksi` VALUES ('d9621c33-ee97-4887-bdf8-6515473e92e4', NULL, 5, NULL, 1000000.00, '1', '2021-04-21 01:12:44', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-20');
INSERT INTO `t_transaksi` VALUES ('dad9de88-169a-4567-bb75-67e219bddb98', NULL, 4, NULL, 500000.00, '1', '2021-04-21 00:59:53', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-21');
INSERT INTO `t_transaksi` VALUES ('e3376f76-0fb5-41e8-b287-93766b899de3', NULL, 3, NULL, 3000000.00, '1', '2021-04-21 00:13:06', NULL, '2021-04-21 00:13:14', NULL, NULL, 1, NULL, 5, 2021, '2021-04-21');
INSERT INTO `t_transaksi` VALUES ('e99468b3-e7e9-4a3f-8727-dc4b319edeb1', NULL, 2, NULL, 150000.00, '1', '2021-04-20 23:42:57', NULL, NULL, NULL, NULL, 1, 1, 4, 2021, '2021-04-20');

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
  `qty` float(20, 2) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_transaksi`(`id_transaksi`) USING BTREE,
  INDEX `id_item_trans`(`id_item_trans`) USING BTREE,
  CONSTRAINT `t_transaksi_det_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `t_transaksi` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_transaksi_det_ibfk_2` FOREIGN KEY (`id_item_trans`) REFERENCES `m_item_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_transaksi_det
-- ----------------------------
INSERT INTO `t_transaksi_det` VALUES ('02ca65a0-1d30-4085-9c4d-4aee344c0110', '91643abb-6756-4de1-bf11-84f3bfd90b9b', 5, 50000.00, NULL, NULL, '2021-04-20 23:44:18', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('0603c6dc-3336-4c23-9525-70f9116b155f', 'd4ec18a5-5bc3-460a-850b-8b2b56137cad', 13, 400000.00, NULL, NULL, '2021-04-21 01:12:35', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('0c8d0724-7ac5-4523-8015-1ee380e2c7ff', 'e99468b3-e7e9-4a3f-8727-dc4b319edeb1', 5, 50000.00, NULL, NULL, '2021-04-20 23:42:57', NULL, NULL, 3.00);
INSERT INTO `t_transaksi_det` VALUES ('15fe7f17-3d6f-4927-b459-18c62f7d39ec', '3a31f80d-f7e2-4def-93c2-5e14475e1068', 2, 10000.00, NULL, NULL, '2021-04-20 22:09:39', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('3ea680b2-73f1-48de-9cd3-6c9b42865f09', '4c99f265-6b58-4679-8c5d-aea47e1b6555', 3, 10000.00, NULL, NULL, '2021-04-20 22:09:24', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('3eb40dd5-22b2-4788-af55-f490d4cc3de7', '4c99f265-6b58-4679-8c5d-aea47e1b6555', 1, 25000.00, NULL, NULL, '2021-04-20 22:09:24', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('67f3ea22-d721-492a-bc7d-3765d43af54d', '58913444-e703-407e-9f52-78cce6f484db', 1, 25000.00, NULL, NULL, '2021-04-20 22:10:11', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('6ba24de9-ea07-4c42-8ea1-e70461e8e914', 'e3376f76-0fb5-41e8-b287-93766b899de3', 6, 3000000.00, NULL, NULL, '2021-04-21 00:13:06', NULL, '2021-04-21 00:13:14', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('776af799-cc38-45f9-8e59-cded01386945', '40c15940-b9d3-41f7-8990-82f528caaad5', 7, 1000000.00, NULL, NULL, '2021-04-21 01:00:56', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('8e019612-252a-4526-ad08-1045737c4a31', '4c99f265-6b58-4679-8c5d-aea47e1b6555', 2, 10000.00, NULL, NULL, '2021-04-20 22:09:24', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('b8528f96-c18a-4022-89ac-f34bdc1c5253', '4d9cb4d0-3e75-41f8-9d0f-cd52139c41a8', 5, 50000.00, NULL, NULL, '2021-04-20 23:43:27', NULL, '2021-04-20 23:43:38', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('bcf1903b-cac6-4ccc-9529-dd8edba00a11', '7dc67df8-8fc0-4253-a903-422ad588010a', 6, 3000000.00, NULL, NULL, '2021-04-21 00:12:43', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('bef50bab-f96f-405c-8ef6-efc789a4c1b2', 'dad9de88-169a-4567-bb75-67e219bddb98', 8, 500000.00, NULL, NULL, '2021-04-21 00:59:53', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('c3312c1d-1ccd-4a78-b0c2-76df5660bd06', 'd9621c33-ee97-4887-bdf8-6515473e92e4', 12, 1000000.00, NULL, NULL, '2021-04-21 01:12:44', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('c89e2bcc-dafa-4fe5-ba68-69f51c58dc48', '58913444-e703-407e-9f52-78cce6f484db', 3, 10000.00, NULL, NULL, '2021-04-20 22:10:11', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('ce242955-56b5-4d64-8c7f-094c7ce3501c', '19194dca-6305-46ca-9c69-9bb50f33f0b4', 16, 50000.00, NULL, NULL, '2021-04-21 01:21:46', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('d0621b35-52af-4269-9ba7-dd24ab711022', 'c85e7334-1d99-4fc4-8bb0-603357e9ba58', 2, 10000.00, NULL, NULL, '2021-04-20 22:08:58', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('ee824424-525d-4fd6-8687-b1e780691551', '80be6c8d-73f0-4f35-86f4-46dccd021a9d', 15, 45000.00, NULL, NULL, '2021-04-21 01:17:01', NULL, NULL, 5.00);

SET FOREIGN_KEY_CHECKS = 1;
