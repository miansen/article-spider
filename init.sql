/*
Navicat MySQL Data Transfer

Source Server         : sen
Source Server Version : 50722
Source Host           : localhost:3306
Source Database       : article_spider

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2019-02-15 21:14:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title` varchar(500) CHARACTER SET utf8 NOT NULL COMMENT '标题',
  `content` longtext COMMENT '正文',
  `excerpt` varchar(2000) CHARACTER SET utf8 DEFAULT NULL COMMENT '摘录',
  `author` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '作者',
  `article_avatar` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章头图',
  `user_avatar` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '作者头像',
  `article_url` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章url',
  `show_content` tinyint(1) DEFAULT NULL COMMENT '是否显示正文 0: 否 1: 是',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `crawler_article_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COMMENT='文章表';

-- ----------------------------
-- Table structure for `crawler_article`
-- ----------------------------
DROP TABLE IF EXISTS `crawler_article`;
CREATE TABLE `crawler_article` (
  `crawler_article_id` int(11) NOT NULL AUTO_INCREMENT,
  `html_id` int(11) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `content` longtext COMMENT '正文',
  `excerpt` varchar(2000) DEFAULT NULL COMMENT '摘录',
  `author` varchar(50) DEFAULT NULL COMMENT '作者',
  `article_avatar` varchar(250) DEFAULT NULL COMMENT '文章头图',
  `user_avatar` varchar(250) DEFAULT NULL COMMENT '作者头像',
  `article_url` varchar(250) DEFAULT NULL COMMENT '文章url',
  `state` varchar(10) DEFAULT '0' COMMENT '0: 未清洗 1: 已清洗',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `is_crawler_content` tinyint(1) DEFAULT '0' COMMENT '是否爬取正文 0: 否 1: 是',
  PRIMARY KEY (`crawler_article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COMMENT='未清洗的文章数据';

-- ----------------------------
-- Table structure for `crawler_html`
-- ----------------------------
DROP TABLE IF EXISTS `crawler_html`;
CREATE TABLE `crawler_html` (
  `html_id` int(11) NOT NULL AUTO_INCREMENT,
  `hub_id` int(11) DEFAULT NULL,
  `html_url` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章URL',
  `state` varchar(10) DEFAULT NULL COMMENT '状态 0: 未抓取 1: 已抓取',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`html_id`),
  UNIQUE KEY `KEY_UNIQUE_HTML_URL` (`html_url`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COMMENT='此表存储html内容';

-- ----------------------------
-- Table structure for `crawler_hub`
-- ----------------------------
DROP TABLE IF EXISTS `crawler_hub`;
CREATE TABLE `crawler_hub` (
  `hub_id` int(11) NOT NULL AUTO_INCREMENT,
  `hub_url` varchar(250) NOT NULL,
  `index_url` varchar(50) NOT NULL COMMENT '首页URL',
  `article_url_selector` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章URL选择器',
  `title_selector` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '标题选择器',
  `article_avatar_img_selector` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章头图选择器',
  `author_selector` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '作者名称选择器',
  `author_avatar_img_selector` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '作者头像选择器',
  `content_selector` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '正文选择器',
  `excerpt_selector` varchar(50) DEFAULT NULL COMMENT '摘录选择器',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 0: 默认 1: 删除',
  `create_date` datetime DEFAULT NULL,
  `is_crawler_content` tinyint(1) DEFAULT '0' COMMENT '是否爬取正文 0: 否 1: 是',
  `is_upload_img` tinyint(1) DEFAULT '0' COMMENT '是否上传图片 0: 否 1: 是（填 1 的话，需要在配置文件application.cfg里填上你的OSS信息）',
  `img_url` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT 'OSS图片访问的URL',
  `article_avatar_img_attr_selector` varchar(50) DEFAULT 'src' COMMENT '文章头图属性选择器',
  `author_avatar_img_attr_selector` varchar(50) DEFAULT 'src' COMMENT '作者头像属性选择器',
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hub_id`),
  UNIQUE KEY `KEY_UNIQUE_HUB_URL` (`hub_url`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='此表用于存储hub页面的url';

-- ----------------------------
-- Records of crawler_hub
-- ----------------------------
INSERT INTO `crawler_hub` VALUES ('1', 'https://www.huxiu.com', 'https://www.huxiu.com', '.mob-ctt .transition', '.article-wrap .t-h1', '.article-img-box img', '.article-wrap .author-name a', '.author-face img', '.article-content-wrap', '.article-content-wrap', '0', '2019-02-15 17:42:44', '1', '1', 'https://article-spider.oss-cn-shenzhen.aliyuncs.com', 'src', 'src', '参考配置，不需要可以手动删除');
INSERT INTO `crawler_hub` VALUES ('2', 'https://www.huxiu.com/channel/103.html', 'https://www.huxiu.com', '.mob-ctt .transition', '.article-wrap .t-h1', '.article-img-box img', '.article-wrap .author-name a', '.author-face img', '.article-content-wrap', '.article-content-wrap', '0', '2019-02-15 20:50:35', '1', '0', null, 'src', 'src', '参考配置，不需要可以手动删除');
