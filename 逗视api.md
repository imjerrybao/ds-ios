## 逗视 API
api.doushi.me
* ### host: gaoxiaoshipin.vipappsina.com (暂时)
* ### 最新逗视: GET </br> /index.php/NewApi36/index/markId/0/random/0/sw/1
* ### 最新逗视-翻页: GET  </br> /index.php/NewApi36/index/lastId/24568/random_more/0/sw/1 <br/>
24568 视频Id，翻页时传入当前页最后一个视频id
* ### 最热视频: GET </br> /index.php/NewApi36/index/markId/0/random/1/sw/1
* ### 最热视频-翻页：GET </br> /index.php/NewApi36/index/lastId/11460/random_more/1/sw/1
11460 视频Id，翻页时传入当前页最后一个视频id

## 逗视GIF API

* ### host: xiaoliao.sinaapp.com
* ### 最新GIF: GET </br> /index.php/GIF_36/index/markId/0/lastId/0/sw/1
* ### 最新GIF-翻页: GET </br> /index.php/GIF_36/index/markId/0/lastId/186353/sw/1
186353 视频Id，翻页时传入当前页最后一个视频id

## 逗视 API 返回实体
``` json
{
  totalRow: 23183, //视频总条数
  rows: [
    {
        id: "24581", //视频id
        title: "绿色兵团一命通关之教学版，其实高手在民间~",//视频标题
        pic: "http://ww4.sinaimg.cn/orj480/736f0c7ejw1ewkybfyemuj20ds08mmz2.jpg",//视频图片
        url: "http://video.weibo.com/show?fid=1034:e4e4e4e4ad8e4e80842f38ace37be0d5",//视频地址
        mp4_url: "http://us.sinaimg.cn/002aw5RCjx06VQx4gykU050d010000IJ0k01.m3u8?KID=unistore,video&Expires=1444033396&ssig=UeubudqBUT",
        cTime: "今天 13:39",//发布时间
        favo_num: "5",//分享条数
        zan_num: "62"//赞条数
    },
    {
        id: "24580",
        title: "哈哈哈哈这视频谁剪的，看的脑门痛。。。",
        pic: "http://wscdn.miaopai.com/stream/cyw2y0GwYHh4lOwZ3AjUUA___tmp_12.jpg",
        url: "http://www.miaopai.com/show/cyw2y0GwYHh4lOwZ3AjUUA__.htm",
        mp4_url: "http://gslb.miaopai.com/stream/cyw2y0GwYHh4lOwZ3AjUUA__.mp4?vend=miaopai&",
        cTime: "今天 13:38",
        favo_num: "17",
        zan_num: "240"
    }
  ]
}
```
## 逗视GIF API 返回实体
``` json
{
  totalRow: 100, //GIF总条数
  rows: [
      {
        id: "186575", //GIF ID
        title: "炫酷的手法~~", //标题
        pic: "http://ww3.sinaimg.cn/large/9fe61bc3jw1ewq6xpsknlj209o07ita7.jpg",//图片地址(展示)
        pic_w: "348",// 图片宽
        pic_h: "270",// 图片高
        pic_t: "gif", //图片类型    
        cate_id: "9", 
        cTime: "10-05 13:23",
        uname: "笑话百科",
        uid: "0",
        web_url: "",
        mp4_url: "http://ww2.sinaimg.cn/bmiddle/0068quT8gw1ewoi1s1m4lg309o07ix6p.gif",//GIF地址
        downUrl: "",
        news_id: "186575",
        url: "",
        url_type: ""
    }
  ]
}
```
