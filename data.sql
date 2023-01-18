-- Adminer 4.8.1 MySQL 8.0.27 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

USE `beauti-blog`;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Banners`;
CREATE TABLE `Banners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_520_ci,
  `sub_title` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button_text` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button_url` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `media_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` enum('image','cta') COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `media_name` (`media_name`),
  CONSTRAINT `Banners_ibfk_1` FOREIGN KEY (`media_name`) REFERENCES `Media` (`filename`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Banners` (`id`, `title`, `content`, `sub_title`, `button_text`, `button_url`, `media_name`, `type`, `createdAt`, `updatedAt`) VALUES
(2,	'Teoxane Anatomy Academy Thailand 2019',	'Lớp học chuyên sâu về Giải phẫu học vùng đầu mặt cổ - thực hành tiêm filler trên xác tươi, dành cho các chuyên gia của Teoxane tại Châu Á',	'Teoxane Brand',	'Tìm hiểu ngay',	'http://drdongphuong.com/about-me',	'IMG_2852-1636426457551.JPG',	'cta',	'2021-11-09 09:21:13',	'2021-11-15 14:46:43'),
(3,	'Filler Injection',	'Những sản phẩm làm đầy thế hệ mới nhất, an toàn và được FDA Hoa Kỳ chứng nhận ',	'teoxane Brand',	'',	'Tìm hiểu ngay',	'Teoxane - RHA Group with Syringes - Landscape-1636449742919.jpg',	'image',	'2021-11-09 09:23:19',	'2021-11-17 02:12:43');

DROP TABLE IF EXISTS `Blog_Category`;
CREATE TABLE `Blog_Category` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `BlogId` int NOT NULL,
  `CategoryId` int NOT NULL,
  PRIMARY KEY (`BlogId`,`CategoryId`),
  KEY `CategoryId` (`CategoryId`),
  CONSTRAINT `Blog_Category_ibfk_1` FOREIGN KEY (`BlogId`) REFERENCES `Blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Blog_Category_ibfk_2` FOREIGN KEY (`CategoryId`) REFERENCES `Categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Blog_Category` (`createdAt`, `updatedAt`, `BlogId`, `CategoryId`) VALUES
('2021-11-02 09:04:47',	'2021-11-02 09:04:47',	9,	1),
('2021-11-02 09:08:48',	'2021-11-02 09:08:48',	10,	1),
('2021-11-02 09:46:43',	'2021-11-02 09:46:43',	11,	1),
('2021-11-02 12:19:07',	'2021-11-02 12:19:07',	12,	1),
('2021-11-19 08:41:30',	'2021-11-19 08:41:30',	16,	7),
('2021-11-19 14:21:48',	'2021-11-19 14:21:48',	17,	7),
('2021-11-19 14:39:56',	'2021-11-19 14:39:56',	18,	7),
('2021-11-19 14:55:08',	'2021-11-19 14:55:08',	19,	7),
('2022-10-30 19:10:10',	'2022-10-30 19:10:10',	34,	1);

DROP TABLE IF EXISTS `Blog_Product`;
CREATE TABLE `Blog_Product` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `BlogId` int NOT NULL,
  `ProductId` int NOT NULL,
  PRIMARY KEY (`BlogId`,`ProductId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `Blog_Product_ibfk_1` FOREIGN KEY (`BlogId`) REFERENCES `Blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Blog_Product_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Blog_Product` (`createdAt`, `updatedAt`, `BlogId`, `ProductId`) VALUES
('2021-11-02 12:19:07',	'2021-11-02 12:19:07',	12,	1),
('2022-10-30 19:12:26',	'2022-10-30 19:12:26',	34,	3);

DROP TABLE IF EXISTS `Blog_Tag`;
CREATE TABLE `Blog_Tag` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `BlogId` int NOT NULL,
  `TagId` int NOT NULL,
  PRIMARY KEY (`BlogId`,`TagId`),
  KEY `TagId` (`TagId`),
  CONSTRAINT `Blog_Tag_ibfk_1` FOREIGN KEY (`BlogId`) REFERENCES `Blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Blog_Tag_ibfk_2` FOREIGN KEY (`TagId`) REFERENCES `Tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Blog_Tag` (`createdAt`, `updatedAt`, `BlogId`, `TagId`) VALUES
('2021-11-19 08:41:30',	'2021-11-19 08:41:30',	16,	2),
('2021-11-19 08:41:30',	'2021-11-19 08:41:30',	16,	15),
('2021-11-19 14:21:48',	'2021-11-19 14:21:48',	17,	2),
('2021-11-19 14:21:48',	'2021-11-19 14:21:48',	17,	15),
('2021-11-19 14:21:48',	'2021-11-19 14:21:48',	17,	16),
('2021-11-19 14:39:56',	'2021-11-19 14:39:56',	18,	2),
('2021-11-19 14:39:56',	'2021-11-19 14:39:56',	18,	4),
('2021-11-19 14:39:56',	'2021-11-19 14:39:56',	18,	15),
('2021-11-19 14:39:56',	'2021-11-19 14:39:56',	18,	16),
('2021-11-19 14:55:08',	'2021-11-19 14:55:08',	19,	2),
('2021-11-19 14:55:08',	'2021-11-19 14:55:08',	19,	3),
('2021-11-19 14:55:08',	'2021-11-19 14:55:08',	19,	4),
('2021-11-19 14:55:08',	'2021-11-19 14:55:08',	19,	15),
('2021-11-19 14:55:08',	'2021-11-19 14:55:08',	19,	16),
('2022-10-30 19:12:26',	'2022-10-30 19:12:26',	34,	2),
('2022-10-30 19:12:26',	'2022-10-30 19:12:26',	34,	4),
('2022-10-30 19:12:26',	'2022-10-30 19:12:26',	34,	15);

DROP TABLE IF EXISTS `Blogs`;
CREATE TABLE `Blogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` enum('edit','publish','draft','deleted') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'edit',
  `path` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `last_publish` datetime DEFAULT NULL,
  `feature_image` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `allow_comment` tinyint(1) DEFAULT '1',
  `stick_to_top` tinyint(1) DEFAULT '0',
  `view` int DEFAULT '0',
  `send_mail` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`),
  UNIQUE KEY `path_2` (`path`),
  KEY `feature_image` (`feature_image`),
  CONSTRAINT `Blogs_ibfk_1` FOREIGN KEY (`feature_image`) REFERENCES `Media` (`filename`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Blogs` (`id`, `title`, `status`, `path`, `content`, `visible`, `last_publish`, `feature_image`, `description`, `allow_comment`, `stick_to_top`, `view`, `send_mail`, `createdAt`, `updatedAt`) VALUES
(1,	'Hướng Dẫn Mua Hàng',	'draft',	'huong-dan-mua-hang',	'{\"time\":1635832264524,\"blocks\":[{\"id\":\"SDNhzMbgau\",\"type\":\"paragraph\",\"data\":{\"text\":\"Hướng dẫn mua hàng nè\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-02 05:51:04',	'2021-11-02 05:51:04'),
(2,	'Phương Thức Thanh Toán',	'draft',	'phuong-thuc-thanh-toan',	'{\"time\":1635832284699,\"blocks\":[{\"id\":\"VJgCEpjD9V\",\"type\":\"paragraph\",\"data\":{\"text\":\"phương thức thanh toán nè\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-02 05:51:25',	'2021-11-02 05:51:25'),
(3,	'Phương thức vận chuyển',	'draft',	'phuong-thuc-van-chuyen',	'{\"time\":1635832526933,\"blocks\":[{\"id\":\"AbT5yxMOcA\",\"type\":\"paragraph\",\"data\":{\"text\":\"phương thức vận chuyển nè\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-02 05:51:54',	'2021-11-02 05:55:27'),
(4,	'Chính Sách Đổi Trả',	'draft',	'chinh-sach-doi-traa',	'{\"time\":1635832335457,\"blocks\":[{\"id\":\"hHqHuRMtsO\",\"type\":\"paragraph\",\"data\":{\"text\":\"chính sách đổi trả nè\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-02 05:52:15',	'2021-11-02 05:52:15'),
(5,	'Điều Khoản Dịch Vụ',	'draft',	'dieu-khoan-dich-vu',	'{\"time\":1641564447398,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-02 05:52:35',	'2022-01-07 14:07:27'),
(6,	'Liên Hệ',	'draft',	'lien-he',	'{\"time\":1635832372169,\"blocks\":[{\"id\":\"eG44-1qht8\",\"type\":\"paragraph\",\"data\":{\"text\":\"Liên Hệ nè\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-02 05:52:52',	'2021-11-02 05:52:52'),
(7,	'Lớp học chuyên sâu về giải phẫu vùng mặt dành cho bác sĩ thẩm mỹ - Thailand 2018',	'deleted',	'hinh-anh',	'{\"time\":1637035424208,\"blocks\":[{\"id\":\"CldNLGbQ1l\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_2798-1636992577109.jpeg\",\"alt\":\"\"},\"caption\":\"IMG_2814-1636992577113.jpeg\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-02 05:55:45',	'2021-11-19 14:56:08'),
(8,	'Dịch Vụ',	'publish',	'dich-vu',	'{\"time\":1642553181659,\"blocks\":[{\"id\":\"tQWFtaS5Mn\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>*** NỘI KHOA THẨM MỸ</b>\",\"alignment\":\"left\"}},{\"id\":\"jzJoJUdjsS\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"TIÊM TRẺ HOÁ DA MẶT\",\"TIÊM TRẺ HOÁ DA CỔ\",\"TIÊM LÀM ĐẦY THÁI DƯƠNG\",\"TIÊM LÀM ĐẦY TRÁN\",\"TIÊM LÀM ĐẦY VÀ GIẢM THÂM VÙNG MẮT\",\"TIÊM LÀM ĐẦY RÃNH MŨI MÁ\",\"TIÊM TẠO HÌNH DÁI TAI PHONG THUỶ\",\"TIÊM TẠO HÌNH MÔI\",\"TIÊM LÀM ĐẦY CÁC RÃNH NHĂN VÙNG CỔ\",\"TIÊM LÀM ĐẦY BÀN TAY\",\"TIÊM TAO HÌNH MÔNG\",\"TIÊM BOTOX XOÁ NHĂN TRÁN&nbsp;\",\"TIÊM BOTOX XOÁ NHĂN GIAN CUNG MÀY\",\"TIÊM BOTOX XOÁ NHĂN ĐUÔI MẮT\",\"TIÊM ĐIỀU TRỊ CƯỜI HỞ LỢI\",\"TIÊM XOÁ NẾP NHĂN VÙNG CẰM\",\"TIÊM LIFTING MẶT\",\"TIÊM ĐIỀU TRỊ TUYẾN MỒ HÔI VÙNG NÁCH\",\"TIÊM ĐIỀU TRỊ MỒ HÔI BÀN TAY\",\"TIÊM ĐIỀU TRỊ NÁM MÁ\",\"TIÊM TẠO HÌNH VÙNG KÍN - LÀM ĐẦY MÔI LỚN\",\"TIÊM CẤP ẨM VÀ LÀM KHÍT ÂM ĐẠO\",\"CĂNG DA MẶT BẰNG CHỈ\",\"NÂNG CƠ BẰNG CÔNG NGHỆ ULTHERAPY\",\"TRẺ HOÁ DA, XOÁ NHĂN, THON GỌN MẶT BẰNG CÔNG NGHỆ THERMAGE\"]}},{\"id\":\"85wr2xMtUA\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>*** NGOẠI KHOA THẨM MỸ</b>\",\"alignment\":\"left\"}},{\"id\":\"jVMmrkjG7T\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"CẮT MẮT HAI MÍ\",\"NHẤN MẮT HAI MÍ\",\"CẮT DA THỪA MÍ TRÊN\",\"CẮT DA THỪA MÍ DƯỚI\",\"TREO CUNG MÀY\",\"TREO MÍ\",\"TẠO MÁ LÚM ĐỒNG TIỀN\"]}}],\"version\":\"2.22.2\"}',	0,	'2022-12-16 14:42:06',	'side-view-female-friends-applying-beauty-product-1636300912038.jpg',	'Filler, Botox và các công nghệ làm đẹp hot nhất hiện nay',	1,	0,	629,	0,	'2021-11-02 05:56:01',	'2022-12-16 14:42:06'),
(9,	'Bài viết mới',	'deleted',	'bai-viet-moi',	'{\"time\":1635843886531,\"blocks\":[{\"id\":\"Yo4Ev_pO24\",\"type\":\"paragraph\",\"data\":{\"text\":\"bài viết mới\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:23:00',	'1008-900x600-1635843826412.jpg',	'mô tả bài viết ở đây',	1,	1,	47,	1,	'2021-11-02 05:57:25',	'2021-11-02 15:06:00'),
(10,	'Bài viết ghim',	'deleted',	'bai-viet-ghim',	'{\"time\":1635844127378,\"blocks\":[{\"id\":\"dLZHdgnVTq\",\"type\":\"paragraph\",\"data\":{\"text\":\"bài viết ghim\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:29:33',	'175-900x600-1635843845669.jpg',	'mô tả bài viết ở đây',	1,	0,	28,	0,	'2021-11-02 09:08:47',	'2021-11-02 15:06:11'),
(11,	'Bài viết có hình ',	'deleted',	'bai-viet-co-hinh',	'{\"time\":1635846403299,\"blocks\":[{\"id\":\"3P3H-IP2rt\",\"type\":\"paragraph\",\"data\":{\"text\":\"bài viết có hình\",\"alignment\":\"left\"}},{\"id\":\"37UNlLZUdF\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/431-900x600-1635843819926.jpg\",\"alt\":\"\"},\"caption\":\"431-900x600-1635843819926.jpg\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:29:35',	'213-900x600-1635843816343.jpg',	NULL,	1,	0,	21,	0,	'2021-11-02 09:46:28',	'2021-11-02 15:06:08'),
(12,	'Bài viết',	'deleted',	'bai-viet',	'{\"time\":1635855546681,\"blocks\":[{\"id\":\"DQpokfbsBf\",\"type\":\"paragraph\",\"data\":{\"text\":\"novapo\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:29:36',	'431-900x600-1635843819926.jpg',	NULL,	1,	0,	8,	0,	'2021-11-02 12:19:07',	'2021-11-02 15:06:05'),
(13,	'fsef',	'deleted',	'fsef',	'{\"time\":1635947892862,\"blocks\":[{\"id\":\"y2zxHAOk2Z\",\"type\":\"paragraph\",\"data\":{\"text\":\"fsefesfsef\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-03 13:58:13',	'2021-11-04 07:04:19'),
(14,	'bai viet test',	'deleted',	'bai-viet-test',	'{\"time\":1636297888865,\"blocks\":[{\"id\":\"KWn0GOh1XD\",\"type\":\"paragraph\",\"data\":{\"text\":\"hello\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-09 15:47:55',	NULL,	NULL,	1,	0,	39,	1,	'2021-11-07 15:11:29',	'2021-11-16 04:08:11'),
(15,	'Hyaluronic Acid và những ứng dụng hiện nay',	'publish',	'hyaluronic-acid-va-nhung-ung-dung-hien-nay',	'{\"time\":1641564308872,\"blocks\":[{\"id\":\"5LFzM-tFKv\",\"type\":\"paragraph\",\"data\":{\"text\":\"Cụm từ Hyaluronic Acid chắc hẳn không quá xa lạ với chúng ta - đặc biệt là những tín đồ làm đẹp. Nó xuất hiện từ trong các sản phẩm mỹ phẩm dưỡng da cho đến những dịch vụ làm đẹp như tiêm Filler, lăn kim, phi kim vi điểm ... Vậy thì Hyaluronic Acid (HA) là gì và vì sao nó lại được ứng dụng nhiều như vậy, cùng Bác Sĩ Đông Phương tìm hiểu nhé!\",\"alignment\":\"left\"}},{\"id\":\"6zRtp2TyEk\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/How to Tell If Your Pricey Hyaluronic Acid Serum Is Actually Worth It-1636815750661.jpg\",\"alt\":\"\"},\"caption\":\"Hyaluronic Acid&nbsp;\",\"withBorder\":true,\"stretched\":false,\"withBackground\":false}},{\"id\":\"urf5VSzOgM\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Lịch sử về Hyaluronic Acid</b>\",\"alignment\":\"left\"}},{\"id\":\"s1iCUsrSsK\",\"type\":\"paragraph\",\"data\":{\"text\":\"Hyaluronic Acid là một chất được tìm thấy lần đầu tiên trong mắt của bò bởi nhà sinh học Karl Meyer và cộng sự vào năm 1934. Sau đó, các nhà khoa học đã nghiên cứu ra cấu trúc của HA bao gồm 2 chuỗi phân tử đường là D-glucuronic acid và D-N-Acetyl glucosamine. Ứng dụng đầu tiên của HA vào những năm 1950, thuộc chuyên ngành giải phẫu vùng mắt. Và sau đó thì được nghiên cứu, phát triển và ứng dụng rộng rãi vào các chuyên ngành khác, và gần trong những năm gần đây là chuyên ngành Da Liễu - Thẩm mỹ, phân nhánh Chống lão hoá.\",\"alignment\":\"left\"}},{\"id\":\"zlKTlu5s4d\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/Haworth_projection_of_hyaluronan-1641528792791.svg.png\",\"alt\":\"\"},\"caption\":\"cấu trúc Hyaluronic Acid\",\"withBorder\":false,\"stretched\":true,\"withBackground\":false}},{\"id\":\"ODEB2ZpdZG\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Ứng dụng của Hyaluronic Acid</b>\",\"alignment\":\"left\"}},{\"id\":\"tOlGMuEX3F\",\"type\":\"paragraph\",\"data\":{\"text\":\"Ngoài việc ứng dụng làm đẹp rầm rộ trong giai đoạn hiện nay, thì HA còn là một thành phần được ứng dụng điều trị rất tích cực trong nhiều lĩnh vực chăm sóc sức khoẻ khác như:\",\"alignment\":\"left\"}},{\"id\":\"4XxS_GYRw9\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Tái tạo dịch khớp\",\"Nước mắt nhân tạo, điều trị/ phẫu thuật vùng mắt\",\"Hỗ trợ điều trị làm lành vết thương nhanh chóng\",\"Ứng dụng trong các ngành tiết niệu, nghiên cứu ung thư, ...\"]}},{\"id\":\"bZO5phzVXw\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/Biomedical-applications-of-hyaluronic-acid-1641528797473.png\",\"alt\":\"\"},\"caption\":\"Các ứng dụng của HA&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"AR9j8UAddX\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Ứng dụng của HA trong Thẩm mỹ</b>\",\"alignment\":\"left\"}},{\"id\":\"4NpUhf4Vid\",\"type\":\"paragraph\",\"data\":{\"text\":\"HA hiện nay được xem như là một \\\" thần dược\\\", \\\"cứu cánh\\\" cho rất nhiều chị em phụ nữ. Không quá khó để có thể bắt gặp cụm từ HA trên các diễn đàn làm đẹp, các sản phẩm chăm sóc da, các sản phẩm điều trị. Bác sĩ Đông Phương xin tổng kết những ứng dụng mà HA mang lại cho làn da chúng ta trong các sản phẩm bôi và các sản phẩm tiêm điều trị.\",\"alignment\":\"left\"}},{\"id\":\"NHkgvziVBt\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Giữ nước gấp 1000 lần trọng lượng phân tử HA\",\"Làm căng, phẳng các nếp nhăn\",\"Tăng cường sức khoẻ làn da, giúp giảm các dấu hiệu lão hoá như lỗ chân lông to, nếp nhăn li ti\",\"Kết hợp với các acid amin giúp thúc đẩy lại quá trình tái tạo ma trận collagen-elastin-HA\",\"Giúp da sáng, bóng và căng mịn&nbsp;\",\"Tăng độ đàn hồi cho da\",\"Cải thiện sự săn chắc cho da\",\"Củng cố hàng rào bảo vệ của da trước sự tấn công của các tác nhân gây lão hoá như nắng, gió, ...\"]}},{\"id\":\"CA5Stbt7pv\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Các cách cung cấp HA cho da</b>\",\"alignment\":\"left\"}},{\"id\":\"G2UHgrClXt\",\"type\":\"paragraph\",\"data\":{\"text\":\"&nbsp;Để da có thể đầy đủ HA, việc bôi các sản phẩm có chứa thành phần HA cũng chưa đủ khi làn da bước sang tuổi 25. Khi đó, việc cung cấp HA sẽ nên thực hiện với các phương pháp như Tiêm vi điểm hoặc Lăn kim vi điểm để đưa HA vào bên trong da, giúp da củng cố lại cấu trúc da, đồng thời tái tạo lại ma trận Collagen - elastin - HA, từ đó giúp da chống lại lão hoá, chống lại các nếp nhăn, và các vấn đề do lão hoá gây ra.\",\"alignment\":\"left\"}},{\"id\":\"V6zHQzgy6V\",\"type\":\"paragraph\",\"data\":{\"text\":\"Mong rằng bài viết trên giúp các bạn có cái nhìn tổng quát nhất về Hyaluronic Acid và các ứng dụng, cũng như hiệu quả mà HA mang lại cho sức khoẻ và sắc đẹp của mình.\",\"alignment\":\"left\"}},{\"id\":\"_RQiimsnEs\",\"type\":\"paragraph\",\"data\":{\"text\":\"Bs. Nguyễn Ngọc Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-16 14:42:06',	NULL,	NULL,	1,	0,	554,	0,	'2021-11-13 15:03:00',	'2022-12-16 14:42:06'),
(16,	'Khoá học chuyên sâu về giải phẫu học dành cho bác sĩ tại Thailand - 2018',	'publish',	'khoa-hoc-chuyen-sau-ve-giai-phau-hoc-danh-cho-bac-si-tai-thailand-2018',	'{\"time\":1637418609853,\"blocks\":[{\"id\":\"QOS_8PYwZO\",\"type\":\"paragraph\",\"data\":{\"text\":\"Là một trong những bác sĩ trẻ được tham dự khoá học Tiêm filler trên xác tươi với sự hướng dẫn của chuyên gia giải phẫu học hàng đầu tại Pháp - Dr. Matt Stefanelli. Bác sĩ Đông Phương đã có dịp tiếp xúc, trao đổi chuyên môn và học tập kinh nghiệm điều trị từ các đồng nghiệp đến từ Nhật Bản, Indonesia trong lớp học iClass được tổ chức tại Thailand. Một trong những chuyến đi đầy trải nghiệm tuyệt vời cùng bạn bè quốc tế.\",\"alignment\":\"left\"}},{\"id\":\"eLK2xNKj9W\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_2798-1636992577109.jpeg\",\"alt\":\"\"},\"caption\":\"Bác sĩ Đông Phương chụp ảnh tại lễ bế giảng lớp học cùng các chuyên gia.\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"ewko5cDJs_\",\"type\":\"paragraph\",\"data\":{\"text\":\"Với sự giảng dạy từ các chuyên gia như Dr. Rungsima Wanitphakdeedecha, Dr. Matt, sự thấu hiểu về giải phẫu vùng mặt một cách chi tiết, đã giúp ích cho việc phát triển về kĩ năng Tạo hình về Filler cũng như thiết kế gương mặt một cách hiệu quả và tinh tế nhất.\",\"alignment\":\"left\"}},{\"id\":\"vbm0kcnXtO\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_2814-1636992577113.jpeg\",\"alt\":\"\"},\"caption\":\"Nhận bằng tốt nghiệp sau khi hoàn thành khoá học.\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"T8Ytzq4b-m\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_9195-1637394745533.jpeg\",\"alt\":\"\"},\"caption\":\"Các bác sĩ đến từ Nhật, Indonesia, Malaysia, Singapore, Philippine, Thailand\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"X0jXWRV0D7\",\"type\":\"paragraph\",\"data\":{\"text\":\"Thailand 26/05/2018\",\"alignment\":\"left\"}},{\"id\":\"v3pceuVePz\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-16 14:42:07',	'IMG_2798-1636992577109.jpeg',	NULL,	1,	0,	626,	0,	'2021-11-19 08:33:05',	'2022-12-16 14:42:07'),
(17,	'Lớp phẫu tích trên xác tươi tại Philippine 3/2018',	'publish',	'lop-phau-tich-tren-xac-tuoi-tai-philippine-3-2018',	'{\"time\":1637331708508,\"blocks\":[{\"id\":\"PsodDEFf8d\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tháng 3 năm 2018, Bs Đông Phương tham dự lớp học chuyên sâu về giải phẫu học vùng mặt tại Philippine với sự hướng dẫn của Chuyên gia giải phẫu học Sebastian Cotofana. Bên cạnh đó, với sự dẫn dắt và hướng dẫn về việc tiêm filler đúng vị trí, tránh được các vùng nguy hiểm trên gương mặt, Bác sĩ Đông Phương đã cập nhật được rất nhiều kiến thức để thực hiện các thủ thuật làm đẹp An Toàn và Hiệu Quả.\",\"alignment\":\"left\"}},{\"id\":\"s10YnxXBNo\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1525-1636992361819.jpg\",\"alt\":\"\"},\"caption\":\"Lớp giải phẫu học cùng chuyên gia giải phẫu học Dr. Sebastian Cotofana\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"QwVPREdJHh\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1607-1636992370165.jpg\",\"alt\":\"\"},\"caption\":\"Khung cảnh lớp học&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"uUKj81ea0N\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1605-1636992370160.jpg\",\"alt\":\"\"},\"caption\":\"Bác sĩ giải phẫu học - Bác sĩ Sebastian Cotofana&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"87XC8QFvaa\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1632-1636992361818.jpg\",\"alt\":\"\"},\"caption\":\"Cùng các Bác sĩ đầu ngành về Filler tại Philippine\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"9El2Hn2Gx2\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1532-1636992361827.jpg\",\"alt\":\"\"},\"caption\":\"Khung cảnh lớp trước khi diễn ra khoá học\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"9YO25v9GCs\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1647-1636992370183.jpg\",\"alt\":\"\"},\"caption\":\"Nhận chứng chỉ sau khi hoàn thành xong lớp học giải phẫu trên xác tươi&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"QiWVrX7FLP\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_2465-1636992395530.jpg\",\"alt\":\"\"},\"caption\":\"Hội nghị da liễu và phẫu thuật tại Philippine 2018\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"67141yJlrQ\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1654-1636992395520.jpg\",\"alt\":\"\"},\"caption\":\"Trường học ở bên ngoài&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"_iJIfcZmVr\",\"type\":\"paragraph\",\"data\":{\"text\":\"Philippine, 1/3/2018\",\"alignment\":\"left\"}},{\"id\":\"q-clLPTzkX\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-16 14:42:07',	'IMG_1632-1636992361818.jpg',	NULL,	1,	0,	617,	0,	'2021-11-19 14:21:48',	'2022-12-16 14:42:07'),
(18,	'Hội nghị Teoxane Expert Day 2016 - Malaysia',	'publish',	'hoi-nghi-teoxane-expert-day-2016-malaysia',	'{\"time\":1637332798701,\"blocks\":[{\"id\":\"ttIjnaynX3\",\"type\":\"paragraph\",\"data\":{\"text\":\"Vinh dự là một trong những bác sĩ trẻ nhất đoàn được tham dự một hội nghị tầm cỡ Quốc tế về Filler do hãng Teoxane - Một thương hiệu hàng đầu hiện nay về Filler tổ chức tại Malaysia. Không chỉ hoành tráng về mặt tổ chức, Teoxane Expert Day (TED) đã mang lại rất nhiều kiến thức chuyên sâu, bổ ích và đầy tính nghệ thuật trong từng bài giảng của các chuyên gia đến từ Pháp, Vương Quốc Anh, HongKong, Malaysia, Dubai...&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"WoJz98rq2H\",\"type\":\"paragraph\",\"data\":{\"text\":\"Được học và trải nghiệm dòng sản phẩm Filler&nbsp;cao cấp đến từ Thuỵ Sĩ - Teoxane - ngay khi vừa ra trường là một trong những bước ngoặt lớn nhất và đáng nhớ nhất của Bs. Đông Phương.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"9EWyYrfqLr\",\"type\":\"paragraph\",\"data\":{\"text\":\"Cùng nhìn lại một số hình ảnh trong chuyến đi này với Bs. Phương nhé.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"KdCjUlpGia\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_075701-1636992261244.jpg\",\"alt\":\"\"},\"caption\":\"Check in tại sảnh tiếp đón\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"suNXAyKRZL\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_065013-1636992261239.jpg\",\"alt\":\"\"},\"caption\":\"Kỉ niệm cùng Dr. Kieren Bong - Chuyên gia hàng đầu đến từ Anh Quốc\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"UlCzPZjVow\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_134015-1636992284931.jpg\",\"alt\":\"\"},\"caption\":\"Cùng Dr. Kieren Bong và Bs Thuý Anh&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"cBA0_8y9ve\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_224253-1636992284948.jpg\",\"alt\":\"\"},\"caption\":\"Cùng với Dr. Hassan Galadari - Chuyên gia đến từ Dubai, và đại diện công ty Teoxane, công ty Grassroots\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"NFz9kI2z7v\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_081512-1636992261235.jpg\",\"alt\":\"\"},\"caption\":\"Trải nghiệm bút tiêm tự động - tiêm không đau và làm cho vùng tiêm đẹp hơn và mềm mại hơn\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"NDEQXygtbk\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_081448-1636992261231.jpg\",\"alt\":\"\"},\"caption\":\"Trải nghiệm bút tiêm trên mô hình\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"CJ2c32Nlgz\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160606_132622-1636992284943.jpg\",\"alt\":\"\"},\"caption\":\"Thẻ đeo tham dự hội nghị TED 2016\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"2kpfaBVzbS\",\"type\":\"paragraph\",\"data\":{\"text\":\"Malaysia, 5/2016\",\"alignment\":\"left\"}},{\"id\":\"FXqKh9XtRI\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-16 14:42:07',	'20160604_065018-1636992261225.jpg',	NULL,	1,	0,	603,	0,	'2021-11-19 14:39:56',	'2022-12-16 14:42:07'),
(19,	'Hướng dẫn tiêm Filler - Bệnh viện Phong Da liễu Trung ương Quy Hoà ',	'publish',	'huong-dan-tiem-filler-benh-vien-phong-da-lieu-trung-uong-quy-hoa',	'{\"time\":1637333707819,\"blocks\":[{\"id\":\"y5ZcdKwxkW\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tháng 6/2019, Bs Đông Phương có dịp đến Bệnh viện Phong - Da Liễu Trung Ương Quy Hoà, Quy Nhơn, Bình Định để chia sẻ về phương pháp tiếp cận bệnh nhân và các phương pháp tiêm Filler hiện nay cho các chỉ định như: Tiêm Filler vùng Rãnh lệ điều trị Trũng mắt và Thâm Quầng Mắt, Tiêm Filler rãnh mũi má, ... và Tiêm Botox xoá nhăn - với sự đồng hàng của nhãn hàng Teoxane và Beautem.Bs. Phương rất vui vì có sự tham dự của Giám đốc bệnh viện, trưởng khoa phẫu thuật da và được trả lời những câu hỏi về chuyên môn đến từ các bác sĩ tham dự.&nbsp;Cùng xem những khoảnh khắc đáng nhớ này với Bs. Đông Phương nhé. &lt;3&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"Nba2xNONlm\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1644-1636992634390.JPG\",\"alt\":\"\"},\"caption\":\"Tiêm Botulinum Toxin Type A ( Beautem - Daewoong)&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"or7BNMfZ5D\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1619-1636992624185.JPG\",\"alt\":\"\"},\"caption\":\"\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"An9OwW1iml\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1622-1636992624192.JPG\",\"alt\":\"\"},\"caption\":\"Demo cách tiêm cho các bác sĩ xem\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"MphKNjUkSk\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1623-1636992624197.JPG\",\"alt\":\"\"},\"caption\":\"Tiêm Filler vùng rãnh lệ - giúp làm giảm thâm quầng mắt và giảm trũng mắt\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"23S-DB1E3t\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1621-1636992624181.JPG\",\"alt\":\"\"},\"caption\":\"Tiêm Filler Teoxane cho vùng mắt\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"11NwjBAudN\",\"type\":\"paragraph\",\"data\":{\"text\":\"Quy Nhơn, Bình Định 6/2019\",\"alignment\":\"left\"}},{\"id\":\"QXoUsXlAez\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-17 03:54:15',	'IMG_1644-1636992634390.JPG',	NULL,	1,	0,	607,	0,	'2021-11-19 14:55:07',	'2022-12-17 03:54:15'),
(20,	'Chống nắng và những điều cần lưu ý',	'draft',	'chong-nang-va-nhung-ieu-can-luu-y',	'{\"time\":1637418628158,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	'IMG_2798-1636992577109.jpeg',	NULL,	1,	0,	0,	0,	'2021-11-20 14:30:28',	'2021-11-20 14:30:28'),
(21,	'Chống nắng nội sinh và những thông tin cần lưu ý',	'draft',	'chong-nang-noi-sinh-va-nhung-thong-tin-can-luu-y',	'{\"time\":1637419560409,\"blocks\":[{\"id\":\"y_37MVuRcZ\",\"type\":\"paragraph\",\"data\":{\"text\":\"Chống nắng - là một điều chắc hẳn tất cả mọi người, đặc biệt là những tín đồ Skincare đã không còn quá xa lạ và gần như là một bước rất quan trọng - không thể quên trong chu trình chăm sóc da mỗi ngày.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"tOvT527a0E\",\"type\":\"paragraph\",\"data\":{\"text\":\"Việc thoa chống nắng theo hướng dẫn của bác sĩ, các chuyên gia da liễu bao gồm: thoa chống nắng ngày 2 - 3 lần, &nbsp;trước khi ra nắng 15 - 30 phút, che chắn với Khẩu trang, Nón, Ô ... là điều mà ai cũng đã biết. Nhưng liệu với tất cả những điều đó đã có đủ khả năng bảo vệ làn da trước sự tấn công của các tác nhân gây lão hoá da như Nắng, Không khí ô nhiễm, Nước bẩn, và Stress ?!!!\",\"alignment\":\"left\"}},{\"id\":\"MEoj_mmwub\",\"type\":\"paragraph\",\"data\":{\"text\":\"Câu trả lời là KHÔNG ĐỦ!!\",\"alignment\":\"left\"}},{\"id\":\"qErsuBtPMO\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dưỡng da và thoa chống nắng chỉ có tác dụng trên bề mặt da tại vùng được thoa, và rất dễ bị mất tác dụng nhanh chóng khi hoạt động ngoài trời, nhất là với cái nắng của Việt Nam hiện nay, khiến cho việc bảo vệ da trở nên khó khăn hơn. Tuy nhiên, cách đây khoảng&nbsp;\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	'IMG_2798-1636992577109.jpeg',	NULL,	1,	0,	0,	0,	'2021-11-20 14:46:00',	'2021-11-20 14:46:00'),
(22,	'a',	'deleted',	'a',	'{\"time\":1639066021152,\"blocks\":[{\"id\":\"FwCAeIH_pJ\",\"type\":\"paragraph\",\"data\":{\"text\":\"A\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	'side-view-female-friends-applying-beauty-product-1636300912038.jpg',	NULL,	1,	0,	0,	0,	'2021-12-09 16:07:02',	'2021-12-09 16:07:39'),
(23,	'test',	'deleted',	'test',	'{\"time\":1639123072866,\"blocks\":[{\"id\":\"xAyGZFB4ae\",\"type\":\"paragraph\",\"data\":{\"text\":\"kakaka\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	'IMG_1644-1636992634390.JPG',	NULL,	1,	0,	0,	0,	'2021-12-10 07:57:53',	'2021-12-10 07:58:02'),
(24,	'CÁCH CHĂM SÓC BÀN TAY - CHỐNG LẠI DẤU HIỆU LÃO HOÁ',	'draft',	'cach-cham-soc-ban-tay-chong-lai-dau-hieu-lao-hoa',	'{\"time\":1641564508536,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:08:28',	'2022-01-07 14:08:28'),
(25,	'TRẺ HOÁ VÙNG KÍN - VẤN ĐỀ NHẠY CẢM NHƯNG VÔ CÙNG QUAN TRỌNG',	'draft',	'tre-hoa-vung-kin-van-e-nhay-cam-nhung-vo-cung-quan-trong',	'{\"time\":1641564545029,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:09:05',	'2022-01-07 14:09:05'),
(26,	'CÁC LOẠI NƯỚC DETOX CHO LÀN DA KHOẺ ĐẸP',	'draft',	'cac-loai-nuoc-detox-cho-lan-da-khoe-ep',	'{\"time\":1641564567409,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:09:27',	'2022-01-07 14:09:27'),
(27,	'10 CÁCH ĐỂ GIÚP CHO CUỘC SỐNG CÂN BẰNG',	'draft',	'10-cach-e-giup-cho-cuoc-song-can-bang',	'{\"time\":1641564626096,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	'Giữ cho thân tâm luôn an lạc, bạn đã thử những cách này chưa?',	1,	0,	0,	0,	'2022-01-07 14:10:26',	'2022-01-18 16:30:27'),
(28,	'LÀM ĐẸP VỚI CHANH - BẠN ĐÃ BIẾT CHƯA?',	'draft',	'lam-ep-voi-chanh-ban-a-biet-chua',	'{\"time\":1641564652034,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	'Chanh không chỉ để vắt nước uống, mà còn vô số công dụng xịn xò cần bạn tìm hiểu và áp dụng ngay đấy. Cùng Bs. Đông Phương tìm hiểu nhé!',	1,	0,	0,	0,	'2022-01-07 14:10:52',	'2022-01-18 16:31:32'),
(29,	'CHẤT LÀM ĐẦY ( FILLER) VÀ ỨNG DỤNG ',	'draft',	'chat-lam-ay-filler-va-ung-dung',	'{\"time\":1641564842785,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	'Giải oan cho Filler, những thông tin cực kì bổ ích và khoa học đang đợi bạn khám phá. Tìm hiểu cùng Bs. Đông Phương nhé.',	1,	0,	0,	0,	'2022-01-07 14:14:02',	'2022-01-18 16:32:54'),
(30,	'BOTOX ( BOTULINUM TOXIN) VÀ NHỮNG ỨNG DỤNG TRONG ĐIỀU TRỊ',	'draft',	'botox-botulinum-toxin-va-nhung-ung-dung-trong-ieu-tri',	'{\"time\":1641564884651,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:14:44',	'2022-01-07 14:14:44'),
(31,	'LÃO HOÁ VÙNG MẮT - ĐỪNG ĐỂ ĐÔI MẮT TỐ CÁO TUỔI CỦA BẠN',	'draft',	'lao-hoa-vung-mat-ung-e-oi-mat-to-cao-tuoi-cua-ban',	'{\"time\":1641565012423,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:16:52',	'2022-01-07 14:16:52'),
(32,	'ĐÔI ĐIỀU VỀ VIỆC CHỐNG LÃO HOÁ',	'publish',	'oi-ieu-ve-viec-chong-lao-hoa',	'{\"time\":1642523313673,\"blocks\":[{\"id\":\"6zEKF6sKgV\",\"type\":\"paragraph\",\"data\":{\"text\":\"CHỐNG LÃO HOÁ - cụm từ nghe rất đổi quen thuộc nhưng phần lớn chúng ta đều CHẬM TRỄ trong việc đối mặt với nó và xử lý nó.\",\"alignment\":\"left\"}},{\"id\":\"sVzkBQE0u2\",\"type\":\"paragraph\",\"data\":{\"text\":\"Khi một em bé được sinh ra, ngay từ lúc mới ra đời, cơ thể em bé đã bắt đầu kích hoạt tiến trình lão hoá tự nhiên của chính nó. Mỗi ngày qua đi, em bé lớn lên, các tế bào bên trong cơ thể phát triển và cơ thể luôn có chu trình: TÁI TẠO - THOÁI TRIỂN, và quy luật đó là điều KHÔNG THỂ TRÁNH KHỎI.\",\"alignment\":\"left\"}},{\"id\":\"QfCxpe-e_8\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/anti_ageing-870x450-1642522866484.jpg\",\"alt\":\"\"},\"caption\":\"\",\"withBorder\":true,\"stretched\":false,\"withBackground\":false}},{\"id\":\"jsi5ffW0L8\",\"type\":\"paragraph\",\"data\":{\"text\":\"Vậy, thời điểm nào chúng ta lại cần phải CHỐNG LÃO HOÁ?!\",\"alignment\":\"left\"}},{\"id\":\"WSmQbpjOBO\",\"type\":\"paragraph\",\"data\":{\"text\":\"Khi còn trẻ, tốc độ tái tạo của tế bào sẽ nhanh hơn tốc độ thoái triển, nhưng khi càng lớn tuổi, chu trình đó lại ngược lại. Cột mốc nhận thấy dấu hiệu LÃO HOÁ xuất hiện dễ dàng nhận ra nhất, đối với một người không có ý thức chăm sóc sức khoẻ, sắc đẹp sẽ rơi vào tầm tuổi 24 - 26 tuổi, và trãi dài các năm về sau đó thì tốc độ lão hoá ngày càng nhanh hơn và biểu hiện ngày một mạnh hơn.\",\"alignment\":\"left\"}},{\"id\":\"iI9S3-LhKB\",\"type\":\"paragraph\",\"data\":{\"text\":\"Từ đó, dễ dàng nhận thấy, việc chống lão hoá nên bắt đầu từ độ tuổi 18, và việc ngăn chặn các yếu tố tác động đến chu trình lão hoá nên diễn ra sớm hơn.\",\"alignment\":\"left\"}},{\"id\":\"21Ih4d-w5X\",\"type\":\"paragraph\",\"data\":{\"text\":\"Việc chống lão hoá nên bắt đầu từ những việc đơn giản nhất và ở độ tuổi nhỏ nhất bao gồm:\",\"alignment\":\"left\"}},{\"id\":\"XMIv64wLmT\",\"type\":\"list\",\"data\":{\"style\":\"unordered\",\"items\":[\"Dùng thực phẩm tươi tốt, ăn nhiều rau xanh, trái cây; dùng nhiều cá hơn thịt, dùng thịt trắng tốt hơn thịt đỏ.\",\"Uống đúng và đủ nước.\",\"Ngủ đủ giấc, và nên tập thói quen ngủ sớm để cơ thể được tái tạo.\",\"Chăm sóc da đúng cách: rửa mặt đúng cách, dùng kem dưỡng đúng loại cho làn da, tẩy tế bào chết đúng chu kì của da, tẩy trang đúng cách...\",\"Sử dụng kem chống nắng thường xuyên: có các loại kem chống nắng chuyên dụng dành cho trẻ em, người lớn với nhiều loại da khác nhau, và dành cho nhiều dịp khác nhau như: đi biển, chống nắng hàng ngày...; che chắn bằng mũ nón, ô dù, ..\"]}},{\"id\":\"OGk3RbulLD\",\"type\":\"paragraph\",\"data\":{\"text\":\"Khi bắt đầu bước sang tuổi 18, chống lão hoá không còn đơn thuần chỉ cần các bước cơ bản trên, sẽ nên bắt đầu kết hợp thêm vào những sản phẩm có chứa thành phần chống lão hoá nhẹ nhàng. Sau 25 tuổi, nên bắt đầu dùng các sản phẩm có chứa thành phần chuyên sâu cho việc chống lão hoá như Hyaluronic Acid, Niacinamine, Vitamin C, Co-enzyme Q10 ... và nếu da bắt đầu xuất hiện các dấu hiệu lão hoá nhiều, khi đó cần phải can thiệp bằng các liệu trình chống lão hoá.\",\"alignment\":\"left\"}},{\"id\":\"6x7F54aQLX\",\"type\":\"paragraph\",\"data\":{\"text\":\"Hiện nay, trên thị trường có rất nhiều những liệu trình chống lão hoá khác nhau. Tuỳ vào mỗi vấn đề của da, sẽ có những cách thực hiện và điều trị khác nhau, vì vậy, các bạn nên tham khảo ý kiến của bác sĩ, cũng như có sự hướng dẫn, theo dõi da nghiêm ngặt để có thể ngăn chặn được quá trình lão hoá tốt nhất.\",\"alignment\":\"left\"}},{\"id\":\"HbQpOXcfnI\",\"type\":\"paragraph\",\"data\":{\"text\":\"Một số các phương pháp điều trị chống lão hoá như:\",\"alignment\":\"left\"}},{\"id\":\"wtmJJHH7Iu\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tiêm tái tạo da bằng Hyaluronic Acid, PRP\",\"alignment\":\"center\"}},{\"id\":\"GAzw1dXnja\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tiêm Botox xoá các nếp nhăn ở các vùng: Cau mày, đuôi mắt, Trán ..\",\"alignment\":\"center\"}},{\"id\":\"aDy3xq3Dgt\",\"type\":\"paragraph\",\"data\":{\"text\":\"Nâng cơ, tái tạo collagen bằng công nghệ Thermage\",\"alignment\":\"center\"}},{\"id\":\"y8UeCkHxoA\",\"type\":\"paragraph\",\"data\":{\"text\":\"Nâng cơ, giảm mỡ và săn chắc cơ bằng công nghệ Ultherapy\",\"alignment\":\"center\"}},{\"id\":\"xxIwMf3BaX\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tái tạo bề mặt da, thu nhỏ lỗ chân lông, .. với Skinbooster\",\"alignment\":\"center\"}},{\"id\":\"OSv7uQ3arI\",\"type\":\"paragraph\",\"data\":{\"text\":\"Căng da mặt bằng chỉ collagen, chỉ nâng cơ\",\"alignment\":\"center\"}},{\"id\":\"hQwMt9I7qT\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tiêm tái tạo thể tích cho các vùng bị mất mỡ\",\"alignment\":\"center\"}},{\"id\":\"4u3uZBl9IU\",\"type\":\"paragraph\",\"data\":{\"text\":\"Với một số thông tin Bác sĩ Đông Phương nêu trên, các bạn có thể biết được rằng, việc chống lão hoá không phải chỉ cần thiết cho các cô, các mẹ, mà ngay cả những người trẻ, nên có ý thức bảo vệ sức khoẻ, sắc đẹp ngay từ khi các dấu hiệu đó chưa thật sự xuất hiện. Có như vậy thì Thanh xuân mới ở bên cạnh chúng ta lâu dài hơn và trọn vẹn hơn.\",\"alignment\":\"left\"}},{\"id\":\"MWvHFQwQQP\",\"type\":\"paragraph\",\"data\":{\"text\":\"Thương chúc các bạn luôn hạnh phúc, bình an và luôn mãi xinh đẹp.\",\"alignment\":\"left\"}},{\"id\":\"6L300ZDPVm\",\"type\":\"paragraph\",\"data\":{\"text\":\"Love,\",\"alignment\":\"left\"}},{\"id\":\"ABEySMYLmT\",\"type\":\"paragraph\",\"data\":{\"text\":\"Bs. Nguyễn Ngọc Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-17 03:54:15',	NULL,	'Chống lão hoá - ngay từ khi là một em bé, bạn có nghĩ như thế không? Chúng ta cùng tìm hiểu nhé!',	1,	0,	504,	1,	'2022-01-07 14:17:14',	'2022-12-17 03:54:15'),
(33,	'LÀM ĐẸP VỚI DẦU DỪA ',	'draft',	'lam-ep-voi-dau-dua',	'{\"time\":1641565061354,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:17:41',	'2022-01-07 14:17:41'),
(34,	'[Kết quả] Tiêm filler vùng Trũng má - Rãnh lệ / Case 01',	'publish',	'ket-qua-tiem-filler-vung-trung-ma-ranh-le-case-01',	'{\"time\":1667157148327,\"blocks\":[{\"id\":\"DBUAi8_9qx\",\"type\":\"paragraph\",\"data\":{\"text\":\"Với xu hướng làm đẹp hiện nay thì việc sử dụng các chất làm đầy đưa vào cơ thể - đặc biệt là vùng mặt đã không còn quá xa lạ với mọi người.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"uLj8OdUIQQ\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tuy nhiên để hiểu rõ hơn về công dụng cũng như là kết quả sau khi thực hiện, mời các bạn xem qua những thông tin trong bài viết này.\",\"alignment\":\"left\"}},{\"id\":\"e4unp1kx3g\",\"type\":\"paragraph\",\"data\":{\"text\":\"Case Study:\",\"alignment\":\"left\"}},{\"id\":\"jsoPaQ53bD\",\"type\":\"paragraph\",\"data\":{\"text\":\"Khách hàng Nam giới, quốc tịch Anh, 34 tuổi, công việc có nhiều stress và thường hay thức khuya làm việc. Khách hàng đến với Bs. Đông Phương vì cảm thấy phiền lòng bởi tình trạng mắt bị thâm quầng, làm cho gương mặt cảm thấy mệt mỏi - thiếu sức sống, kém hấp dẫn và trông già hơn so với tuổi.\",\"alignment\":\"left\"}},{\"id\":\"KCELIMEby2\",\"type\":\"paragraph\",\"data\":{\"text\":\"Qua thăm khám và đánh giá, bác sĩ Đông Phương đưa ra những vấn đề sau:\",\"alignment\":\"left\"}},{\"id\":\"g6cn3VKDS2\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tình trạng trước tiêm:&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"iDCHGsn7fY\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Hình thái bên ngoài: Trũng rãnh lệ, Trũng vùng má ngoài - ổ mắt, Trũng vùng Má giữa\",\"Cấu trúc bên trong: Phì đại túi mỡ dưới ổ mắt, giảm thể tích mỡ vùng má trung tâm, cơ vòng mi kém độ săn chắc - đàn hồi.\"]}},{\"id\":\"DPKRNdxNb1\",\"type\":\"paragraph\",\"data\":{\"text\":\"Hướng xử trí: Tiêm chất làm đầy ( filler) vào vùng rãnh lệ ( Tear-trough), vùng má trung tâm ( mid-cheek), và vùng má ngoài - ổ mắt&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"ZLp4rBlndc\",\"type\":\"paragraph\",\"data\":{\"text\":\"Thuốc tiêm được sử dụng: Teoxane - Teosyal Redensity 2 và Teosyal RHA3 ( link FDA Approved:&nbsp;https://www.accessdata.fda.gov/scripts/cdrh/devicesatfda/index.cfm?db=pma&amp;id=400854)\",\"alignment\":\"left\"}},{\"id\":\"HJuxe3Mtth\",\"type\":\"paragraph\",\"data\":{\"text\":\"Kết quả sau thực hiện:\",\"alignment\":\"left\"}},{\"id\":\"rG_0I72s0z\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Vẻ ngoài: Gương mặt tươi trẻ hơn sau khi thực hiện điều trị - da vùng mắt sáng, hết thâm quầng\",\"Cải thiện các rãnh trũng sâu: Rãnh lệ - Rãnh má ngoài - ổ mắt và tái tạo lại thể tích vùng má giữa\"]}},{\"id\":\"w-u9f4XHIH\",\"type\":\"paragraph\",\"data\":{\"text\":\"Kết quả có thể kéo dài từ 15- 24 tháng - tuỳ thuộc vào sự chăm sóc hằng ngày của khách hàng.\",\"alignment\":\"left\"}},{\"id\":\"swC22R1ilH\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/525B3463-8D10-4889-952A-B54437508ED9 2-1667155005515.JPEG\",\"alt\":\"\"},\"caption\":\"Bệnh nhân Nam - 34 tuổi - Quốc tịch Mỹ - Filler vùng má - rãnh lệ\",\"withBorder\":false,\"stretched\":false,\"withBackground\":true}},{\"id\":\"7VWxFxxfHs\",\"type\":\"paragraph\",\"data\":{\"text\":\"Bác sĩ Nguyễn Ngọc Đông Phương\",\"alignment\":\"left\"}},{\"id\":\"bGWc29wjep\",\"type\":\"paragraph\",\"data\":{\"text\":\"Đặt hẹn qua:&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"IqJx1RUR2h\",\"type\":\"list\",\"data\":{\"style\":\"unordered\",\"items\":[\"Web:&nbsp;https://wesapp.vn/clinic/116/atp-medical-clinic\",\"Số điện thoại: 0943993665 ( zalo - viber - whatsapp)\",\"Email: drdphuong@gmail.com\",\"Facebook:&nbsp;https://www.facebook.com/drdongphuong&nbsp;\"]}}],\"version\":\"2.22.2\"}',	0,	'2022-12-16 14:42:07',	'525B3463-8D10-4889-952A-B54437508ED9 2-1667155005515.JPEG',	'Điều trị giảm thâm quầng mắt - trũng rãnh lệ, rãnh má ổ mắt',	1,	0,	43,	0,	'2022-10-30 18:47:21',	'2022-12-16 14:42:07');

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `allow_sub` tinyint(1) DEFAULT '1',
  `path` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `Categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `Categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Categories` (`id`, `name`, `description`, `parent_id`, `allow_sub`, `path`, `order`, `createdAt`, `updatedAt`) VALUES
(1,	'Nội khoa Thẩm mỹ',	NULL,	NULL,	0,	'noi-khoa-tham-my',	'0|y00000:',	'2021-11-02 03:12:32',	'2021-11-03 09:05:48'),
(3,	'Ngoại khoa Thẩm mỹ',	NULL,	NULL,	1,	'ngoai-khoa-tham-my',	'0|xzzzzw:',	'2021-11-02 15:03:14',	'2021-11-03 09:05:48'),
(4,	'Dinh dưỡng làm đẹp',	NULL,	NULL,	1,	'dinh-duong-lam-ep',	'0|xzzzzs:',	'2021-11-02 15:04:59',	'2021-11-02 15:04:59'),
(5,	'Tips làm đẹp',	NULL,	NULL,	1,	'tips-lam-ep',	'0|xzzzzk:',	'2021-11-02 15:05:46',	'2021-11-02 15:05:46'),
(6,	'Các hoạt chất mỹ phẩm',	NULL,	NULL,	1,	'cac-hoat-chat-my-pham',	'0|xzzzzc:',	'2021-11-04 07:04:08',	'2021-11-04 07:04:08'),
(7,	'Hình ảnh',	NULL,	NULL,	1,	'hinh-anh',	'0|xzzzz4:',	'2021-11-17 15:13:21',	'2021-11-17 15:13:21');

DROP TABLE IF EXISTS `Comments`;
CREATE TABLE `Comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_show` tinyint(1) DEFAULT '0',
  `blog_id` int NOT NULL,
  `reply` text COLLATE utf8mb4_unicode_520_ci,
  `repliedAt` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_id` (`blog_id`),
  CONSTRAINT `Comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `Blogs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


DROP TABLE IF EXISTS `Media`;
CREATE TABLE `Media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `filetype` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `alt` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `filesize` float DEFAULT NULL,
  `uploadBy` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `filename_2` (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Media` (`id`, `title`, `url`, `filename`, `filetype`, `alt`, `filesize`, `uploadBy`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1,	'maria-orlova-XmhAN9TYD50-unsplash-1635822778207.jpg',	'/upload/maria-orlova-XmhAN9TYD50-unsplash-1635822778207.jpg',	'maria-orlova-XmhAN9TYD50-unsplash-1635822778207.jpg',	'image/jpeg',	'',	1125570,	'admin',	'2021-11-02 03:12:58',	'2021-11-15 16:08:22',	'2021-11-15 16:08:22'),
(2,	'farhad-fallahzad-VtQMBG_Ljc0-unsplash-1635822984160.jpg',	'/upload/farhad-fallahzad-VtQMBG_Ljc0-unsplash-1635822984160.jpg',	'farhad-fallahzad-VtQMBG_Ljc0-unsplash-1635822984160.jpg',	'image/jpeg',	'',	704711,	'admin',	'2021-11-02 03:16:24',	'2021-11-15 16:08:26',	'2021-11-15 16:08:26'),
(3,	'henning-witzel-ukvgqriuOgo-unsplash-1635822989682.jpg',	'/upload/henning-witzel-ukvgqriuOgo-unsplash-1635822989682.jpg',	'henning-witzel-ukvgqriuOgo-unsplash-1635822989682.jpg',	'image/jpeg',	'',	1896440,	'admin',	'2021-11-02 03:16:29',	'2021-11-15 16:08:40',	'2021-11-15 16:08:40'),
(4,	'461-1000x1000-1635841117663.jpg',	'/upload/461-1000x1000-1635841117663.jpg',	'461-1000x1000-1635841117663.jpg',	'image/jpeg',	'',	78080,	'admin',	'2021-11-02 08:18:37',	'2021-11-15 16:08:36',	'2021-11-15 16:08:36'),
(5,	'56-1440x500-1635841165787.jpg',	'/upload/56-1440x500-1635841165787.jpg',	'56-1440x500-1635841165787.jpg',	'image/jpeg',	'',	36197,	'admin',	'2021-11-02 08:19:25',	'2021-11-15 16:08:33',	'2021-11-15 16:08:33'),
(6,	'539-1440x500-1635841169252.jpg',	'/upload/539-1440x500-1635841169252.jpg',	'539-1440x500-1635841169252.jpg',	'image/jpeg',	'',	101934,	'admin',	'2021-11-02 08:19:29',	'2021-11-15 16:08:43',	'2021-11-15 16:08:43'),
(7,	'821-1440x500-1635841172583.jpg',	'/upload/821-1440x500-1635841172583.jpg',	'821-1440x500-1635841172583.jpg',	'image/jpeg',	'',	38016,	'admin',	'2021-11-02 08:19:32',	'2021-11-15 16:08:19',	'2021-11-15 16:08:19'),
(8,	'945-1440x500-1635841176129.jpg',	'/upload/945-1440x500-1635841176129.jpg',	'945-1440x500-1635841176129.jpg',	'image/jpeg',	'',	189042,	'admin',	'2021-11-02 08:19:36',	'2021-11-15 16:08:15',	'2021-11-15 16:08:15'),
(9,	'1079-1440x500-1635841179833.jpg',	'/upload/1079-1440x500-1635841179833.jpg',	'1079-1440x500-1635841179833.jpg',	'image/jpeg',	'',	138851,	'admin',	'2021-11-02 08:19:39',	'2021-11-15 16:08:12',	'2021-11-15 16:08:12'),
(10,	'213-900x600-1635843816343.jpg',	'/upload/213-900x600-1635843816343.jpg',	'213-900x600-1635843816343.jpg',	'image/jpeg',	'',	43187,	'admin',	'2021-11-02 09:03:36',	'2021-11-15 16:08:29',	'2021-11-15 16:08:29'),
(11,	'431-900x600-1635843819926.jpg',	'/upload/431-900x600-1635843819926.jpg',	'431-900x600-1635843819926.jpg',	'image/jpeg',	'',	48881,	'admin',	'2021-11-02 09:03:39',	'2021-11-15 16:08:09',	'2021-11-15 16:08:09'),
(12,	'1008-900x600-1635843826412.jpg',	'/upload/1008-900x600-1635843826412.jpg',	'1008-900x600-1635843826412.jpg',	'image/jpeg',	'',	41171,	'admin',	'2021-11-02 09:03:46',	'2021-11-15 16:09:00',	'2021-11-15 16:09:00'),
(13,	'175-900x600-1635843845669.jpg',	'/upload/175-900x600-1635843845669.jpg',	'175-900x600-1635843845669.jpg',	'image/jpeg',	'',	59605,	'admin',	'2021-11-02 09:04:05',	'2021-11-15 16:08:48',	'2021-11-15 16:08:48'),
(14,	'596-500x500-1635845310612.jpg',	'/upload/596-500x500-1635845310612.jpg',	'596-500x500-1635845310612.jpg',	'image/jpeg',	'',	53241,	'admin',	'2021-11-02 09:28:30',	'2021-11-15 16:08:57',	'2021-11-15 16:08:57'),
(15,	'971-500x500-1635846653858.jpg',	'/upload/971-500x500-1635846653858.jpg',	'971-500x500-1635846653858.jpg',	'image/jpeg',	'',	19371,	'admin',	'2021-11-02 09:50:53',	'2021-11-15 16:09:05',	'2021-11-15 16:09:05'),
(16,	'637-500x500-1635846666330.jpg',	'/upload/637-500x500-1635846666330.jpg',	'637-500x500-1635846666330.jpg',	'image/jpeg',	'',	27543,	'admin',	'2021-11-02 09:51:06',	'2021-11-15 16:08:53',	'2021-11-15 16:08:53'),
(17,	'P1013002-1636287664840.JPG',	'/upload/P1013002-1636287664840.JPG',	'P1013002-1636287664840.JPG',	'image/jpeg',	'',	3104300,	'admin',	'2021-11-07 12:21:05',	'2021-11-07 12:21:05',	NULL),
(18,	'side-view-female-friends-applying-beauty-product-1636300912038.jpg',	'/upload/side-view-female-friends-applying-beauty-product-1636300912038.jpg',	'side-view-female-friends-applying-beauty-product-1636300912038.jpg',	'image/jpeg',	'',	1462080,	'admin',	'2021-11-07 16:01:52',	'2021-11-07 16:01:52',	NULL),
(19,	'IMG_2852-1636426457551.JPG',	'/upload/IMG_2852-1636426457551.JPG',	'IMG_2852-1636426457551.JPG',	'image/jpeg',	'',	2938920,	'admin',	'2021-11-09 02:54:17',	'2021-11-09 02:54:17',	NULL),
(20,	'Teoxane - RHA Group with Syringes - Landscape-1636449742919.jpg',	'/upload/Teoxane - RHA Group with Syringes - Landscape-1636449742919.jpg',	'Teoxane - RHA Group with Syringes - Landscape-1636449742919.jpg',	'image/jpeg',	'',	1184440,	'admin',	'2021-11-09 09:22:23',	'2021-11-09 09:22:23',	NULL),
(21,	'6 Best Hyaluronic Acid Serum Benefits For Your Skin-1636815745716.png',	'/upload/6 Best Hyaluronic Acid Serum Benefits For Your Skin-1636815745716.png',	'6 Best Hyaluronic Acid Serum Benefits For Your Skin-1636815745716.png',	'image/png',	'',	548872,	'admin',	'2021-11-13 15:02:25',	'2021-11-13 15:02:25',	NULL),
(22,	'How to Tell If Your Pricey Hyaluronic Acid Serum Is Actually Worth It-1636815750661.jpg',	'/upload/How to Tell If Your Pricey Hyaluronic Acid Serum Is Actually Worth It-1636815750661.jpg',	'How to Tell If Your Pricey Hyaluronic Acid Serum Is Actually Worth It-1636815750661.jpg',	'image/jpeg',	'',	25360,	'admin',	'2021-11-13 15:02:30',	'2021-11-13 15:02:30',	NULL),
(23,	'tiem-filler-drdongphuong',	'/upload/P1013001-1636815771260.JPG',	'P1013001-1636815771260.JPG',	'image/jpeg',	'',	3190780,	'admin',	'2021-11-13 15:02:51',	'2021-11-15 08:32:50',	NULL),
(24,	'tiem-tre-hoa-drdongphuong',	'/upload/P1013026-1636965111177.JPG',	'P1013026-1636965111177.JPG',	'image/jpeg',	'',	2852120,	'admin',	'2021-11-15 08:31:51',	'2021-11-15 08:32:31',	NULL),
(25,	'3DLip-1636965433315.jpg',	'/upload/3DLip-1636965433315.jpg',	'3DLip-1636965433315.jpg',	'image/jpeg',	'',	406724,	'admin',	'2021-11-15 08:37:13',	'2021-11-15 08:37:13',	NULL),
(26,	'AdvFiller-1636965437288.jpg',	'/upload/AdvFiller-1636965437288.jpg',	'AdvFiller-1636965437288.jpg',	'image/jpeg',	'',	546553,	'admin',	'2021-11-15 08:37:17',	'2021-11-15 08:37:17',	NULL),
(27,	'AHA Square-1636965441815.jpg',	'/upload/AHA Square-1636965441815.jpg',	'AHA Square-1636965441815.jpg',	'image/jpeg',	'',	422771,	'admin',	'2021-11-15 08:37:21',	'2021-11-15 08:37:21',	NULL),
(28,	'DeeprepairBalm-1636965446195.jpg',	'/upload/DeeprepairBalm-1636965446195.jpg',	'DeeprepairBalm-1636965446195.jpg',	'image/jpeg',	'',	562415,	'admin',	'2021-11-15 08:37:26',	'2021-11-15 08:37:26',	NULL),
(29,	'R2Eyes-1636965450734.jpg',	'/upload/R2Eyes-1636965450734.jpg',	'R2Eyes-1636965450734.jpg',	'image/jpeg',	'',	621331,	'admin',	'2021-11-15 08:37:30',	'2021-11-15 08:37:30',	NULL),
(30,	'RHASerum-1636965454883.jpg',	'/upload/RHASerum-1636965454883.jpg',	'RHASerum-1636965454883.jpg',	'image/jpeg',	'',	386864,	'admin',	'2021-11-15 08:37:34',	'2021-11-15 08:37:34',	NULL),
(31,	'Amy_AHACleansingGel-1636965464422.jpg',	'/upload/Amy_AHACleansingGel-1636965464422.jpg',	'Amy_AHACleansingGel-1636965464422.jpg',	'image/jpeg',	'',	343387,	'admin',	'2021-11-15 08:37:44',	'2021-11-15 08:37:44',	NULL),
(32,	'APS_Factsheets-1636965471391.jpg',	'/upload/APS_Factsheets-1636965471391.jpg',	'APS_Factsheets-1636965471391.jpg',	'image/jpeg',	'',	169508,	'admin',	'2021-11-15 08:37:51',	'2021-11-15 08:37:51',	NULL),
(33,	'APS_MarbleProtect-1636965477279.jpg',	'/upload/APS_MarbleProtect-1636965477279.jpg',	'APS_MarbleProtect-1636965477279.jpg',	'image/jpeg',	'',	268460,	'admin',	'2021-11-15 08:37:57',	'2021-11-15 08:37:57',	NULL),
(34,	'MicrosoftTeams-image (1)-1636980796663.png',	'/upload/MicrosoftTeams-image (1)-1636980796663.png',	'MicrosoftTeams-image (1)-1636980796663.png',	'image/png',	'',	6844,	'admin',	'2021-11-15 12:53:16',	'2021-11-15 12:53:31',	'2021-11-15 12:53:31'),
(35,	'19520834 NGO VAN PHONG-1636980796610.png',	'/upload/19520834 NGO VAN PHONG-1636980796610.png',	'19520834 NGO VAN PHONG-1636980796610.png',	'image/png',	'',	119818,	'admin',	'2021-11-15 12:53:17',	'2021-11-15 12:53:27',	'2021-11-15 12:53:27'),
(36,	'256435690_5307571035925631_559143971487885714_n-1636980796603.jpg',	'/upload/256435690_5307571035925631_559143971487885714_n-1636980796603.jpg',	'256435690_5307571035925631_559143971487885714_n-1636980796603.jpg',	'image/jpeg',	'',	271526,	'admin',	'2021-11-15 12:53:17',	'2021-11-15 12:53:24',	'2021-11-15 12:53:24'),
(37,	'254319721_428529498663871_2728254976710193543_n-1636980796620.png',	'/upload/254319721_428529498663871_2728254976710193543_n-1636980796620.png',	'254319721_428529498663871_2728254976710193543_n-1636980796620.png',	'image/png',	'',	250166,	'admin',	'2021-11-15 12:53:17',	'2021-11-15 12:53:21',	'2021-11-15 12:53:21'),
(38,	'R2Eyes_Wakeup-1636983598292.jpg',	'/upload/R2Eyes_Wakeup-1636983598292.jpg',	'R2Eyes_Wakeup-1636983598292.jpg',	'image/jpeg',	'',	2209210,	'admin',	'2021-11-15 13:39:58',	'2021-11-15 13:39:58',	NULL),
(39,	'Teoxane - Advanced Perfecting Shield - RII Eyes - Make-Up-1636983607461.JPG',	'/upload/Teoxane - Advanced Perfecting Shield - RII Eyes - Make-Up-1636983607461.JPG',	'Teoxane - Advanced Perfecting Shield - RII Eyes - Make-Up-1636983607461.JPG',	'image/jpeg',	'',	1426810,	'admin',	'2021-11-15 13:40:07',	'2021-11-15 13:40:07',	NULL),
(40,	'Teoxane - Dull Pigmentation - VCIP Serum-1636983619992.JPG',	'/upload/Teoxane - Dull Pigmentation - VCIP Serum-1636983619992.JPG',	'Teoxane - Dull Pigmentation - VCIP Serum-1636983619992.JPG',	'image/jpeg',	'',	1461010,	'admin',	'2021-11-15 13:40:20',	'2021-11-15 13:40:20',	NULL),
(41,	'Teoxane Skin Hydration - Square-1636984462673.JPG',	'/upload/Teoxane Skin Hydration - Square-1636984462673.JPG',	'Teoxane Skin Hydration - Square-1636984462673.JPG',	'image/jpeg',	'',	820375,	'admin',	'2021-11-15 13:54:23',	'2021-11-15 13:54:23',	NULL),
(42,	'DeeprepairBalm-1636984471093.jpg',	'/upload/DeeprepairBalm-1636984471093.jpg',	'DeeprepairBalm-1636984471093.jpg',	'image/jpeg',	'',	562415,	'admin',	'2021-11-15 13:54:31',	'2021-11-15 13:54:31',	NULL),
(43,	'AHA Square-1636984479116.jpg',	'/upload/AHA Square-1636984479116.jpg',	'AHA Square-1636984479116.jpg',	'image/jpeg',	'',	422771,	'admin',	'2021-11-15 13:54:39',	'2021-11-15 13:54:39',	NULL),
(44,	'Amy_VitC-1636984495021.jpg',	'/upload/Amy_VitC-1636984495021.jpg',	'Amy_VitC-1636984495021.jpg',	'image/jpeg',	'',	392692,	'admin',	'2021-11-15 13:54:55',	'2021-11-15 13:54:55',	NULL),
(45,	'Laura_Post 3-1636984529533.jpg',	'/upload/Laura_Post 3-1636984529533.jpg',	'Laura_Post 3-1636984529533.jpg',	'image/jpeg',	'',	615527,	'admin',	'2021-11-15 13:55:29',	'2021-11-15 13:55:29',	NULL),
(46,	'Teoxane - VCIP - Fruit Slices - Landscape-1636984541459.jpg',	'/upload/Teoxane - VCIP - Fruit Slices - Landscape-1636984541459.jpg',	'Teoxane - VCIP - Fruit Slices - Landscape-1636984541459.jpg',	'image/jpeg',	'',	1621920,	'admin',	'2021-11-15 13:55:41',	'2021-11-15 13:55:41',	NULL),
(47,	'Teoxane Radiance vs Pigmentation - Square-1636984547843.JPG',	'/upload/Teoxane Radiance vs Pigmentation - Square-1636984547843.JPG',	'Teoxane Radiance vs Pigmentation - Square-1636984547843.JPG',	'image/jpeg',	'',	1659890,	'admin',	'2021-11-15 13:55:48',	'2021-11-15 13:55:48',	NULL),
(48,	'VCIP_Facts-1636984557669.jpg',	'/upload/VCIP_Facts-1636984557669.jpg',	'VCIP_Facts-1636984557669.jpg',	'image/jpeg',	'',	214421,	'admin',	'2021-11-15 13:55:57',	'2021-11-15 13:55:57',	NULL),
(49,	'Teoxane Eyecare for men - Square-1636984564801.JPG',	'/upload/Teoxane Eyecare for men - Square-1636984564801.JPG',	'Teoxane Eyecare for men - Square-1636984564801.JPG',	'image/jpeg',	'',	1173620,	'admin',	'2021-11-15 13:56:05',	'2021-11-15 13:56:05',	NULL),
(50,	'Teoxane Radiance vs Pigmentation - Landscape-1636984572026.JPG',	'/upload/Teoxane Radiance vs Pigmentation - Landscape-1636984572026.JPG',	'Teoxane Radiance vs Pigmentation - Landscape-1636984572026.JPG',	'image/jpeg',	'',	1986390,	'admin',	'2021-11-15 13:56:12',	'2021-11-15 13:56:12',	NULL),
(51,	'Teoxane - Wimbledon 2 - Advanced Perfecting Shield - RHA Serum-1636984582391.JPG',	'/upload/Teoxane - Wimbledon 2 - Advanced Perfecting Shield - RHA Serum-1636984582391.JPG',	'Teoxane - Wimbledon 2 - Advanced Perfecting Shield - RHA Serum-1636984582391.JPG',	'image/jpeg',	'',	1339130,	'admin',	'2021-11-15 13:56:22',	'2021-11-15 13:56:22',	NULL),
(52,	'3D Lip _Ad-1636984591700.jpg',	'/upload/3D Lip _Ad-1636984591700.jpg',	'3D Lip _Ad-1636984591700.jpg',	'image/jpeg',	'',	438901,	'admin',	'2021-11-15 13:56:31',	'2021-11-15 13:56:31',	NULL),
(53,	'RHA_MarbleHydrate-1636984605524.jpg',	'/upload/RHA_MarbleHydrate-1636984605524.jpg',	'RHA_MarbleHydrate-1636984605524.jpg',	'image/jpeg',	'',	274796,	'admin',	'2021-11-15 13:56:45',	'2021-11-15 13:56:45',	NULL),
(54,	'Teoxane - Grassy Area - Advanced Perfecting Shield-1636984627388.JPG',	'/upload/Teoxane - Grassy Area - Advanced Perfecting Shield-1636984627388.JPG',	'Teoxane - Grassy Area - Advanced Perfecting Shield-1636984627388.JPG',	'image/jpeg',	'',	2029730,	'admin',	'2021-11-15 13:57:07',	'2021-11-15 13:57:07',	NULL),
(55,	'Autumn_SPF_APS-1636984638466.jpg',	'/upload/Autumn_SPF_APS-1636984638466.jpg',	'Autumn_SPF_APS-1636984638466.jpg',	'image/jpeg',	'',	1826460,	'admin',	'2021-11-15 13:57:18',	'2021-11-15 13:57:18',	NULL),
(56,	'Teoxane - Micellar - Gym - Landscape-1636984657643.jpg',	'/upload/Teoxane - Micellar - Gym - Landscape-1636984657643.jpg',	'Teoxane - Micellar - Gym - Landscape-1636984657643.jpg',	'image/jpeg',	'',	1685140,	'admin',	'2021-11-15 13:57:37',	'2021-11-15 13:57:37',	NULL),
(57,	'Micellar_Efficiacy-1636986988439.jpg',	'/upload/Micellar_Efficiacy-1636986988439.jpg',	'Micellar_Efficiacy-1636986988439.jpg',	'image/jpeg',	'',	261027,	'admin',	'2021-11-15 14:36:28',	'2021-11-15 14:36:28',	NULL),
(58,	'Inner Youth RHA-1636986988430.png',	'/upload/Inner Youth RHA-1636986988430.png',	'Inner Youth RHA-1636986988430.png',	'image/png',	'',	639555,	'admin',	'2021-11-15 14:36:28',	'2021-11-15 14:36:28',	NULL),
(59,	'Laura_Post 3-1636986988435.jpg',	'/upload/Laura_Post 3-1636986988435.jpg',	'Laura_Post 3-1636986988435.jpg',	'image/jpeg',	'',	615527,	'admin',	'2021-11-15 14:36:28',	'2021-11-15 14:36:44',	'2021-11-15 14:36:44'),
(60,	'Perfect_RefinePSRNight-1636986988445.jpg',	'/upload/Perfect_RefinePSRNight-1636986988445.jpg',	'Perfect_RefinePSRNight-1636986988445.jpg',	'image/jpeg',	'',	447219,	'admin',	'2021-11-15 14:36:28',	'2021-11-15 14:36:28',	NULL),
(61,	'Micellar_no1-1636986988454.jpg',	'/upload/Micellar_no1-1636986988454.jpg',	'Micellar_no1-1636986988454.jpg',	'image/jpeg',	'',	1311100,	'admin',	'2021-11-15 14:36:28',	'2021-11-15 14:36:28',	NULL),
(62,	'Teoxane - Perfect Skin Refiner - Radiant Night Peel - Pyjamas-1636989521325.JPG',	'/upload/Teoxane - Perfect Skin Refiner - Radiant Night Peel - Pyjamas-1636989521325.JPG',	'Teoxane - Perfect Skin Refiner - Radiant Night Peel - Pyjamas-1636989521325.JPG',	'image/jpeg',	'',	3140790,	'admin',	'2021-11-15 15:18:42',	'2021-11-15 15:18:42',	NULL),
(63,	'Teoxane - Space for text - RHA - Clinical Glove-1636992182640.JPEG',	'/upload/Teoxane - Space for text - RHA - Clinical Glove-1636992182640.JPEG',	'Teoxane - Space for text - RHA - Clinical Glove-1636992182640.JPEG',	'image/jpeg',	'',	817841,	'admin',	'2021-11-15 16:03:02',	'2021-11-15 16:03:02',	NULL),
(64,	'Teoxane - Space for text - Perfect Skin Refiner - Blemishes-1636992182636.JPG',	'/upload/Teoxane - Space for text - Perfect Skin Refiner - Blemishes-1636992182636.JPG',	'Teoxane - Space for text - Perfect Skin Refiner - Blemishes-1636992182636.JPG',	'image/jpeg',	'',	1316090,	'admin',	'2021-11-15 16:03:02',	'2021-11-15 16:03:02',	NULL),
(65,	'20160604_065013-1636992261239.jpg',	'/upload/20160604_065013-1636992261239.jpg',	'20160604_065013-1636992261239.jpg',	'image/jpeg',	'',	2800890,	'admin',	'2021-11-15 16:04:22',	'2021-11-15 16:04:22',	NULL),
(66,	'20160604_065018-1636992261225.jpg',	'/upload/20160604_065018-1636992261225.jpg',	'20160604_065018-1636992261225.jpg',	'image/jpeg',	'',	3824710,	'admin',	'2021-11-15 16:04:23',	'2021-11-15 16:04:23',	NULL),
(67,	'20160604_081512-1636992261235.jpg',	'/upload/20160604_081512-1636992261235.jpg',	'20160604_081512-1636992261235.jpg',	'image/jpeg',	'',	3719600,	'admin',	'2021-11-15 16:04:23',	'2021-11-15 16:04:23',	NULL),
(68,	'20160604_081448-1636992261231.jpg',	'/upload/20160604_081448-1636992261231.jpg',	'20160604_081448-1636992261231.jpg',	'image/jpeg',	'',	4491920,	'admin',	'2021-11-15 16:04:23',	'2021-11-15 16:04:23',	NULL),
(69,	'20160604_075701-1636992261244.jpg',	'/upload/20160604_075701-1636992261244.jpg',	'20160604_075701-1636992261244.jpg',	'image/jpeg',	'',	4687220,	'admin',	'2021-11-15 16:04:23',	'2021-11-15 16:04:23',	NULL),
(70,	'20160606_132622-1636992284943.jpg',	'/upload/20160606_132622-1636992284943.jpg',	'20160606_132622-1636992284943.jpg',	'image/jpeg',	'',	4362590,	'admin',	'2021-11-15 16:04:46',	'2021-11-15 16:04:46',	NULL),
(71,	'20160604_224253-1636992284948.jpg',	'/upload/20160604_224253-1636992284948.jpg',	'20160604_224253-1636992284948.jpg',	'image/jpeg',	'',	4164920,	'admin',	'2021-11-15 16:04:46',	'2021-11-15 16:04:46',	NULL),
(72,	'20160604_134015-1636992284931.jpg',	'/upload/20160604_134015-1636992284931.jpg',	'20160604_134015-1636992284931.jpg',	'image/jpeg',	'',	4500490,	'admin',	'2021-11-15 16:04:46',	'2021-11-15 16:04:46',	NULL),
(73,	'20160604_081516-1636992284937.jpg',	'/upload/20160604_081516-1636992284937.jpg',	'20160604_081516-1636992284937.jpg',	'image/jpeg',	'',	4567650,	'admin',	'2021-11-15 16:04:46',	'2021-11-15 16:04:46',	NULL),
(74,	'IMG_1532-1636992361827.jpg',	'/upload/IMG_1532-1636992361827.jpg',	'IMG_1532-1636992361827.jpg',	'image/jpeg',	'',	706899,	'admin',	'2021-11-15 16:06:02',	'2021-11-15 16:06:02',	NULL),
(75,	'IMG_1632-1636992361818.jpg',	'/upload/IMG_1632-1636992361818.jpg',	'IMG_1632-1636992361818.jpg',	'image/jpeg',	'',	734571,	'admin',	'2021-11-15 16:06:02',	'2021-11-15 16:06:02',	NULL),
(76,	'IMG_1633-1636992361830.jpg',	'/upload/IMG_1633-1636992361830.jpg',	'IMG_1633-1636992361830.jpg',	'image/jpeg',	'',	794310,	'admin',	'2021-11-15 16:06:02',	'2021-11-15 16:06:02',	NULL),
(77,	'IMG_1525-1636992361819.jpg',	'/upload/IMG_1525-1636992361819.jpg',	'IMG_1525-1636992361819.jpg',	'image/jpeg',	'',	774551,	'admin',	'2021-11-15 16:06:02',	'2021-11-15 16:06:02',	NULL),
(78,	'IMG_1574-1636992370175.jpg',	'/upload/IMG_1574-1636992370175.jpg',	'IMG_1574-1636992370175.jpg',	'image/jpeg',	'',	679070,	'admin',	'2021-11-15 16:06:10',	'2021-11-15 16:06:10',	NULL),
(79,	'IMG_1607-1636992370165.jpg',	'/upload/IMG_1607-1636992370165.jpg',	'IMG_1607-1636992370165.jpg',	'image/jpeg',	'',	635327,	'admin',	'2021-11-15 16:06:10',	'2021-11-15 16:06:10',	NULL),
(80,	'IMG_1605-1636992370160.jpg',	'/upload/IMG_1605-1636992370160.jpg',	'IMG_1605-1636992370160.jpg',	'image/jpeg',	'',	656120,	'admin',	'2021-11-15 16:06:10',	'2021-11-15 16:06:10',	NULL),
(81,	'IMG_1646-1636992370170.jpg',	'/upload/IMG_1646-1636992370170.jpg',	'IMG_1646-1636992370170.jpg',	'image/jpeg',	'',	631881,	'admin',	'2021-11-15 16:06:10',	'2021-11-15 16:06:10',	NULL),
(82,	'IMG_1647-1636992370183.jpg',	'/upload/IMG_1647-1636992370183.jpg',	'IMG_1647-1636992370183.jpg',	'image/jpeg',	'',	604167,	'admin',	'2021-11-15 16:06:10',	'2021-11-15 16:06:10',	NULL),
(83,	'IMG_1648-1636992370189.jpg',	'/upload/IMG_1648-1636992370189.jpg',	'IMG_1648-1636992370189.jpg',	'image/jpeg',	'',	621241,	'admin',	'2021-11-15 16:06:10',	'2021-11-15 16:06:10',	NULL),
(84,	'IMG_2465-1636992395530.jpg',	'/upload/IMG_2465-1636992395530.jpg',	'IMG_2465-1636992395530.jpg',	'image/jpeg',	'',	615164,	'admin',	'2021-11-15 16:06:35',	'2021-11-15 16:06:35',	NULL),
(85,	'IMG_1654-1636992395520.jpg',	'/upload/IMG_1654-1636992395520.jpg',	'IMG_1654-1636992395520.jpg',	'image/jpeg',	'',	996548,	'admin',	'2021-11-15 16:06:35',	'2021-11-15 16:06:35',	NULL),
(86,	'IMG_2473-1636992395534.JPG',	'/upload/IMG_2473-1636992395534.JPG',	'IMG_2473-1636992395534.JPG',	'image/jpeg',	'',	1121100,	'admin',	'2021-11-15 16:06:35',	'2021-11-15 16:06:35',	NULL),
(87,	'IMG_2798-1636992577109.jpeg',	'/upload/IMG_2798-1636992577109.jpeg',	'IMG_2798-1636992577109.jpeg',	'image/jpeg',	'',	1586140,	'admin',	'2021-11-15 16:09:37',	'2021-11-15 16:09:37',	NULL),
(88,	'IMG_2814-1636992577113.jpeg',	'/upload/IMG_2814-1636992577113.jpeg',	'IMG_2814-1636992577113.jpeg',	'image/jpeg',	'',	1625700,	'admin',	'2021-11-15 16:09:37',	'2021-11-15 16:09:37',	NULL),
(89,	'IMG_1620-1636992624177.JPG',	'/upload/IMG_1620-1636992624177.JPG',	'IMG_1620-1636992624177.JPG',	'image/jpeg',	'',	1139700,	'admin',	'2021-11-15 16:10:25',	'2021-11-15 16:10:25',	NULL),
(90,	'IMG_1621-1636992624181.JPG',	'/upload/IMG_1621-1636992624181.JPG',	'IMG_1621-1636992624181.JPG',	'image/jpeg',	'',	1060240,	'admin',	'2021-11-15 16:10:25',	'2021-11-15 16:10:25',	NULL),
(91,	'IMG_1619-1636992624185.JPG',	'/upload/IMG_1619-1636992624185.JPG',	'IMG_1619-1636992624185.JPG',	'image/jpeg',	'',	1173520,	'admin',	'2021-11-15 16:10:25',	'2021-11-15 16:10:25',	NULL),
(92,	'IMG_1622-1636992624192.JPG',	'/upload/IMG_1622-1636992624192.JPG',	'IMG_1622-1636992624192.JPG',	'image/jpeg',	'',	1389260,	'admin',	'2021-11-15 16:10:25',	'2021-11-15 16:10:25',	NULL),
(93,	'IMG_1623-1636992624197.JPG',	'/upload/IMG_1623-1636992624197.JPG',	'IMG_1623-1636992624197.JPG',	'image/jpeg',	'',	1348640,	'admin',	'2021-11-15 16:10:25',	'2021-11-15 16:10:25',	NULL),
(94,	'IMG_1735-1636992634408.JPG',	'/upload/IMG_1735-1636992634408.JPG',	'IMG_1735-1636992634408.JPG',	'image/jpeg',	'',	117134,	'admin',	'2021-11-15 16:10:34',	'2021-11-15 16:10:34',	NULL),
(95,	'IMG_1625-1636992634381.JPG',	'/upload/IMG_1625-1636992634381.JPG',	'IMG_1625-1636992634381.JPG',	'image/jpeg',	'',	1326320,	'admin',	'2021-11-15 16:10:34',	'2021-11-15 16:10:34',	NULL),
(96,	'IMG_1644-1636992634390.JPG',	'/upload/IMG_1644-1636992634390.JPG',	'IMG_1644-1636992634390.JPG',	'image/jpeg',	'',	1284230,	'admin',	'2021-11-15 16:10:35',	'2021-11-15 16:10:35',	NULL),
(97,	'IMG_1671-1636992634404.JPG',	'/upload/IMG_1671-1636992634404.JPG',	'IMG_1671-1636992634404.JPG',	'image/jpeg',	'',	1574950,	'admin',	'2021-11-15 16:10:35',	'2021-11-15 16:10:35',	NULL),
(98,	'IMG_1671-1636992652580.JPG',	'/upload/IMG_1671-1636992652580.JPG',	'IMG_1671-1636992652580.JPG',	'image/jpeg',	'',	1574950,	'admin',	'2021-11-15 16:10:52',	'2021-11-15 16:10:57',	'2021-11-15 16:10:57'),
(99,	'IMG_4462-1636992670411.jpeg',	'/upload/IMG_4462-1636992670411.jpeg',	'IMG_4462-1636992670411.jpeg',	'image/jpeg',	'',	2838540,	'admin',	'2021-11-15 16:11:10',	'2021-11-15 16:11:10',	NULL),
(100,	'1079-1440x500-1637115011113.jpg',	'/upload/1079-1440x500-1637115011113.jpg',	'1079-1440x500-1637115011113.jpg',	'image/jpeg',	'',	138851,	'admin',	'2021-11-17 02:10:11',	'2021-11-17 02:12:16',	'2021-11-17 02:12:16'),
(101,	'17869EF8-2E70-456B-8F9D-B3BA8B509BC5-1637333875708.jpg',	'/upload/17869EF8-2E70-456B-8F9D-B3BA8B509BC5-1637333875708.jpg',	'17869EF8-2E70-456B-8F9D-B3BA8B509BC5-1637333875708.jpg',	'image/jpeg',	'',	872546,	'admin',	'2021-11-19 14:57:55',	'2021-11-19 14:57:55',	NULL),
(102,	'IMG_2191-1637333875711.jpeg',	'/upload/IMG_2191-1637333875711.jpeg',	'IMG_2191-1637333875711.jpeg',	'image/jpeg',	'',	2208260,	'admin',	'2021-11-19 14:57:56',	'2021-11-19 14:57:56',	NULL),
(103,	'IMG_3647-1637334179053.JPG',	'/upload/IMG_3647-1637334179053.JPG',	'IMG_3647-1637334179053.JPG',	'image/jpeg',	'',	331776,	'admin',	'2021-11-19 15:02:59',	'2021-11-19 15:02:59',	NULL),
(104,	'high-angle-containers-arrangement-1637334202125.jpg',	'/upload/high-angle-containers-arrangement-1637334202125.jpg',	'high-angle-containers-arrangement-1637334202125.jpg',	'image/jpeg',	'',	1116780,	'admin',	'2021-11-19 15:03:22',	'2021-11-19 15:03:22',	NULL),
(105,	'IMG_1735-1637394704071.JPG',	'/upload/IMG_1735-1637394704071.JPG',	'IMG_1735-1637394704071.JPG',	'image/jpeg',	'',	117134,	'admin',	'2021-11-20 07:51:44',	'2021-11-20 07:51:52',	'2021-11-20 07:51:52'),
(106,	'IMG_2852-1637394732021.JPG',	'/upload/IMG_2852-1637394732021.JPG',	'IMG_2852-1637394732021.JPG',	'image/jpeg',	'',	2938920,	'admin',	'2021-11-20 07:52:12',	'2021-11-20 07:52:12',	NULL),
(107,	'IMG_2854-1637394732023.JPG',	'/upload/IMG_2854-1637394732023.JPG',	'IMG_2854-1637394732023.JPG',	'image/jpeg',	'',	3024400,	'admin',	'2021-11-20 07:52:12',	'2021-11-20 07:52:12',	NULL),
(108,	'IMG_9195-1637394745533.jpeg',	'/upload/IMG_9195-1637394745533.jpeg',	'IMG_9195-1637394745533.jpeg',	'image/jpeg',	'',	2237120,	'admin',	'2021-11-20 07:52:25',	'2021-11-20 07:52:25',	NULL),
(109,	'Haworth_projection_of_hyaluronan-1641528792791.svg.png',	'/upload/Haworth_projection_of_hyaluronan-1641528792791.svg.png',	'Haworth_projection_of_hyaluronan-1641528792791.svg.png',	'image/png',	'',	9469,	'admin',	'2022-01-07 04:13:12',	'2022-01-07 04:13:12',	NULL),
(110,	'Biomedical-applications-of-hyaluronic-acid-1641528797473.png',	'/upload/Biomedical-applications-of-hyaluronic-acid-1641528797473.png',	'Biomedical-applications-of-hyaluronic-acid-1641528797473.png',	'image/png',	'',	285718,	'admin',	'2022-01-07 04:13:17',	'2022-01-07 04:13:17',	NULL),
(111,	'anti_ageing-870x450-1642522866484.jpg',	'/upload/anti_ageing-870x450-1642522866484.jpg',	'anti_ageing-870x450-1642522866484.jpg',	'image/jpeg',	'',	52198,	'admin',	'2022-01-18 16:21:06',	'2022-01-18 16:21:06',	NULL),
(112,	'drdphuong-1642522903571.jpg',	'/upload/drdphuong-1642522903571.jpg',	'drdphuong-1642522903571.jpg',	'image/jpeg',	'',	52198,	'admin',	'2022-01-18 16:21:43',	'2022-01-18 16:21:43',	NULL),
(113,	'Hoya-Stellify-1-1663319528697.60-HVP.png',	'/upload/Hoya-Stellify-1-1663319528697.60-HVP.png',	'Hoya-Stellify-1-1663319528697.60-HVP.png',	'image/png',	'',	609485,	'admin',	'2022-09-16 09:12:19',	'2022-09-16 09:12:27',	'2022-09-16 09:12:27'),
(114,	'525B3463-8D10-4889-952A-B54437508ED9 2-1667155005515.JPEG',	'/upload/525B3463-8D10-4889-952A-B54437508ED9 2-1667155005515.JPEG',	'525B3463-8D10-4889-952A-B54437508ED9 2-1667155005515.JPEG',	'image/jpeg',	'',	1774070,	'admin',	'2022-10-30 18:36:45',	'2022-10-30 18:36:45',	NULL);

DROP TABLE IF EXISTS `OrderItems`;
CREATE TABLE `OrderItems` (
  `product_id` int NOT NULL,
  `variant_id` int NOT NULL,
  `order_id` int NOT NULL,
  `number` int DEFAULT NULL,
  `total` float DEFAULT '0',
  `discount` float DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`product_id`,`variant_id`,`order_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `OrderItems_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `OrderItems_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `OrderItems` (`product_id`, `variant_id`, `order_id`, `number`, `total`, `discount`, `createdAt`, `updatedAt`) VALUES
(1,	0,	1,	1,	200000,	40000,	'2021-11-02 09:54:08',	'2021-11-02 09:54:08'),
(1,	0,	2,	3,	600000,	120000,	'2021-11-02 12:38:13',	'2021-11-02 12:38:13'),
(1,	0,	3,	1,	200000,	40000,	'2021-11-09 15:46:50',	'2021-11-09 15:46:50'),
(2,	0,	4,	1,	1350000,	0,	'2022-04-02 02:21:11',	'2022-04-02 02:21:11'),
(3,	0,	6,	1,	2000000,	0,	'2022-11-04 00:19:54',	'2022-11-04 00:19:54'),
(5,	0,	5,	2,	2340000,	0,	'2022-07-28 05:16:14',	'2022-07-28 05:16:14');

DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `product_money` float DEFAULT NULL,
  `promotion_money` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `status` enum('pending','shipping','success','cancel','confirm') COLLATE utf8mb4_unicode_520_ci DEFAULT 'pending',
  `note` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `handle_note` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `mail_confirm` tinyint(1) DEFAULT '0',
  `mail_shipping` tinyint(1) DEFAULT '0',
  `invoice_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Orders` (`id`, `phone`, `customer_email`, `customer_name`, `address`, `product_money`, `promotion_money`, `total`, `status`, `note`, `handle_note`, `mail_confirm`, `mail_shipping`, `invoice_name`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1,	'0943493434',	'luffy3qvietnam@gmail.com',	'ngô văn phóng',	'224 Nguyen Trai Quan 5, TPHCM, Phường Bạch Sam, Thị xã Mỹ Hào, Tỉnh Hưng Yên',	200000,	40000,	160000,	'confirm',	NULL,	'xác nhận nè',	1,	0,	'11636202285290.pdf',	'2021-11-02 09:54:08',	'2021-11-06 12:38:13',	NULL),
(2,	'0943493434',	'novapoxperia@gmail.com',	'ngô văn phóng',	'224 Nguyen Trai Quan 5, TPHCM, Xã Lang Quán, Huyện Yên Sơn, Tỉnh Tuyên Quang',	600000,	120000,	480000,	'confirm',	NULL,	'ghi chú nè',	1,	1,	'21636202171069.pdf',	'2021-11-02 12:38:13',	'2022-09-20 07:53:55',	NULL),
(3,	'345345345345',	'phongngonovapo@gmail.com',	'Ngo Phong',	'114 Bui Dinh Tuy, Xã Yên Giả, Huyện Quế Võ, Tỉnh Bắc Ninh',	200000,	40000,	160000,	'pending',	NULL,	NULL,	0,	0,	'31636472825175.pdf',	'2021-11-09 15:46:50',	'2021-11-09 15:47:05',	NULL),
(4,	'0837923838',	'testgame@gmail.com',	'a',	'142, Xã Vinh Quang, Huyện Vĩnh Bảo, Thành phố Hải Phòng',	1350000,	0,	1350000,	'pending',	NULL,	NULL,	0,	0,	'41648880591589.pdf',	'2022-04-02 02:21:11',	'2022-04-02 06:23:11',	NULL),
(5,	'0837923838',	'testgame@gmail.com',	'a',	'142, Xã Đại Hà, Huyện Kiến Thuỵ, Thành phố Hà Nội',	2340000,	0,	2340000,	'pending',	NULL,	NULL,	0,	0,	'51663660422385.pdf',	'2022-07-28 05:16:14',	'2022-09-20 07:53:42',	NULL),
(6,	'899933',	'hjjj@gmail.com',	'Hjj',	'Hdjdjd iisosbijee, Xã Quảng Bạch, Huyện Chợ Đồn, Tỉnh Bắc Kạn',	2000000,	0,	2000000,	'pending',	NULL,	NULL,	0,	0,	NULL,	'2022-11-04 00:19:54',	'2022-11-04 00:19:54',	NULL);

DROP TABLE IF EXISTS `ProductCategories`;
CREATE TABLE `ProductCategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `allow_sub` tinyint(1) DEFAULT '1',
  `path` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `ProductCategories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `ProductCategories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `ProductCategories` (`id`, `name`, `description`, `parent_id`, `allow_sub`, `path`, `order`, `createdAt`, `updatedAt`) VALUES
(4,	'Teoxane',	'Dược mỹ phẩm đến từ Thuỵ Sĩ',	NULL,	1,	'teoxane',	'0|xzzzzw:',	'2021-11-02 09:49:35',	'2022-06-15 08:49:35'),
(5,	'Heliocare',	NULL,	NULL,	1,	'heliocare',	'0|y00000:',	'2021-11-02 15:07:07',	'2021-11-02 15:07:07'),
(6,	'White Leaf',	NULL,	NULL,	1,	'white-leaf',	'0|xzzzzg:',	'2021-11-02 15:07:20',	'2022-06-15 08:49:35'),
(7,	'Obagi',	NULL,	NULL,	1,	'obagi',	'0|xzzzzk:',	'2021-11-02 15:07:33',	'2021-11-02 15:07:33'),
(8,	'Các sản phẩm khác',	NULL,	NULL,	1,	'cac-san-pham-khac',	'0|xzzzzc:',	'2021-11-02 15:07:57',	'2021-11-02 15:08:11');

DROP TABLE IF EXISTS `ProductVariants`;
CREATE TABLE `ProductVariants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `price` float NOT NULL,
  `product_id` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `ProductVariants_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `ProductVariants` (`id`, `name`, `description`, `price`, `product_id`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1,	'novapo',	'novapo',	20000,	7,	'2022-06-15 08:52:18',	'2022-06-15 08:52:18',	NULL);

DROP TABLE IF EXISTS `Product_Media`;
CREATE TABLE `Product_Media` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `MediumId` int NOT NULL,
  `ProductId` int NOT NULL,
  PRIMARY KEY (`MediumId`,`ProductId`),
  KEY `ProductId` (`ProductId`),
  CONSTRAINT `Product_Media_ibfk_1` FOREIGN KEY (`MediumId`) REFERENCES `Media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Product_Media_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Product_Media` (`createdAt`, `updatedAt`, `MediumId`, `ProductId`) VALUES
('2021-11-02 09:51:51',	'2021-11-02 09:51:51',	16,	1),
('2021-11-15 13:53:42',	'2021-11-15 13:53:42',	38,	3),
('2021-11-15 14:05:53',	'2021-11-15 14:05:53',	41,	4),
('2021-11-15 14:35:30',	'2021-11-15 14:35:30',	41,	6),
('2021-11-15 13:59:33',	'2021-11-15 13:59:33',	45,	2),
('2021-11-15 13:59:33',	'2021-11-15 13:59:33',	52,	2),
('2022-06-15 08:53:35',	'2022-06-15 08:53:35',	106,	8),
('2022-06-15 08:52:07',	'2022-06-15 08:52:07',	110,	7),
('2022-06-15 08:52:07',	'2022-06-15 08:52:07',	112,	7);

DROP TABLE IF EXISTS `Products`;
CREATE TABLE `Products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `rating` float NOT NULL DEFAULT '0',
  `category_id` int DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `price` float DEFAULT '0',
  `view` int DEFAULT '0',
  `is_on_sale` tinyint(1) DEFAULT '0',
  `discount` float DEFAULT '0',
  `SKU` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_track_inventory` tinyint(1) DEFAULT '0',
  `is_in_stock` tinyint(1) DEFAULT '1',
  `is_publish` tinyint(1) DEFAULT '1',
  `brand` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `shipping_infor` text COLLATE utf8mb4_unicode_520_ci,
  `return_infor` text COLLATE utf8mb4_unicode_520_ci,
  `manual_infor` text COLLATE utf8mb4_unicode_520_ci,
  `brand_infor` text COLLATE utf8mb4_unicode_520_ci,
  `content` text COLLATE utf8mb4_unicode_520_ci,
  `maxDiscount` int DEFAULT NULL,
  `deal_of_week` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`),
  UNIQUE KEY `path_2` (`path`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `Products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `ProductCategories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Products` (`id`, `name`, `description`, `path`, `rating`, `category_id`, `thumbnail`, `price`, `view`, `is_on_sale`, `discount`, `SKU`, `is_track_inventory`, `is_in_stock`, `is_publish`, `brand`, `shipping_infor`, `return_infor`, `manual_infor`, `brand_infor`, `content`, `maxDiscount`, `deal_of_week`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1,	'sản phẩm 1-deleted-1636984015233',	'mô tả ngắn',	'san-pham-1-deleted-1636984015233',	0,	4,	'/upload/971-500x500-1635846653858.jpg',	200000,	0,	1,	0.2,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>hướng dẫn</p>',	'<p>thương hiẹu</p>',	'<p>nội dung</p>',	100000,	0,	'2021-11-02 09:51:51',	'2021-11-15 13:46:55',	'2021-11-15 13:46:55'),
(2,	'3D Lips - Teoxane ',	'Một phát minh mới nhất của Teoxane*: [3D] Lip –  Đem đến cho bạn một đôi môi căng mọng, được nuôi dưỡng & cấp ẩm tối ưu chỉ sau một lần sử dụng, với thiết kế nhỏ gọn, giúp bạn có thể chăm sóc đôi môi bất cứ lúc nào bạn muốn.',	'3d-lips-teoxane',	0,	4,	'/upload/3DLip-1636965433315.jpg',	1350000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<ul><li>Thoa mỗi ngày, sáng tối, có thể dùng nhiều lần trong ngày, trước khi đánh son màu, giúp môi luôn căng mọng và mịn màng</li></ul>',	'',	'<p>Thành phần chính:<br>- HYALURONIC ACID &amp; COLLAGEN MICROSPHERES: Cung cấp lại HA và tái tạo lại collagen cho môi<br>- UNSAPONIFIABLE SHEA BUTTER: Dưỡng ẩm, chống lại các nếp nhăn cho môi<br>- CERAMIDE 2 AND MATRIKINE COMPLEX: làm mềm và mịn màng đôi môi</p><p>&nbsp;</p><p>Bảng thành phần:</p><p>PARAFFINUM LIQUIDUM (MINERAL OIL), DIISOSTEARYL MALATE, HYDROGENATED STYRENE/ISOPRENE COPOLYMER, OCTYLDODECYL OLEATE, OLEIC/LINOLEIC/LINOLENIC POLYGLYCERIDES, OCTYLDODECANOL, PENTAERYTHRITYL TETRAISOSTEARATE, OCTYLDODECYL STEAROYL STEARATE, CERA ALBA (BEESWAX), CAPRYLIC/CAPRIC TRIGLYCERIDE, C12-15 ALKYL BENZOATE, BUTYROSPERMUM PARKII (SHEA BUTTER), RICINUS COMMUNIS SEED OIL, SODIUM HYALURONATE, POLYHYDROXYSTEARIC ACID, BUTYROSPERMUM PARKII (SHEA) BUTTER UNSAPONIFIABLES, HYDROXYMETHOXYPHENYL PROPYLMETHYLMETHOXYBENZOFURAN, PARFUM (FRAGRANCE), TRIBEHENIN, DIETHYLHEXYL SYRINGYLIDENEMALONATE, HYDROGENATED CASTOR OIL, TRIHYDROXYSTEARIN, CERAMIDE NG, PEG-10 PHYTOSTEROL, SODIUM CHONDROITIN SULFATE, ATELOCOLLAGEN, LACTIC ACID, PALMITOYL HEXAPEPTIDE-12.</p>',	0,	0,	'2021-11-15 13:46:36',	'2021-11-15 13:59:33',	NULL),
(3,	'R[2]Eyes - Teoxane',	'Vùng da nhạy cảm quanh mắt được sáng lên thấy rõ sau lần sử dụng đầu tiên . Sản phẩm được đánh giá cao nhất của Teoxane**!  R[II] Eyes Contour có màu tệp với màu da và khả năng cấp ẩm tối ưu, công thức không chứa chất tạo mùi được thiết kế dành riêng cho việc điều trị nếp nhăn/bọng mắt & vùng thâm quanh mắt\n',	'r-2-eyes-teoxane',	0,	4,	'/upload/R2Eyes-1636965450734.jpg',	2000000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>Phù hợp với tất cả các loại da, đặc biệt cho da nhạy cảm, Sử dụng R[II] Eyes Contour vào buổi sáng &amp; chiều tối để đạt kết quả tốt nhất.</p><p>Vỗ nhẹ phần phẳng của đầu típ kim loại dọc theo vùng mắt, giúp làm mát &amp; mang lại hiệu quả làm thông thoáng những vùng bị tắc nghẽn. Sau đó, thoa sản phẩm bằng cách đẩy &amp; massage nhẹ nhàng cho đến khi sản phẩm hoàn toàn được thẩm thấu</p>',	'',	'<p>Thành phần chính:</p><ul><li>Resilient Hyaluronic Acid : Giữ ẩm lâu &amp; củng cố hàng rào bảo vệ da</li><li>DERMO-RESTRUCTURING COMPLEX: Hỗn hợp gồm 8 amino acids, 3 chất chống oxy hóa, 2 chất khoáng, 1 vitamin B6. Giúp bảo vệ &amp; tái tạo làn da</li><li>DISODIUM ACETYL GLUCOSAMINE PHOSPHATE: Thành tố tự nhiên của hyaluronic acid – Thành tố cấu thành HA tự nhiên trong cơ thể.</li><li>ESCIN &amp; HAMAMELIS EXTRACT: Chống tắc nghẽn mạch máu</li></ul><h3>&nbsp;</h3><p>Thành phần khác:</p><p>AQUA (WATER), HELIANTHUS ANNUUS (SUNFLOWER) SEED OIL, GLYCERIN, PROPANEDIOL, BUTYLENE GLYCOL, DIMETHICONE, POLYETHYLENE, MYRISTYL ALCOHOL, TRIETHYLHEXANOIN, CETYL ALCOHOL, GLYCERYL STEARATE, OLEIC/LINOLEIC/LINOLENIC POLYGLYCERIDES, HEXYLDECANOL, HEXYLDECYL LAURATE, PROPYLENE GLYCOL, PEG-75 STEARATE, BENZYL ALCOHOL, CETETH-20, STEARETH-20, CYCLOPENTASILOXANE, ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER, CHLORPHENESIN, XANTHAN GUM, PARFUM (FRAGRANCE), GLYCINE SOJA (SOYBEAN) OIL, GLYCINE SOJA (SOYBEAN) STEROLS, DIPROPYLENE GLYCOL, ALLANTOIN, DISODIUM EDTA, PHOSPHATE BUFFERED SALINE, PEG-8, SALICYLIC ACID, HEXYL LAURATE, SODIUM HYDROXIDE, DIPHENYL DIMETHICONE, PERSEA GRATISSIMA (AVOCADO) OIL, TOCOPHEROL, ETHYLENE BRASSYLATE, ARNICA MONTANA FLOWER EXTRACT, SORBIC ACID, CETEARYL ALCOHOL, ASCORBYL PALMITATE, HELICHRYSUM ARENARIUM FLOWER EXTRACT, GERANIOL, HYDROGENATED PALM GLYCERIDES CITRATE, SODIUM HYALURONATE CROSSPOLYMER-2, ASCORBIC ACID, CITRIC ACID, DEXTRAN, PALMITOYL TRIPEPTIDE-8, BHT</p>',	0,	0,	'2021-11-15 13:53:42',	'2021-11-15 13:53:42',	NULL),
(4,	'RHA serum - Teoxane',	'Sản phẩm được đánh giá cao* với hàm lượng công thức cốt lõi cao nhất của Teoxane, với khả năng cấp ẩm từ công nghệ RHA® được cấp bằng sáng chế.  Nhỏ gọn & tiện lợi, RHA® Serum là một sự kết hợp mạnh mẽ của các thành phần chống oxy hóa & lão hóa, giúp tái tạo & trẻ hóa làn da chỉ sau 14 ngày.\n\nSerum đầu tiên được nghiên cứu kỹ càng để cải thiện khả năng mất nước, sạm màu & sự lão hóa của làn da. Phù hợp cho mọi loại da. Sự kết hợp mạnh mẽ của các thành phần chống oxy hóa & lão hóa giúp phục hồi chức năng tái tạo tự nhiên của da. Da mịn & săn chắc hơn, nước da sáng hơn, khả năng cấp ẩm được cải thiện rõ chỉ sau 14 ngày **',	'rha-serum-teoxane',	0,	4,	'/upload/RHASerum-1636965454883.jpg',	3600000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>Thoa một lượng nhỏ serum lên da mặt và cổ sau bước làm sạch - 2 lần trong ngày giúp củng cố hàng rào bảo vệ da &amp; cải thiện chức năng giữ ẩm, nên kết hợp sử dụng cùng ADVANCED FILLER hoặc ADVANCED PERFECTING SHIELD</p><p>Khuyến nghị sử dụng trước và sau liệu trình thẩm mỹ:</p><p>Sử dụng ngày và đêm trong vòng 1 tháng trước liệu trình thẩm mỹ giúp củng cố hàng rào bảo vệ da &amp; duy trì độ ẩm.</p><p>** Kết quả thấy được sau 28 ngày dùng sản phẩm</p>',	'',	'<p>Thành phần chính:</p><ul><li>Resilient Hyaluronic Acid : Giữ ẩm lâu &amp; củng cố hàng rào bảo vệ da</li><li>DERMO-RESTRUCTURING COMPLEX: Hỗn hợp gồm 8 amino acids, 3 chất chống oxy hóa, 2 chất khoáng, 1 vitamin B6. Giúp bảo vệ &amp; tái tạo làn da</li><li>DISODIUM ACETYL GLUCOSAMINE PHOSPHATE: Thành tố tự nhiên của hyaluronic acid – Thành tố cấu thành HA tự nhiên trong cơ thể.</li><li>SODIUM HYALURONATE: Cấp ẩm và làm căng mọng da</li></ul><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p><strong>Bảng thành phần:</strong></p><p>AQUA (WATER), DIGLYCERIN, PROPANEDIOL, GLYCERIN, PHOSPHATE BUFFERED SALINE, PENTYLENE GLYCOL, IMPERATA CYLINDRICA ROOT EXTRACT, HYDROXYETHYL ACRYLATE/SODIUM ACRYLOYLDIMETHYL TAURATE COPOLYMER, SODIUM POLYACRYLATE STARCH, PPG-26-BUTETH-26, CHLORPHENESIN, SODIUM HYALURONATE, PEG-40 HYDROGENATED CASTOR OIL, PARFUM (FRAGRANCE), TAMARINDUS INDICA SEED GUM, O-CYMEN-5-OL, SODIUM HYALURONATE CROSSPOLYMER-2, DISODIUM ACETYL GLUCOSAMINE PHOSPHATE, GLYCERYL ACRYLATE/ACRYLIC ACID COPOLYMER, POLYSORBATE 60, SORBITAN ISOSTEARATE, CAPRYLYL GLYCOL, CARBOMER, ALTEROMONAS FERMENT EXTRACT, PHENETHYL ALCOHOL, SODIUM CITRATE, ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER, CITRIC ACID, BIOTIN, GLUTATHIONE, PYRIDOXINE HCL, THIOCTIC ACID, ACETYL CYSTEINE, LYSINE HYDROCHLORIDE, VALINE, ISOLEUCINE, LEUCINE, THREONINE, ARGININE, GLYCINE, ZINC ACETATE, PROLINE, COPPER SULFATE.</p>',	0,	0,	'2021-11-15 14:05:53',	'2021-11-15 14:05:53',	NULL),
(5,	'AHA Cleansing - Teoxane',	'AHA Cleansing gel là loại gel rửa mặt giúp làm sạch sâu và thanh lọc làn da. Công thức độc quyền kết hợp thông minh các thành phần: axit glycolic, axit trái cây, RHA Resilient Hyaluronic acid và một phức hợp làm sáng để loại bỏ lớp trang điểm lâu trôi, tạp chất và các tế bào da chết, ngoài ra còn giúp da được cấp ẩm, mang lại làn da tươi tắn và rạng rỡ.',	'aha-cleansing-teoxane',	0,	4,	'/upload/AHA Square-1636965441815.jpg',	1170000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>Sử dụng 1 lần/ngày vào buổi sáng hoặc tối lên mặt và cổ đã được làm ẩm bằng nước. Tạo bọt và rửa sạch bằng nước ấm.</p><p>AHA Cleansing gel phù hợp với mọi loại da, trừ da nhạy cảm.</p>',	'',	'<p>Thành phần chính:</p><ul><li>GLYCOLIC AND FRUIT ACIDS: Axit Glycolic và Axit trái cây, thuộc họ Axit Alpha Hydroxy (AHA): &nbsp;hoạt hoá bề mặt và nhẹ nhàng làm sạch tế bào chết trên da để mang lại làn da tươi mới, mềm mại và sạch sẽ hơn **</li><li>RHA: Giữ ẩm lâu &amp; củng cố hàng rào bảo vệ da</li><li>BRIGHTENING COMPLEX: Phức hợp làm sáng da – Hỗn hợp 5 thành phần làm sáng được lựa chọn cẩn thận để ngăn chặn sự hình thành của các đốm đen&nbsp;</li></ul><p>&nbsp;</p>',	0,	0,	'2021-11-15 14:10:20',	'2021-11-15 14:10:20',	NULL),
(6,	'Advanced Filler Normal to Combination Skin - Teoxane',	'abc',	'advanced-filler-normal-to-combination-skin-teoxane',	0,	4,	'/upload/AdvFiller-1636965437288.jpg',	2800000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'',	'',	NULL,	0,	0,	'2021-11-15 14:35:30',	'2021-11-15 14:35:30',	NULL),
(7,	'sản phẩm 1-deleted-1655283150362',	'kakakak',	'san-pham-1-deleted-1655283150362',	0,	4,	'/upload/anti_ageing-870x450-1642522866484.jpg',	15000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'',	'',	NULL,	0,	0,	'2022-06-15 08:52:07',	'2022-06-15 08:52:30',	'2022-06-15 08:52:30'),
(8,	'SP ko biến thể - deal of weekkkkkkkk SP ko biến thể - deal of weekkkkkkkk SP ko biến thể - deal of weekkkkkkkk SP ko biến thể - -deleted-1655283294948',	'sề',	'sp-ko-bien-the-deal-of-weekkkkkkkk-sp-ko-bien-the-deal-of-weekkkkkkkk-sp-ko-bien-the-deal-of-weekkkkkkkk-sp-ko-bien-the-deleted-1655283294948',	0,	4,	'/upload/Biomedical-applications-of-hyaluronic-acid-1641528797473.png',	12,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>fsfe</p>',	'<p>fsef</p>',	'<p>ế</p>',	0,	0,	'2022-06-15 08:53:35',	'2022-06-15 08:54:54',	'2022-06-15 08:54:54');

DROP TABLE IF EXISTS `SlideLocations`;
CREATE TABLE `SlideLocations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `SlideLocations` (`id`, `name`, `createdAt`, `updatedAt`) VALUES
(1,	'homepage',	'2021-11-02 08:08:24',	'2021-11-02 08:08:24'),
(2,	'allProduct',	'2021-11-02 08:09:34',	'2021-11-02 08:09:34'),
(3,	'allblog',	'2021-11-02 08:09:49',	'2021-11-02 08:09:49'),
(4,	'testimonial',	'2021-11-02 08:10:02',	'2021-11-02 08:10:02');

DROP TABLE IF EXISTS `Slide_Banner`;
CREATE TABLE `Slide_Banner` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `SlideId` int NOT NULL,
  `BannerId` int NOT NULL,
  PRIMARY KEY (`SlideId`,`BannerId`),
  KEY `BannerId` (`BannerId`),
  CONSTRAINT `Slide_Banner_ibfk_1` FOREIGN KEY (`SlideId`) REFERENCES `Slides` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Slide_Banner_ibfk_2` FOREIGN KEY (`BannerId`) REFERENCES `Banners` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Slide_Banner` (`createdAt`, `updatedAt`, `SlideId`, `BannerId`) VALUES
('2021-11-15 14:47:48',	'2021-11-15 14:47:48',	1,	2),
('2021-11-17 02:08:40',	'2021-11-17 02:08:40',	1,	3);

DROP TABLE IF EXISTS `Slides`;
CREATE TABLE `Slides` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location_id` int DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `slideId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location_id` (`location_id`),
  KEY `slideId` (`slideId`),
  CONSTRAINT `Slides_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `SlideLocations` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `Slides_ibfk_2` FOREIGN KEY (`slideId`) REFERENCES `SlideLocations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Slides` (`id`, `location_id`, `is_visible`, `name`, `createdAt`, `updatedAt`, `slideId`) VALUES
(1,	1,	1,	'Trang chủ',	'2021-11-02 08:15:40',	'2021-11-15 14:47:40',	NULL),
(2,	3,	1,	'Trang bài viết',	'2021-11-02 08:15:56',	'2021-11-02 08:15:56',	NULL),
(3,	2,	1,	'Trang sản phẩm',	'2021-11-02 08:16:06',	'2021-11-02 08:16:06',	NULL),
(4,	4,	1,	'Nhận xét của khách hàng',	'2021-11-02 08:16:21',	'2021-11-02 08:16:21',	NULL);

DROP TABLE IF EXISTS `Subscribes`;
CREATE TABLE `Subscribes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secret_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `receive_blog` tinyint(1) DEFAULT '1',
  `receive_product` tinyint(1) DEFAULT '1',
  `receive_news` tinyint(1) DEFAULT '1',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Subscribes` (`id`, `name`, `email`, `secret_key`, `receive_blog`, `receive_product`, `receive_news`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1,	'Ngo Phong',	'phongngonovapo@gmail.com',	'$2b$10$o2K/uXndPOtWQXUdEA5bxuVwkw/gAhYSNhSJpcaV3bPIg1.f1Kt8e',	1,	1,	1,	'2021-11-02 12:41:11',	'2021-11-02 12:41:11',	NULL),
(2,	'Phước',	'kimipu632@gmail.com',	'$2b$10$9uSIaQJJFljZw3gOXgOGBOXFDqsV7v1TwdTabaDxvJZ0Hwh9kvwxm',	1,	1,	1,	'2022-09-26 12:45:11',	'2022-09-26 12:45:11',	NULL),
(3,	'20521751',	'20521751@gm.uit.edu.vn',	'$2b$10$Vah.oRopJNzGzxBFjpKufeaZR26vxCdvIFcR9Vp/T0YJTUWge5fqK',	1,	1,	1,	'2022-09-27 15:13:16',	'2022-09-27 15:13:16',	NULL),
(4,	'nova',	'novapoxperia@gmail.com',	'$2b$10$4Z9y.7X1o90XaFhmAruIVe9gwl1lxRrp5P.Z2ELc8xpm2.MQiZBZG',	1,	1,	1,	'2022-11-03 09:24:53',	'2022-11-03 09:24:53',	NULL);

DROP TABLE IF EXISTS `Tags`;
CREATE TABLE `Tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  UNIQUE KEY `path` (`path`),
  UNIQUE KEY `path_2` (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Tags` (`id`, `name`, `description`, `path`, `createdAt`, `updatedAt`) VALUES
(2,	'filler',	NULL,	'filler',	'2021-11-07 12:38:04',	'2021-11-07 12:38:04'),
(3,	'botox',	NULL,	'botox',	'2021-11-07 12:38:10',	'2021-11-07 12:38:10'),
(4,	'Teoxane',	NULL,	'teoxane',	'2021-11-07 12:38:15',	'2021-11-07 12:38:15'),
(5,	'RHA Serum',	NULL,	'rha-serum',	'2021-11-07 12:38:24',	'2021-11-07 12:38:24'),
(10,	'Microneedling',	NULL,	'microneedling',	'2021-11-07 12:39:15',	'2021-11-07 12:39:15'),
(11,	'Hyacorp',	NULL,	'hyacorp',	'2021-11-07 12:39:26',	'2021-11-07 12:39:26'),
(12,	'threadlift',	NULL,	'threadlift',	'2021-11-07 12:39:34',	'2021-11-07 12:39:34'),
(15,	'BsĐôngPhương',	NULL,	'bs-ong-phuong',	'2021-11-07 12:40:39',	'2021-11-07 12:40:39'),
(16,	'DrĐôngPhương',	NULL,	'dr-ong-phuong',	'2021-11-07 12:40:56',	'2021-11-07 12:40:56'),
(19,	'căng chỉ',	NULL,	'cang-chi',	'2021-11-07 12:41:20',	'2021-11-07 12:41:20'),
(26,	'biến chứng',	NULL,	'bien-chung',	'2021-11-07 12:42:09',	'2021-11-07 12:42:09'),
(63,	'dược mỹ phẩm',	NULL,	'duoc-my-pham',	'2021-11-07 12:47:20',	'2021-11-07 12:47:20'),
(64,	'mỹ phẩm',	NULL,	'my-pham',	'2021-11-07 12:47:26',	'2021-11-07 12:47:26'),
(67,	'tiêm xoá nhăn',	NULL,	'tiem-xoa-nhan',	'2021-11-07 12:48:30',	'2021-11-07 12:48:30'),
(68,	'tiêm tuyến mồ hôi',	NULL,	'tiem-tuyen-mo-hoi',	'2021-11-07 12:48:42',	'2021-11-07 12:48:42'),
(69,	'làm đẹp',	NULL,	'lam-ep',	'2021-11-07 12:50:23',	'2021-11-07 12:50:23'),
(90,	'cream',	NULL,	'cream',	'2021-11-07 12:59:17',	'2021-11-07 12:59:17');

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `role` enum('admin','blogger') COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `about` text COLLATE utf8mb4_unicode_520_ci,
  `description` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username_2` (`username`),
  UNIQUE KEY `email_2` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Users` (`id`, `name`, `username`, `email`, `password`, `role`, `about`, `description`, `avatar`, `createdAt`, `updatedAt`) VALUES
(1,	'Nguyễn Ngọc Đông Phương',	'admin',	'admin@beauti.com',	'$2b$10$Cmcm9S8Xv6tjIlit5/f3Z.0QWGiENUWCb1Wcx2P7MSGwvWCJUMKWK',	'admin',	'<p>Tốt nghiệp Bác sĩ tạo hình thẩm mỹ - Đại học y khoa Phạm Ngọc Thạch, tôi mang trong mình một sứ mệnh đem đến nét đẹp tự nhiên và hài hoà nhất đến với khách hàng của tôi. Với sự dẫn dắt và hướng dẫn tận tâm từ các chuyên gia quốc tế từ Anh, Pháp, Hàn Quốc, Thái Lan, Philippine, tôi đã khắc hoạ được chân dung của cái đẹp theo xu hướng cá nhân hoá trên từng khuôn mặt. Vẫn là bạn đấy, nhưng lại đẹp một cách tinh tế hơn, nhẹ nhàng hơn và đối phương khó có thể quên được nét đẹp đầy sự thanh tao ấy trong những lần gặp gỡ.</p><p>&nbsp;</p><p>Là phụ nữ, hãy luôn yêu bản thân mình đầu tiên, bạn nhé.&nbsp;</p><p>&nbsp;</p><p>Thân thương,</p><p>&nbsp;</p><p>Dr. Đông Phương</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>',	'Bác sĩ Tạo hình - Thẩm mỹ',	'/upload/P1013001-1636815771260.JPG',	'2021-11-02 03:12:32',	'2021-11-26 04:13:49');

-- 2022-12-17 05:26:12