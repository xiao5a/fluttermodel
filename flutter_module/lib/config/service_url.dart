const serviceUrl= 'http://v.jspang.com:8088/baixing/';//此端口针对于正版用户开放，可自行fiddle获取。
const servicePath={
  'homePageContext': serviceUrl+'wxmini/homePageContent', // 商家首页信息
  'homePageBelowConten': serviceUrl+'wxmini/homePageBelowConten', //商城首页热卖商品拉取
  'getCategory': serviceUrl+'wxmini/getCategory', //商品类别信息
  'getMallGoods': serviceUrl+'wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailINfoByID': serviceUrl+'wxmini/getGoodDetailById', //商品详细信息
};


const TaxserviceUrl= 'https://mtax.hb-n-tax.gov.cn/webroot';//此端口针对于正版用户开放，可自行fiddle获取。
const TaxservicePath={
  'homePageContext': TaxserviceUrl+'/CheckVersionbyMobileAction.do?method=checkXMLVersion', // 商家首页信息
};