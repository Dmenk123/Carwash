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

 Date: 19/04/2021 00:19:56
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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `m_item_trans` VALUES (8, 4, 'Investasi dari Om Rudi', 'Investasi dari Om Rudi', 0.00, 0.00, '2021-04-17 04:56:18', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (12, 5, 'Biaya Listrik', 'Biaya Listrik', 1000000.00, 1000000.00, '2021-04-17 20:18:11', '2021-04-17 20:18:21', NULL, NULL);
INSERT INTO `m_item_trans` VALUES (13, 5, 'Biaya Air', 'Biaya Air', 400000.00, 400000.00, '2021-04-17 20:18:43', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (14, 6, 'SHODAQOH YATIM PIATU', 'SHODAQOH YATIM PIATU', 0.00, 0.00, '2021-04-17 22:53:58', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (15, 6, 'Beli Spanduk Iklan', 'Beli Spanduk Iklan', 45000.00, 45000.00, '2021-04-17 22:54:44', NULL, NULL, NULL);
INSERT INTO `m_item_trans` VALUES (16, 7, 'Sumbangan Pak RT', 'Sumbangan Pak RT', 0.00, 0.00, '2021-04-17 23:30:27', NULL, NULL, NULL);

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
INSERT INTO `m_user` VALUES (1, 1, 'superadmin', 'SnIvSVV6c2UwdWhKS1ZKMDluUlp4dz09', 1, '2021-04-18 19:56:34', 'USR-00001', NULL, NULL, NULL, NULL, 'pemiliknya');
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
INSERT INTO `t_log_aktivitas` VALUES ('1e7a2b5c-13da-40aa-adb7-6fb7abf9545e', 14, 1, 'DELETE', '[{\"id\":\"ad35c4d3-f0e0-4c34-bccd-134b2244cfcf\",\"id_transaksi\":\"b5b1c84f-5212-4800-afec-89dab2471857\",\"id_item_trans\":\"5\",\"harga_satuan\":\"3000.00\",\"is_disc_jual\":null,\"ket_disc_jual\":null,\"created_at\":\"2021-04-16 21:34:21\",\"updated_at\":null,\"deleted_at\":null,\"qty\":\"2.00\"}]', NULL, '2021-04-18 21:36:22', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('322ca181-0a88-4655-81fb-4c34666712b3', 14, 1, 'DELETE', 'null', NULL, '2021-04-18 21:34:54', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('438df55e-6d45-4ad3-90f8-cd5216478a26', 9, 1, 'CREATE', NULL, '{\"id\":\"41164dbe-7d6b-4344-8a9c-5c563d4b02fa\",\"id_transaksi\":\"58c87a01-69d4-4df7-996d-0c66bb5fd123\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-10 12:40:39\"}', '2021-04-10 12:40:39', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4c45d86c-bfa2-4407-aef9-77c0b87a1d70', 14, 1, 'CREATE', NULL, '[{\"id\":\"5d13f9d3-121d-42bd-bcc1-f1731c62d898\",\"id_transaksi\":\"4d3664bf-c664-4160-8979-98321943858c\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"qty\":\"4\",\"created_at\":\"2021-04-19 00:02:55\"}]', '2021-04-19 00:02:55', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4d90ef86-ff41-4ddb-b66c-d4984845076b', 9, 2, 'CREATE', NULL, '{\"id\":\"a1cc944d-aafb-4022-864f-2a764946c4f0\",\"id_transaksi\":\"aed1554a-57d9-4baa-ac50-d2496619b5c3\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-11 23:08:58\"}', '2021-04-11 23:08:58', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('518a525e-bd9d-47fc-98ba-26b2c44170a3', 9, 2, 'CREATE', NULL, '{\"id\":\"01c3943a-e7ae-47f4-aa59-e2a84cd630f9\",\"id_transaksi\":\"c53b2e29-5983-494c-87aa-189d20e2ecfa\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-11 23:08:48\"}', '2021-04-11 23:08:48', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('5f5a4e84-3523-4b5d-9413-13ead0741c76', 9, 1, 'CREATE', NULL, '{\"id\":\"ccd705b9-3b4a-45a2-b775-0512163e6453\",\"id_transaksi\":\"3bf384cf-c2eb-4947-add7-8b547b90d5d7\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-10 09:13:17\"}', '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('6935b4a1-6d6e-436d-8934-c961f6a67de2', 14, 1, 'CREATE', NULL, '[{\"id\":\"1adf9db2-1be2-418a-a465-df8a70bc8f6b\",\"id_transaksi\":\"daa8f19d-59a3-4d7e-b766-c487bda66df0\",\"id_item_trans\":\"6\",\"harga_satuan\":\"3000000.00\",\"qty\":1,\"created_at\":\"2021-04-18 21:38:30\"}]', '2021-04-18 21:38:30', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('6cea075e-c095-401f-89c1-d6cabb4f7c31', 9, 1, 'CREATE', NULL, '{\"id\":\"eac9f12c-a7eb-4d7a-8cc1-8adf155aae96\",\"id_transaksi\":\"0cb83009-a6ac-4399-ad69-5ee8c0b8c14d\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-10 09:12:16\"}', '2021-04-10 09:12:16', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('9d5a0d38-d2dc-4a1e-bbe3-b428a274ecf9', 9, 1, 'CREATE', NULL, '{\"id\":\"e23e0e15-1b59-4461-8af8-364dbcab1d19\",\"id_transaksi\":\"20af352e-ad3e-4b76-a552-b4510ca62dde\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-10 09:13:41\"}', '2021-04-10 09:13:41', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('acd715c6-2c43-4486-8684-b81d6e6c925c', 14, 1, 'DELETE', 'null', NULL, '2021-04-18 21:34:47', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('b0ccb43f-a87d-49e6-9056-a8e032406f9e', 14, 1, 'DELETE', '[{\"id\":\"3176f964-89ff-4862-ac12-7e62643690bb\",\"id_transaksi\":\"4f682a9d-2158-43af-94d9-0ff11aa9a38b\",\"id_item_trans\":\"6\",\"harga_satuan\":\"3000000.00\",\"is_disc_jual\":null,\"ket_disc_jual\":null,\"created_at\":\"2021-04-17 09:54:47\",\"updated_at\":null,\"deleted_at\":null,\"qty\":\"1.00\"}]', NULL, '2021-04-18 21:37:14', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d83b49f6-4ee9-43ec-8edf-973e6f0c9ec0', 9, 1, 'CREATE', NULL, '{\"id\":\"3f589560-3627-46b9-9640-e2ac1a060c13\",\"id_transaksi\":\"56cd3383-73ca-428d-b2a5-cee4d392bcae\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-10 09:12:33\"}', '2021-04-10 09:12:33', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('f4b8569f-3a06-4b68-a5ef-4c267fb9fa78', 9, 1, 'CREATE', NULL, '{\"id\":\"956d5c43-7631-4e11-a018-8fb331d9a7cb\",\"id_transaksi\":\"8ef38300-1ec8-4731-b2db-9a2cb7658ec3\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-16 05:03:57\"}', '2021-04-16 05:03:57', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_counter_member
-- ----------------------------
INSERT INTO `t_log_counter_member` VALUES (1, 1, 1, '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (2, 1, 1, '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (3, 1, 2, '2021-04-10 09:13:17', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (4, 1, 1, '2021-04-16 05:03:57', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (5, 1, 2, '2021-04-16 05:03:57', NULL, NULL);

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
  `bulan_gaji` int(2) NULL DEFAULT NULL COMMENT 'untuk penggajian (boleh kosong)',
  `tahun_gaji` int(4) NULL DEFAULT NULL COMMENT 'untuk penggajian (boleh kosong)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_jenis_trans`(`id_jenis_trans`) USING BTREE,
  INDEX `id_member`(`id_member`) USING BTREE,
  CONSTRAINT `t_transaksi_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_jenis_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_transaksi_ibfk_2` FOREIGN KEY (`id_member`) REFERENCES `m_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_transaksi
-- ----------------------------
INSERT INTO `t_transaksi` VALUES ('0addcec3-d4e8-4a30-8d85-78d512bfd046', NULL, 3, NULL, 3000000.00, '1', '2021-04-17 00:15:32', NULL, '2021-04-17 00:16:22', NULL, NULL, 1, NULL, 3, 2021);
INSERT INTO `t_transaksi` VALUES ('0b736c8a-61f6-40f1-a6bc-02642032c1a9', NULL, 5, NULL, 400000.00, '1', '2021-04-17 20:29:31', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('0cb83009-a6ac-4399-ad69-5ee8c0b8c14d', 'INV-21041000001', 1, NULL, 15000.00, '1', '2021-04-10 09:12:16', NULL, NULL, 15000.00, 0.00, 0, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('1ab878b6-31a2-4bba-a6c3-05e72e7ba3b8', NULL, 6, NULL, 900000.00, '1', '2021-04-17 23:08:42', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('20af352e-ad3e-4b76-a552-b4510ca62dde', 'INV-21041000004', 1, NULL, 15000.00, '1', '2021-04-10 09:13:41', NULL, NULL, 15000.00, 0.00, 1, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('3bf384cf-c2eb-4947-add7-8b547b90d5d7', 'INV-21041000003', 1, 1, 35000.00, '1', '2021-04-10 09:13:17', NULL, NULL, 40000.00, 5000.00, 0, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('3ea7c2be-8504-4132-a3d3-3c53fbaf09e2', NULL, 6, NULL, 500000.00, '1', '2021-04-17 23:03:30', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('3fbbe87c-df24-4ea7-bdee-7afba8c0608d', NULL, 2, NULL, 20000.00, '1', '2021-04-15 05:19:10', NULL, NULL, NULL, NULL, 1, 1, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('4d3664bf-c664-4160-8979-98321943858c', NULL, 2, NULL, 200000.00, '1', '2021-04-19 00:02:55', NULL, NULL, NULL, NULL, 1, 1, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('4f682a9d-2158-43af-94d9-0ff11aa9a38b', NULL, 3, NULL, 3000000.00, '1', '2021-04-17 09:54:47', NULL, '2021-04-18 21:37:14', NULL, NULL, 1, NULL, 5, 2021);
INSERT INTO `t_transaksi` VALUES ('52559532-9a31-40eb-9219-cf3d058b3fa4', NULL, 3, NULL, 3000000.00, '1', '2021-04-17 00:15:18', NULL, '2021-04-17 00:16:46', NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('56cd3383-73ca-428d-b2a5-cee4d392bcae', 'INV-21041000002', 1, NULL, 35000.00, '1', '2021-04-10 09:12:33', NULL, NULL, 35000.00, 0.00, 1, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('58c87a01-69d4-4df7-996d-0c66bb5fd123', 'INV-21041000005', 1, NULL, 15000.00, '1', '2021-04-10 12:40:39', NULL, NULL, 30000.00, 15000.00, 1, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('6569fec6-eaba-4bb4-afc7-ea5a5865ccff', NULL, 6, NULL, 90000.00, '1', '2021-04-17 23:09:44', NULL, '2021-04-17 23:09:50', NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('72ca7778-3f30-448b-9f52-b73b32644f07', NULL, 7, NULL, 100000.00, '1', '2021-04-17 23:32:02', NULL, '2021-04-17 23:32:08', NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('740fe3b7-2e23-4b8a-b9cc-935c9c697f74', NULL, 4, NULL, 1000000.00, '1', '2021-04-17 20:04:39', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('7c2433c9-48fc-43d3-976d-641a6cde6e58', NULL, 4, NULL, 50000.00, '1', '2021-04-17 20:04:56', NULL, '2021-04-17 20:05:30', NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('7fb18b84-e9d2-423e-84c7-2e7381747c9e', NULL, 5, NULL, 400000.00, '1', '2021-04-17 20:29:23', NULL, '2021-04-17 20:29:29', NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('80db9616-9bfd-41fb-9da3-7e5892516465', NULL, 2, NULL, 190000.00, '1', '2021-04-16 05:00:06', NULL, NULL, NULL, NULL, 1, 1, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('8ef38300-1ec8-4731-b2db-9a2cb7658ec3', 'INV-21041600008', 1, 1, 40000.00, '1', '2021-04-16 05:03:57', NULL, NULL, 40000.00, 0.00, 1, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('9a35b2af-6159-464a-afc4-dd87e519afa3', NULL, 4, NULL, 10000.00, '1', '2021-04-17 20:07:11', NULL, '2021-04-17 20:07:15', NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('aed1554a-57d9-4baa-ac50-d2496619b5c3', 'INV-21041100007', 1, NULL, 10000.00, '2', '2021-04-11 23:08:58', NULL, NULL, 10000.00, 0.00, 1, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('b0bb8efb-219d-465b-be71-9c7e5804910d', NULL, 7, NULL, 100000.00, '1', '2021-04-17 23:32:13', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('b54252b7-dd87-48a1-99bd-7209ab4a9348', NULL, 5, NULL, 1000000.00, '1', '2021-04-17 20:29:15', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('b5b1c84f-5212-4800-afec-89dab2471857', NULL, 2, NULL, 6000.00, '1', '2021-04-16 21:34:21', NULL, '2021-04-18 21:36:22', NULL, NULL, 1, 1, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('bb0676a5-5175-405b-bebe-ab40a9e26860', NULL, 2, NULL, 15000.00, '1', '2021-04-15 19:25:22', NULL, '2021-04-18 21:34:54', NULL, NULL, 1, 1, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('bd05d843-b2fb-4f9d-8291-ddae19ec6e5a', NULL, 2, NULL, 90000.00, '1', '2021-04-16 04:58:27', NULL, '2021-04-16 23:05:49', NULL, NULL, 1, 1, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('bf68625a-0d31-4e52-bf03-e678eaf03bcc', NULL, 2, NULL, 50000.00, '1', '2021-04-16 21:34:09', NULL, '2021-04-16 23:05:45', NULL, NULL, 1, 1, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('c43e4854-7fb0-408a-bc8e-04be6b66e126', NULL, 4, NULL, 12000.00, '1', '2021-04-17 20:06:04', NULL, '2021-04-17 20:06:08', NULL, NULL, 1, NULL, 4, 2021);
INSERT INTO `t_transaksi` VALUES ('c53b2e29-5983-494c-87aa-189d20e2ecfa', 'INV-21041100006', 1, NULL, 15000.00, '2', '2021-04-11 23:08:48', NULL, NULL, 20000.00, 5000.00, 1, NULL, NULL, NULL);
INSERT INTO `t_transaksi` VALUES ('daa8f19d-59a3-4d7e-b766-c487bda66df0', NULL, 3, NULL, 3000000.00, '1', '2021-04-18 21:38:30', NULL, NULL, NULL, NULL, 1, NULL, 5, 2021);
INSERT INTO `t_transaksi` VALUES ('ef0dda75-018a-4d5d-984d-6b44d37a7c48', NULL, 3, NULL, 3000000.00, '1', '2021-04-17 00:16:53', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021);

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
INSERT INTO `t_transaksi_det` VALUES ('01c3943a-e7ae-47f4-aa59-e2a84cd630f9', 'c53b2e29-5983-494c-87aa-189d20e2ecfa', 4, 5000.00, NULL, NULL, '2021-04-11 23:08:48', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('14095534-0eea-4bf8-b648-06fb2c757bd3', '0addcec3-d4e8-4a30-8d85-78d512bfd046', 6, 3000000.00, NULL, NULL, '2021-04-17 00:15:32', NULL, '2021-04-17 00:16:22', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('1adf9db2-1be2-418a-a465-df8a70bc8f6b', 'daa8f19d-59a3-4d7e-b766-c487bda66df0', 6, 3000000.00, NULL, NULL, '2021-04-18 21:38:30', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('2568cf3c-8665-4d25-97b5-6ac6f3349c47', '7c2433c9-48fc-43d3-976d-641a6cde6e58', 8, 50000.00, NULL, NULL, '2021-04-17 20:04:56', NULL, '2021-04-17 20:05:30', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('26f9f711-b265-4c52-9e6a-e008594649e2', 'c53b2e29-5983-494c-87aa-189d20e2ecfa', 2, 10000.00, NULL, NULL, '2021-04-11 23:08:48', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('2800a48e-f867-46b0-9fbb-4fbff5b323a3', '6569fec6-eaba-4bb4-afc7-ea5a5865ccff', 15, 45000.00, NULL, NULL, '2021-04-17 23:09:44', NULL, '2021-04-17 23:09:50', 2.00);
INSERT INTO `t_transaksi_det` VALUES ('2a16f52e-6106-4b55-b836-2f97162cae7e', '80db9616-9bfd-41fb-9da3-7e5892516465', 5, 10000.00, NULL, NULL, '2021-04-16 05:00:06', NULL, NULL, 19.00);
INSERT INTO `t_transaksi_det` VALUES ('2d873e2b-9219-4583-8e94-c646b3a9ba61', '3bf384cf-c2eb-4947-add7-8b547b90d5d7', 1, 25000.00, NULL, NULL, '2021-04-10 09:13:17', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('3176f964-89ff-4862-ac12-7e62643690bb', '4f682a9d-2158-43af-94d9-0ff11aa9a38b', 6, 3000000.00, NULL, NULL, '2021-04-17 09:54:47', NULL, '2021-04-18 21:37:14', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('34d923c3-d9a8-4442-a767-6f87160c757b', '7fb18b84-e9d2-423e-84c7-2e7381747c9e', 13, 400000.00, NULL, NULL, '2021-04-17 20:29:23', NULL, '2021-04-17 20:29:29', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('36b631dd-5f41-49de-abb2-140c0ada182b', 'b0bb8efb-219d-465b-be71-9c7e5804910d', 16, 100000.00, NULL, NULL, '2021-04-17 23:32:13', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('3f589560-3627-46b9-9640-e2ac1a060c13', '56cd3383-73ca-428d-b2a5-cee4d392bcae', 3, 10000.00, NULL, NULL, '2021-04-10 09:12:33', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('41164dbe-7d6b-4344-8a9c-5c563d4b02fa', '58c87a01-69d4-4df7-996d-0c66bb5fd123', 4, 5000.00, NULL, NULL, '2021-04-10 12:40:39', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('4a719957-b38a-465a-9782-d174ae90f2e1', 'ef0dda75-018a-4d5d-984d-6b44d37a7c48', 6, 3000000.00, NULL, NULL, '2021-04-17 00:16:53', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('56c8b27b-ef71-4123-9c23-bcf5b48b328e', '0cb83009-a6ac-4399-ad69-5ee8c0b8c14d', 2, 10000.00, NULL, NULL, '2021-04-10 09:12:16', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('586ef2f4-3434-4baf-958a-df9246b04c99', '9a35b2af-6159-464a-afc4-dd87e519afa3', 8, 10000.00, NULL, NULL, '2021-04-17 20:07:11', NULL, '2021-04-17 20:07:15', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('5d13f9d3-121d-42bd-bcc1-f1731c62d898', '4d3664bf-c664-4160-8979-98321943858c', 5, 50000.00, NULL, NULL, '2021-04-19 00:02:55', NULL, NULL, 4.00);
INSERT INTO `t_transaksi_det` VALUES ('61679012-b705-4e15-a8da-7d5caae3396a', 'b54252b7-dd87-48a1-99bd-7209ab4a9348', 12, 1000000.00, NULL, NULL, '2021-04-17 20:29:15', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('68add352-afb3-4b0c-b50d-49d23bf7eef5', '1ab878b6-31a2-4bba-a6c3-05e72e7ba3b8', 15, 45000.00, NULL, NULL, '2021-04-17 23:08:42', NULL, NULL, 20.00);
INSERT INTO `t_transaksi_det` VALUES ('6ce51d6d-6343-4a37-a449-d94e17a1d307', '72ca7778-3f30-448b-9f52-b73b32644f07', 16, 100000.00, NULL, NULL, '2021-04-17 23:32:02', NULL, '2021-04-17 23:32:08', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('7968f7cd-498b-4a7d-b797-d6e1c4084f21', 'bb0676a5-5175-405b-bebe-ab40a9e26860', 5, 15000.00, NULL, NULL, '2021-04-15 19:25:22', NULL, '2021-04-18 21:34:54', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('858480ea-ff5c-4c67-b6e4-0e1406fb2760', '58c87a01-69d4-4df7-996d-0c66bb5fd123', 3, 10000.00, NULL, NULL, '2021-04-10 12:40:39', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('88d2c66e-ab47-4226-8c88-38bb2ea703d6', '3ea7c2be-8504-4132-a3d3-3c53fbaf09e2', 14, 500000.00, NULL, NULL, '2021-04-17 23:03:30', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('8dcf1d3a-0f82-4bfa-ae26-6cc530d1247b', 'bd05d843-b2fb-4f9d-8291-ddae19ec6e5a', 5, 10000.00, NULL, NULL, '2021-04-16 04:58:27', NULL, '2021-04-16 23:05:49', 9.00);
INSERT INTO `t_transaksi_det` VALUES ('956d5c43-7631-4e11-a018-8fb331d9a7cb', '8ef38300-1ec8-4731-b2db-9a2cb7658ec3', 4, 5000.00, NULL, NULL, '2021-04-16 05:03:57', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('989b5de4-b65b-44e5-bba9-7d90447fdd64', 'c43e4854-7fb0-408a-bc8e-04be6b66e126', 8, 12000.00, NULL, NULL, '2021-04-17 20:06:04', NULL, '2021-04-17 20:06:08', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('9e4e9bd7-b764-43e6-96b7-484c02e1cadb', '8ef38300-1ec8-4731-b2db-9a2cb7658ec3', 2, 10000.00, NULL, NULL, '2021-04-16 05:03:57', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('a1cc944d-aafb-4022-864f-2a764946c4f0', 'aed1554a-57d9-4baa-ac50-d2496619b5c3', 3, 10000.00, NULL, NULL, '2021-04-11 23:08:58', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('ad35c4d3-f0e0-4c34-bccd-134b2244cfcf', 'b5b1c84f-5212-4800-afec-89dab2471857', 5, 3000.00, NULL, NULL, '2021-04-16 21:34:21', NULL, '2021-04-18 21:36:22', 2.00);
INSERT INTO `t_transaksi_det` VALUES ('ae5590f2-a414-4b08-bf8d-90829796cf3d', '0b736c8a-61f6-40f1-a6bc-02642032c1a9', 13, 400000.00, NULL, NULL, '2021-04-17 20:29:31', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('bbb36ee8-fcfb-43aa-9d2c-0c501c3b469a', '20af352e-ad3e-4b76-a552-b4510ca62dde', 2, 10000.00, NULL, NULL, '2021-04-10 09:13:41', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('be0640b7-030c-40c9-8645-38178ebfd371', '3fbbe87c-df24-4ea7-bdee-7afba8c0608d', 5, 10000.00, NULL, NULL, '2021-04-15 05:19:10', NULL, NULL, 2.00);
INSERT INTO `t_transaksi_det` VALUES ('c7178cfd-d236-4fab-a6e2-e40bb49f6731', '8ef38300-1ec8-4731-b2db-9a2cb7658ec3', 1, 25000.00, NULL, NULL, '2021-04-16 05:03:57', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('ccd705b9-3b4a-45a2-b775-0512163e6453', '3bf384cf-c2eb-4947-add7-8b547b90d5d7', 3, 10000.00, NULL, NULL, '2021-04-10 09:13:17', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('d2c14220-da90-42c6-add8-0b8c2d10a22d', '52559532-9a31-40eb-9219-cf3d058b3fa4', 6, 3000000.00, NULL, NULL, '2021-04-17 00:15:18', NULL, '2021-04-17 00:16:46', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('df8c8b31-fdd1-434c-b309-dba215f627a6', 'bf68625a-0d31-4e52-bf03-e678eaf03bcc', 5, 10000.00, NULL, NULL, '2021-04-16 21:34:09', NULL, '2021-04-16 23:05:45', 5.00);
INSERT INTO `t_transaksi_det` VALUES ('e23e0e15-1b59-4461-8af8-364dbcab1d19', '20af352e-ad3e-4b76-a552-b4510ca62dde', 4, 5000.00, NULL, NULL, '2021-04-10 09:13:41', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('e24e0f69-70f5-419c-bc0a-c66876a51a46', '740fe3b7-2e23-4b8a-b9cc-935c9c697f74', 7, 1000000.00, NULL, NULL, '2021-04-17 20:04:39', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('e51049aa-0a48-4d6a-a413-997390e1fe0c', '56cd3383-73ca-428d-b2a5-cee4d392bcae', 1, 25000.00, NULL, NULL, '2021-04-10 09:12:33', NULL, NULL, 0.00);
INSERT INTO `t_transaksi_det` VALUES ('eac9f12c-a7eb-4d7a-8cc1-8adf155aae96', '0cb83009-a6ac-4399-ad69-5ee8c0b8c14d', 4, 5000.00, NULL, NULL, '2021-04-10 09:12:16', NULL, NULL, 0.00);

SET FOREIGN_KEY_CHECKS = 1;
