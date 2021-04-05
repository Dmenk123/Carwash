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

 Date: 05/04/2021 15:15:44
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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_jenis_trans`(`id_jenis_trans`) USING BTREE,
  CONSTRAINT `m_item_trans_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_item_trans
-- ----------------------------
INSERT INTO `m_item_trans` VALUES (1, 1, 'Cuci Mobil', 'Cuci Mobil', 25000.00, 25000.00, '2021-03-27 19:44:12', NULL, NULL);
INSERT INTO `m_item_trans` VALUES (2, 1, 'Cuci Motor', 'Cuci Motor', 10000.00, 10000.00, '2021-03-27 19:44:12', NULL, NULL);
INSERT INTO `m_item_trans` VALUES (3, 1, 'Poles Mobil', 'Poles Mobil', 10000.00, 10000.00, '2021-03-27 19:44:12', NULL, NULL);
INSERT INTO `m_item_trans` VALUES (4, 1, 'Poles Motor', 'Poles Motor', 5000.00, 5000.00, '2021-03-27 19:44:12', NULL, NULL);

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
  `counter_diskon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '(COUNTER TERKINI) WAJIB DIUPDATE ketika isi log counter diskon',
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
INSERT INTO `m_member` VALUES (1, 'M210328001', 'Masnur', 'Jalan Raya', 'masnur@masnur.com', '1212121', 'L', '1', NULL, NULL, '2021-03-28 14:17:23', NULL, NULL);
INSERT INTO `m_member` VALUES (2, 'M210328002', 'Runsam', 'Ayar Nalaj', 'masnur@masnur.com', '78w7q8w7', 'P', '9', NULL, NULL, '2021-03-28 14:17:23', NULL, NULL);

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
INSERT INTO `m_user` VALUES (1, 1, 'superadmin', 'SnIvSVV6c2UwdWhKS1ZKMDluUlp4dz09', 1, '2021-04-05 12:24:45', 'USR-00001', NULL, NULL, NULL, NULL, 'pemiliknya');
INSERT INTO `m_user` VALUES (2, 3, 'admin', 'Tzg1eTllUlU2a2xNQk5yYktIM1pwUT09', NULL, NULL, 'USR-00002', 'coba-1602775328.jpg', '2020-10-15 22:22:08', '2020-10-15 22:43:54', '2020-10-15 22:58:50', NULL);

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
INSERT INTO `t_log_aktivitas` VALUES ('028aacbf-3b01-4826-9393-58fb0d8709a3', 9, 1, 'CREATE', NULL, '{\"id\":\"15152e7e-7228-4395-9cd9-bb20a24a2304\",\"id_transaksi\":\"499896cd-0673-4e04-8f18-d51ff1f67c08\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 15:02:14\"}', '2021-04-05 15:02:14', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('34a32d93-9a4f-4086-994a-d068b4fdbd94', 9, 1, 'CREATE', NULL, '{\"id\":\"d1a8ac6f-56f6-49cd-bc95-6c582dfbbb54\",\"id_transaksi\":\"237920b2-34c4-4db1-af02-a9c7e649f1c2\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:58:55\"}', '2021-04-05 14:58:55', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4044a9d6-7c4a-4bb2-9252-cde72d4f556b', 9, 1, 'CREATE', NULL, '{\"id\":\"c725298d-4ed0-489e-8ae1-bad0642a6495\",\"id_transaksi\":\"9fedb741-3d7b-41bc-81ca-7bd9c616513c\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:50:49\"}', '2021-04-05 14:50:49', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('4cf914af-6798-4183-b723-b0aa517c437f', 9, 1, 'CREATE', NULL, '{\"id\":\"fae9cd1e-76e9-4560-a173-bd3a161e8eda\",\"id_transaksi\":\"c637e01f-c6a6-436d-a3e7-3a55ad955a10\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 15:01:32\"}', '2021-04-05 15:01:32', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('500573d4-b845-4b61-bb55-3454a3fc7e7c', 9, 1, 'CREATE', NULL, '{\"id\":\"3434853d-5c54-41e7-8606-316f10ec9529\",\"id_transaksi\":\"f0c711d5-11ad-4517-87fe-b7810ef0b644\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:57:56\"}', '2021-04-05 14:57:56', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('5db3a5c6-a509-4e3a-9ece-90c5414d1d35', 9, 1, 'CREATE', NULL, '{\"id\":\"31293a35-8198-4d88-a371-df50d69fc93e\",\"id_transaksi\":\"07ff5bb7-3be8-4608-af97-6cb3692c38e7\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:41:36\"}', '2021-04-05 14:41:36', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('80ef8a63-6c7e-499d-99a9-a453db0241d0', 9, 1, 'CREATE', NULL, '{\"id\":\"2378982a-9492-48be-b723-34da202bb8f5\",\"id_transaksi\":\"429a2d3d-0522-4125-9897-a073bc040b17\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:58:42\"}', '2021-04-05 14:58:42', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('84582c4e-c1c2-4d4c-b1f4-7ffa5eeefdef', 9, 1, 'CREATE', NULL, '{\"id\":\"8a2b655b-dca7-4c8a-a5d2-47f14f595865\",\"id_transaksi\":\"27cc88c6-00d7-4c7a-9bed-4bfe70119422\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:33:55\"}', '2021-04-05 14:33:55', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('884a4db0-2610-4fd4-972f-9875dc4110d7', 9, 1, 'CREATE', NULL, '{\"id\":\"cbd4c1a8-cdcf-4c03-8d3c-26eb423e0f98\",\"id_transaksi\":\"c83901bb-ddf0-408e-aa23-9d2c20da7f54\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 15:00:18\"}', '2021-04-05 15:00:18', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('a7aaf877-5376-4447-9911-8cf7f7ce1d5f', 9, 1, 'CREATE', NULL, '{\"id\":\"17148a88-0776-4873-8aa4-0f5f4ae03bc1\",\"id_transaksi\":\"7f5db307-8589-4b44-8751-6c9875015e79\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:56:02\"}', '2021-04-05 14:56:02', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('aad050fb-0cb8-4913-a64d-9636c13173ff', 9, 1, 'CREATE', NULL, '{\"id\":\"d4097960-2a64-407a-bc20-3126e4b6212b\",\"id_transaksi\":\"cd85c73e-95d4-4400-befa-d8c69c14bcb4\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:32:11\"}', '2021-04-05 14:32:11', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('bdeaf2de-f381-46cd-a177-0ddc447e4b7b', 9, 1, 'CREATE', NULL, '{\"id\":\"739a990d-0347-4bb9-bdc5-e781841ca283\",\"id_transaksi\":\"97aec982-657d-425f-ae1b-f1a09f2a6f45\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:41:14\"}', '2021-04-05 14:41:14', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('c422def3-c2ff-45d1-be5f-cbd949d0cde4', 9, 1, 'CREATE', NULL, '{\"id\":\"a1816093-cf6d-4f52-af4c-e79a7348bc90\",\"id_transaksi\":\"e971439a-3635-4fe1-8f7a-d8b29dd78a12\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:49:22\"}', '2021-04-05 14:49:22', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('c5fa039b-85fe-4210-8142-25550cd67da7', 9, 1, 'CREATE', NULL, '{\"id\":\"a9288d37-1531-482b-807a-d25a719c7f80\",\"id_transaksi\":\"669a1b1d-c6d6-421f-ba58-5cb3df0d6b48\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:52:45\"}', '2021-04-05 14:52:45', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('c9f28906-a31d-4df6-a31c-db863d3e7382', 9, 1, 'CREATE', NULL, '{\"id\":\"e7092f0a-84b5-4411-976f-0e91f3c8d39a\",\"id_transaksi\":\"abd5bdd6-3439-402b-8419-280e46028aff\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:59:59\"}', '2021-04-05 14:59:59', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('cdf29b40-c0ff-4b1f-8c81-27f10925868a', 9, 1, 'CREATE', NULL, '{\"id\":\"74d65439-2d19-4cd9-8ea8-e2cdb6afef47\",\"id_transaksi\":\"b27cb1e4-b102-40d1-bdd8-0260ac09531d\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 15:00:41\"}', '2021-04-05 15:00:41', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('cece46d3-d7b5-481c-96af-bdef9217d02d', 9, 1, 'CREATE', NULL, '{\"id\":\"a9cba207-c7ea-4632-a2c3-b46d14104c91\",\"id_transaksi\":\"0a7b90c4-7041-46a3-a217-35169a469c0b\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 15:00:02\"}', '2021-04-05 15:00:02', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('cf2c4691-6f54-4871-b89c-139402a59a18', 9, 1, 'CREATE', NULL, '{\"id\":\"d091eb05-2e44-4941-bef4-dc904f81df7a\",\"id_transaksi\":\"e642528d-c7a4-4143-9bd2-6a78e0b4cc8a\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:54:32\"}', '2021-04-05 14:54:32', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d71935a1-9ce0-4ec1-8ecb-201ab5f04ee8', 9, 1, 'CREATE', NULL, '{\"id\":\"c10c8806-6161-413f-b3a0-4db614cdcb29\",\"id_transaksi\":\"eefa4531-8609-4bda-8108-427dd147305a\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:56:45\"}', '2021-04-05 14:56:45', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('d7e5cb77-8c9e-447d-bb7d-8894619b6b9e', 9, 1, 'CREATE', NULL, '{\"id\":\"7e290dd1-49e4-4866-8e3b-c5f2fff7f9f9\",\"id_transaksi\":\"b0d3ffd4-1680-42ea-930b-93fd9386e9f6\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:42:26\"}', '2021-04-05 14:42:26', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('f0d09aff-2f72-45be-9c74-24765e644404', 9, 1, 'CREATE', NULL, '{\"id\":\"2ef089cf-6f26-4ba4-9c9b-65c17da6a74c\",\"id_transaksi\":\"5a87b2be-da51-4801-bc33-b23c342783cb\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:48:50\"}', '2021-04-05 14:48:50', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('f484f7c4-6739-4181-88da-41520617d87b', 9, 1, 'CREATE', NULL, '{\"id\":\"cc2c934e-857e-4783-8b0d-5ef6793f9c62\",\"id_transaksi\":\"a4b9aaf9-b7cc-4275-b5b2-702647a1044f\",\"id_item_trans\":\"3\",\"harga_satuan\":\"10000.00\",\"created_at\":\"2021-04-05 14:41:57\"}', '2021-04-05 14:41:57', NULL, NULL);
INSERT INTO `t_log_aktivitas` VALUES ('f7cdb2a7-1245-4160-96a2-37a8af1dc47c', 9, 1, 'CREATE', NULL, '{\"id\":\"85362bb2-c3c2-44b7-a3ce-d1318def4134\",\"id_transaksi\":\"1d683955-3ab1-4e12-a2a8-384737815fb6\",\"id_item_trans\":\"4\",\"harga_satuan\":\"5000.00\",\"created_at\":\"2021-04-05 14:33:12\"}', '2021-04-05 14:33:12', NULL, NULL);

-- ----------------------------
-- Table structure for t_log_counter_member
-- ----------------------------
DROP TABLE IF EXISTS `t_log_counter_member`;
CREATE TABLE `t_log_counter_member`  (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'wajib melakukan pengecekan count dengan kondisi deleted_at is null sebelum insert ke tabel ini, jika counter sudah 10 maka kolom deleted_at wajib di isi timestamp now',
  `id_member` int(14) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_member`(`id_member`) USING BTREE,
  CONSTRAINT `t_log_counter_member_ibfk_1` FOREIGN KEY (`id_member`) REFERENCES `m_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log_counter_member
-- ----------------------------

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_jenis_trans`(`id_jenis_trans`) USING BTREE,
  INDEX `id_member`(`id_member`) USING BTREE,
  CONSTRAINT `t_transaksi_ibfk_1` FOREIGN KEY (`id_jenis_trans`) REFERENCES `m_jenis_trans` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_transaksi_ibfk_2` FOREIGN KEY (`id_member`) REFERENCES `m_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_transaksi
