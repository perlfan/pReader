use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;
use Smart::Comments ;
use YAML qw(Dump);

use Test::More tests => 3;    # last test to print

BEGIN {
    use_ok('Reader::WebScraper::iKandou::Magazine');
};

my $yaml = '/home/nightlord/james/pReader/conf/scraper/ikandou.com/yy.yml';
my $spider = new Reader::WebScraper::iKandou::Magazine(
    config => $yaml
);
#warn Dump $spider->scraper;

### test init config with yaml
my $callbacks = $spider->callbacks;
is( ref $spider->scraper,'Web::Scraper::Config','test scraper init object');

### test parse html result
=pod
    - desc: ' 发现创新价值的科技媒体 '
          download_url: http://ikandou.com/download/book/28
                name: 爱范儿
                      post_times: 4700
                            subscribers: 539
=cut
my $expect_html_result = {
    book_info => {
            name => '爱范儿',
            post_times => 4700,
            download_url => 'http://ikandou.com/download/book/28',
            desc => ' 发现创新价值的科技媒体 ',
            subscribers => 539,
    }
};
warn Dump $expect_html_result;

my $html = do { local $/; <DATA> };
my $hashref = $spider->parse($html); 
my $test_hashref = $hashref->{book_info}{list}[7];
warn Dump $test_hashref;
is_deeply( $test_hashref,$expect_html_result->{book_info},'test parse html result ');

done_testing(3);

