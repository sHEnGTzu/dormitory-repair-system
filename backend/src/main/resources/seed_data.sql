/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: dormitory_repair
-- ------------------------------------------------------
-- Server version	11.8.6-MariaDB-0+deb13u1 from Debian

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `dormitory_repair`
--

/*!40000 DROP DATABASE IF EXISTS `dormitory_repair`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dormitory_repair` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `dormitory_repair`;

--
-- Table structure for table `dormitory`
--

DROP TABLE IF EXISTS `dormitory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dormitory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) NOT NULL,
  `floor_num` int(11) NOT NULL,
  `room_num` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dormitory`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `dormitory` WRITE;
/*!40000 ALTER TABLE `dormitory` DISABLE KEYS */;
INSERT INTO `dormitory` (`id`, `building`, `floor_num`, `room_num`) VALUES (1,'A栋',5,'501'),
(2,'B栋',3,'308'),
(3,'A栋',1,'101'),
(4,'A栋',1,'102'),
(5,'B栋',2,'201'),
(6,'C栋',6,'601'),
(7,'A栋',1,'103'),
(8,'A栋',1,'104'),
(9,'A栋',1,'105'),
(10,'A栋',1,'106'),
(11,'A栋',1,'107'),
(12,'A栋',1,'108'),
(13,'A栋',2,'201'),
(14,'A栋',2,'202'),
(15,'A栋',2,'203'),
(16,'A栋',2,'204'),
(17,'A栋',2,'205'),
(18,'A栋',2,'206'),
(19,'A栋',2,'207'),
(20,'A栋',2,'208'),
(21,'A栋',3,'301'),
(22,'A栋',3,'302'),
(23,'A栋',3,'303'),
(24,'A栋',3,'304'),
(25,'A栋',3,'305'),
(26,'A栋',3,'306'),
(27,'A栋',3,'307'),
(28,'A栋',3,'308'),
(29,'A栋',4,'401'),
(30,'A栋',4,'402'),
(31,'A栋',4,'403'),
(32,'A栋',4,'404'),
(33,'A栋',4,'405'),
(34,'A栋',4,'406'),
(35,'A栋',4,'407'),
(36,'A栋',4,'408'),
(37,'A栋',5,'502'),
(38,'A栋',5,'503'),
(39,'A栋',5,'504'),
(40,'A栋',5,'505'),
(41,'A栋',5,'506'),
(42,'A栋',5,'507'),
(43,'A栋',5,'508'),
(44,'A栋',6,'601'),
(45,'A栋',6,'602'),
(46,'A栋',6,'603'),
(47,'A栋',6,'604'),
(48,'A栋',6,'605'),
(49,'A栋',6,'606'),
(50,'A栋',6,'607'),
(51,'A栋',6,'608'),
(52,'B栋',1,'101'),
(53,'B栋',1,'102'),
(54,'B栋',1,'103'),
(55,'B栋',1,'104'),
(56,'B栋',1,'105'),
(57,'B栋',1,'106'),
(58,'B栋',2,'202'),
(59,'B栋',2,'203'),
(60,'B栋',2,'204'),
(61,'B栋',2,'205'),
(62,'B栋',2,'206'),
(63,'B栋',3,'301'),
(64,'B栋',3,'302'),
(65,'B栋',3,'303'),
(66,'B栋',3,'304'),
(67,'B栋',3,'305'),
(68,'B栋',3,'306'),
(69,'B栋',3,'307'),
(70,'B栋',4,'401'),
(71,'B栋',4,'402'),
(72,'B栋',4,'403'),
(73,'B栋',4,'404'),
(74,'B栋',4,'405'),
(75,'B栋',4,'406'),
(76,'C栋',1,'101'),
(77,'C栋',1,'102'),
(78,'C栋',1,'103'),
(79,'C栋',1,'104'),
(80,'C栋',1,'105'),
(81,'C栋',1,'106'),
(82,'C栋',2,'201'),
(83,'C栋',2,'202'),
(84,'C栋',2,'203'),
(85,'C栋',2,'204'),
(86,'C栋',2,'205'),
(87,'C栋',2,'206'),
(88,'C栋',3,'301'),
(89,'C栋',3,'302'),
(90,'C栋',3,'303'),
(91,'C栋',3,'304'),
(92,'C栋',3,'305'),
(93,'C栋',3,'306'),
(94,'C栋',4,'401'),
(95,'C栋',4,'402'),
(96,'C栋',4,'403'),
(97,'C栋',4,'404'),
(98,'C栋',4,'405'),
(99,'C栋',4,'406'),
(100,'C栋',5,'501'),
(101,'C栋',5,'502'),
(102,'C栋',5,'503'),
(103,'C栋',5,'504'),
(104,'C栋',5,'505'),
(105,'C栋',5,'506'),
(106,'C栋',6,'602'),
(107,'C栋',6,'603'),
(108,'C栋',6,'604'),
(109,'C栋',6,'605'),
(110,'C栋',6,'606'),
(111,'C栋',7,'701'),
(112,'C栋',7,'702'),
(113,'C栋',7,'703'),
(114,'C栋',7,'704'),
(115,'C栋',7,'705'),
(116,'C栋',7,'706'),
(117,'D栋',1,'101'),
(118,'D栋',1,'102'),
(119,'D栋',1,'103'),
(120,'D栋',1,'104'),
(121,'D栋',2,'201'),
(122,'D栋',2,'202'),
(123,'D栋',2,'203'),
(124,'D栋',2,'204'),
(125,'D栋',3,'301'),
(126,'D栋',3,'302'),
(127,'D栋',3,'303'),
(128,'D栋',3,'304'),
(129,'D栋',4,'401'),
(130,'D栋',4,'402'),
(131,'D栋',4,'403'),
(132,'D栋',4,'404'),
(133,'D栋',5,'501'),
(134,'D栋',5,'502'),
(135,'D栋',5,'503'),
(136,'D栋',5,'504'),
(137,'E栋',1,'101'),
(138,'E栋',1,'102'),
(139,'E栋',1,'103'),
(140,'E栋',1,'104'),
(141,'E栋',1,'105'),
(142,'E栋',1,'106'),
(143,'E栋',1,'107'),
(144,'E栋',1,'108'),
(145,'E栋',2,'201'),
(146,'E栋',2,'202'),
(147,'E栋',2,'203'),
(148,'E栋',2,'204'),
(149,'E栋',2,'205'),
(150,'E栋',2,'206'),
(151,'E栋',2,'207'),
(152,'E栋',2,'208'),
(153,'E栋',3,'301'),
(154,'E栋',3,'302'),
(155,'E栋',3,'303'),
(156,'E栋',3,'304'),
(157,'E栋',3,'305'),
(158,'E栋',3,'306'),
(159,'E栋',3,'307'),
(160,'E栋',3,'308'),
(161,'F栋',1,'101'),
(162,'F栋',1,'102'),
(163,'F栋',1,'103'),
(164,'F栋',1,'104'),
(165,'F栋',2,'201'),
(166,'F栋',2,'202'),
(167,'F栋',2,'203'),
(168,'F栋',2,'204'),
(169,'F栋',3,'301'),
(170,'F栋',3,'302'),
(171,'F栋',3,'303'),
(172,'F栋',3,'304'),
(173,'F栋',4,'401'),
(174,'F栋',4,'402'),
(175,'F栋',4,'403'),
(176,'F栋',4,'404'),
(177,'F栋',5,'501'),
(178,'F栋',5,'502'),
(179,'F栋',5,'503'),
(180,'F栋',5,'504'),
(181,'F栋',6,'601'),
(182,'F栋',6,'602'),
(183,'F栋',6,'603'),
(184,'F栋',6,'604');
/*!40000 ALTER TABLE `dormitory` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `repair_order`
--

DROP TABLE IF EXISTS `repair_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `dormitory_id` bigint(20) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `repair_type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT '待处理',
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `repair_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair_order`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `repair_order` WRITE;
/*!40000 ALTER TABLE `repair_order` DISABLE KEYS */;
INSERT INTO `repair_order` (`id`, `user_id`, `dormitory_id`, `title`, `repair_type`, `description`, `status`, `create_time`) VALUES (4,22,29,'灯管不亮','灯具','宿舍灯管一闪一闪的，要完全打开才亮，需要更换新的灯管','待处理','2026-06-08 02:46:00'),
(5,6,27,'空调漏水','空调','空调出风口有水滴滴落，怀疑排水管堵塞，地面已经湿了一片','处理中','2026-06-04 04:23:00'),
(6,15,9,'门锁损坏','门窗','宿舍门锁生锈严重，钥匙插不进去也转不动','待处理','2026-06-09 02:28:00'),
(7,21,7,'窗户关不上','水管','窗户滑轨变形，推到一半就卡住了，无法完全关闭','处理中','2026-05-31 19:16:00'),
(8,19,108,'水龙头漏水','电路','洗手台水龙头关不紧，一直在滴水，晚上声音很吵','待处理','2026-06-03 01:09:00'),
(9,1,41,'马桶堵塞','家具','马桶冲水不畅，疑似有异物堵塞，已经快溢出来了','处理中','2026-06-07 01:51:00'),
(10,8,87,'插座没电','墙面','房间靠窗的插座没电，充电器和台灯都用不了','待处理','2026-06-06 04:38:00'),
(11,13,155,'床板断裂','其他','上铺床板有一块断裂，睡觉时很不安全，担心会塌','待处理','2026-06-11 18:31:00'),
(12,19,32,'墙面开裂','灯具','床头墙角出现一条裂缝，约30厘米长，还在继续扩大','已关闭','2026-06-06 04:25:00'),
(13,11,161,'热水器故障','空调','热水器打不着火，显示故障代码E1，已经洗不了热水澡了','处理中','2026-06-06 20:48:00'),
(14,24,18,'风扇异响','门窗','天花板吊扇转动时有咯吱咯吱的异响，声音很大','待处理','2026-06-08 17:42:00'),
(15,4,60,'窗帘脱落','水管','窗帘杆一端脱落，窗帘整个掉下来了，需要重新固定','已完成','2026-06-06 01:31:00'),
(16,22,94,'桌腿松动','电路','书桌左前桌腿螺丝松动，桌面放东西就摇晃','待处理','2026-06-07 02:18:00'),
(17,10,180,'网络接口坏','家具','墙上网口面板松动，网线插进去就掉出来','已关闭','2026-06-02 04:22:00'),
(18,22,44,'下水道堵塞','墙面','洗手台下水道堵塞，积水排不出去，已经三天了','处理中','2026-06-09 03:31:00'),
(19,14,70,'门把手断裂','其他','房门把手松动严重，用力一拉就掉下来了','已关闭','2026-06-01 18:25:00'),
(20,9,176,'暖气不热','灯具','暖气片完全不发热，摸上去是冰凉的，晚上很冷','待处理','2026-05-30 17:57:00'),
(21,9,9,'开关失灵','空调','床头灯开关按下去弹不回来，灯一直亮着','已完成','2026-06-06 01:56:00'),
(22,8,146,'柜门损坏','门窗','衣柜门合页生锈，开关门吱呀响还卡顿','已完成','2026-06-07 02:19:00'),
(23,17,102,'空调不制冷','水管','空调开了半小时还是不凉，出风口风量也很小','已完成','2026-06-01 22:51:00'),
(24,10,36,'水压太小','电路','洗澡时水压很小，六楼用水高峰期基本没水','待处理','2026-06-03 21:44:00'),
(25,25,150,'墙面渗水','家具','靠窗墙面有渗水痕迹，墙皮已经发霉脱落','处理中','2026-06-02 23:37:00'),
(26,9,36,'窗户破裂','墙面','窗户玻璃有一条裂纹，长约20厘米，怕会碎掉','处理中','2026-06-10 17:57:00'),
(27,5,40,'空调噪音大','其他','空调室外机嗡嗡声很大，晚上影响睡眠','处理中','2026-05-30 19:33:00'),
(28,21,17,'水管爆裂','灯具','洗手台下水管破裂，水漏了一地，急需维修','待处理','2026-06-02 22:27:00'),
(29,10,142,'电路跳闸','空调','一用吹风机就跳闸，整个房间都没电了','已完成','2026-06-11 19:14:00'),
(30,5,175,'桌椅摇晃','门窗','椅子坐上去左右摇晃，四条腿不平，需要修理','已完成','2026-05-31 01:11:00'),
(31,22,88,'纱窗破损','水管','纱窗破了一个大洞，夏天蚊子都飞进来了','待处理','2026-06-06 03:31:00'),
(32,1,68,'排风扇不转','电路','卫生间排风扇完全不转了，异味排不出去','已关闭','2026-05-31 03:28:00'),
(33,5,161,'门框松动','家具','宿舍门框整体松动，关门时晃动很大','待处理','2026-06-01 21:22:00');
/*!40000 ALTER TABLE `repair_order` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `real_name` varchar(50) DEFAULT NULL,
  `role` varchar(20) DEFAULT '学生',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `real_name`, `role`) VALUES (1,'test01','e10adc3949ba59abbe56e057f20f883e','测试学生','学生'),
(2,'zhangsan','e99a18c428cb38d5f260853678922e03','张三','学生'),
(3,'admin','0192023a7bbd73250516f069df18b500','系统管理员','管理员'),
(4,'student1','e10adc3949ba59abbe56e057f20f883e','王小明','学生'),
(5,'stu2','e10adc3949ba59abbe56e057f20f883e','李小红','学生'),
(6,'stu3','e10adc3949ba59abbe56e057f20f883e','赵小刚','学生'),
(7,'stu4','e10adc3949ba59abbe56e057f20f883e','陈小红','学生'),
(8,'stu5','e10adc3949ba59abbe56e057f20f883e','刘晓明','学生'),
(9,'stu6','e10adc3949ba59abbe56e057f20f883e','周小丽','学生'),
(10,'stu7','e10adc3949ba59abbe56e057f20f883e','吴小华','学生'),
(11,'stu8','e10adc3949ba59abbe56e057f20f883e','郑小强','学生'),
(12,'stu9','e10adc3949ba59abbe56e057f20f883e','王小芳','学生'),
(13,'stu10','e10adc3949ba59abbe56e057f20f883e','冯小亮','学生'),
(14,'stu11','e10adc3949ba59abbe56e057f20f883e','蒋小美','学生'),
(15,'stu12','e10adc3949ba59abbe56e057f20f883e','沈小军','学生'),
(16,'stu13','e10adc3949ba59abbe56e057f20f883e','韩小冰','学生'),
(17,'stu14','e10adc3949ba59abbe56e057f20f883e','杨小洋','学生'),
(18,'stu15','e10adc3949ba59abbe56e057f20f883e','朱小婷','学生'),
(19,'stu16','e10adc3949ba59abbe56e057f20f883e','秦小磊','学生'),
(20,'stu17','e10adc3949ba59abbe56e057f20f883e','许小文','学生'),
(21,'stu18','e10adc3949ba59abbe56e057f20f883e','何小雅','学生'),
(22,'stu19','e10adc3949ba59abbe56e057f20f883e','吕小豪','学生'),
(23,'stu20','e10adc3949ba59abbe56e057f20f883e','施小杰','学生'),
(24,'stu21','e10adc3949ba59abbe56e057f20f883e','张小米','学生'),
(25,'stu22','e10adc3949ba59abbe56e057f20f883e','李小花','学生');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-06-14 15:44:17
