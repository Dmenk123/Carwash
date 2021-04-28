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

 Date: 29/04/2021 02:10:44
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
INSERT INTO `m_jenis_trans` VALUES (1, 'Penjualan', 'A-01', 'Penjualan', '2021-03-27 19:42:00', NULL, NULL, 'in', 'penjualan');
INSERT INTO `m_jenis_trans` VALUES (2, 'Pembelian', 'A-02', 'Pembelian', '2021-04-14 21:02:26', NULL, NULL, 'out', 'pembelian');
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
INSERT INTO `m_menu` VALUES (14, 8, 'Transaksi Lain Lain', 'Form Transaksi Non Penjualan', 'trans_lain', 'flaticon-open-box', 1, 2, 3, 1, 1, 1);
INSERT INTO `m_menu` VALUES (15, 8, 'Daftar Transaksi Lain-Lain', 'Pengelolaan Transaksi Non Penjualan', 'daftar_transaksi_lain', 'flaticon-list-2', 1, 2, 4, 1, 1, 1);
INSERT INTO `m_menu` VALUES (16, 0, 'Laporan', 'Laporan', '', 'flaticon-line-graph', 1, 1, 4, 0, 0, 0);
INSERT INTO `m_menu` VALUES (17, 16, 'Laporan Transaksi', 'Laporan Transaksi', 'lap_transaksi', 'flaticon-graph', 1, 2, 1, 1, 1, 1);
INSERT INTO `m_menu` VALUES (18, 16, 'Laporan Keuangan', 'Laporan Keuangan', 'lap_keuangan', 'flaticon-coins', 1, 2, 2, 1, 1, 1);
INSERT INTO `m_menu` VALUES (19, 6, 'Master Supplier', 'Master Supplier', 'master_supplier', 'flaticon-support', 1, 2, 5, 1, 1, 1);

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
INSERT INTO `m_profil` VALUES (1, 'Wijaya Premium Car Wash', 'Jl. Raya Tubanan No. 34', 'Karangpoh', 'Tandes', 'Surabaya', '60188', 'Jawa timur', '081321425352', 'nurcahyono320@gmail.com', 'Cuci Mobil dengan standar Premium', NULL, 'jual-ban-motorpng.png', '2021-03-27 19:47:40', NULL, NULL);

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
INSERT INTO `m_user` VALUES (1, 1, 'superadmin', 'SnIvSVV6c2UwdWhKS1ZKMDluUlp4dz09', 1, '2021-04-29 01:39:29', 'USR-00001', NULL, NULL, NULL, NULL, 'pemiliknya');
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
INSERT INTO `t_log_aktivitas` VALUES ('08cc2bf9-8d25-414a-a5d2-7ef1c5755bbd', 9, 1, 'CREATE', NULL, '[{\"id\":\"3a83da06-4a24-4732-ac9e-1d884a7a4631\",\"id_transaksi\":\"6759cb58-6743-48ef-a192-9e08500043dc\",\"qty\":1,\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-25 19:27:05\"},{\"id\":\"070509c6-b47e-4bd4-946b-19550a2b1f75\",\"id_transaksi\":\"6759cb58-6743-48ef-a192-9e08500043dc\",\"qty\":1,\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-25 19:27:05\"}]', '2021-04-25 19:27:05', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('097baf19-8261-43ec-b4b0-581711bca833', 14, 1, 'CREATE', NULL, '[{\"id\":\"5307129e-e8fb-4487-a47c-62dbb673c199\",\"id_transaksi\":\"fac332dc-2bb7-4ac7-ad0a-5b5c034658f9\",\"id_item_trans\":\"13\",\"harga_satuan\":\"400000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:28:24\"}]', '2021-04-25 19:28:24', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('097feacc-273a-4660-a1c1-f99ddb857fce', 14, 1, 'CREATE', NULL, '[{\"id\":\"d7cbc496-b76f-481b-a492-008b6d80871f\",\"id_transaksi\":\"3e929f4b-f4f4-475c-9b73-95b6aefab0de\",\"id_item_trans\":\"15\",\"harga_satuan\":\"4500000000.00\",\"qty\":\"1\",\"created_at\":\"2021-04-26 23:32:45\"}]', '2021-04-26 23:32:45', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('0e141eb5-275a-4a9d-91d4-395d70c240cc', 9, 1, 'CREATE', NULL, '[{\"id\":\"27ffd5f0-6dcd-446d-842c-0b9b78a00a11\",\"id_transaksi\":\"5914d29f-0830-431d-ade7-99b3d9651640\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:26:20\"},{\"id\":\"d0f8426e-e5c9-4d84-bfa7-f46be8556248\",\"id_transaksi\":\"5914d29f-0830-431d-ade7-99b3d9651640\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:26:20\"}]', '2021-04-25 19:26:20', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('0f65dacb-66a2-495e-8f8d-3c61e734e89e', 14, 1, 'CREATE', NULL, '[{\"id\":\"545d043d-dda1-4b4d-afb4-3ac8f4e40463\",\"id_transaksi\":\"9aa7cf28-dead-4da0-86ce-24210764321f\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"qty\":\"4\",\"created_at\":\"2021-04-25 19:27:16\"}]', '2021-04-25 19:27:17', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('1494ac7c-d053-4eb8-90fd-d0ec90a71ab5', 9, 1, 'CREATE', NULL, '[{\"id\":\"4ecca9f7-4850-47d9-97c5-79b94a6d7f3a\",\"id_transaksi\":\"e71d1873-9b93-46af-9bc7-e94d3a7bda5e\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 18:51:22\"}]', '2021-04-28 18:51:22', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('1d3e14c5-43fb-4b08-aca7-9f9cdf628ab1', 9, 1, 'CREATE', NULL, '[{\"id\":\"7ca99c32-9d8d-40e5-92a2-98ec4598aeb8\",\"id_transaksi\":\"815f4a64-7964-4d2a-be05-802faa2feeab\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:40:36\"},{\"id\":\"7bb9a521-8be4-472d-91b8-3d7b8be17393\",\"id_transaksi\":\"815f4a64-7964-4d2a-be05-802faa2feeab\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:40:36\"}]', '2021-04-28 22:40:36', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('1f56ec9e-392e-48e1-b2b5-056c024ee38d', 9, 1, 'CREATE', NULL, '[{\"id\":\"b68baa27-3ad7-4b37-a552-2865dc4b4e86\",\"id_transaksi\":\"a822dbfa-b2ed-4587-bb2e-f1c11c1b48a1\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"qty\":1,\"created_at\":\"2021-04-28 23:32:32\"},{\"id\":\"c5950caa-8686-4054-b4c0-3cb4e768e580\",\"id_transaksi\":\"a822dbfa-b2ed-4587-bb2e-f1c11c1b48a1\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 23:32:32\"}]', '2021-04-28 23:32:32', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('2144575b-5807-480b-96fe-074ea317a00b', 9, 1, 'CREATE', NULL, '[{\"id\":\"ceb43937-b77a-44d9-a4ed-512c4aad78d1\",\"id_transaksi\":\"e3e4f203-e1bd-4634-9bd1-6e21fa048b5c\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"qty\":1,\"created_at\":\"2021-04-28 20:00:31\"}]', '2021-04-28 20:00:31', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('21ff952d-fff7-4833-99f6-a76b1134b241', NULL, 1, 'LOGIN', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-25 19:15:38\",\"id_role\":\"1\",\"logged_in\":true}', '2021-04-26 20:38:41', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('22405881-c8f0-47c3-b2e5-725f937abb39', 9, 1, 'CREATE', NULL, '[{\"id\":\"8525e879-ddfb-41bc-be99-376a1ce8b133\",\"id_transaksi\":\"17662ed2-ed6d-4ff9-a736-026875ac8262\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:26:05\"}]', '2021-04-25 19:26:05', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('26229c23-54bd-49bf-9d4c-02ced6a52d48', 9, 1, 'CREATE', NULL, '[{\"id\":\"5c916940-ce9e-4b09-868c-7a3d79eaf70b\",\"id_transaksi\":\"a01cb30e-58a3-4992-90ba-1232981b9675\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 20:21:39\"}]', '2021-04-28 20:21:39', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('3275b4b6-bc05-4afd-86e4-7633e0414782', 14, 1, 'CREATE', NULL, '[{\"id\":\"03d17e0f-1d18-4b43-bc15-275c33d9fed1\",\"id_transaksi\":\"d01559a8-f3d7-439a-bbc2-1a2705bb5db2\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"qty\":\"1\",\"created_at\":\"2021-04-25 19:27:26\"}]', '2021-04-25 19:27:26', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('361cbc0a-5c55-419d-9fa0-cb7b4d4761a7', 9, 1, 'CREATE', NULL, '[{\"id\":\"efd7cb8a-e7be-486a-b0cd-9365554a4f9c\",\"id_transaksi\":\"3fd5345d-7850-4958-a0fa-9b7151c8caec\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 20:21:55\"}]', '2021-04-28 20:21:55', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('377ac4c3-425a-4de3-9503-0e26e9bcdc4a', 9, 1, 'CREATE', NULL, '[{\"id\":\"ff7670be-8268-45fe-a33c-8cdf74471bba\",\"id_transaksi\":\"19cd5933-8639-45cf-a81e-fd561dbc1768\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:46:14\"},{\"id\":\"e2a411dc-d2b5-4938-8a96-56f72849603b\",\"id_transaksi\":\"19cd5933-8639-45cf-a81e-fd561dbc1768\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:46:14\"}]', '2021-04-28 22:46:15', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('39292335-1acc-4bbf-9168-26e2927f2d6b', 9, 1, 'CREATE', NULL, '[{\"id\":\"c8065955-c505-4131-99e7-394ce0fdc1a2\",\"id_transaksi\":\"6b3a7cf6-5ed3-4235-a65c-10c0ee253425\",\"qty\":1,\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"created_at\":\"2021-04-25 19:26:45\"},{\"id\":\"322d33df-31b3-49bd-94d2-2c4bdebd0176\",\"id_transaksi\":\"6b3a7cf6-5ed3-4235-a65c-10c0ee253425\",\"qty\":1,\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-25 19:26:45\"}]', '2021-04-25 19:26:45', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('39cfefe6-bcd7-4f1c-8491-cdd786edf36e', 14, 1, 'CREATE', NULL, '[{\"id\":\"3822043d-4cf8-48e6-a996-e92f1ce9ed19\",\"id_transaksi\":\"9c9d07ac-8590-4f6e-81da-baf2738bbc0b\",\"id_item_trans\":\"8\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:28:03\"}]', '2021-04-25 19:28:03', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('3a55ba76-e2d1-4594-ad77-36624324785b', NULL, 1, 'LOGIN', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-28 18:51:08\",\"id_role\":\"1\",\"logged_in\":true}', '2021-04-29 01:39:29', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('3b671e95-79a6-450a-9147-ccf6871c95ec', 9, 1, 'CREATE', NULL, '[{\"id\":\"336c0702-7c9b-4c60-a806-a7ffd09a5d47\",\"id_transaksi\":\"c1840669-ecbd-4cb6-acc5-16e539c32a6f\",\"qty\":1,\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"created_at\":\"2021-04-28 23:37:19\"},{\"id\":\"2dd9eec2-deba-4845-8f66-c3378569b3df\",\"id_transaksi\":\"c1840669-ecbd-4cb6-acc5-16e539c32a6f\",\"qty\":1,\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-28 23:37:19\"}]', '2021-04-28 23:37:19', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('3bb70372-1f78-4d85-9acc-672a38d457fc', 14, 1, 'CREATE', NULL, '[{\"id\":\"ed9ef564-aade-41ab-be66-fc4ef7b8511d\",\"id_transaksi\":\"68846dae-7e55-4c8e-8a6a-ae3acb88aedc\",\"id_item_trans\":\"16\",\"harga_satuan\":\"20000.00\",\"qty\":\"1\",\"created_at\":\"2021-04-25 19:29:00\"}]', '2021-04-25 19:29:00', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4553c9dd-1eb7-4b63-9f30-6496332c6787', 9, 1, 'CREATE', NULL, '[{\"id\":\"14416bb9-29b0-496c-a2ea-b898f01b877e\",\"id_transaksi\":\"869d4176-a5e2-4d78-a529-3b3cfed85199\",\"qty\":1,\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-29 01:40:05\"},{\"id\":\"a19c6404-c7eb-4c7a-881a-9fea0af10cd6\",\"id_transaksi\":\"869d4176-a5e2-4d78-a529-3b3cfed85199\",\"qty\":1,\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-29 01:40:05\"}]', '2021-04-29 01:40:05', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4831fb87-a039-434e-8586-547a4d9cbd29', 14, 1, 'CREATE', NULL, '[{\"id\":\"a6735271-4a47-4d00-8e4a-38614f5f79d4\",\"id_transaksi\":\"0f04fba9-99d0-4414-8d9a-2f23efcc59f9\",\"id_item_trans\":\"6\",\"harga_satuan\":\"3000000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:27:51\"}]', '2021-04-25 19:27:51', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('49f87cd4-5b47-483f-8e70-5bf934008054', 9, 1, 'CREATE', NULL, '[{\"id\":\"89823957-4633-42b6-bf18-e235ce83c5f9\",\"id_transaksi\":\"5554e987-d21b-42f5-bea7-11ffd468096e\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"qty\":1,\"created_at\":\"2021-04-29 01:52:16\"},{\"id\":\"0a770b95-70b3-4e10-92e6-c0e8176978f5\",\"id_transaksi\":\"5554e987-d21b-42f5-bea7-11ffd468096e\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-29 01:52:16\"},{\"id\":\"74521e11-fb7b-479d-9150-43dd81223992\",\"id_transaksi\":\"5554e987-d21b-42f5-bea7-11ffd468096e\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-29 01:52:16\"},{\"id\":\"36c10faa-ead3-4395-a770-1927b941284e\",\"id_transaksi\":\"5554e987-d21b-42f5-bea7-11ffd468096e\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"qty\":1,\"created_at\":\"2021-04-29 01:52:16\"}]', '2021-04-29 01:52:16', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4c1432b4-9580-40e4-a4ab-9a07960c4d05', 9, 1, 'CREATE', NULL, '[{\"id\":\"321f6c67-3dab-4876-b3ce-aec7a7a89b75\",\"id_transaksi\":\"a0255eaa-76c2-4995-97bd-c75112eb56bf\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:30:37\"}]', '2021-04-28 22:30:37', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('534842e1-5976-472b-99b0-ac99d96832e7', 9, 1, 'CREATE', NULL, '[{\"id\":\"5df03fef-efdb-49dd-bd94-8d790219f628\",\"id_transaksi\":\"210e6660-fffe-445e-9148-1da1a611d583\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 19:45:29\"}]', '2021-04-28 19:45:29', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('53d1bbe7-ddcd-4bed-9520-951c1f740893', 9, 1, 'CREATE', NULL, '[{\"id\":\"735eb5e1-db14-4d7a-a61d-888f0a758266\",\"id_transaksi\":\"e026f701-839b-44bb-8bb3-e248e3323c50\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 23:24:15\"},{\"id\":\"8bf3e9cb-7a3e-49ed-98dc-690cc9c39c83\",\"id_transaksi\":\"e026f701-839b-44bb-8bb3-e248e3323c50\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 23:24:15\"},{\"id\":\"6f841f17-aefc-4e41-b864-ac7b5b005cbf\",\"id_transaksi\":\"e026f701-839b-44bb-8bb3-e248e3323c50\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"qty\":1,\"created_at\":\"2021-04-28 23:24:15\"}]', '2021-04-28 23:24:15', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('5854e552-6041-4183-9e02-69e986e710ba', 9, 1, 'CREATE', NULL, '[{\"id\":\"65fc6c1e-27a8-40ae-916f-af8290d881f3\",\"id_transaksi\":\"23dde684-286b-41cc-9317-8a0170752260\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 19:46:19\"},{\"id\":\"3cd11541-a976-4c0c-86bb-45f45cc95899\",\"id_transaksi\":\"23dde684-286b-41cc-9317-8a0170752260\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"qty\":1,\"created_at\":\"2021-04-28 19:46:19\"}]', '2021-04-28 19:46:19', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('63549e43-8e71-4bc9-8c88-1cd757c0f692', 14, 1, 'CREATE', NULL, '[{\"id\":\"968d559a-4966-4e0a-9b78-ba63d96e78d2\",\"id_transaksi\":\"9a5335a0-4891-4c18-be78-dc10faa4885a\",\"id_item_trans\":\"12\",\"harga_satuan\":\"1000000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:28:30\"}]', '2021-04-25 19:28:30', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('75f3facc-875d-4410-a664-d3388ac33c10', 9, 1, 'CREATE', NULL, '[{\"id\":\"c176481e-47c2-410a-8426-2ec5b0f91920\",\"id_transaksi\":\"7d47f6ff-5736-4f29-96af-a1a42a98226c\",\"qty\":1,\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-29 01:47:11\"},{\"id\":\"154eefa4-ed5c-4a5b-9a14-edcb62b471c2\",\"id_transaksi\":\"7d47f6ff-5736-4f29-96af-a1a42a98226c\",\"qty\":1,\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-29 01:47:11\"}]', '2021-04-29 01:47:11', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('76891ffc-d046-45eb-95d5-925b380f0935', 9, 1, 'CREATE', NULL, '[{\"id\":\"94a261aa-c71b-4515-8574-7b0182f1a2b0\",\"id_transaksi\":\"d1aec4cf-0bfd-44ed-b717-f74ba8c3a99b\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:40:14\"},{\"id\":\"6d5f7488-f83c-4360-9d0b-3bccd59b5345\",\"id_transaksi\":\"d1aec4cf-0bfd-44ed-b717-f74ba8c3a99b\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:40:14\"}]', '2021-04-28 22:40:14', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('8b5db7e0-e682-4cb1-bad6-0066f682ba69', 9, 1, 'CREATE', NULL, '[{\"id\":\"efdef95d-4a4c-46b5-a133-0350d792521e\",\"id_transaksi\":\"757eebae-54bd-4814-aa68-a1ab4f449d24\",\"id_item_trans\":\"1\",\"harga_satuan\":\"25000.00\",\"qty\":1,\"created_at\":\"2021-04-28 20:22:34\"},{\"id\":\"65b276e4-4ade-480c-abf3-ac8cb06d2598\",\"id_transaksi\":\"757eebae-54bd-4814-aa68-a1ab4f449d24\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 20:22:34\"}]', '2021-04-28 20:22:34', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('8e541f93-4850-4010-8c54-e6a4ee854290', 9, 1, 'CREATE', NULL, '[{\"id\":\"a677b226-1a8e-4d96-bf3b-48887a419587\",\"id_transaksi\":\"87031c13-de6c-4bb0-a74b-047ceb95225e\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 20:01:53\"}]', '2021-04-28 20:01:53', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('90cf3cdb-5983-4e0f-928e-8ac6b573cae0', 14, 1, 'CREATE', NULL, '[{\"id\":\"6e143de7-fc10-4e31-9d28-9b0cd4323f39\",\"id_transaksi\":\"1b4b8163-26e8-488b-be50-036d989ab496\",\"id_item_trans\":\"5\",\"harga_satuan\":\"50000.00\",\"qty\":\"12\",\"created_at\":\"2021-04-25 19:27:43\"}]', '2021-04-25 19:27:43', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('98a1133d-2379-46a8-9784-8054e5d72962', 9, 1, 'CREATE', NULL, '[{\"id\":\"7b59d936-7103-47a8-891b-da7294d3f558\",\"id_transaksi\":\"1afd3dc2-0cdf-4d0d-ae50-6d8bae5d1a93\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 19:52:38\"}]', '2021-04-28 19:52:38', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('a601710d-d78a-49d4-95a6-9bd239bff148', 14, 1, 'DELETE', '[{\"id\":\"d7cbc496-b76f-481b-a492-008b6d80871f\",\"id_transaksi\":\"3e929f4b-f4f4-475c-9b73-95b6aefab0de\",\"id_item_trans\":\"15\",\"harga_satuan\":\"4499999744.00\",\"is_disc_jual\":null,\"ket_disc_jual\":null,\"created_at\":\"2021-04-26 23:32:45\",\"updated_at\":null,\"deleted_at\":null,\"qty\":\"1.00\"}]', NULL, '2021-04-26 23:33:19', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('a7cc6c57-405a-426b-a61a-0604146b3897', 14, 1, 'CREATE', NULL, '[{\"id\":\"b1d7382a-a7b7-4d06-a69f-16090f81f0c5\",\"id_transaksi\":\"da54a5a6-87bb-4caf-8499-bc4e8b254bf7\",\"id_item_trans\":\"14\",\"harga_satuan\":\"5000000.00\",\"qty\":\"1\",\"created_at\":\"2021-04-25 19:28:47\"}]', '2021-04-25 19:28:47', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('a9f85f0d-158c-47cb-9843-4c9db3f7d685', NULL, 1, 'LOGIN', NULL, '{\"username\":\"superadmin\",\"id_user\":\"1\",\"last_login\":\"2021-04-26 20:38:41\",\"id_role\":\"1\",\"logged_in\":true}', '2021-04-28 18:51:08', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d438df3d-c77b-41c3-8b8b-80ba64be327a', 9, 1, 'CREATE', NULL, '[{\"id\":\"542b0e47-30fa-4bf6-9126-13308f6ea77e\",\"id_transaksi\":\"e4593c7f-3bd4-4975-83b2-fcb54bf1811f\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 22:31:39\"}]', '2021-04-28 22:31:39', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d4f74807-5826-475a-89fc-6a684f136dfa', 14, 1, 'CREATE', NULL, '[{\"id\":\"b8701f5f-21ce-48d1-a609-4760da2812c9\",\"id_transaksi\":\"f37e0a27-bebf-4495-9003-fd15976dc88b\",\"id_item_trans\":\"7\",\"harga_satuan\":\"10000000.00\",\"qty\":1,\"created_at\":\"2021-04-26 23:08:37\"}]', '2021-04-26 23:08:37', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d85134b4-1df9-445c-87a8-720e26a9c3b3', 14, 1, 'CREATE', NULL, '[{\"id\":\"14001f1a-da61-47fd-84d8-9a73d91e0d5a\",\"id_transaksi\":\"56d093c6-d105-402c-b4f8-837e36d25ffd\",\"id_item_trans\":\"7\",\"harga_satuan\":\"1000000.00\",\"qty\":1,\"created_at\":\"2021-04-25 19:28:14\"}]', '2021-04-25 19:28:14', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('de98e664-0df1-4993-a350-071810755011', 9, 1, 'CREATE', NULL, '[{\"id\":\"e2ac985e-9ef4-484a-ab33-723d28dac17e\",\"id_transaksi\":\"674b8453-213b-406c-85f5-7ea9b399a8a2\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 23:29:50\"},{\"id\":\"e678332c-3934-4492-b75a-7edb2a5c8d21\",\"id_transaksi\":\"674b8453-213b-406c-85f5-7ea9b399a8a2\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 23:29:50\"}]', '2021-04-28 23:29:50', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('df8d3702-07da-4109-bfd2-94e5cf358da6', 9, 1, 'CREATE', NULL, '[{\"id\":\"a0282535-6a11-4d95-9351-66dab94597cf\",\"id_transaksi\":\"f24165fa-a179-471c-995a-594286591b28\",\"qty\":1,\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-29 01:48:28\"},{\"id\":\"cb5dcbeb-b7cd-4f32-8b96-a5e3610997c2\",\"id_transaksi\":\"f24165fa-a179-471c-995a-594286591b28\",\"qty\":1,\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-29 01:48:28\"}]', '2021-04-29 01:48:28', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('eed0f4d9-f038-476f-9fa7-79d44dc66177', 15, 1, 'UPDATE', '[{\"id\":\"da54a5a6-87bb-4caf-8499-bc4e8b254bf7\",\"kode\":null,\"id_jenis_trans\":\"6\",\"id_member\":null,\"harga_total\":\"5000000.00\",\"id_user\":\"1\",\"created_at\":\"2021-04-25 19:28:47\",\"updated_at\":null,\"deleted_at\":null,\"harga_bayar\":null,\"harga_kembalian\":null,\"is_kunci\":\"1\",\"id_supplier\":null,\"bulan_trans\":\"4\",\"tahun_trans\":\"2021\",\"tgl_trans\":\"2021-04-03\"},{\"id\":\"b1d7382a-a7b7-4d06-a69f-16090f81f0c5\",\"id_transaksi\":\"da54a5a6-87bb-4caf-8499-bc4e8b254bf7\",\"id_item_trans\":\"14\",\"harga_satuan\":\"5000000.00\",\"is_disc_jual\":null,\"ket_disc_jual\":null,\"created_at\":\"2021-04-25 19:28:47\",\"updated_at\":null,\"deleted_at\":null,\"qty\":\"1.00\"}]', '[{\"id_jenis_trans\":\"6\",\"bulan_trans\":4,\"tahun_trans\":2021,\"tgl_trans\":\"2021-04-03\",\"harga_total\":\"100000.00\",\"id_user\":\"1\",\"updated_at\":\"2021-04-26 23:06:44\"},{\"id_item_trans\":\"14\",\"harga_satuan\":\"100000.00\",\"qty\":\"1\",\"updated_at\":\"2021-04-26 23:06:44\"}]', '2021-04-26 23:06:44', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('efc9c82d-e897-4235-9f8d-265f3d6709af', 9, 1, 'CREATE', NULL, '[{\"id\":\"08802963-672e-41b9-a2eb-70e4199b710b\",\"id_transaksi\":\"9bb1ebe2-37ef-42c8-bf5f-a253436e66d5\",\"id_item_trans\":\"2\",\"harga_satuan\":\"10000.00\",\"qty\":1,\"created_at\":\"2021-04-28 20:20:40\"}]', '2021-04-28 20:20:40', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_counter_member
-- ----------------------------
INSERT INTO `t_log_counter_member` VALUES (1, 1, 1, '2021-04-25 19:26:45', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (2, 1, 2, '2021-04-25 19:26:45', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (3, 1, 2, '2021-04-25 19:27:05', NULL, NULL);
INSERT INTO `t_log_counter_member` VALUES (4, 2, 1, '2021-04-28 23:37:19', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_kunci
-- ----------------------------
INSERT INTO `t_log_kunci` VALUES (1, 4, 2021, 1, '2021-04-24 22:31:56', NULL, '2021-04-25 01:13:10');

-- ----------------------------
-- Table structure for t_log_laporan
-- ----------------------------
DROP TABLE IF EXISTS `t_log_laporan`;
CREATE TABLE `t_log_laporan`  (
  `id` int(11) NOT NULL,
  `id_user` int(64) NULL DEFAULT NULL,
  `bulan` int(2) NULL DEFAULT NULL,
  `tahun` int(4) NULL DEFAULT NULL,
  `id_log_kunci` int(64) NULL DEFAULT NULL,
  `saldo_awal` float(20, 2) NULL DEFAULT NULL,
  `saldo_akhir` float(20, 2) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_laporan
-- ----------------------------

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
  `saldo_awal` float(20, 2) NULL DEFAULT NULL,
  `saldo_akhir` float(20, 2) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_laporan_det
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
INSERT INTO `t_role_menu` VALUES (19, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (8, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (9, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (13, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (14, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (15, 1, 1, 1, 0);
INSERT INTO `t_role_menu` VALUES (16, 1, 0, 0, 0);
INSERT INTO `t_role_menu` VALUES (17, 1, 1, 1, 1);
INSERT INTO `t_role_menu` VALUES (18, 1, 1, 1, 1);
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
INSERT INTO `t_transaksi` VALUES ('0f04fba9-99d0-4414-8d9a-2f23efcc59f9', NULL, 3, NULL, 3000000.00, '1', '2021-04-25 19:27:51', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-25');
INSERT INTO `t_transaksi` VALUES ('17662ed2-ed6d-4ff9-a736-026875ac8262', 'INV-21042500001', 1, NULL, 10000.00, '1', '2021-04-25 19:26:05', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-25');
INSERT INTO `t_transaksi` VALUES ('19cd5933-8639-45cf-a81e-fd561dbc1768', 'INV-21042800019', 1, NULL, 35000.00, '1', '2021-04-28 22:46:14', NULL, NULL, 50000.00, 15000.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('1afd3dc2-0cdf-4d0d-ae50-6d8bae5d1a93', 'INV-21042800008', 1, NULL, 10000.00, '1', '2021-04-28 19:52:38', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('1b4b8163-26e8-488b-be50-036d989ab496', NULL, 2, NULL, 600000.00, '1', '2021-04-25 19:27:43', NULL, NULL, NULL, NULL, 1, 1, 4, 2021, '2021-04-13');
INSERT INTO `t_transaksi` VALUES ('210e6660-fffe-445e-9148-1da1a611d583', 'INV-21042800006', 1, NULL, 10000.00, '1', '2021-04-28 19:45:29', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('23dde684-286b-41cc-9317-8a0170752260', 'INV-21042800007', 1, NULL, 15000.00, '1', '2021-04-28 19:46:19', NULL, NULL, 15000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('3e929f4b-f4f4-475c-9b73-95b6aefab0de', NULL, 6, NULL, 4499999744.00, '1', '2021-04-26 23:32:45', NULL, '2021-04-26 23:33:19', NULL, NULL, 1, NULL, 4, 2021, '2021-04-26');
INSERT INTO `t_transaksi` VALUES ('3fd5345d-7850-4958-a0fa-9b7151c8caec', 'INV-21042800013', 1, NULL, 10000.00, '1', '2021-04-28 20:21:55', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('5554e987-d21b-42f5-bea7-11ffd468096e', 'INV-21042900027', 1, NULL, 50000.00, '1', '2021-04-29 01:52:16', NULL, NULL, 50000.00, 0.00, 1, NULL, 4, 2021, '2021-04-29');
INSERT INTO `t_transaksi` VALUES ('56d093c6-d105-402c-b4f8-837e36d25ffd', NULL, 4, NULL, 1000000.00, '1', '2021-04-25 19:28:14', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-07');
INSERT INTO `t_transaksi` VALUES ('5914d29f-0830-431d-ade7-99b3d9651640', 'INV-21042500002', 1, NULL, 35000.00, '1', '2021-04-25 19:26:20', NULL, NULL, 40000.00, 5000.00, 1, NULL, 4, 2021, '2021-04-25');
INSERT INTO `t_transaksi` VALUES ('674b8453-213b-406c-85f5-7ea9b399a8a2', 'INV-21042800021', 1, NULL, 20000.00, '1', '2021-04-28 23:29:50', NULL, NULL, 20000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('6759cb58-6743-48ef-a192-9e08500043dc', 'INV-21042500004', 1, 1, 15000.00, '1', '2021-04-25 19:27:05', NULL, NULL, 20000.00, 5000.00, 1, NULL, 4, 2021, '2021-04-25');
INSERT INTO `t_transaksi` VALUES ('68846dae-7e55-4c8e-8a6a-ae3acb88aedc', NULL, 7, NULL, 20000.00, '1', '2021-04-25 19:29:00', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-07');
INSERT INTO `t_transaksi` VALUES ('6b3a7cf6-5ed3-4235-a65c-10c0ee253425', 'INV-21042500003', 1, 1, 35000.00, '1', '2021-04-25 19:26:45', NULL, NULL, 50000.00, 15000.00, 1, NULL, 4, 2021, '2021-04-25');
INSERT INTO `t_transaksi` VALUES ('757eebae-54bd-4814-aa68-a1ab4f449d24', 'INV-21042800014', 1, NULL, 35000.00, '1', '2021-04-28 20:22:34', NULL, NULL, 50000.00, 15000.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('7d47f6ff-5736-4f29-96af-a1a42a98226c', 'INV-21042900025', 1, 2, 15000.00, '1', '2021-04-29 01:47:11', NULL, NULL, 20000.00, 5000.00, 1, NULL, 4, 2021, '2021-04-29');
INSERT INTO `t_transaksi` VALUES ('815f4a64-7964-4d2a-be05-802faa2feeab', 'INV-21042800018', 1, NULL, 20000.00, '1', '2021-04-28 22:40:36', NULL, NULL, 20000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('869d4176-a5e2-4d78-a529-3b3cfed85199', 'INV-21042900024', 1, 2, 15000.00, '1', '2021-04-29 01:40:05', NULL, NULL, 20000.00, 5000.00, 1, NULL, 4, 2021, '2021-04-29');
INSERT INTO `t_transaksi` VALUES ('87031c13-de6c-4bb0-a74b-047ceb95225e', 'INV-21042800010', 1, NULL, 10000.00, '1', '2021-04-28 20:01:53', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('9a5335a0-4891-4c18-be78-dc10faa4885a', NULL, 5, NULL, 1000000.00, '1', '2021-04-25 19:28:30', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-15');
INSERT INTO `t_transaksi` VALUES ('9aa7cf28-dead-4da0-86ce-24210764321f', NULL, 2, NULL, 200000.00, '1', '2021-04-25 19:27:16', NULL, NULL, NULL, NULL, 1, 1, 4, 2021, '2021-04-25');
INSERT INTO `t_transaksi` VALUES ('9bb1ebe2-37ef-42c8-bf5f-a253436e66d5', 'INV-21042800011', 1, NULL, 10000.00, '1', '2021-04-28 20:20:40', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('9c9d07ac-8590-4f6e-81da-baf2738bbc0b', NULL, 4, NULL, 10000.00, '1', '2021-04-25 19:28:03', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-02');
INSERT INTO `t_transaksi` VALUES ('a01cb30e-58a3-4992-90ba-1232981b9675', 'INV-21042800012', 1, NULL, 10000.00, '1', '2021-04-28 20:21:39', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('a0255eaa-76c2-4995-97bd-c75112eb56bf', 'INV-21042800015', 1, NULL, 10000.00, '1', '2021-04-28 22:30:37', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('a822dbfa-b2ed-4587-bb2e-f1c11c1b48a1', 'INV-21042800022', 1, NULL, 35000.00, '1', '2021-04-28 23:32:32', NULL, NULL, 500000.00, 465000.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('c1840669-ecbd-4cb6-acc5-16e539c32a6f', 'INV-21042800023', 1, 2, 35000.00, '1', '2021-04-28 23:37:19', NULL, NULL, 40000.00, 5000.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('d01559a8-f3d7-439a-bbc2-1a2705bb5db2', NULL, 2, NULL, 50000.00, '1', '2021-04-25 19:27:26', NULL, NULL, NULL, NULL, 1, 1, 4, 2021, '2021-04-09');
INSERT INTO `t_transaksi` VALUES ('d1aec4cf-0bfd-44ed-b717-f74ba8c3a99b', 'INV-21042800017', 1, NULL, 35000.00, '1', '2021-04-28 22:40:14', NULL, NULL, 50000.00, 15000.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('da54a5a6-87bb-4caf-8499-bc4e8b254bf7', NULL, 6, NULL, 100000.00, '1', '2021-04-25 19:28:47', '2021-04-26 23:06:44', NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-03');
INSERT INTO `t_transaksi` VALUES ('e026f701-839b-44bb-8bb3-e248e3323c50', 'INV-21042800020', 1, NULL, 25000.00, '1', '2021-04-28 23:24:15', NULL, NULL, 25000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('e3e4f203-e1bd-4634-9bd1-6e21fa048b5c', 'INV-21042800009', 1, NULL, 5000.00, '1', '2021-04-28 20:00:31', NULL, NULL, 10000.00, 5000.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('e4593c7f-3bd4-4975-83b2-fcb54bf1811f', 'INV-21042800016', 1, NULL, 10000.00, '1', '2021-04-28 22:31:39', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('e71d1873-9b93-46af-9bc7-e94d3a7bda5e', 'INV-21042800005', 1, NULL, 10000.00, '1', '2021-04-28 18:51:22', NULL, NULL, 10000.00, 0.00, 1, NULL, 4, 2021, '2021-04-28');
INSERT INTO `t_transaksi` VALUES ('f24165fa-a179-471c-995a-594286591b28', 'INV-21042900026', 1, 2, 15000.00, '1', '2021-04-29 01:48:28', NULL, NULL, 15000.00, 0.00, 1, NULL, 4, 2021, '2021-04-29');
INSERT INTO `t_transaksi` VALUES ('f37e0a27-bebf-4495-9003-fd15976dc88b', NULL, 4, NULL, 10000000.00, '1', '2021-04-26 23:08:37', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-01');
INSERT INTO `t_transaksi` VALUES ('fac332dc-2bb7-4ac7-ad0a-5b5c034658f9', NULL, 5, NULL, 400000.00, '1', '2021-04-25 19:28:24', NULL, NULL, NULL, NULL, 1, NULL, 4, 2021, '2021-04-25');

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
INSERT INTO `t_transaksi_det` VALUES ('03d17e0f-1d18-4b43-bc15-275c33d9fed1', 'd01559a8-f3d7-439a-bbc2-1a2705bb5db2', 5, 50000.00, NULL, NULL, '2021-04-25 19:27:26', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('070509c6-b47e-4bd4-946b-19550a2b1f75', '6759cb58-6743-48ef-a192-9e08500043dc', 4, 5000.00, NULL, NULL, '2021-04-25 19:27:05', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('08802963-672e-41b9-a2eb-70e4199b710b', '9bb1ebe2-37ef-42c8-bf5f-a253436e66d5', 2, 10000.00, NULL, NULL, '2021-04-28 20:20:40', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('0a770b95-70b3-4e10-92e6-c0e8176978f5', '5554e987-d21b-42f5-bea7-11ffd468096e', 2, 10000.00, NULL, NULL, '2021-04-29 01:52:16', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('14001f1a-da61-47fd-84d8-9a73d91e0d5a', '56d093c6-d105-402c-b4f8-837e36d25ffd', 7, 1000000.00, NULL, NULL, '2021-04-25 19:28:14', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('14416bb9-29b0-496c-a2ea-b898f01b877e', '869d4176-a5e2-4d78-a529-3b3cfed85199', 3, 10000.00, NULL, NULL, '2021-04-29 01:40:05', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('154eefa4-ed5c-4a5b-9a14-edcb62b471c2', '7d47f6ff-5736-4f29-96af-a1a42a98226c', 4, 5000.00, NULL, NULL, '2021-04-29 01:47:11', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('27ffd5f0-6dcd-446d-842c-0b9b78a00a11', '5914d29f-0830-431d-ade7-99b3d9651640', 1, 25000.00, NULL, NULL, '2021-04-25 19:26:20', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('2dd9eec2-deba-4845-8f66-c3378569b3df', 'c1840669-ecbd-4cb6-acc5-16e539c32a6f', 3, 10000.00, NULL, NULL, '2021-04-28 23:37:19', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('321f6c67-3dab-4876-b3ce-aec7a7a89b75', 'a0255eaa-76c2-4995-97bd-c75112eb56bf', 3, 10000.00, NULL, NULL, '2021-04-28 22:30:37', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('322d33df-31b3-49bd-94d2-2c4bdebd0176', '6b3a7cf6-5ed3-4235-a65c-10c0ee253425', 2, 10000.00, NULL, NULL, '2021-04-25 19:26:45', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('336c0702-7c9b-4c60-a806-a7ffd09a5d47', 'c1840669-ecbd-4cb6-acc5-16e539c32a6f', 1, 25000.00, NULL, NULL, '2021-04-28 23:37:19', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('36c10faa-ead3-4395-a770-1927b941284e', '5554e987-d21b-42f5-bea7-11ffd468096e', 4, 5000.00, NULL, NULL, '2021-04-29 01:52:16', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('3822043d-4cf8-48e6-a996-e92f1ce9ed19', '9c9d07ac-8590-4f6e-81da-baf2738bbc0b', 8, 10000.00, NULL, NULL, '2021-04-25 19:28:03', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('3a83da06-4a24-4732-ac9e-1d884a7a4631', '6759cb58-6743-48ef-a192-9e08500043dc', 2, 10000.00, NULL, NULL, '2021-04-25 19:27:05', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('3cd11541-a976-4c0c-86bb-45f45cc95899', '23dde684-286b-41cc-9317-8a0170752260', 4, 5000.00, NULL, NULL, '2021-04-28 19:46:19', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('4ecca9f7-4850-47d9-97c5-79b94a6d7f3a', 'e71d1873-9b93-46af-9bc7-e94d3a7bda5e', 2, 10000.00, NULL, NULL, '2021-04-28 18:51:22', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('5307129e-e8fb-4487-a47c-62dbb673c199', 'fac332dc-2bb7-4ac7-ad0a-5b5c034658f9', 13, 400000.00, NULL, NULL, '2021-04-25 19:28:24', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('542b0e47-30fa-4bf6-9126-13308f6ea77e', 'e4593c7f-3bd4-4975-83b2-fcb54bf1811f', 2, 10000.00, NULL, NULL, '2021-04-28 22:31:39', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('545d043d-dda1-4b4d-afb4-3ac8f4e40463', '9aa7cf28-dead-4da0-86ce-24210764321f', 5, 50000.00, NULL, NULL, '2021-04-25 19:27:16', NULL, NULL, 4.00);
INSERT INTO `t_transaksi_det` VALUES ('5c916940-ce9e-4b09-868c-7a3d79eaf70b', 'a01cb30e-58a3-4992-90ba-1232981b9675', 2, 10000.00, NULL, NULL, '2021-04-28 20:21:39', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('5df03fef-efdb-49dd-bd94-8d790219f628', '210e6660-fffe-445e-9148-1da1a611d583', 3, 10000.00, NULL, NULL, '2021-04-28 19:45:29', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('65b276e4-4ade-480c-abf3-ac8cb06d2598', '757eebae-54bd-4814-aa68-a1ab4f449d24', 3, 10000.00, NULL, NULL, '2021-04-28 20:22:34', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('65fc6c1e-27a8-40ae-916f-af8290d881f3', '23dde684-286b-41cc-9317-8a0170752260', 2, 10000.00, NULL, NULL, '2021-04-28 19:46:19', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('6d5f7488-f83c-4360-9d0b-3bccd59b5345', 'd1aec4cf-0bfd-44ed-b717-f74ba8c3a99b', 2, 10000.00, NULL, NULL, '2021-04-28 22:40:14', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('6e143de7-fc10-4e31-9d28-9b0cd4323f39', '1b4b8163-26e8-488b-be50-036d989ab496', 5, 50000.00, NULL, NULL, '2021-04-25 19:27:43', NULL, NULL, 12.00);
INSERT INTO `t_transaksi_det` VALUES ('6f841f17-aefc-4e41-b864-ac7b5b005cbf', 'e026f701-839b-44bb-8bb3-e248e3323c50', 4, 5000.00, NULL, NULL, '2021-04-28 23:24:15', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('735eb5e1-db14-4d7a-a61d-888f0a758266', 'e026f701-839b-44bb-8bb3-e248e3323c50', 2, 10000.00, NULL, NULL, '2021-04-28 23:24:15', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('74521e11-fb7b-479d-9150-43dd81223992', '5554e987-d21b-42f5-bea7-11ffd468096e', 3, 10000.00, NULL, NULL, '2021-04-29 01:52:16', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('7b59d936-7103-47a8-891b-da7294d3f558', '1afd3dc2-0cdf-4d0d-ae50-6d8bae5d1a93', 2, 10000.00, NULL, NULL, '2021-04-28 19:52:38', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('7bb9a521-8be4-472d-91b8-3d7b8be17393', '815f4a64-7964-4d2a-be05-802faa2feeab', 3, 10000.00, NULL, NULL, '2021-04-28 22:40:36', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('7ca99c32-9d8d-40e5-92a2-98ec4598aeb8', '815f4a64-7964-4d2a-be05-802faa2feeab', 2, 10000.00, NULL, NULL, '2021-04-28 22:40:36', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('8525e879-ddfb-41bc-be99-376a1ce8b133', '17662ed2-ed6d-4ff9-a736-026875ac8262', 2, 10000.00, NULL, NULL, '2021-04-25 19:26:05', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('89823957-4633-42b6-bf18-e235ce83c5f9', '5554e987-d21b-42f5-bea7-11ffd468096e', 1, 25000.00, NULL, NULL, '2021-04-29 01:52:16', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('8bf3e9cb-7a3e-49ed-98dc-690cc9c39c83', 'e026f701-839b-44bb-8bb3-e248e3323c50', 3, 10000.00, NULL, NULL, '2021-04-28 23:24:15', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('94a261aa-c71b-4515-8574-7b0182f1a2b0', 'd1aec4cf-0bfd-44ed-b717-f74ba8c3a99b', 1, 25000.00, NULL, NULL, '2021-04-28 22:40:14', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('968d559a-4966-4e0a-9b78-ba63d96e78d2', '9a5335a0-4891-4c18-be78-dc10faa4885a', 12, 1000000.00, NULL, NULL, '2021-04-25 19:28:30', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('a0282535-6a11-4d95-9351-66dab94597cf', 'f24165fa-a179-471c-995a-594286591b28', 3, 10000.00, NULL, NULL, '2021-04-29 01:48:28', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('a19c6404-c7eb-4c7a-881a-9fea0af10cd6', '869d4176-a5e2-4d78-a529-3b3cfed85199', 4, 5000.00, NULL, NULL, '2021-04-29 01:40:05', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('a6735271-4a47-4d00-8e4a-38614f5f79d4', '0f04fba9-99d0-4414-8d9a-2f23efcc59f9', 6, 3000000.00, NULL, NULL, '2021-04-25 19:27:51', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('a677b226-1a8e-4d96-bf3b-48887a419587', '87031c13-de6c-4bb0-a74b-047ceb95225e', 3, 10000.00, NULL, NULL, '2021-04-28 20:01:53', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('b1d7382a-a7b7-4d06-a69f-16090f81f0c5', 'da54a5a6-87bb-4caf-8499-bc4e8b254bf7', 14, 100000.00, NULL, NULL, '2021-04-25 19:28:47', '2021-04-26 23:06:44', NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('b68baa27-3ad7-4b37-a552-2865dc4b4e86', 'a822dbfa-b2ed-4587-bb2e-f1c11c1b48a1', 1, 25000.00, NULL, NULL, '2021-04-28 23:32:32', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('b8701f5f-21ce-48d1-a609-4760da2812c9', 'f37e0a27-bebf-4495-9003-fd15976dc88b', 7, 10000000.00, NULL, NULL, '2021-04-26 23:08:37', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('c176481e-47c2-410a-8426-2ec5b0f91920', '7d47f6ff-5736-4f29-96af-a1a42a98226c', 3, 10000.00, NULL, NULL, '2021-04-29 01:47:11', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('c5950caa-8686-4054-b4c0-3cb4e768e580', 'a822dbfa-b2ed-4587-bb2e-f1c11c1b48a1', 3, 10000.00, NULL, NULL, '2021-04-28 23:32:32', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('c8065955-c505-4131-99e7-394ce0fdc1a2', '6b3a7cf6-5ed3-4235-a65c-10c0ee253425', 1, 25000.00, NULL, NULL, '2021-04-25 19:26:45', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('cb5dcbeb-b7cd-4f32-8b96-a5e3610997c2', 'f24165fa-a179-471c-995a-594286591b28', 4, 5000.00, NULL, NULL, '2021-04-29 01:48:28', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('ceb43937-b77a-44d9-a4ed-512c4aad78d1', 'e3e4f203-e1bd-4634-9bd1-6e21fa048b5c', 4, 5000.00, NULL, NULL, '2021-04-28 20:00:31', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('d0f8426e-e5c9-4d84-bfa7-f46be8556248', '5914d29f-0830-431d-ade7-99b3d9651640', 3, 10000.00, NULL, NULL, '2021-04-25 19:26:20', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('d7cbc496-b76f-481b-a492-008b6d80871f', '3e929f4b-f4f4-475c-9b73-95b6aefab0de', 15, 4499999744.00, NULL, NULL, '2021-04-26 23:32:45', NULL, '2021-04-26 23:33:19', 1.00);
INSERT INTO `t_transaksi_det` VALUES ('e2a411dc-d2b5-4938-8a96-56f72849603b', '19cd5933-8639-45cf-a81e-fd561dbc1768', 3, 10000.00, NULL, NULL, '2021-04-28 22:46:14', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('e2ac985e-9ef4-484a-ab33-723d28dac17e', '674b8453-213b-406c-85f5-7ea9b399a8a2', 2, 10000.00, NULL, NULL, '2021-04-28 23:29:50', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('e678332c-3934-4492-b75a-7edb2a5c8d21', '674b8453-213b-406c-85f5-7ea9b399a8a2', 3, 10000.00, NULL, NULL, '2021-04-28 23:29:50', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('ed9ef564-aade-41ab-be66-fc4ef7b8511d', '68846dae-7e55-4c8e-8a6a-ae3acb88aedc', 16, 20000.00, NULL, NULL, '2021-04-25 19:29:00', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('efd7cb8a-e7be-486a-b0cd-9365554a4f9c', '3fd5345d-7850-4958-a0fa-9b7151c8caec', 3, 10000.00, NULL, NULL, '2021-04-28 20:21:55', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('efdef95d-4a4c-46b5-a133-0350d792521e', '757eebae-54bd-4814-aa68-a1ab4f449d24', 1, 25000.00, NULL, NULL, '2021-04-28 20:22:34', NULL, NULL, 1.00);
INSERT INTO `t_transaksi_det` VALUES ('ff7670be-8268-45fe-a33c-8cdf74471bba', '19cd5933-8639-45cf-a81e-fd561dbc1768', 1, 25000.00, NULL, NULL, '2021-04-28 22:46:14', NULL, NULL, 1.00);

SET FOREIGN_KEY_CHECKS = 1;
