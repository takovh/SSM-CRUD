/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50562
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2019-11-14 16:42:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_dept`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dept
-- ----------------------------
INSERT INTO `tbl_dept` VALUES ('1', '开发部');
INSERT INTO `tbl_dept` VALUES ('2', '测试部');
INSERT INTO `tbl_dept` VALUES ('3', '市场部');

-- ----------------------------
-- Table structure for `tbl_emp`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_emp`;
CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `d_id` int(11) NOT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_emp_dept` (`d_id`),
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_emp
-- ----------------------------
INSERT INTO `tbl_emp` VALUES ('1', '尹杰', 'W', 'yinjie@qq.com', '2');
INSERT INTO `tbl_emp` VALUES ('2', '李羡鬼', 'M', 'lixiangui@qq.com', '3');
INSERT INTO `tbl_emp` VALUES ('3', '罗谅解', 'M', 'luoliangjie@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('4', '王浩', 'M', 'wanghao@qq.com', '1');
