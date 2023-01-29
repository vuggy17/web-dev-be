-- Adminer 4.8.1 MySQL 8.0.31 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

USE `beauti-blog`;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Banners`;
CREATE TABLE `Banners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `media_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` enum('image','cta') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `media_name` (`media_name`),
  CONSTRAINT `Banners_ibfk_1` FOREIGN KEY (`media_name`) REFERENCES `Media` (`filename`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Banners` (`id`, `title`, `content`, `sub_title`, `button_text`, `button_url`, `media_name`, `type`, `createdAt`, `updatedAt`) VALUES
(2,	'Món quà tặng mùa hè giá rẻ mà bạn không thể bỏ qua',	'Việc tặng quà cho khách hàng luôn được xem là một chiến lược thông minh của các doanh nghiệp. Đó là hành động thể hiện sự tri ân chân thành mà bạn muốn gửi đến khách hàng của mình. Hôm nay chúng tôi sẽ giới thiệu cho bạn 10 món quà tặng mùa hè giá rẻ mà bạn không thể bỏ qua.',	'BST hè 2023',	'Tìm hiểu ngay',	'https://unsplash.com/photos/7RQf2X6aXXI',	'raphael-biscaldi-7RQf2X6aXXI-unsplash-1671354793076.jpg',	'cta',	'2021-11-09 09:21:13',	'2022-12-30 00:45:32'),
(3,	'Làm gì khi mùa du lịch tới',	'Những sản phẩm đang hot nhất trong mùa du lịch',	'SUMMER 2023',	'Tìm hiểu ngay',	'#',	'jon-flobrant-lRSChvh1Mhs-unsplash-1671351364629.jpg',	'cta',	'2021-11-09 09:23:19',	'2022-12-30 06:16:32'),
(4,	'Bộ sưu tập lễ hội',	'Món quà khiến nyc quay lại trong vòng 1 nốt nhạc',	'Christmas 2022',	'Tìm hiểu ngay',	'Tìm hiểu ngay',	'photo-1670705881039-2645d2bb1603-1671354275993.jpeg',	'cta',	'2022-12-18 09:04:40',	'2022-12-18 09:04:40');

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
('2022-12-30 06:40:38',	'2022-12-30 06:40:38',	32,	1),
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
('2022-12-30 06:40:38',	'2022-12-30 06:40:38',	32,	9),
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
('2022-12-30 06:40:38',	'2022-12-30 06:40:38',	32,	92);

DROP TABLE IF EXISTS `Blogs`;
CREATE TABLE `Blogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` enum('edit','publish','draft','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'edit',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `last_publish` datetime DEFAULT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
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
(8,	'Dịch Vụ',	'deleted',	'dich-vu',	'{\"time\":1642553181659,\"blocks\":[{\"id\":\"tQWFtaS5Mn\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>*** NỘI KHOA THẨM MỸ</b>\",\"alignment\":\"left\"}},{\"id\":\"jzJoJUdjsS\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"TIÊM TRẺ HOÁ DA MẶT\",\"TIÊM TRẺ HOÁ DA CỔ\",\"TIÊM LÀM ĐẦY THÁI DƯƠNG\",\"TIÊM LÀM ĐẦY TRÁN\",\"TIÊM LÀM ĐẦY VÀ GIẢM THÂM VÙNG MẮT\",\"TIÊM LÀM ĐẦY RÃNH MŨI MÁ\",\"TIÊM TẠO HÌNH DÁI TAI PHONG THUỶ\",\"TIÊM TẠO HÌNH MÔI\",\"TIÊM LÀM ĐẦY CÁC RÃNH NHĂN VÙNG CỔ\",\"TIÊM LÀM ĐẦY BÀN TAY\",\"TIÊM TAO HÌNH MÔNG\",\"TIÊM BOTOX XOÁ NHĂN TRÁN&nbsp;\",\"TIÊM BOTOX XOÁ NHĂN GIAN CUNG MÀY\",\"TIÊM BOTOX XOÁ NHĂN ĐUÔI MẮT\",\"TIÊM ĐIỀU TRỊ CƯỜI HỞ LỢI\",\"TIÊM XOÁ NẾP NHĂN VÙNG CẰM\",\"TIÊM LIFTING MẶT\",\"TIÊM ĐIỀU TRỊ TUYẾN MỒ HÔI VÙNG NÁCH\",\"TIÊM ĐIỀU TRỊ MỒ HÔI BÀN TAY\",\"TIÊM ĐIỀU TRỊ NÁM MÁ\",\"TIÊM TẠO HÌNH VÙNG KÍN - LÀM ĐẦY MÔI LỚN\",\"TIÊM CẤP ẨM VÀ LÀM KHÍT ÂM ĐẠO\",\"CĂNG DA MẶT BẰNG CHỈ\",\"NÂNG CƠ BẰNG CÔNG NGHỆ ULTHERAPY\",\"TRẺ HOÁ DA, XOÁ NHĂN, THON GỌN MẶT BẰNG CÔNG NGHỆ THERMAGE\"]}},{\"id\":\"85wr2xMtUA\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>*** NGOẠI KHOA THẨM MỸ</b>\",\"alignment\":\"left\"}},{\"id\":\"jVMmrkjG7T\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"CẮT MẮT HAI MÍ\",\"NHẤN MẮT HAI MÍ\",\"CẮT DA THỪA MÍ TRÊN\",\"CẮT DA THỪA MÍ DƯỚI\",\"TREO CUNG MÀY\",\"TREO MÍ\",\"TẠO MÁ LÚM ĐỒNG TIỀN\"]}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:18:29',	NULL,	'Filler, Botox và các công nghệ làm đẹp hot nhất hiện nay',	1,	0,	631,	0,	'2021-11-02 05:56:01',	'2022-12-30 06:24:16'),
(9,	'Bài viết mới',	'deleted',	'bai-viet-moi',	'{\"time\":1635843886531,\"blocks\":[{\"id\":\"Yo4Ev_pO24\",\"type\":\"paragraph\",\"data\":{\"text\":\"bài viết mới\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:23:00',	NULL,	'mô tả bài viết ở đây',	1,	1,	47,	1,	'2021-11-02 05:57:25',	'2021-11-02 15:06:00'),
(10,	'Bài viết ghim',	'deleted',	'bai-viet-ghim',	'{\"time\":1635844127378,\"blocks\":[{\"id\":\"dLZHdgnVTq\",\"type\":\"paragraph\",\"data\":{\"text\":\"bài viết ghim\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:29:33',	NULL,	'mô tả bài viết ở đây',	1,	0,	28,	0,	'2021-11-02 09:08:47',	'2021-11-02 15:06:11'),
(11,	'Bài viết có hình ',	'deleted',	'bai-viet-co-hinh',	'{\"time\":1635846403299,\"blocks\":[{\"id\":\"3P3H-IP2rt\",\"type\":\"paragraph\",\"data\":{\"text\":\"bài viết có hình\",\"alignment\":\"left\"}},{\"id\":\"37UNlLZUdF\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/431-900x600-1635843819926.jpg\",\"alt\":\"\"},\"caption\":\"431-900x600-1635843819926.jpg\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:29:35',	NULL,	NULL,	1,	0,	21,	0,	'2021-11-02 09:46:28',	'2021-11-02 15:06:08'),
(12,	'Bài viết',	'deleted',	'bai-viet',	'{\"time\":1635855546681,\"blocks\":[{\"id\":\"DQpokfbsBf\",\"type\":\"paragraph\",\"data\":{\"text\":\"novapo\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-02 14:29:36',	NULL,	NULL,	1,	0,	8,	0,	'2021-11-02 12:19:07',	'2021-11-02 15:06:05'),
(13,	'fsef',	'deleted',	'fsef',	'{\"time\":1635947892862,\"blocks\":[{\"id\":\"y2zxHAOk2Z\",\"type\":\"paragraph\",\"data\":{\"text\":\"fsefesfsef\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-03 13:58:13',	'2021-11-04 07:04:19'),
(14,	'bai viet test',	'deleted',	'bai-viet-test',	'{\"time\":1636297888865,\"blocks\":[{\"id\":\"KWn0GOh1XD\",\"type\":\"paragraph\",\"data\":{\"text\":\"hello\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2021-11-09 15:47:55',	NULL,	NULL,	1,	0,	39,	1,	'2021-11-07 15:11:29',	'2021-11-16 04:08:11'),
(15,	'Hyaluronic Acid và những ứng dụng hiện nay',	'deleted',	'hyaluronic-acid-va-nhung-ung-dung-hien-nay',	'{\"time\":1641564308872,\"blocks\":[{\"id\":\"5LFzM-tFKv\",\"type\":\"paragraph\",\"data\":{\"text\":\"Cụm từ Hyaluronic Acid chắc hẳn không quá xa lạ với chúng ta - đặc biệt là những tín đồ làm đẹp. Nó xuất hiện từ trong các sản phẩm mỹ phẩm dưỡng da cho đến những dịch vụ làm đẹp như tiêm Filler, lăn kim, phi kim vi điểm ... Vậy thì Hyaluronic Acid (HA) là gì và vì sao nó lại được ứng dụng nhiều như vậy, cùng Bác Sĩ Đông Phương tìm hiểu nhé!\",\"alignment\":\"left\"}},{\"id\":\"6zRtp2TyEk\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/How to Tell If Your Pricey Hyaluronic Acid Serum Is Actually Worth It-1636815750661.jpg\",\"alt\":\"\"},\"caption\":\"Hyaluronic Acid&nbsp;\",\"withBorder\":true,\"stretched\":false,\"withBackground\":false}},{\"id\":\"urf5VSzOgM\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Lịch sử về Hyaluronic Acid</b>\",\"alignment\":\"left\"}},{\"id\":\"s1iCUsrSsK\",\"type\":\"paragraph\",\"data\":{\"text\":\"Hyaluronic Acid là một chất được tìm thấy lần đầu tiên trong mắt của bò bởi nhà sinh học Karl Meyer và cộng sự vào năm 1934. Sau đó, các nhà khoa học đã nghiên cứu ra cấu trúc của HA bao gồm 2 chuỗi phân tử đường là D-glucuronic acid và D-N-Acetyl glucosamine. Ứng dụng đầu tiên của HA vào những năm 1950, thuộc chuyên ngành giải phẫu vùng mắt. Và sau đó thì được nghiên cứu, phát triển và ứng dụng rộng rãi vào các chuyên ngành khác, và gần trong những năm gần đây là chuyên ngành Da Liễu - Thẩm mỹ, phân nhánh Chống lão hoá.\",\"alignment\":\"left\"}},{\"id\":\"zlKTlu5s4d\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/Haworth_projection_of_hyaluronan-1641528792791.svg.png\",\"alt\":\"\"},\"caption\":\"cấu trúc Hyaluronic Acid\",\"withBorder\":false,\"stretched\":true,\"withBackground\":false}},{\"id\":\"ODEB2ZpdZG\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Ứng dụng của Hyaluronic Acid</b>\",\"alignment\":\"left\"}},{\"id\":\"tOlGMuEX3F\",\"type\":\"paragraph\",\"data\":{\"text\":\"Ngoài việc ứng dụng làm đẹp rầm rộ trong giai đoạn hiện nay, thì HA còn là một thành phần được ứng dụng điều trị rất tích cực trong nhiều lĩnh vực chăm sóc sức khoẻ khác như:\",\"alignment\":\"left\"}},{\"id\":\"4XxS_GYRw9\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Tái tạo dịch khớp\",\"Nước mắt nhân tạo, điều trị/ phẫu thuật vùng mắt\",\"Hỗ trợ điều trị làm lành vết thương nhanh chóng\",\"Ứng dụng trong các ngành tiết niệu, nghiên cứu ung thư, ...\"]}},{\"id\":\"bZO5phzVXw\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/Biomedical-applications-of-hyaluronic-acid-1641528797473.png\",\"alt\":\"\"},\"caption\":\"Các ứng dụng của HA&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"AR9j8UAddX\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Ứng dụng của HA trong Thẩm mỹ</b>\",\"alignment\":\"left\"}},{\"id\":\"4NpUhf4Vid\",\"type\":\"paragraph\",\"data\":{\"text\":\"HA hiện nay được xem như là một \\\" thần dược\\\", \\\"cứu cánh\\\" cho rất nhiều chị em phụ nữ. Không quá khó để có thể bắt gặp cụm từ HA trên các diễn đàn làm đẹp, các sản phẩm chăm sóc da, các sản phẩm điều trị. Bác sĩ Đông Phương xin tổng kết những ứng dụng mà HA mang lại cho làn da chúng ta trong các sản phẩm bôi và các sản phẩm tiêm điều trị.\",\"alignment\":\"left\"}},{\"id\":\"NHkgvziVBt\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Giữ nước gấp 1000 lần trọng lượng phân tử HA\",\"Làm căng, phẳng các nếp nhăn\",\"Tăng cường sức khoẻ làn da, giúp giảm các dấu hiệu lão hoá như lỗ chân lông to, nếp nhăn li ti\",\"Kết hợp với các acid amin giúp thúc đẩy lại quá trình tái tạo ma trận collagen-elastin-HA\",\"Giúp da sáng, bóng và căng mịn&nbsp;\",\"Tăng độ đàn hồi cho da\",\"Cải thiện sự săn chắc cho da\",\"Củng cố hàng rào bảo vệ của da trước sự tấn công của các tác nhân gây lão hoá như nắng, gió, ...\"]}},{\"id\":\"CA5Stbt7pv\",\"type\":\"paragraph\",\"data\":{\"text\":\"<b>Các cách cung cấp HA cho da</b>\",\"alignment\":\"left\"}},{\"id\":\"G2UHgrClXt\",\"type\":\"paragraph\",\"data\":{\"text\":\"&nbsp;Để da có thể đầy đủ HA, việc bôi các sản phẩm có chứa thành phần HA cũng chưa đủ khi làn da bước sang tuổi 25. Khi đó, việc cung cấp HA sẽ nên thực hiện với các phương pháp như Tiêm vi điểm hoặc Lăn kim vi điểm để đưa HA vào bên trong da, giúp da củng cố lại cấu trúc da, đồng thời tái tạo lại ma trận Collagen - elastin - HA, từ đó giúp da chống lại lão hoá, chống lại các nếp nhăn, và các vấn đề do lão hoá gây ra.\",\"alignment\":\"left\"}},{\"id\":\"V6zHQzgy6V\",\"type\":\"paragraph\",\"data\":{\"text\":\"Mong rằng bài viết trên giúp các bạn có cái nhìn tổng quát nhất về Hyaluronic Acid và các ứng dụng, cũng như hiệu quả mà HA mang lại cho sức khoẻ và sắc đẹp của mình.\",\"alignment\":\"left\"}},{\"id\":\"_RQiimsnEs\",\"type\":\"paragraph\",\"data\":{\"text\":\"Bs. Nguyễn Ngọc Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:18:29',	NULL,	NULL,	1,	0,	556,	0,	'2021-11-13 15:03:00',	'2022-12-30 06:24:06'),
(16,	'Khoá học chuyên sâu về giải phẫu học dành cho bác sĩ tại Thailand - 2018',	'deleted',	'khoa-hoc-chuyen-sau-ve-giai-phau-hoc-danh-cho-bac-si-tai-thailand-2018',	'{\"time\":1637418609853,\"blocks\":[{\"id\":\"QOS_8PYwZO\",\"type\":\"paragraph\",\"data\":{\"text\":\"Là một trong những bác sĩ trẻ được tham dự khoá học Tiêm filler trên xác tươi với sự hướng dẫn của chuyên gia giải phẫu học hàng đầu tại Pháp - Dr. Matt Stefanelli. Bác sĩ Đông Phương đã có dịp tiếp xúc, trao đổi chuyên môn và học tập kinh nghiệm điều trị từ các đồng nghiệp đến từ Nhật Bản, Indonesia trong lớp học iClass được tổ chức tại Thailand. Một trong những chuyến đi đầy trải nghiệm tuyệt vời cùng bạn bè quốc tế.\",\"alignment\":\"left\"}},{\"id\":\"eLK2xNKj9W\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_2798-1636992577109.jpeg\",\"alt\":\"\"},\"caption\":\"Bác sĩ Đông Phương chụp ảnh tại lễ bế giảng lớp học cùng các chuyên gia.\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"ewko5cDJs_\",\"type\":\"paragraph\",\"data\":{\"text\":\"Với sự giảng dạy từ các chuyên gia như Dr. Rungsima Wanitphakdeedecha, Dr. Matt, sự thấu hiểu về giải phẫu vùng mặt một cách chi tiết, đã giúp ích cho việc phát triển về kĩ năng Tạo hình về Filler cũng như thiết kế gương mặt một cách hiệu quả và tinh tế nhất.\",\"alignment\":\"left\"}},{\"id\":\"vbm0kcnXtO\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_2814-1636992577113.jpeg\",\"alt\":\"\"},\"caption\":\"Nhận bằng tốt nghiệp sau khi hoàn thành khoá học.\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"T8Ytzq4b-m\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_9195-1637394745533.jpeg\",\"alt\":\"\"},\"caption\":\"Các bác sĩ đến từ Nhật, Indonesia, Malaysia, Singapore, Philippine, Thailand\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"X0jXWRV0D7\",\"type\":\"paragraph\",\"data\":{\"text\":\"Thailand 26/05/2018\",\"alignment\":\"left\"}},{\"id\":\"v3pceuVePz\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:18:29',	NULL,	NULL,	1,	0,	629,	0,	'2021-11-19 08:33:05',	'2022-12-30 06:24:05'),
(17,	'Lớp phẫu tích trên xác tươi tại Philippine 3/2018',	'deleted',	'lop-phau-tich-tren-xac-tuoi-tai-philippine-3-2018',	'{\"time\":1637331708508,\"blocks\":[{\"id\":\"PsodDEFf8d\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tháng 3 năm 2018, Bs Đông Phương tham dự lớp học chuyên sâu về giải phẫu học vùng mặt tại Philippine với sự hướng dẫn của Chuyên gia giải phẫu học Sebastian Cotofana. Bên cạnh đó, với sự dẫn dắt và hướng dẫn về việc tiêm filler đúng vị trí, tránh được các vùng nguy hiểm trên gương mặt, Bác sĩ Đông Phương đã cập nhật được rất nhiều kiến thức để thực hiện các thủ thuật làm đẹp An Toàn và Hiệu Quả.\",\"alignment\":\"left\"}},{\"id\":\"s10YnxXBNo\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1525-1636992361819.jpg\",\"alt\":\"\"},\"caption\":\"Lớp giải phẫu học cùng chuyên gia giải phẫu học Dr. Sebastian Cotofana\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"QwVPREdJHh\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1607-1636992370165.jpg\",\"alt\":\"\"},\"caption\":\"Khung cảnh lớp học&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"uUKj81ea0N\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1605-1636992370160.jpg\",\"alt\":\"\"},\"caption\":\"Bác sĩ giải phẫu học - Bác sĩ Sebastian Cotofana&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"87XC8QFvaa\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1632-1636992361818.jpg\",\"alt\":\"\"},\"caption\":\"Cùng các Bác sĩ đầu ngành về Filler tại Philippine\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"9El2Hn2Gx2\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1532-1636992361827.jpg\",\"alt\":\"\"},\"caption\":\"Khung cảnh lớp trước khi diễn ra khoá học\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"9YO25v9GCs\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1647-1636992370183.jpg\",\"alt\":\"\"},\"caption\":\"Nhận chứng chỉ sau khi hoàn thành xong lớp học giải phẫu trên xác tươi&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"QiWVrX7FLP\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_2465-1636992395530.jpg\",\"alt\":\"\"},\"caption\":\"Hội nghị da liễu và phẫu thuật tại Philippine 2018\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"67141yJlrQ\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1654-1636992395520.jpg\",\"alt\":\"\"},\"caption\":\"Trường học ở bên ngoài&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"_iJIfcZmVr\",\"type\":\"paragraph\",\"data\":{\"text\":\"Philippine, 1/3/2018\",\"alignment\":\"left\"}},{\"id\":\"q-clLPTzkX\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:18:29',	NULL,	NULL,	1,	0,	619,	0,	'2021-11-19 14:21:48',	'2022-12-30 06:24:04'),
(18,	'Hội nghị Teoxane Expert Day 2016 - Malaysia',	'deleted',	'hoi-nghi-teoxane-expert-day-2016-malaysia',	'{\"time\":1637332798701,\"blocks\":[{\"id\":\"ttIjnaynX3\",\"type\":\"paragraph\",\"data\":{\"text\":\"Vinh dự là một trong những bác sĩ trẻ nhất đoàn được tham dự một hội nghị tầm cỡ Quốc tế về Filler do hãng Teoxane - Một thương hiệu hàng đầu hiện nay về Filler tổ chức tại Malaysia. Không chỉ hoành tráng về mặt tổ chức, Teoxane Expert Day (TED) đã mang lại rất nhiều kiến thức chuyên sâu, bổ ích và đầy tính nghệ thuật trong từng bài giảng của các chuyên gia đến từ Pháp, Vương Quốc Anh, HongKong, Malaysia, Dubai...&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"WoJz98rq2H\",\"type\":\"paragraph\",\"data\":{\"text\":\"Được học và trải nghiệm dòng sản phẩm Filler&nbsp;cao cấp đến từ Thuỵ Sĩ - Teoxane - ngay khi vừa ra trường là một trong những bước ngoặt lớn nhất và đáng nhớ nhất của Bs. Đông Phương.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"9EWyYrfqLr\",\"type\":\"paragraph\",\"data\":{\"text\":\"Cùng nhìn lại một số hình ảnh trong chuyến đi này với Bs. Phương nhé.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"KdCjUlpGia\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_075701-1636992261244.jpg\",\"alt\":\"\"},\"caption\":\"Check in tại sảnh tiếp đón\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"suNXAyKRZL\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_065013-1636992261239.jpg\",\"alt\":\"\"},\"caption\":\"Kỉ niệm cùng Dr. Kieren Bong - Chuyên gia hàng đầu đến từ Anh Quốc\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"UlCzPZjVow\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_134015-1636992284931.jpg\",\"alt\":\"\"},\"caption\":\"Cùng Dr. Kieren Bong và Bs Thuý Anh&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"cBA0_8y9ve\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_224253-1636992284948.jpg\",\"alt\":\"\"},\"caption\":\"Cùng với Dr. Hassan Galadari - Chuyên gia đến từ Dubai, và đại diện công ty Teoxane, công ty Grassroots\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"NFz9kI2z7v\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_081512-1636992261235.jpg\",\"alt\":\"\"},\"caption\":\"Trải nghiệm bút tiêm tự động - tiêm không đau và làm cho vùng tiêm đẹp hơn và mềm mại hơn\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"NDEQXygtbk\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160604_081448-1636992261231.jpg\",\"alt\":\"\"},\"caption\":\"Trải nghiệm bút tiêm trên mô hình\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"CJ2c32Nlgz\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/20160606_132622-1636992284943.jpg\",\"alt\":\"\"},\"caption\":\"Thẻ đeo tham dự hội nghị TED 2016\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"2kpfaBVzbS\",\"type\":\"paragraph\",\"data\":{\"text\":\"Malaysia, 5/2016\",\"alignment\":\"left\"}},{\"id\":\"FXqKh9XtRI\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:18:29',	NULL,	NULL,	1,	0,	605,	0,	'2021-11-19 14:39:56',	'2022-12-30 06:24:02'),
(19,	'Hướng dẫn tiêm Filler - Bệnh viện Phong Da liễu Trung ương Quy Hoà ',	'deleted',	'huong-dan-tiem-filler-benh-vien-phong-da-lieu-trung-uong-quy-hoa',	'{\"time\":1637333707819,\"blocks\":[{\"id\":\"y5ZcdKwxkW\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tháng 6/2019, Bs Đông Phương có dịp đến Bệnh viện Phong - Da Liễu Trung Ương Quy Hoà, Quy Nhơn, Bình Định để chia sẻ về phương pháp tiếp cận bệnh nhân và các phương pháp tiêm Filler hiện nay cho các chỉ định như: Tiêm Filler vùng Rãnh lệ điều trị Trũng mắt và Thâm Quầng Mắt, Tiêm Filler rãnh mũi má, ... và Tiêm Botox xoá nhăn - với sự đồng hàng của nhãn hàng Teoxane và Beautem.Bs. Phương rất vui vì có sự tham dự của Giám đốc bệnh viện, trưởng khoa phẫu thuật da và được trả lời những câu hỏi về chuyên môn đến từ các bác sĩ tham dự.&nbsp;Cùng xem những khoảnh khắc đáng nhớ này với Bs. Đông Phương nhé. &lt;3&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"Nba2xNONlm\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1644-1636992634390.JPG\",\"alt\":\"\"},\"caption\":\"Tiêm Botulinum Toxin Type A ( Beautem - Daewoong)&nbsp;\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"or7BNMfZ5D\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1619-1636992624185.JPG\",\"alt\":\"\"},\"caption\":\"\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"An9OwW1iml\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1622-1636992624192.JPG\",\"alt\":\"\"},\"caption\":\"Demo cách tiêm cho các bác sĩ xem\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"MphKNjUkSk\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1623-1636992624197.JPG\",\"alt\":\"\"},\"caption\":\"Tiêm Filler vùng rãnh lệ - giúp làm giảm thâm quầng mắt và giảm trũng mắt\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"23S-DB1E3t\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/IMG_1621-1636992624181.JPG\",\"alt\":\"\"},\"caption\":\"Tiêm Filler Teoxane cho vùng mắt\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"11NwjBAudN\",\"type\":\"paragraph\",\"data\":{\"text\":\"Quy Nhơn, Bình Định 6/2019\",\"alignment\":\"left\"}},{\"id\":\"QXoUsXlAez\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dr. Đông Phương\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:18:29',	NULL,	NULL,	1,	0,	611,	0,	'2021-11-19 14:55:07',	'2022-12-30 06:24:00'),
(20,	'Chống nắng và những điều cần lưu ý',	'draft',	'chong-nang-va-nhung-ieu-can-luu-y',	'{\"time\":1637418628158,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-20 14:30:28',	'2021-11-20 14:30:28'),
(21,	'Chống nắng nội sinh và những thông tin cần lưu ý',	'draft',	'chong-nang-noi-sinh-va-nhung-thong-tin-can-luu-y',	'{\"time\":1637419560409,\"blocks\":[{\"id\":\"y_37MVuRcZ\",\"type\":\"paragraph\",\"data\":{\"text\":\"Chống nắng - là một điều chắc hẳn tất cả mọi người, đặc biệt là những tín đồ Skincare đã không còn quá xa lạ và gần như là một bước rất quan trọng - không thể quên trong chu trình chăm sóc da mỗi ngày.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"tOvT527a0E\",\"type\":\"paragraph\",\"data\":{\"text\":\"Việc thoa chống nắng theo hướng dẫn của bác sĩ, các chuyên gia da liễu bao gồm: thoa chống nắng ngày 2 - 3 lần, &nbsp;trước khi ra nắng 15 - 30 phút, che chắn với Khẩu trang, Nón, Ô ... là điều mà ai cũng đã biết. Nhưng liệu với tất cả những điều đó đã có đủ khả năng bảo vệ làn da trước sự tấn công của các tác nhân gây lão hoá da như Nắng, Không khí ô nhiễm, Nước bẩn, và Stress ?!!!\",\"alignment\":\"left\"}},{\"id\":\"MEoj_mmwub\",\"type\":\"paragraph\",\"data\":{\"text\":\"Câu trả lời là KHÔNG ĐỦ!!\",\"alignment\":\"left\"}},{\"id\":\"qErsuBtPMO\",\"type\":\"paragraph\",\"data\":{\"text\":\"Dưỡng da và thoa chống nắng chỉ có tác dụng trên bề mặt da tại vùng được thoa, và rất dễ bị mất tác dụng nhanh chóng khi hoạt động ngoài trời, nhất là với cái nắng của Việt Nam hiện nay, khiến cho việc bảo vệ da trở nên khó khăn hơn. Tuy nhiên, cách đây khoảng&nbsp;\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-11-20 14:46:00',	'2021-11-20 14:46:00'),
(22,	'a',	'deleted',	'a',	'{\"time\":1639066021152,\"blocks\":[{\"id\":\"FwCAeIH_pJ\",\"type\":\"paragraph\",\"data\":{\"text\":\"A\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-12-09 16:07:02',	'2021-12-09 16:07:39'),
(23,	'test',	'deleted',	'test',	'{\"time\":1639123072866,\"blocks\":[{\"id\":\"xAyGZFB4ae\",\"type\":\"paragraph\",\"data\":{\"text\":\"kakaka\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2021-12-10 07:57:53',	'2021-12-10 07:58:02'),
(24,	'CÁCH CHĂM SÓC BÀN TAY - CHỐNG LẠI DẤU HIỆU LÃO HOÁ',	'draft',	'cach-cham-soc-ban-tay-chong-lai-dau-hieu-lao-hoa',	'{\"time\":1641564508536,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:08:28',	'2022-01-07 14:08:28'),
(25,	'TRẺ HOÁ VÙNG KÍN - VẤN ĐỀ NHẠY CẢM NHƯNG VÔ CÙNG QUAN TRỌNG',	'draft',	'tre-hoa-vung-kin-van-e-nhay-cam-nhung-vo-cung-quan-trong',	'{\"time\":1641564545029,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:09:05',	'2022-01-07 14:09:05'),
(26,	'CÁC LOẠI NƯỚC DETOX CHO LÀN DA KHOẺ ĐẸP',	'draft',	'cac-loai-nuoc-detox-cho-lan-da-khoe-ep',	'{\"time\":1641564567409,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:09:27',	'2022-01-07 14:09:27'),
(27,	'10 CÁCH ĐỂ GIÚP CHO CUỘC SỐNG CÂN BẰNG',	'draft',	'10-cach-e-giup-cho-cuoc-song-can-bang',	'{\"time\":1641564626096,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	'Giữ cho thân tâm luôn an lạc, bạn đã thử những cách này chưa?',	1,	0,	0,	0,	'2022-01-07 14:10:26',	'2022-01-18 16:30:27'),
(28,	'LÀM ĐẸP VỚI CHANH - BẠN ĐÃ BIẾT CHƯA?',	'draft',	'lam-ep-voi-chanh-ban-a-biet-chua',	'{\"time\":1641564652034,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	'Chanh không chỉ để vắt nước uống, mà còn vô số công dụng xịn xò cần bạn tìm hiểu và áp dụng ngay đấy. Cùng Bs. Đông Phương tìm hiểu nhé!',	1,	0,	0,	0,	'2022-01-07 14:10:52',	'2022-01-18 16:31:32'),
(29,	'CHẤT LÀM ĐẦY ( FILLER) VÀ ỨNG DỤNG ',	'draft',	'chat-lam-ay-filler-va-ung-dung',	'{\"time\":1641564842785,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	'Giải oan cho Filler, những thông tin cực kì bổ ích và khoa học đang đợi bạn khám phá. Tìm hiểu cùng Bs. Đông Phương nhé.',	1,	0,	0,	0,	'2022-01-07 14:14:02',	'2022-01-18 16:32:54'),
(30,	'BOTOX ( BOTULINUM TOXIN) VÀ NHỮNG ỨNG DỤNG TRONG ĐIỀU TRỊ',	'draft',	'botox-botulinum-toxin-va-nhung-ung-dung-trong-ieu-tri',	'{\"time\":1641564884651,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:14:44',	'2022-01-07 14:14:44'),
(31,	'LÃO HOÁ VÙNG MẮT - ĐỪNG ĐỂ ĐÔI MẮT TỐ CÁO TUỔI CỦA BẠN',	'draft',	'lao-hoa-vung-mat-ung-e-oi-mat-to-cao-tuoi-cua-ban',	'{\"time\":1641565012423,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:16:52',	'2022-01-07 14:16:52'),
(32,	'Tổng hợp 30+ quà Noel (Giáng sinh) cho mọi lứa tuổi cực độc đáo và ấm áp',	'publish',	'oi-ieu-ve-viec-chong-lao-hoa',	'{\"time\":1672382438743,\"blocks\":[{\"id\":\"s1f-ju7Hn_\",\"type\":\"paragraph\",\"data\":{\"text\":\"Khi cái lạnh ùa về, khi mọi nẻo đường được thắp sáng và ngân vang bài ca Jingle Bell, là ta biết một mùa Giáng Sinh nữa lại về. Trong không khí rạo rực ấy, hãy cùng nhau tìm kiếm những món quà Noel độc đáo, ấm áp nhất cho bạn bè, người thân yêu của mình nhé!\",\"alignment\":\"left\"}},{\"id\":\"QfCxpe-e_8\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/qua-noel-cho-moi-lua-tuoi-1672370941197.jpg\",\"alt\":\"\"},\"caption\":\"Quà noel cho mọi lứa tuổi\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"xeaDYFj_cC\",\"type\":\"header\",\"data\":{\"text\":\"1. Đồng hồ đeo tay - Quà giáng sinh đẹp cho mọi lứa tuổi\",\"level\":2}},{\"id\":\"4cbui0aJCS\",\"type\":\"paragraph\",\"data\":{\"text\":\"Thời gian không chờ đợi một ai và thời gian cũng là thứ một khi đã đi qua sẽ không bao giờ lấy lại được. Tặng&nbsp;<a href=\\\"https://galle.vn/\\\">đồng hồ đeo tay</a>&nbsp;trong dịp Noel cũng là cách nhắc nhở đối phương biết trân trọng từng khoảnh khắc bên nhau. Và món quà ấy sẽ phù hợp cho mọi lứa tuổi, giới tính và sở thích.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"BdRfPjRmCE\",\"type\":\"paragraph\",\"data\":{\"text\":\"Ngoài ra, đồng hồ đeo tay ngày nay đã trở thành món phụ kiện thời thượng không thể thiếu trong tủ đồ của bất cứ ai. Do đó, chọn đồng hồ làm quà bạn sẽ không phải lo lắng về việc người ấy có thích hay không. Món quà này còn có thể sử dụng trong 5 - 10 năm tiếp theo mà chẳng hề lỗi mốt.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"FnJpWrLZb2\",\"type\":\"paragraph\",\"data\":{\"text\":\"Nếu bạn còn băn khoăn về việc chọn mẫu mã, thiết kế, hãy đến với Galle Watch, chúng tôi sẽ giúp bạn tìm được một chiếc phù hợp nhất.\",\"alignment\":\"left\"}},{\"id\":\"kwah5Bk1PA\",\"type\":\"header\",\"data\":{\"text\":\"2. Thiệp Handmade - Quà Giáng Sinh ý nghĩa&nbsp;\",\"level\":2}},{\"id\":\"sIzWq8XZ1y\",\"type\":\"paragraph\",\"data\":{\"text\":\"Thiệp Giáng Sinh là món quà truyền thống, tuy nhỏ bé về vật chất nhưng lại giàu tình cảm khi chúng ta tận tay làm và ghi lên đó những lời chúc ý nghĩa và vui tươi. Dù bên ngoài có bán bao nhiêu mẫu thiệp đẹp mắt đi nữa, cũng chẳng thể độc đáo bằng chiếc thiệp mang màu sắc của chính bạn.\",\"alignment\":\"left\"}},{\"id\":\"iOgCeiXLWb\",\"type\":\"paragraph\",\"data\":{\"text\":\"Đây sẽ là gợi ý tuyệt vời cho những ai chưa biết chọn quà Noel. Và nếu có thể, hãy gửi tặng một chiếc thiệp kèm theo một món quà độc đáo khác nhé!\",\"alignment\":\"left\"}},{\"id\":\"0RMHTUVLgT\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/qua-noel-thiep-handmade-1672371224975.jpg\",\"alt\":\"\"},\"caption\":\"Một vài chiếc thiệp xinh xắn làm quà Giáng Sinh\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"ibHLTzoPaa\",\"type\":\"header\",\"data\":{\"text\":\"3. Khăn quàng ấm áp - Quà Noel cho người yêu\",\"level\":2}},{\"id\":\"E7--RS1AAW\",\"type\":\"paragraph\",\"data\":{\"text\":\"Chúng ta thường bảo nhau rằng, cứ thấy cái lạnh là thấy Noel và từ đó món quà đậm chất ấm áp như chiếc khăn len quàng cổ ngày càng được lựa chọn nhiều hơn. Các cặp đôi cũng thường tặng nhau món quà này, để thay cho chính mình, ủ ấm cho người yêu trong mùa đông giá rét. Và nếu bạn có thể chọn một chiếc khăn có màu sắc, thiết kế phù hợp với phong cách của người ấy thì còn gì tuyệt vời hơn\",\"alignment\":\"left\"}},{\"id\":\"Ek3K-Mnnqb\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/qua-giang-sinh-khan-quang-1672371244675.jpg\",\"alt\":\"\"},\"caption\":\"Một chiếc khăn đỏ họa tiết đặc trưng cho mùa Noel\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"OcpbIoYxL3\",\"type\":\"header\",\"data\":{\"text\":\"4. Đồ đôi - Quà Noel ý nghĩa\",\"level\":2}},{\"id\":\"FdLL9ujzsU\",\"type\":\"paragraph\",\"data\":{\"text\":\"Những cặp đôi yêu nhau thường có xu hướng “đánh dấu chủ quyền” với một nửa của mình. Giáng sinh chính là thời điểm lý tưởng để bạn tặng cho anh ấy/cô ấy một cặp áo đôi, giày đôi hoặc bạn hãy thử chọn một bộ đồ nỉ thể thao ấm áp, thậm chí là đồ ngủ, đều sẽ khiến người ấy thích thú hơn đấy! Đừng quên tìm hiểu trước về size quần áo cùng như giày trước khi mua nhé!\",\"alignment\":\"left\"}},{\"id\":\"_SYpySxd8F\",\"type\":\"customImage\",\"data\":{\"file\":{},\"caption\":\"\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"l7DGixTh1d\",\"type\":\"header\",\"data\":{\"text\":\"5. Bánh ngọt - Quà Noel cho crush\",\"level\":2}},{\"id\":\"K0oGQ8nVyv\",\"type\":\"paragraph\",\"data\":{\"text\":\"Hãy tạo cho người bạn thầm thương trộm nhớ một bất ngờ nho nhỏ vào lễ Giáng Sinh, bằng cách tặng cô ấy/anh ấy một chiếc bánh ngọt ngào, có thể là vị chocolate, trang trí thêm các hoạ tiết cây thông, người tuyết, ông già noel,...đều rất tuyệt vời. Ngoài ra, bạn cũng có thể tự tay làm một chiếc bánh của riêng mình, dù không được đẹp như ngoài quán nhưng đủ để thể hiện được tình yêu chân thành dành cho người ấy.\",\"alignment\":\"left\"}},{\"id\":\"Wm2F8HdfcG\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/qua-giang-sinh-banh-ngot-1672371272635.jpg\",\"alt\":\"\"},\"caption\":\"Một chiếc bánh ngọt được trang trí lạ mắt cho mùa Giáng Sinh\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"Ad6tfVWK5T\",\"type\":\"header\",\"data\":{\"text\":\"&nbsp;6. Gấu bông - Quà Noel cho bé\",\"level\":2}},{\"id\":\"vAiaRXrTTz\",\"type\":\"paragraph\",\"data\":{\"text\":\"Một chú gấu bông xinh xắn, đáng yêu sẽ khiến cho các bé vô cùng thích thú. Món quà này sẽ thay bạn ở bên con khi ở nhà, khi đến trường, cùng con chơi vui vẻ mỗi ngày, tận hưởng tuổi thơ sẽ chẳng bao giờ quay trở lại. Hiện nay trên thị trường có rất nhiều mẫu mã gấu bông khác nhau, kích thước đủ loại, tùy vào độ tuổi và sở thích của bé để chọn món quà phù hợp.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"7yipzwrQI_\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/qua-giang-sinh-gau-bong-1672371358990.jpg\",\"alt\":\"\"},\"caption\":\"Một vài chú gấu bông ngộ nghĩnh dành tặng cho các bé trong ngày lễ Giáng Sinh\",\"withBorder\":false,\"stretched\":false,\"withBackground\":false}},{\"id\":\"1I4mF8Aw4k\",\"type\":\"paragraph\",\"data\":{\"text\":\"Noel là ngày lễ lớn nhất trong năm của người phương Tây và cũng là ngày lễ được các bạn trẻ trên khắp thế giới mong chờ. Hãy tận dụng cơ hội này để gửi gắm tình yêu, sự quan tâm đặc biệt của mình đến những người bạn yêu thương và một vài món quà Noel được gợi ý ở trên sẽ đồng hành cùng với bạn. Chúc bạn có một mùa Giáng Sinh đáng nhớ!\",\"alignment\":\"left\"}},{\"id\":\"RnIPNt_2f_\",\"type\":\"paragraph\",\"data\":{\"text\":\"Để được tư vấn vui lòng inbox Zalo: <b>0252651458 </b>bạn nhé\",\"alignment\":\"left\"}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:41:17',	'photo-1670705881039-2645d2bb1603-1671354275993.jpeg',	'Khi cái lạnh ùa về, khi mọi nẻo đường được thắp sáng và ngân vang bài ca Jingle Bell, là ta biết một mùa Giáng Sinh nữa lại về. Trong không khí rạo rực ấy, hãy cùng nhau tìm kiếm những món quà Noel độc đáo, ấm áp nhất cho bạn bè, người thân yêu của mình nhé!',	1,	1,	514,	1,	'2022-01-07 14:17:14',	'2022-12-30 06:41:17'),
(33,	'LÀM ĐẸP VỚI DẦU DỪA ',	'draft',	'lam-ep-voi-dau-dua',	'{\"time\":1641565061354,\"blocks\":[],\"version\":\"2.22.2\"}',	0,	NULL,	NULL,	NULL,	1,	0,	0,	0,	'2022-01-07 14:17:41',	'2022-01-07 14:17:41'),
(34,	'[Kết quả] Tiêm filler vùng Trũng má - Rãnh lệ / Case 01',	'deleted',	'ket-qua-tiem-filler-vung-trung-ma-ranh-le-case-01',	'{\"time\":1667157148327,\"blocks\":[{\"id\":\"DBUAi8_9qx\",\"type\":\"paragraph\",\"data\":{\"text\":\"Với xu hướng làm đẹp hiện nay thì việc sử dụng các chất làm đầy đưa vào cơ thể - đặc biệt là vùng mặt đã không còn quá xa lạ với mọi người.&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"uLj8OdUIQQ\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tuy nhiên để hiểu rõ hơn về công dụng cũng như là kết quả sau khi thực hiện, mời các bạn xem qua những thông tin trong bài viết này.\",\"alignment\":\"left\"}},{\"id\":\"e4unp1kx3g\",\"type\":\"paragraph\",\"data\":{\"text\":\"Case Study:\",\"alignment\":\"left\"}},{\"id\":\"jsoPaQ53bD\",\"type\":\"paragraph\",\"data\":{\"text\":\"Khách hàng Nam giới, quốc tịch Anh, 34 tuổi, công việc có nhiều stress và thường hay thức khuya làm việc. Khách hàng đến với Bs. Đông Phương vì cảm thấy phiền lòng bởi tình trạng mắt bị thâm quầng, làm cho gương mặt cảm thấy mệt mỏi - thiếu sức sống, kém hấp dẫn và trông già hơn so với tuổi.\",\"alignment\":\"left\"}},{\"id\":\"KCELIMEby2\",\"type\":\"paragraph\",\"data\":{\"text\":\"Qua thăm khám và đánh giá, bác sĩ Đông Phương đưa ra những vấn đề sau:\",\"alignment\":\"left\"}},{\"id\":\"g6cn3VKDS2\",\"type\":\"paragraph\",\"data\":{\"text\":\"Tình trạng trước tiêm:&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"iDCHGsn7fY\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Hình thái bên ngoài: Trũng rãnh lệ, Trũng vùng má ngoài - ổ mắt, Trũng vùng Má giữa\",\"Cấu trúc bên trong: Phì đại túi mỡ dưới ổ mắt, giảm thể tích mỡ vùng má trung tâm, cơ vòng mi kém độ săn chắc - đàn hồi.\"]}},{\"id\":\"DPKRNdxNb1\",\"type\":\"paragraph\",\"data\":{\"text\":\"Hướng xử trí: Tiêm chất làm đầy ( filler) vào vùng rãnh lệ ( Tear-trough), vùng má trung tâm ( mid-cheek), và vùng má ngoài - ổ mắt&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"ZLp4rBlndc\",\"type\":\"paragraph\",\"data\":{\"text\":\"Thuốc tiêm được sử dụng: Teoxane - Teosyal Redensity 2 và Teosyal RHA3 ( link FDA Approved:&nbsp;https://www.accessdata.fda.gov/scripts/cdrh/devicesatfda/index.cfm?db=pma&amp;id=400854)\",\"alignment\":\"left\"}},{\"id\":\"HJuxe3Mtth\",\"type\":\"paragraph\",\"data\":{\"text\":\"Kết quả sau thực hiện:\",\"alignment\":\"left\"}},{\"id\":\"rG_0I72s0z\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"Vẻ ngoài: Gương mặt tươi trẻ hơn sau khi thực hiện điều trị - da vùng mắt sáng, hết thâm quầng\",\"Cải thiện các rãnh trũng sâu: Rãnh lệ - Rãnh má ngoài - ổ mắt và tái tạo lại thể tích vùng má giữa\"]}},{\"id\":\"w-u9f4XHIH\",\"type\":\"paragraph\",\"data\":{\"text\":\"Kết quả có thể kéo dài từ 15- 24 tháng - tuỳ thuộc vào sự chăm sóc hằng ngày của khách hàng.\",\"alignment\":\"left\"}},{\"id\":\"swC22R1ilH\",\"type\":\"customImage\",\"data\":{\"file\":{\"url\":\"/upload/525B3463-8D10-4889-952A-B54437508ED9 2-1667155005515.JPEG\",\"alt\":\"\"},\"caption\":\"Bệnh nhân Nam - 34 tuổi - Quốc tịch Mỹ - Filler vùng má - rãnh lệ\",\"withBorder\":false,\"stretched\":false,\"withBackground\":true}},{\"id\":\"7VWxFxxfHs\",\"type\":\"paragraph\",\"data\":{\"text\":\"Bác sĩ Nguyễn Ngọc Đông Phương\",\"alignment\":\"left\"}},{\"id\":\"bGWc29wjep\",\"type\":\"paragraph\",\"data\":{\"text\":\"Đặt hẹn qua:&nbsp;\",\"alignment\":\"left\"}},{\"id\":\"IqJx1RUR2h\",\"type\":\"list\",\"data\":{\"style\":\"unordered\",\"items\":[\"Web:&nbsp;https://wesapp.vn/clinic/116/atp-medical-clinic\",\"Số điện thoại: 0943993665 ( zalo - viber - whatsapp)\",\"Email: drdphuong@gmail.com\",\"Facebook:&nbsp;https://www.facebook.com/drdongphuong&nbsp;\"]}}],\"version\":\"2.22.2\"}',	0,	'2022-12-30 06:18:29',	NULL,	'Điều trị giảm thâm quầng mắt - trũng rãnh lệ, rãnh má ổ mắt',	1,	0,	45,	0,	'2022-10-30 18:47:21',	'2022-12-30 06:23:58');

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `allow_sub` tinyint(1) DEFAULT '1',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `Categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `Categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Categories` (`id`, `name`, `description`, `parent_id`, `allow_sub`, `path`, `order`, `createdAt`, `updatedAt`) VALUES
(1,	'Quà giáng sinh',	NULL,	NULL,	0,	'qua-giang-sinh',	'0|y00000:',	'2021-11-02 03:12:32',	'2022-12-30 03:47:16'),
(8,	'Uncategorized',	NULL,	NULL,	0,	'uncategorized',	'0|zzzzzz:',	'2022-12-18 06:10:03',	'2022-12-18 06:10:03');

DROP TABLE IF EXISTS `Comments`;
CREATE TABLE `Comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_show` tinyint(1) DEFAULT '0',
  `blog_id` int NOT NULL,
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
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
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `filetype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `filesize` float DEFAULT NULL,
  `uploadBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `filename_2` (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Media` (`id`, `title`, `url`, `filename`, `filetype`, `alt`, `filesize`, `uploadBy`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(115,	'jon-flobrant-lRSChvh1Mhs-unsplash-1671351364629.jpg',	'/upload/jon-flobrant-lRSChvh1Mhs-unsplash-1671351364629.jpg',	'jon-flobrant-lRSChvh1Mhs-unsplash-1671351364629.jpg',	'image/jpeg',	'',	3125370,	'admin_duy',	'2022-12-18 08:16:04',	'2022-12-18 08:16:04',	NULL),
(116,	'albert-dera-ILip77SbmOE-unsplash-1671352396675.jpg',	'/upload/albert-dera-ILip77SbmOE-unsplash-1671352396675.jpg',	'albert-dera-ILip77SbmOE-unsplash-1671352396675.jpg',	'image/jpeg',	'',	2413830,	'admin_duy',	'2022-12-18 08:33:16',	'2022-12-30 06:45:57',	'2022-12-30 06:45:57'),
(117,	'photo-1670705881039-2645d2bb1603-1671354275993.jpeg',	'/upload/photo-1670705881039-2645d2bb1603-1671354275993.jpeg',	'photo-1670705881039-2645d2bb1603-1671354275993.jpeg',	'image/jpeg',	'',	276908,	'admin_duy',	'2022-12-18 09:04:36',	'2022-12-18 09:04:36',	NULL),
(118,	'raphael-biscaldi-7RQf2X6aXXI-unsplash-1671354793076.jpg',	'/upload/raphael-biscaldi-7RQf2X6aXXI-unsplash-1671354793076.jpg',	'raphael-biscaldi-7RQf2X6aXXI-unsplash-1671354793076.jpg',	'image/jpeg',	'',	896773,	'admin_duy',	'2022-12-18 09:13:13',	'2022-12-18 09:13:13',	NULL),
(119,	'qua-noel-cho-moi-lua-tuoi-1672370941197.jpg',	'/upload/qua-noel-cho-moi-lua-tuoi-1672370941197.jpg',	'qua-noel-cho-moi-lua-tuoi-1672370941197.jpg',	'image/jpeg',	'',	158215,	'admin_duy',	'2022-12-30 03:29:01',	'2022-12-30 03:29:01',	NULL),
(120,	'qua-noel-thiep-handmade-1672371224975.jpg',	'/upload/qua-noel-thiep-handmade-1672371224975.jpg',	'qua-noel-thiep-handmade-1672371224975.jpg',	'image/jpeg',	'',	66581,	'admin_duy',	'2022-12-30 03:33:44',	'2022-12-30 03:33:44',	NULL),
(121,	'qua-giang-sinh-khan-quang-1672371244675.jpg',	'/upload/qua-giang-sinh-khan-quang-1672371244675.jpg',	'qua-giang-sinh-khan-quang-1672371244675.jpg',	'image/jpeg',	'',	70434,	'admin_duy',	'2022-12-30 03:34:04',	'2022-12-30 03:34:04',	NULL),
(122,	'qua-giang-sinh-banh-ngot-1672371272635.jpg',	'/upload/qua-giang-sinh-banh-ngot-1672371272635.jpg',	'qua-giang-sinh-banh-ngot-1672371272635.jpg',	'image/jpeg',	'',	82362,	'admin_duy',	'2022-12-30 03:34:32',	'2022-12-30 03:34:32',	NULL),
(123,	'qua-giang-sinh-gau-bong-1672371358990.jpg',	'/upload/qua-giang-sinh-gau-bong-1672371358990.jpg',	'qua-giang-sinh-gau-bong-1672371358990.jpg',	'image/jpeg',	'',	95945,	'admin_duy',	'2022-12-30 03:35:58',	'2022-12-30 03:35:58',	NULL),
(124,	'z3999942963211_428b234432729448fc7cddce9e734f42-1672371915594.jpg',	'/upload/z3999942963211_428b234432729448fc7cddce9e734f42-1672371915594.jpg',	'z3999942963211_428b234432729448fc7cddce9e734f42-1672371915594.jpg',	'image/jpeg',	'',	1319150,	'admin_duy',	'2022-12-30 03:45:15',	'2022-12-30 03:45:15',	NULL),
(125,	'Nhu-Y-3-1672381536067.png',	'/upload/Nhu-Y-3-1672381536067.png',	'Nhu-Y-3-1672381536067.png',	'image/png',	'',	1303260,	'admin_duy',	'2022-12-30 06:25:36',	'2022-12-30 06:25:36',	NULL);

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
(9,	0,	7,	1,	200000,	0,	'2022-12-30 06:28:51',	'2022-12-30 06:28:51'),
(9,	0,	8,	1,	200000,	0,	'2022-12-30 07:48:10',	'2022-12-30 07:48:10');

DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `customer_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `product_money` float DEFAULT NULL,
  `promotion_money` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `status` enum('pending','shipping','success','cancel','confirm') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'pending',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `handle_note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `mail_confirm` tinyint(1) DEFAULT '0',
  `mail_shipping` tinyint(1) DEFAULT '0',
  `invoice_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Orders` (`id`, `phone`, `customer_email`, `customer_name`, `address`, `product_money`, `promotion_money`, `total`, `status`, `note`, `handle_note`, `mail_confirm`, `mail_shipping`, `invoice_name`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(7,	'0869256174',	'duyvu17052001@gmail.com',	'dsa',	'dsad, Xã Song Vân, Huyện Tân Yên, Tỉnh Bắc Giang',	200000,	0,	200000,	'pending',	NULL,	NULL,	0,	0,	NULL,	'2022-12-30 06:28:51',	'2022-12-30 06:28:51',	NULL),
(8,	'0869256174',	'duyvu17052001@gmail.com',	'dsa',	'dsad, Xã Lan Giới, Thành phố Bắc Giang, Thành phố Hà Nội',	200000,	0,	200000,	'shipping',	NULL,	NULL,	0,	0,	'81672386523027.pdf',	'2022-12-30 07:48:10',	'2022-12-30 07:49:11',	NULL);

DROP TABLE IF EXISTS `ProductCategories`;
CREATE TABLE `ProductCategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `allow_sub` tinyint(1) DEFAULT '1',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `ProductCategories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `ProductCategories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `ProductCategories` (`id`, `name`, `description`, `parent_id`, `allow_sub`, `path`, `order`, `createdAt`, `updatedAt`) VALUES
(6,	'Quà tết 2023',	NULL,	NULL,	1,	'qua-tet-2023',	'0|xzzzzg:',	'2021-11-02 15:07:20',	'2022-12-30 03:42:05'),
(7,	'Quà giáng sinh',	NULL,	NULL,	1,	'qua-giang-sinh',	'0|xzzzzk:',	'2021-11-02 15:07:33',	'2022-12-30 03:41:50'),
(8,	'Các sản phẩm khác',	NULL,	NULL,	1,	'cac-san-pham-khac',	'0|xzzzzc:',	'2021-11-02 15:07:57',	'2021-11-02 15:08:11');

DROP TABLE IF EXISTS `ProductVariants`;
CREATE TABLE `ProductVariants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
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
('2022-12-30 06:23:33',	'2022-12-30 06:23:33',	119,	9),
('2022-12-30 06:23:33',	'2022-12-30 06:23:33',	120,	9),
('2022-12-30 06:23:33',	'2022-12-30 06:23:33',	121,	9),
('2022-12-30 06:23:33',	'2022-12-30 06:23:33',	122,	9),
('2022-12-30 06:26:42',	'2022-12-30 06:26:42',	125,	10);

DROP TABLE IF EXISTS `Products`;
CREATE TABLE `Products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `rating` float NOT NULL DEFAULT '0',
  `category_id` int DEFAULT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `price` float DEFAULT '0',
  `view` int DEFAULT '0',
  `is_on_sale` tinyint(1) DEFAULT '0',
  `discount` float DEFAULT '0',
  `SKU` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_track_inventory` tinyint(1) DEFAULT '0',
  `is_in_stock` tinyint(1) DEFAULT '1',
  `is_publish` tinyint(1) DEFAULT '1',
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `shipping_infor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `return_infor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `manual_infor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `brand_infor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
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
(1,	'sản phẩm 1-deleted-1636984015233',	'mô tả ngắn',	'san-pham-1-deleted-1636984015233',	0,	NULL,	'/upload/971-500x500-1635846653858.jpg',	200000,	0,	1,	0.2,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>hướng dẫn</p>',	'<p>thương hiẹu</p>',	'<p>nội dung</p>',	100000,	0,	'2021-11-02 09:51:51',	'2021-11-15 13:46:55',	'2021-11-15 13:46:55'),
(2,	'3D Lips - Teoxane -deleted-1672381338201',	'Một phát minh mới nhất của Teoxane*: [3D] Lip –  Đem đến cho bạn một đôi môi căng mọng, được nuôi dưỡng & cấp ẩm tối ưu chỉ sau một lần sử dụng, với thiết kế nhỏ gọn, giúp bạn có thể chăm sóc đôi môi bất cứ lúc nào bạn muốn.',	'3d-lips-teoxane-deleted-1672381338201',	0,	NULL,	'/upload/3DLip-1636965433315.jpg',	1350000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<ul><li>Thoa mỗi ngày, sáng tối, có thể dùng nhiều lần trong ngày, trước khi đánh son màu, giúp môi luôn căng mọng và mịn màng</li></ul>',	'',	'<p>Thành phần chính:<br>- HYALURONIC ACID &amp; COLLAGEN MICROSPHERES: Cung cấp lại HA và tái tạo lại collagen cho môi<br>- UNSAPONIFIABLE SHEA BUTTER: Dưỡng ẩm, chống lại các nếp nhăn cho môi<br>- CERAMIDE 2 AND MATRIKINE COMPLEX: làm mềm và mịn màng đôi môi</p><p>&nbsp;</p><p>Bảng thành phần:</p><p>PARAFFINUM LIQUIDUM (MINERAL OIL), DIISOSTEARYL MALATE, HYDROGENATED STYRENE/ISOPRENE COPOLYMER, OCTYLDODECYL OLEATE, OLEIC/LINOLEIC/LINOLENIC POLYGLYCERIDES, OCTYLDODECANOL, PENTAERYTHRITYL TETRAISOSTEARATE, OCTYLDODECYL STEAROYL STEARATE, CERA ALBA (BEESWAX), CAPRYLIC/CAPRIC TRIGLYCERIDE, C12-15 ALKYL BENZOATE, BUTYROSPERMUM PARKII (SHEA BUTTER), RICINUS COMMUNIS SEED OIL, SODIUM HYALURONATE, POLYHYDROXYSTEARIC ACID, BUTYROSPERMUM PARKII (SHEA) BUTTER UNSAPONIFIABLES, HYDROXYMETHOXYPHENYL PROPYLMETHYLMETHOXYBENZOFURAN, PARFUM (FRAGRANCE), TRIBEHENIN, DIETHYLHEXYL SYRINGYLIDENEMALONATE, HYDROGENATED CASTOR OIL, TRIHYDROXYSTEARIN, CERAMIDE NG, PEG-10 PHYTOSTEROL, SODIUM CHONDROITIN SULFATE, ATELOCOLLAGEN, LACTIC ACID, PALMITOYL HEXAPEPTIDE-12.</p>',	0,	0,	'2021-11-15 13:46:36',	'2022-12-30 06:22:18',	'2022-12-30 06:22:18'),
(3,	'R[2]Eyes - Teoxane-deleted-1672381335683',	'Vùng da nhạy cảm quanh mắt được sáng lên thấy rõ sau lần sử dụng đầu tiên . Sản phẩm được đánh giá cao nhất của Teoxane**!  R[II] Eyes Contour có màu tệp với màu da và khả năng cấp ẩm tối ưu, công thức không chứa chất tạo mùi được thiết kế dành riêng cho việc điều trị nếp nhăn/bọng mắt & vùng thâm quanh mắt\n',	'r-2-eyes-teoxane-deleted-1672381335683',	0,	NULL,	'/upload/R2Eyes-1636965450734.jpg',	2000000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>Phù hợp với tất cả các loại da, đặc biệt cho da nhạy cảm, Sử dụng R[II] Eyes Contour vào buổi sáng &amp; chiều tối để đạt kết quả tốt nhất.</p><p>Vỗ nhẹ phần phẳng của đầu típ kim loại dọc theo vùng mắt, giúp làm mát &amp; mang lại hiệu quả làm thông thoáng những vùng bị tắc nghẽn. Sau đó, thoa sản phẩm bằng cách đẩy &amp; massage nhẹ nhàng cho đến khi sản phẩm hoàn toàn được thẩm thấu</p>',	'',	'<p>Thành phần chính:</p><ul><li>Resilient Hyaluronic Acid : Giữ ẩm lâu &amp; củng cố hàng rào bảo vệ da</li><li>DERMO-RESTRUCTURING COMPLEX: Hỗn hợp gồm 8 amino acids, 3 chất chống oxy hóa, 2 chất khoáng, 1 vitamin B6. Giúp bảo vệ &amp; tái tạo làn da</li><li>DISODIUM ACETYL GLUCOSAMINE PHOSPHATE: Thành tố tự nhiên của hyaluronic acid – Thành tố cấu thành HA tự nhiên trong cơ thể.</li><li>ESCIN &amp; HAMAMELIS EXTRACT: Chống tắc nghẽn mạch máu</li></ul><h3>&nbsp;</h3><p>Thành phần khác:</p><p>AQUA (WATER), HELIANTHUS ANNUUS (SUNFLOWER) SEED OIL, GLYCERIN, PROPANEDIOL, BUTYLENE GLYCOL, DIMETHICONE, POLYETHYLENE, MYRISTYL ALCOHOL, TRIETHYLHEXANOIN, CETYL ALCOHOL, GLYCERYL STEARATE, OLEIC/LINOLEIC/LINOLENIC POLYGLYCERIDES, HEXYLDECANOL, HEXYLDECYL LAURATE, PROPYLENE GLYCOL, PEG-75 STEARATE, BENZYL ALCOHOL, CETETH-20, STEARETH-20, CYCLOPENTASILOXANE, ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER, CHLORPHENESIN, XANTHAN GUM, PARFUM (FRAGRANCE), GLYCINE SOJA (SOYBEAN) OIL, GLYCINE SOJA (SOYBEAN) STEROLS, DIPROPYLENE GLYCOL, ALLANTOIN, DISODIUM EDTA, PHOSPHATE BUFFERED SALINE, PEG-8, SALICYLIC ACID, HEXYL LAURATE, SODIUM HYDROXIDE, DIPHENYL DIMETHICONE, PERSEA GRATISSIMA (AVOCADO) OIL, TOCOPHEROL, ETHYLENE BRASSYLATE, ARNICA MONTANA FLOWER EXTRACT, SORBIC ACID, CETEARYL ALCOHOL, ASCORBYL PALMITATE, HELICHRYSUM ARENARIUM FLOWER EXTRACT, GERANIOL, HYDROGENATED PALM GLYCERIDES CITRATE, SODIUM HYALURONATE CROSSPOLYMER-2, ASCORBIC ACID, CITRIC ACID, DEXTRAN, PALMITOYL TRIPEPTIDE-8, BHT</p>',	0,	0,	'2021-11-15 13:53:42',	'2022-12-30 06:22:15',	'2022-12-30 06:22:15'),
(4,	'RHA serum - Teoxane-deleted-1672381333841',	'Sản phẩm được đánh giá cao* với hàm lượng công thức cốt lõi cao nhất của Teoxane, với khả năng cấp ẩm từ công nghệ RHA® được cấp bằng sáng chế.  Nhỏ gọn & tiện lợi, RHA® Serum là một sự kết hợp mạnh mẽ của các thành phần chống oxy hóa & lão hóa, giúp tái tạo & trẻ hóa làn da chỉ sau 14 ngày.\n\nSerum đầu tiên được nghiên cứu kỹ càng để cải thiện khả năng mất nước, sạm màu & sự lão hóa của làn da. Phù hợp cho mọi loại da. Sự kết hợp mạnh mẽ của các thành phần chống oxy hóa & lão hóa giúp phục hồi chức năng tái tạo tự nhiên của da. Da mịn & săn chắc hơn, nước da sáng hơn, khả năng cấp ẩm được cải thiện rõ chỉ sau 14 ngày **',	'rha-serum-teoxane-deleted-1672381333841',	0,	NULL,	'/upload/RHASerum-1636965454883.jpg',	3600000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>Thoa một lượng nhỏ serum lên da mặt và cổ sau bước làm sạch - 2 lần trong ngày giúp củng cố hàng rào bảo vệ da &amp; cải thiện chức năng giữ ẩm, nên kết hợp sử dụng cùng ADVANCED FILLER hoặc ADVANCED PERFECTING SHIELD</p><p>Khuyến nghị sử dụng trước và sau liệu trình thẩm mỹ:</p><p>Sử dụng ngày và đêm trong vòng 1 tháng trước liệu trình thẩm mỹ giúp củng cố hàng rào bảo vệ da &amp; duy trì độ ẩm.</p><p>** Kết quả thấy được sau 28 ngày dùng sản phẩm</p>',	'',	'<p>Thành phần chính:</p><ul><li>Resilient Hyaluronic Acid : Giữ ẩm lâu &amp; củng cố hàng rào bảo vệ da</li><li>DERMO-RESTRUCTURING COMPLEX: Hỗn hợp gồm 8 amino acids, 3 chất chống oxy hóa, 2 chất khoáng, 1 vitamin B6. Giúp bảo vệ &amp; tái tạo làn da</li><li>DISODIUM ACETYL GLUCOSAMINE PHOSPHATE: Thành tố tự nhiên của hyaluronic acid – Thành tố cấu thành HA tự nhiên trong cơ thể.</li><li>SODIUM HYALURONATE: Cấp ẩm và làm căng mọng da</li></ul><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p><strong>Bảng thành phần:</strong></p><p>AQUA (WATER), DIGLYCERIN, PROPANEDIOL, GLYCERIN, PHOSPHATE BUFFERED SALINE, PENTYLENE GLYCOL, IMPERATA CYLINDRICA ROOT EXTRACT, HYDROXYETHYL ACRYLATE/SODIUM ACRYLOYLDIMETHYL TAURATE COPOLYMER, SODIUM POLYACRYLATE STARCH, PPG-26-BUTETH-26, CHLORPHENESIN, SODIUM HYALURONATE, PEG-40 HYDROGENATED CASTOR OIL, PARFUM (FRAGRANCE), TAMARINDUS INDICA SEED GUM, O-CYMEN-5-OL, SODIUM HYALURONATE CROSSPOLYMER-2, DISODIUM ACETYL GLUCOSAMINE PHOSPHATE, GLYCERYL ACRYLATE/ACRYLIC ACID COPOLYMER, POLYSORBATE 60, SORBITAN ISOSTEARATE, CAPRYLYL GLYCOL, CARBOMER, ALTEROMONAS FERMENT EXTRACT, PHENETHYL ALCOHOL, SODIUM CITRATE, ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER, CITRIC ACID, BIOTIN, GLUTATHIONE, PYRIDOXINE HCL, THIOCTIC ACID, ACETYL CYSTEINE, LYSINE HYDROCHLORIDE, VALINE, ISOLEUCINE, LEUCINE, THREONINE, ARGININE, GLYCINE, ZINC ACETATE, PROLINE, COPPER SULFATE.</p>',	0,	0,	'2021-11-15 14:05:53',	'2022-12-30 06:22:13',	'2022-12-30 06:22:13'),
(5,	'AHA Cleansing - Teoxane-deleted-1672381331735',	'AHA Cleansing gel là loại gel rửa mặt giúp làm sạch sâu và thanh lọc làn da. Công thức độc quyền kết hợp thông minh các thành phần: axit glycolic, axit trái cây, RHA Resilient Hyaluronic acid và một phức hợp làm sáng để loại bỏ lớp trang điểm lâu trôi, tạp chất và các tế bào da chết, ngoài ra còn giúp da được cấp ẩm, mang lại làn da tươi tắn và rạng rỡ.',	'aha-cleansing-teoxane-deleted-1672381331735',	0,	NULL,	'/upload/AHA Square-1636965441815.jpg',	1170000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>Sử dụng 1 lần/ngày vào buổi sáng hoặc tối lên mặt và cổ đã được làm ẩm bằng nước. Tạo bọt và rửa sạch bằng nước ấm.</p><p>AHA Cleansing gel phù hợp với mọi loại da, trừ da nhạy cảm.</p>',	'',	'<p>Thành phần chính:</p><ul><li>GLYCOLIC AND FRUIT ACIDS: Axit Glycolic và Axit trái cây, thuộc họ Axit Alpha Hydroxy (AHA): &nbsp;hoạt hoá bề mặt và nhẹ nhàng làm sạch tế bào chết trên da để mang lại làn da tươi mới, mềm mại và sạch sẽ hơn **</li><li>RHA: Giữ ẩm lâu &amp; củng cố hàng rào bảo vệ da</li><li>BRIGHTENING COMPLEX: Phức hợp làm sáng da – Hỗn hợp 5 thành phần làm sáng được lựa chọn cẩn thận để ngăn chặn sự hình thành của các đốm đen&nbsp;</li></ul><p>&nbsp;</p>',	0,	0,	'2021-11-15 14:10:20',	'2022-12-30 06:22:11',	'2022-12-30 06:22:11'),
(6,	'Advanced Filler Normal to Combination Skin - Teoxane-deleted-1672381325529',	'abc',	'advanced-filler-normal-to-combination-skin-teoxane-deleted-1672381325529',	0,	NULL,	'/upload/AdvFiller-1636965437288.jpg',	2800000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'',	'',	NULL,	0,	1,	'2021-11-15 14:35:30',	'2022-12-30 06:22:05',	'2022-12-30 06:22:05'),
(7,	'sản phẩm 1-deleted-1655283150362',	'kakakak',	'san-pham-1-deleted-1655283150362',	0,	NULL,	'/upload/anti_ageing-870x450-1642522866484.jpg',	15000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'',	'',	NULL,	0,	0,	'2022-06-15 08:52:07',	'2022-06-15 08:52:30',	'2022-06-15 08:52:30'),
(8,	'SP ko biến thể - deal of weekkkkkkkk SP ko biến thể - deal of weekkkkkkkk SP ko biến thể - deal of weekkkkkkkk SP ko biến thể - -deleted-1655283294948',	'sề',	'sp-ko-bien-the-deal-of-weekkkkkkkk-sp-ko-bien-the-deal-of-weekkkkkkkk-sp-ko-bien-the-deal-of-weekkkkkkkk-sp-ko-bien-the-deleted-1655283294948',	0,	NULL,	'/upload/Biomedical-applications-of-hyaluronic-acid-1641528797473.png',	12,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>fsfe</p>',	'<p>fsef</p>',	'<p>ế</p>',	0,	0,	'2022-06-15 08:53:35',	'2022-06-15 08:54:54',	'2022-06-15 08:54:54'),
(9,	'Combo quà giáng sinh',	'Combo gồm bánh, thiệp, khăn choàng, và 1 box quà bí mật',	'combo-qua-giang-sinh',	0,	7,	'/upload/qua-giang-sinh-banh-ngot-1672371272635.jpg',	200000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'<p>Không</p>',	'<p>Không</p>',	'<p>Combo gồm bánh, thiệp, khăn choàng, và 1 box quà bí mật</p>',	0,	1,	'2022-12-30 06:23:33',	'2022-12-30 06:23:37',	NULL),
(10,	'Hộp quà tết đặc biệt',	'Hộp quà tết Đặc biệt là một trong những mẫu đẹp mang tới ý nghĩa của sự tấn tới, phát triển, đại diện cho lời chúc về sự nghiệp thắng tiến, tiền tài.',	'hop-qua-tet-ac-biet',	0,	6,	'/upload/Nhu-Y-3-1672381536067.png',	500000,	0,	0,	0,	'string',	1,	1,	1,	'',	'string',	'string',	'',	'',	'<p>Hộp quà tết Đặc biệt là một trong những mẫu đẹp mang tới ý nghĩa của sự tấn tới, phát triển, đại diện cho lời chúc về sự nghiệp thắng tiến, tiền tài. Đây được xem như gợi ý thích hợp để bạn dành tặng cho bạn bè, đồng nghiệp, cấp trên mỗi dịp tết đến xuân về. Bên trong của hộp quà tết Như Ý 3 sẽ bao gồm các thành phần cao cấp như:</p>',	0,	1,	'2022-12-30 06:26:42',	'2022-12-30 06:26:42',	NULL);

DROP TABLE IF EXISTS `SlideLocations`;
CREATE TABLE `SlideLocations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
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
('2021-11-17 02:08:40',	'2021-11-17 02:08:40',	1,	3),
('2022-12-18 09:09:09',	'2022-12-18 09:09:09',	1,	4);

DROP TABLE IF EXISTS `Slides`;
CREATE TABLE `Slides` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location_id` int DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
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
(1,	1,	1,	'Trang chủ',	'2021-11-02 08:15:40',	'2022-12-18 08:29:54',	NULL),
(2,	3,	1,	'Trang bài viết',	'2021-11-02 08:15:56',	'2021-11-02 08:15:56',	NULL),
(3,	2,	1,	'Trang sản phẩm',	'2021-11-02 08:16:06',	'2021-11-02 08:16:06',	NULL),
(4,	4,	1,	'Nhận xét của khách hàng',	'2021-11-02 08:16:21',	'2021-11-02 08:16:21',	NULL);

DROP TABLE IF EXISTS `Subscribes`;
CREATE TABLE `Subscribes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  UNIQUE KEY `path` (`path`),
  UNIQUE KEY `path_2` (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Tags` (`id`, `name`, `description`, `path`, `createdAt`, `updatedAt`) VALUES
(91,	'Untagged',	'',	'untagged',	'2022-12-18 06:10:03',	'2022-12-18 06:10:03'),
(92,	'Quà tặng',	NULL,	'qua-tang',	'2022-12-30 06:38:27',	'2022-12-30 06:38:27'),
(93,	'Tết 2023',	NULL,	'tet-2023',	'2022-12-30 06:38:36',	'2022-12-30 06:38:36');

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `role` enum('admin','blogger') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username_2` (`username`),
  UNIQUE KEY `email_2` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO `Users` (`id`, `name`, `username`, `email`, `password`, `role`, `about`, `description`, `avatar`, `createdAt`, `updatedAt`) VALUES
(1,	'Nguyễn Ngọc Đông Phương',	'admin',	'admin@beauti.com',	'$2b$10$Cmcm9S8Xv6tjIlit5/f3Z.0QWGiENUWCb1Wcx2P7MSGwvWCJUMKWK',	'admin',	'<p>Tốt nghiệp Bác sĩ tạo hình thẩm mỹ - Đại học y khoa Phạm Ngọc Thạch, tôi mang trong mình một sứ mệnh đem đến nét đẹp tự nhiên và hài hoà nhất đến với khách hàng của tôi. Với sự dẫn dắt và hướng dẫn tận tâm từ các chuyên gia quốc tế từ Anh, Pháp, Hàn Quốc, Thái Lan, Philippine, tôi đã khắc hoạ được chân dung của cái đẹp theo xu hướng cá nhân hoá trên từng khuôn mặt. Vẫn là bạn đấy, nhưng lại đẹp một cách tinh tế hơn, nhẹ nhàng hơn và đối phương khó có thể quên được nét đẹp đầy sự thanh tao ấy trong những lần gặp gỡ.</p><p>&nbsp;</p><p>Là phụ nữ, hãy luôn yêu bản thân mình đầu tiên, bạn nhé.&nbsp;</p><p>&nbsp;</p><p>Thân thương,</p><p>&nbsp;</p><p>Dr. Đông Phương</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>',	'Bác sĩ Tạo hình - Thẩm mỹ',	'/upload/P1013001-1636815771260.JPG',	'2021-11-02 03:12:32',	'2021-11-26 04:13:49'),
(2,	'Khương Duy',	'admin_duy',	'admin_duy@gmail.com',	'$2b$10$aWiOLfuF8aoZo4kaGd3nge9/CahIksOieE9mVp36HYOh6sc9iHMWG',	'admin',	'<p>“Người làm mọi nghề<i>”</i></p><p><br>Hầu hết những người trẻ đều đã từng hoặc đang trải qua cảm giác không biết mình thuộc về đâu. Khó khăn lớn nhất có lẽ không phải là kiếm được việc, mà là chọn được một nghề thực sự phù hợp với bản thân. Trên hành trình kiếm tìm ấy, người trẻ phải gánh trên vai rất nhiều áp lực vô hình từ gia đình và xã hội. Đi học thì ngành phải \"hot\", trường phải \"xịn\". Đi làm thì vị trí phải “oai\", lương tháng phải “cao\", công ty phải “khủng\".&nbsp;</p><p>Chúng ta mải chạy theo những thứ bề nổi mà quên mất rằng mục đích sau cùng của việc chọn ngành, chọn nghề là giúp mình tìm được điểm giao thoa giữa năng lực, sở thích cá nhân với nhu cầu của xã hội.</p><p>Dưới đây là dịch vụ chúng tôi cung cấp:</p><p><strong>Dịch vụ:&nbsp;</strong></p><ul><li>Thiết kế quà theo yêu cầu</li><li>Gợi ý quà tặng</li><li>Đặt hàng quà</li></ul><p>&nbsp;</p>',	'Kĩ sư IT cơ khí',	'/upload/z3999942963211_428b234432729448fc7cddce9e734f42-1672371915594.jpg',	'2022-12-18 06:10:03',	'2022-12-30 06:45:47');

-- 2023-01-22 06:07:26