-- ----------------------------
INSERT INTO `t_transaksi` VALUES ('07ff5bb7-3be8-4608-af97-6cb3692c38e7', 'INV-21040500005', 1, NULL, 20000.00, '1', '2021-04-05 14:41:36', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('0a7b90c4-7041-46a3-a217-35169a469c0b', 'INV-21040500019', 1, NULL, 20000.00, '1', '2021-04-05 15:00:02', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('1d683955-3ab1-4e12-a2a8-384737815fb6', 'INV-21040500002', 1, NULL, 40000.00, '1', '2021-04-05 14:33:12', NULL, NULL, 3101020.00, 3061020.00);
INSERT INTO `t_transaksi` VALUES ('237920b2-34c4-4db1-af02-a9c7e649f1c2', 'INV-21040500017', 1, NULL, 20000.00, '1', '2021-04-05 14:58:55', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('27cc88c6-00d7-4c7a-9bed-4bfe70119422', 'INV-21040500003', 1, NULL, 20000.00, '1', '2021-04-05 14:33:55', NULL, NULL, 20000.00, 0.00);
INSERT INTO `t_transaksi` VALUES ('429a2d3d-0522-4125-9897-a073bc040b17', 'INV-21040500016', 1, NULL, 20000.00, '1', '2021-04-05 14:58:42', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('499896cd-0673-4e04-8f18-d51ff1f67c08', 'INV-21040500023', 1, NULL, 20000.00, '1', '2021-04-05 15:02:14', NULL, NULL, 15000.00, -5000.00);
INSERT INTO `t_transaksi` VALUES ('5a87b2be-da51-4801-bc33-b23c342783cb', 'INV-21040500008', 1, NULL, 20000.00, '1', '2021-04-05 14:48:50', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('669a1b1d-c6d6-421f-ba58-5cb3df0d6b48', 'INV-21040500011', 1, NULL, 20000.00, '1', '2021-04-05 14:52:45', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('7f5db307-8589-4b44-8751-6c9875015e79', 'INV-21040500013', 1, NULL, 20000.00, '1', '2021-04-05 14:56:02', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('97aec982-657d-425f-ae1b-f1a09f2a6f45', 'INV-21040500004', 1, NULL, 20000.00, '1', '2021-04-05 14:41:14', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('9fedb741-3d7b-41bc-81ca-7bd9c616513c', 'INV-21040500010', 1, NULL, 20000.00, '1', '2021-04-05 14:50:49', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('a4b9aaf9-b7cc-4275-b5b2-702647a1044f', 'INV-21040500006', 1, NULL, 20000.00, '1', '2021-04-05 14:41:57', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('abd5bdd6-3439-402b-8419-280e46028aff', 'INV-21040500018', 1, NULL, 20000.00, '1', '2021-04-05 14:59:59', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('b0d3ffd4-1680-42ea-930b-93fd9386e9f6', 'INV-21040500007', 1, NULL, 20000.00, '1', '2021-04-05 14:42:26', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('b27cb1e4-b102-40d1-bdd8-0260ac09531d', 'INV-21040500021', 1, NULL, 20000.00, '1', '2021-04-05 15:00:41', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('c637e01f-c6a6-436d-a3e7-3a55ad955a10', 'INV-21040500022', 1, NULL, 20000.00, '1', '2021-04-05 15:01:32', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('c83901bb-ddf0-408e-aa23-9d2c20da7f54', 'INV-21040500020', 1, NULL, 20000.00, '1', '2021-04-05 15:00:18', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('cd85c73e-95d4-4400-befa-d8c69c14bcb4', 'INV-21040500001', 1, NULL, 20000.00, '1', '2021-04-05 14:32:11', NULL, NULL, 30000.00, 10000.00);
INSERT INTO `t_transaksi` VALUES ('e642528d-c7a4-4143-9bd2-6a78e0b4cc8a', 'INV-21040500012', 1, NULL, 20000.00, '1', '2021-04-05 14:54:32', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('e971439a-3635-4fe1-8f7a-d8b29dd78a12', 'INV-21040500009', 1, NULL, 20000.00, '1', '2021-04-05 14:49:22', NULL, NULL, 40000.00, 20000.00);
INSERT INTO `t_transaksi` VALUES ('eefa4531-8609-4bda-8108-427dd147305a', 'INV-21040500014', 1, NULL, 20000.00, '1', '2021-04-05 14:56:45', NULL, NULL, 100000.00, 80000.00);
INSERT INTO `t_transaksi` VALUES ('f0c711d5-11ad-4517-87fe-b7810ef0b644', 'INV-21040500015', 1, NULL, 20000.00, '1', '2021-04-05 14:57:56', NULL, NULL, 100000.00, 80000.00);

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
INSERT INTO `t_transaksi_det` VALUES ('068abaea-7422-4147-a1d5-497e7ad2d262', 'e642528d-c7a4-4143-9bd2-6a78e0b4cc8a', 2, 10000.00, NULL, NULL, '2021-04-05 14:54:32', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('091bd723-9611-4ae5-b9c0-96827fa75d7d', '1d683955-3ab1-4e12-a2a8-384737815fb6', 1, 25000.00, NULL, NULL, '2021-04-05 14:33:12', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('15152e7e-7228-4395-9cd9-bb20a24a2304', '499896cd-0673-4e04-8f18-d51ff1f67c08', 3, 10000.00, NULL, NULL, '2021-04-05 15:02:14', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('17148a88-0776-4873-8aa4-0f5f4ae03bc1', '7f5db307-8589-4b44-8751-6c9875015e79', 3, 10000.00, NULL, NULL, '2021-04-05 14:56:02', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('1d42110a-7a6f-4a89-891e-1da440f511f3', 'c637e01f-c6a6-436d-a3e7-3a55ad955a10', 2, 10000.00, NULL, NULL, '2021-04-05 15:01:32', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('21641340-f389-4985-85a2-7570c2a32fff', 'f0c711d5-11ad-4517-87fe-b7810ef0b644', 2, 10000.00, NULL, NULL, '2021-04-05 14:57:56', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('2378982a-9492-48be-b723-34da202bb8f5', '429a2d3d-0522-4125-9897-a073bc040b17', 3, 10000.00, NULL, NULL, '2021-04-05 14:58:42', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('2d1b5826-bef2-4c2d-94d8-10b736394e52', '27cc88c6-00d7-4c7a-9bed-4bfe70119422', 2, 10000.00, NULL, NULL, '2021-04-05 14:33:55', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('2ef089cf-6f26-4ba4-9c9b-65c17da6a74c', '5a87b2be-da51-4801-bc33-b23c342783cb', 3, 10000.00, NULL, NULL, '2021-04-05 14:48:50', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('31293a35-8198-4d88-a371-df50d69fc93e', '07ff5bb7-3be8-4608-af97-6cb3692c38e7', 3, 10000.00, NULL, NULL, '2021-04-05 14:41:36', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('3434853d-5c54-41e7-8606-316f10ec9529', 'f0c711d5-11ad-4517-87fe-b7810ef0b644', 3, 10000.00, NULL, NULL, '2021-04-05 14:57:56', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('45e557c1-0fd3-4eaa-9336-51cf9d4a876d', 'e971439a-3635-4fe1-8f7a-d8b29dd78a12', 2, 10000.00, NULL, NULL, '2021-04-05 14:49:22', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('4f2c2438-a124-4203-bf70-2bcdf58e8a46', '97aec982-657d-425f-ae1b-f1a09f2a6f45', 2, 10000.00, NULL, NULL, '2021-04-05 14:41:14', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('4f8603df-5d4b-4dd0-a1a0-682bf606017c', 'c83901bb-ddf0-408e-aa23-9d2c20da7f54', 2, 10000.00, NULL, NULL, '2021-04-05 15:00:18', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('5140f34d-c664-42ac-a5c7-003f63cab77b', 'abd5bdd6-3439-402b-8419-280e46028aff', 2, 10000.00, NULL, NULL, '2021-04-05 14:59:59', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('5269a137-bcf7-4aa1-b2cb-bbafc72a43f0', '1d683955-3ab1-4e12-a2a8-384737815fb6', 3, 10000.00, NULL, NULL, '2021-04-05 14:33:12', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('54d566c5-5f26-43b6-bf15-f9ba706ad315', 'cd85c73e-95d4-4400-befa-d8c69c14bcb4', 2, 10000.00, NULL, NULL, '2021-04-05 14:32:11', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('55d36985-ea65-46d4-8bfb-5f348d0d928a', '9fedb741-3d7b-41bc-81ca-7bd9c616513c', 2, 10000.00, NULL, NULL, '2021-04-05 14:50:49', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('576e0353-b632-4e9e-8fab-1d802ce995d7', 'b27cb1e4-b102-40d1-bdd8-0260ac09531d', 2, 10000.00, NULL, NULL, '2021-04-05 15:00:41', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('5a23202f-e3c8-4c02-ace4-8405e99779af', 'a4b9aaf9-b7cc-4275-b5b2-702647a1044f', 2, 10000.00, NULL, NULL, '2021-04-05 14:41:57', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('5f568250-0e88-4586-867f-c89c324079aa', '07ff5bb7-3be8-4608-af97-6cb3692c38e7', 2, 10000.00, NULL, NULL, '2021-04-05 14:41:36', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('739a990d-0347-4bb9-bdc5-e781841ca283', '97aec982-657d-425f-ae1b-f1a09f2a6f45', 3, 10000.00, NULL, NULL, '2021-04-05 14:41:14', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('73bafe1d-8241-4070-8f4d-fe7a130e65f3', '499896cd-0673-4e04-8f18-d51ff1f67c08', 2, 10000.00, NULL, NULL, '2021-04-05 15:02:14', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('74d65439-2d19-4cd9-8ea8-e2cdb6afef47', 'b27cb1e4-b102-40d1-bdd8-0260ac09531d', 3, 10000.00, NULL, NULL, '2021-04-05 15:00:41', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('7e290dd1-49e4-4866-8e3b-c5f2fff7f9f9', 'b0d3ffd4-1680-42ea-930b-93fd9386e9f6', 3, 10000.00, NULL, NULL, '2021-04-05 14:42:26', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('80bc22b9-8170-41ed-9cb2-20d09b1bea26', '7f5db307-8589-4b44-8751-6c9875015e79', 2, 10000.00, NULL, NULL, '2021-04-05 14:56:02', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('8496d4ce-e522-4daf-bcf6-2df0ea803030', 'b0d3ffd4-1680-42ea-930b-93fd9386e9f6', 2, 10000.00, NULL, NULL, '2021-04-05 14:42:26', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('85362bb2-c3c2-44b7-a3ce-d1318def4134', '1d683955-3ab1-4e12-a2a8-384737815fb6', 4, 5000.00, NULL, NULL, '2021-04-05 14:33:12', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('8a2b655b-dca7-4c8a-a5d2-47f14f595865', '27cc88c6-00d7-4c7a-9bed-4bfe70119422', 3, 10000.00, NULL, NULL, '2021-04-05 14:33:55', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('8b30696f-90bf-4133-93eb-8dcf72fe8793', '5a87b2be-da51-4801-bc33-b23c342783cb', 2, 10000.00, NULL, NULL, '2021-04-05 14:48:50', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('8ce04c21-ee26-4315-9373-378466545174', '669a1b1d-c6d6-421f-ba58-5cb3df0d6b48', 2, 10000.00, NULL, NULL, '2021-04-05 14:52:45', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('985b5880-a1ce-4b4c-b314-26d7571a6439', '237920b2-34c4-4db1-af02-a9c7e649f1c2', 2, 10000.00, NULL, NULL, '2021-04-05 14:58:55', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('a1816093-cf6d-4f52-af4c-e79a7348bc90', 'e971439a-3635-4fe1-8f7a-d8b29dd78a12', 3, 10000.00, NULL, NULL, '2021-04-05 14:49:22', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('a59ce6ea-1892-4d5e-85e1-b0a87310f908', '0a7b90c4-7041-46a3-a217-35169a469c0b', 2, 10000.00, NULL, NULL, '2021-04-05 15:00:02', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('a9288d37-1531-482b-807a-d25a719c7f80', '669a1b1d-c6d6-421f-ba58-5cb3df0d6b48', 3, 10000.00, NULL, NULL, '2021-04-05 14:52:45', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('a9cba207-c7ea-4632-a2c3-b46d14104c91', '0a7b90c4-7041-46a3-a217-35169a469c0b', 3, 10000.00, NULL, NULL, '2021-04-05 15:00:02', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('ad4d61fc-c6c0-444e-8989-6cb47f337329', '429a2d3d-0522-4125-9897-a073bc040b17', 2, 10000.00, NULL, NULL, '2021-04-05 14:58:42', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('c10c8806-6161-413f-b3a0-4db614cdcb29', 'eefa4531-8609-4bda-8108-427dd147305a', 3, 10000.00, NULL, NULL, '2021-04-05 14:56:45', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('c725298d-4ed0-489e-8ae1-bad0642a6495', '9fedb741-3d7b-41bc-81ca-7bd9c616513c', 3, 10000.00, NULL, NULL, '2021-04-05 14:50:49', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('cbd4c1a8-cdcf-4c03-8d3c-26eb423e0f98', 'c83901bb-ddf0-408e-aa23-9d2c20da7f54', 3, 10000.00, NULL, NULL, '2021-04-05 15:00:18', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('cc2c934e-857e-4783-8b0d-5ef6793f9c62', 'a4b9aaf9-b7cc-4275-b5b2-702647a1044f', 3, 10000.00, NULL, NULL, '2021-04-05 14:41:57', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('d091eb05-2e44-4941-bef4-dc904f81df7a', 'e642528d-c7a4-4143-9bd2-6a78e0b4cc8a', 3, 10000.00, NULL, NULL, '2021-04-05 14:54:32', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('d1a8ac6f-56f6-49cd-bc95-6c582dfbbb54', '237920b2-34c4-4db1-af02-a9c7e649f1c2', 3, 10000.00, NULL, NULL, '2021-04-05 14:58:55', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('d37ae50a-dadb-41cc-a68e-92b25ad1b745', 'eefa4531-8609-4bda-8108-427dd147305a', 2, 10000.00, NULL, NULL, '2021-04-05 14:56:45', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('d4097960-2a64-407a-bc20-3126e4b6212b', 'cd85c73e-95d4-4400-befa-d8c69c14bcb4', 3, 10000.00, NULL, NULL, '2021-04-05 14:32:11', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('e7092f0a-84b5-4411-976f-0e91f3c8d39a', 'abd5bdd6-3439-402b-8419-280e46028aff', 3, 10000.00, NULL, NULL, '2021-04-05 14:59:59', NULL, NULL);
INSERT INTO `t_transaksi_det` VALUES ('fae9cd1e-76e9-4560-a173-bd3a161e8eda', 'c637e01f-c6a6-436d-a3e7-3a55ad955a10', 3, 10000.00, NULL, NULL, '2021-04-05 15:01:32', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