__DATA__

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  
  <head>
    <title> 爱看豆 (ikandou.com) | 每天投递新鲜的报纸和杂志到你的kindle </title>
    <meta property="wb:webmaster" content="7b0a8a7d93e0bc08" />    
    <!-- QSTDPB6ZpVe_dRBtulg_vDAh3iQ -->    
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="description" content="每天推送新鲜的杂志和报纸到你的kindle。提供电子书，报纸杂志的下载，阅读和推送服务。" />
    <meta name="keywords" content="kindle 推送, 电子书, 杂志, 报纸, 免费, bbc, bbc中文, new york times,  rss, 订阅, mobi电子书, ipad, B&N Nook, kindle 3, kindle 4, kindle touch,新闻, kindle看新闻" />
    <link href="/media/css/main.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/js/jquery.qtip.js"  />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/js/csrf.js"></script>    
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>    

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-19482461-5']);
  _gaq.push(['_setDomainName', '.ikindle.mobi']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>  
  </head>
  <body>
    
    <div id="promote">
我们也开始<b>投递电子书</b>了!去<a href="http://ikandou.com/book/" target="_blank">万卷书</a>看看吧.
    </div>
    <div id="header">
      <div id="userpanel">
	
	<a class="login" href="/accounts/login/">登录</a>
        <span style="color: #ccc;">•</span>
	<a style="color:red;" href="/accounts/register/">注册</a>
	
      </div>
      <h1 id="logo">
        <a href="/" class="logo kindle">
	  <img src="/media/pic/ikindle0.png" alt="ikindle" border="0">
	  </a>
      </h1>
      <div style="font-size: 14px; margin-top: 8px;">每天投递新鲜的报纸和杂志到你的<b style="color:#222;">kindle</b>
	<a href="http://blog.ikindle.mobi/archives/1" style="font-size:12px;float:right;"><span style="color:red;">+</span>了解更多</a>
      </div>
    </div>    
    <div id="content">
      
<div id="left_column" style="min-height:600px;">
<div class="pagination" id="paginationTop">
  <span style="text-decoration: none;">&nbsp;</span>
</div>
<h2 id="categoryHeader">
  <a  href="/popular">最受欢迎</a>
  <span style="color: #ccc;">•</span>
  <a  class="active" href="/latest">最近更新</a>  
  <span style="color: #ccc;">•</span>
  <a  href="/mysubscribes">我的订阅</a>
  <span style="color: #ccc;">•</span>
  <a class="" href="/faq#start">常见问题</a>
  <span style="color: #ccc;margin:0 60px;">&nbsp;</span>
  <a class="" href="http://ikindle.uservoice.com" target="_blank">用户反馈</a>
</h2>
<div class="alert-message warning" style="font-size:12px;clear:both;margin-right:20px;">


你最多可以订阅 <b>2</b> 份报纸，可以考虑<a href="/upgrade/plans/">付费订阅</a>
<!-- 你最多可以订阅 <b>2</b> 份报纸, bravo! -->

</div>


<div class="notification">
  
</div>

<div id="bookmark_list">
  
  
  <div class="tableViewCell tableViewCellFirst" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=22>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/22">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/22">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="22" href="/book/22/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase22" href="/book/22">豆瓣经典短篇阅读</a><a href="http://douban.com/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    <span title="每周投递" style="color:#888;font-size:12px;">周一投递</span>
        
    
  <span class="subscribers">10577</span>
  <div class="summary">
    名家名篇。王小波，鲁迅，村上春树，屠格涅夫，钱钟书，林语堂。
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  <div class="label-free">
    <a class="tooltip" title="标记为无限制订阅的杂志不受订阅数量的限制，可以免费订阅。" style="color:white;text-decoration:none;">无限制订阅</a>
  </div>
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/dbnv/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:22 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;27920</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/22" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">6607</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=34>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/34">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/34">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="34" href="/book/34/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase34" href="/book/34">UCD China</a><a href="#" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    <span title="每日投递" style="color:#888;font-size:12px;">每日投递</span>
    
        
    
  <span class="subscribers">22</span>
  <div class="summary">
    UCD大社区- 以用户为中心的设计
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/ucdchina/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:18 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;111</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/34" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">55</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=33>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/33">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/33">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="33" href="/book/33/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase33" href="/book/33">一五一十周刊</a><a href="http://my1510.cn/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    <span title="每周投递" style="color:#888;font-size:12px;">周一投递</span>
        
    
  <span class="subscribers">658</span>
  <div class="summary">
    分享听到的，看到的，想到的 | 让我们看的更清楚，辩的更明白
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/yiwuyishi/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:21 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;4399</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/33" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">1333</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=32>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/32">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/32">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="32" href="/book/32/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase32" href="/book/32">FT中文网-英国《金融时报》</a><a href="#" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    <span title="每日投递" style="color:#888;font-size:12px;">每日投递</span>
    
        
    
  <span class="subscribers">1783</span>
  <div class="summary">
    FT中文网是英国《金融时报》唯一的非英语网站，致力于向中国商业菁英和企业决策者及时提供来自全球的商业、经济、市场、管理和科技新闻.
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/ftchinese/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:13 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;10056</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/32" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">2999</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=31>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/31">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/31">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="31" href="/book/31/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase31" href="/book/31">下厨房美食生活杂志</a><a href="http://xiachufang.com/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    <span title="每周投递" style="color:#888;font-size:12px;">周一投递</span>
        
    
  <span class="subscribers">1047</span>
  <div class="summary">
    唯有美食与爱不可辜负 (下厨房出品)
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/xiachufang/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:15 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;4581</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/31" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">1372</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=30>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/30">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/30">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="30" href="/book/30/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase30" href="/book/30">糗事百科</a><a href="http://qiushibaike.com/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    <span title="每日投递" style="color:#888;font-size:12px;">每日投递</span>
    
        
    
  <span class="subscribers">1207</span>
  <div class="summary">
    快乐就是要建立在别人的痛苦之上.
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/qiubai/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:19 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;8494</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/30" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">2189</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=29>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/29">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/29">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="29" href="/book/29/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase29" href="/book/29">SocialBeta</a><a href="http://socialbeta.cn/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    <span title="每周投递" style="color:#888;font-size:12px;">周一投递</span>
        
    
  <span class="subscribers">396</span>
  <div class="summary">
    专注于社会化媒体的内容博客
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  <a class="tag" href="/tag/4">
    IT
  </a>
  
  <a class="tag" href="/tag/6">
    博客
  </a>
  
  </span>
  <a href="/books/socialbeta/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:16 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;2162</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/29" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">846</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=28>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/28">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/28">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="28" href="/book/28/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase28" href="/book/28">爱范儿</a><a href="http://www.ifanr.com/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    <span title="每日投递" style="color:#888;font-size:12px;">每日投递</span>
    
        
    
  <span class="subscribers">539</span>
  <div class="summary">
    发现创新价值的科技媒体
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  <a class="tag" href="/tag/4">
    IT
  </a>
  
  <a class="tag" href="/tag/6">
    博客
  </a>
  
  </span>
  <a href="/books/ifanr/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:25 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;4700</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/28" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">1459</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=27>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/27">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/27">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="27" href="/book/27/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase27" href="/book/27">TechWeb每日热点推荐</a><a href="http://www.techweb.com.cn/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    <span title="每日投递" style="color:#888;font-size:12px;">每日投递</span>
    
        
    
  <span class="subscribers">383</span>
  <div class="summary">
    领先的互联网行业互动媒体。
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  <a class="tag" href="/tag/4">
    IT
  </a>
  
  <a class="tag" href="/tag/6">
    博客
  </a>
  
  </span>
  <a href="/books/techweb/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:20 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;3459</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/27" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">1183</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=26>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/26">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/26">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="26" href="/book/26/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase26" href="/book/26">TechCrunch</a><a href="http://techcrunch.com/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    <span title="每日投递" style="color:#888;font-size:12px;">每日投递</span>
    
        
    
  <span class="subscribers">668</span>
  <div class="summary">
    IT News
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/techcrunch/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:09 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;3219</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/26" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">1146</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=25>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/25">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/25">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="25" href="/book/25/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase25" href="/book/25">酷壳</a><a href="http://coolshell.cn/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    <span title="每周投递" style="color:#888;font-size:12px;">周一投递</span>
        
    
  <span class="subscribers">1034</span>
  <div class="summary">
    享受编程和技术所带来的快乐.
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/coolshell/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:26 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;4018</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/25" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">1355</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=24>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/24">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/24">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="24" href="/book/24/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase24" href="/book/24">译言</a><a href="http://www.yeeyan.org/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    <span title="每日投递" style="color:#888;font-size:12px;">每日投递</span>
    
        
    
  <span class="subscribers">2645</span>
  <div class="summary">
    发现，翻译，阅读中文之外的互联网精华
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  </span>
  <a href="/books/yeeyan/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:06 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;11034</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/24" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">3466</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=23>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/23">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/23">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="23" href="/book/23/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase23" href="/book/23">云风的blog</a><a href="http://codingnow.com/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    
    <span title="每月投递" style="color:#888;font-size:12px;">每月1号</span>    
    
  <span class="subscribers">388</span>
  <div class="summary">
    思绪来得快去得也快，偶尔会在这里停留. 云风-简悦创始人之一，他的博客关注语言与设计，游戏开发，攀岩，质量非常不错的博客。
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  <a class="tag" href="/tag/4">
    IT
  </a>
  
  <a class="tag" href="/tag/6">
    博客
  </a>
  
  </span>
  <a href="/books/yfblog/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:19 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;1408</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/23" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">868</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
  
    <div class="tableViewCell" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=21>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/21">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/21">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="21" href="/book/21/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase21" href="/book/21">Harvard Buiness Review</a><a href="http://hbr.org/" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    <span title="每周投递" style="color:#888;font-size:12px;">周一投递</span>
        
    
  <span class="subscribers">4265</span>
  <div class="summary">
    哈佛商业评论（ Harvard Business Review，简称HBR ）是全球顶尖的管理杂志，也是哈佛商学院的标志性刊物，创刊于1922年。
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  <a class="tag" href="/tag/7">
    管理
  </a>
  
  <a class="tag" href="/tag/2">
    英文
  </a>
  
  </span>
  <a href="/books/hbr/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:03 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;12370</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/21" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">4389</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
    
    <div class="tableViewCell tableViewCellLast" id="tableViewCell176832828">
    
    

<div class="cornerControls" idnum=20>
  <a title="现在推送到我的kindle" class="actionButton textButton" id="text176832828" href="/pushto/kindle/20">推送</a>
  
  <a title="订阅这本杂志，每天推送到我的kindle" class="subscribe actionButton archiveButton" id="skip176832828" href="/subscribe/book/20">订阅</a>
  
</div> <!-- cornerControls -->
<div class="likeBox">
  
  <a class="like tooltip" pk="20" href="/book/20/like" title="你登录后就可以喜欢这本杂志了"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png"></img></a>
  
</div>
<div class="titleRow">
  <a class="tableViewCellTitleLink" name="bookbase20" href="/book/20">月光博客</a><a href="http://www.williamlong.info" class="orig_link" target="_blank"><img src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/external.png"></img></a>
    
    
    <span title="每周投递" style="color:#888;font-size:12px;">周一投递</span>
        
    
  <span class="subscribers">1007</span>
  <div class="summary">
    月光博客，是一个专注于电脑技术、网站架设互联网、搜索引擎行业、Web 2.0等的原创IT科技博客。
  </div>
</div>
<div class="secondaryControls" id="secondaryControls176832828">
  
  
  
  
  <span class="tagging">
  
  <a class="tag" href="/tag/4">
    IT
  </a>
  
  <a class="tag" href="/tag/6">
    博客
  </a>
  
  </span>
  <a href="/books/ygblog/feed_0/index.html" style="color:#D14836;font-size:12px;" title="你现在可以直接通过网页阅读了">阅读</a>
  <span class="host">13:13 07-11</span>
  <span class="separator">•</span>
  <span class="host">推送&nbsp;3089</span>
  <span class="separator">•</span>
  <a class="actionLink" href="/download/book/20" title="下载(mobi格式)" href="#">下载</a><span style="color:#666; font-size:11px;padding-left:2px;">1362</span>
  <!-- <span class="separator">•</span> -->
  <!-- <a class="actionLink deleteLink" title="Permanently delete" id="dele176832828" style="color: #770000;" href="">预览</a> -->
</div> <!-- secondaryControls -->
<div class="clear">&nbsp;</div>

  </div>
  
    <div class="fr viewmore">
      

<div class="pagination">
    
        <span class="disabled prev">&lsaquo;&lsaquo; 前一页</span>
    
    
        
            
                <span class="current page">1</span>
            
        
    
        
            
                <a href="?page=2" class="page">2</a>
            
        
    
        
            
                <a href="?page=3" class="page">3</a>
            
        
    
    
        <a href="?page=2" class="next">下一页&rsaquo;&rsaquo;</a>
    
</div>


    </div>
</div>
    
</div>
<div id="right_column">
   <div id="ad">
<!-- Place this tag where you want the +1 button to render -->
<g:plusone size="medium"></g:plusone>
<!-- Place this render call where appropriate -->
<script type="text/javascript">
  window.___gcfg = {lang: 'zh-CN'};

  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>     
   <!--   <a href="" style="font-size:12px;"></a>&nbsp;&nbsp;卓越网 -->
   <!-- <br /> -->
   <!--  -->
   </div>
   
   <div id="gads" style="font-size:12px;">
     <br />
     <br />
     <script type="text/javascript"><!--
google_ad_client = "ca-pub-9092631985506649";
/* 200x200 */
google_ad_slot = "4120730842";
google_ad_width = 200;
google_ad_height = 200;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
   </div>
   <div id="tags">
     <h3 class="section_header" style="margin-bottom:8px;">TAGS</h3>
     
     <li>
       <a class="tag" href="/tag/4">IT</a><span style="color:#666;"> x 10</span>
     </li>
     
     <li>
       <a class="tag" href="/tag/6">博客</a><span style="color:#666;"> x 5</span>
     </li>
     
     <li>
       <a class="tag" href="/tag/1">新闻</a><span style="color:#666;"> x 10</span>
     </li>
     
     <li>
       <a class="tag" href="/tag/5">法语</a><span style="color:#666;"> x 1</span>
     </li>
     
     <li>
       <a class="tag" href="/tag/3">科技</a><span style="color:#666;"> x 1</span>
     </li>
     
     <li>
       <a class="tag" href="/tag/7">管理</a><span style="color:#666;"> x 1</span>
     </li>
     
     <li>
       <a class="tag" href="/tag/2">英文</a><span style="color:#666;"> x 4</span>
     </li>
     
   </div>
   <div id="bookmarkListDeckAdPlaceholder" style="height: 200px;">
   <h3 class="section_header" style="margin: 0 0 5px 0;">Subscribe with</h3>
   <a title="rss订阅，我们会及时发送更新给你" href="http://feeds.feedburner.com/ikindlemobi"><img width="16px;" src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/rss.png"></img> </a>
   <a title="rss订阅，我们会及时发送更新给你" class="rss" href="http://feeds.feedburner.com/ikindlemobi">RSS订阅</a>
   <p style="margin-bottom: -6px; padding:0;"></p>
   <!-- <a title="rss订阅，我们会及时发送更新给你" href="http://feeds.feedburner.com/ikindlemobi"> </a> -->
   
   <a title="我们会将最新添加杂志的样刊投递一份到你的kindle,你可以阅读后决定是否订阅." class="rss tooltip" href="/register/kindle"><img width="16px;" src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/kindle.png"></img></a></a>
   <a title="我们会将最新添加杂志的样刊投递一份到你的kindle,你可以阅读后决定是否订阅." class="rss tooltip" href="/register/kindle">kindle订阅</a>
   
   <span style="font-size:16px; color:#a44;">5788</span>
   <p style="margin-bottom: -6px; padding:0;"></p>   
   <a title="在新浪微薄关注我们" class="rss" href="http://weibo.com/ikindle4u"><img width="16px;" src="http://blog.ikindle.mobi/wp-content/themes/albeo/images/weibo-logo.gif"></img></a>
   <a title="在新浪微薄关注我们" class="rss" href="http://weibo.com/ikindle4u">关注我们</a>   
   <p style="border-bottom: 1px #ccc solid;padding-top:2px;margin-top:-1px;"/>&nbsp;</p>
<a target="_blank" href="/book/donate">捐助我们</a>
<p style="color:#444;font-size:12px;">
     你现在也可以通过<span style="background-color:#ffc;">支付宝捐助</span>我们了，你可以考虑帮我们买<a style="color:#AE0000;" target="_blank" href="/book/donate">一杯咖啡，一块馅饼或者一米阳光...</a></a>.
</p>
   <p>
   <a href="http://blog.ikindle.mobi">blog</a>
   </p>
  <p>
   <a style="font-size:12px;" href="http://blog.ikindle.mobi/%E8%81%94%E7%B3%BB%E6%88%91%E4%BB%AC">联系我们</a>
   </p>
</div>
<script type="text/javascript">
  var uvOptions = {};
  (function() {
    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/PakAteMxLWW0AIsWrEVkNQ.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
  })();
</script>

    </div>
    <script src="https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/js/jquery.qtip.js"></script>
    <script type="text/javascript">
      $(function(){
      $("a.tooltip").qtip(
      {
      position:{
        my: 'top left',
        at: 'bottom right'
      },
      });
      });
    </script>
    <script type="text/javascript">
      $(function(){
      $("a.subscribe").click(function(event){
      event.preventDefault();
      me = $(this);
      var pk= $(this).parent().attr('idnum');
      var link="";
      $.ajax({
        type:"POST",
        url:"/subscribe/book/0",
        data:{'pk':pk},
        cache:false,
        beforeSend:function(){
          me.addClass('loading');
          me.attr('disabled','disabled');
        },
        success:function(data){
          var data=eval('('+data+')');
          if (data.success){
          me.removeClass('loading');
          me.text('已订阅');
          me.attr('href',me.attr('href').replace('subscribe','unsubscribe'));
          me.attr('class','unsubscribe actionButton textButton highlight');
          me.removeAttr('href');
          me.unbind('click');
          }else{
            me.removeClass('loading');	      
            $('.error-notification').remove();
            var $err=$('<div>').addClass('error-notification')
	                       .html('<h2>'+data.error_msg +'</h2>(单击这里取消)')
	                       .css('left',me.position().left);
	    me.after($err);
	    $err.fadeIn('fast');
          }
        },
      });
      });

      $("a.unsubscribe").click(function(event){
      event.preventDefault();
      me = $(this);
      var pk= $(this).parent().attr('idnum');
      var link="";
      $.ajax({
        type:"POST",
        url:"/unsubscribe/book/0",
        data:{'pk':pk},
        cache:false,
        beforeSend:function(){
          me.addClass('loading');
          me.attr('disabled','disabled');
        },
        success:function(data){
          var data=eval('('+data+')');      
          if (data.success){
          me.removeClass('loading');
          me.text('已取消');
          me.attr ('href', me.attr('href').replace('unsubscribe','subscribe'));
          me.attr('class','unsubscribe actionButton textButton highlight');
          me.removeAttr('href');
          me.unbind('click');
          }
          else{
            me.removeClass('loading');	
            $('.error-notification').remove();
            var $err=$('<div>').addClass('error-notification')
	                       .html('<h2>'+data.error_msg +'</h2>(click)')
	                       .css('left',me.position().left);
	    me.after($err);
	    $err.fadeIn('fast');
          }
        },
      });
      });

      $('.error-notification').live('click',function(){
	$(this).fadeOut('fast', function(){$(this).remove();})});
      });
    </script>
    <script>
      $("a.like").click(function(event){
      event.preventDefault();
      var pk=$(this).attr('pk');
      thisl=$(this);
      if ($(this).hasClass('liked')){
      var unlikeurl="/book/0/unlike";
      unlikeurl = unlikeurl.replace(/\d+/g,pk);
      $.post(unlikeurl,{},
      function(data){
      if(data.success){
      thisl.find('img').attr("src","https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png");
      thisl.removeClass('liked');
      }else{}},"json");
      }else{
      var likeurl="/book/0/like";
      likeurl = likeurl.replace(/\d+/g,pk);
      $.post(likeurl,{},function(data){if(data.success){thisl.find('img').attr("src","https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/liked.png");thisl.addClass('liked');}else{}},"json");
      }
      });

      $("a.unlike").click(function(event){
      event.preventDefault();
      var pk=$(this).attr('pk');
      thisl=$(this);
      if ($(this).hasClass('unliked')){
      var likeurl="/book/0/like";
      likeurl = likeurl.replace(/\d+/g,pk);
      $.post(likeurl,{},function(data){if(data.success){thisl.find('img').attr("src","https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/liked.png"); thisl.removeClass('unliked');}else{
      }},"json");
      }else{
      var unlikeurl="/book/0/unlike";
      unlikeurl = unlikeurl.replace(/\d+/g,pk);
      $.post(unlikeurl,{},function(data){if(data.success){thisl.find('img').attr("src","https://s3-ap-northeast-1.amazonaws.com/ikindlestatic/media/pic/unliked.png");thisl.addClass('unliked');}else{}},"json");
      }
      });
      
    </script>	
  </body>
  <div id="footer" style="padding-top:50px;">
    <a href="http://feeds.feedburner.com/ikindlemobi">rss</a>
    <span style="color: #ccc;">•</span>
    <a href="http://blog.ikindle.mobi">blog</a>
    <span style="color: #ccc;">•</span>
    <a href="http://weibo.com/ikindle4u">weibo</a>
    <span style="color: #ccc;">•</span>
    <a href="https://github.com/fengli/alipay_python" target="_blank">alipay-api</a> (python)
    <span style="color: #ccc;">•</span>
    <span style="color:#666;">style got from instapaper and dogear</span>
    <div style="margin-top: 1em;">
      ©&nbsp;2011 ikindle.mobi.
    </div>
  </div>
</html>
