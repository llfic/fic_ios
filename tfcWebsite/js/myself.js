// JavaScript Document

 $(function() {
	 var shouye_image1 = document.getElementById('shouye_image1');
                    $("[data-toggle='popover']").each(function() {
                        var element = $(this);
                        element.popover({
                            trigger: 'manual',
                            html: true,
                            title: '',
                            placement: 'top',
                            content: function() {
                                return content();
                            }
                        }).on("mouseenter", function() {
                            var _this = this;
                            $(this).popover("show");
							shouye_image1.src = "img/people/icon_qq_xz.png";
                            $(this).siblings(".popover").on("mouseleave", function() {
                                $(_this).popover('hide');
								shouye_image1.src = "img/people/icon_qq_wx.png";
                            });
                        }).on("mouseleave", function() {
                            var _this = this;
                            setTimeout(function() {
                                if(!$(".popover:hover").length) {
                                    $(_this).popover("hide")
									shouye_image1.src = "img/people/icon_qq_wx.png";
                                }
                            }, 100);
                        });

                    });

                });  
				
				
  //模拟动态加载内容(真实情况可能会跟后台进行ajax交互)  
                function  content()  {      
                    var  data  =  $("<form><img src='img/people/img_qqerweim.png'/></form>");            
                    return  data;  
                }  
               
function gotoTwitter(){
	//window.location.href="http://twitter.com/?lang=en" 
	window.open("https://twitter.com/TopFansChaintf1") 
}
function gotoFaccbook(){
	//window.location.href="http://www.facebook.com/topfans.chain" 
	window.open("http://www.facebook.com/topfans.chain") 
}
function gotoTfc(){
	//window.location.href="http://t.me/topfanschain_tfc" 
	window.open("http://t.me/topfanschain_tfc") 
}
function downloadbook(){
	 alert('ajax请求之前');
   
	window.open("http://148.70.53.15:8088/TopFansChainWhitePaper.pdf") 
}

function showQuery(data) {
   window.open("http://t.me/topfanschain_tfc") 
}