#!/usr/bin/python
# -*- coding:UTF-8 -*-
# Author: wangmiansen
# Date: 2018-12-13

from DataCrawler import *
from DataClean import *
import configparser

dataCrawler = DataCrawler()
dataClean = DataClean()
conf = configparser.ConfigParser()
conf.read('application.cfg',encoding="utf-8")

while 1:
    dataCrawler.getHtmlUrl()
    dataCrawler.getArticle()
    dataClean.dataClean()
    time.sleep(int(conf.get('app', 'intervalTime')))