$.fn.switchstylesheet=function(e){function t(t){$("link[rel*=style][title*="+e.seperator+"]").each(function(e){this.disabled=!0,$(this).attr("title")==t&&(this.disabled=!1)}),cookie.createCookie(e.seperator,t,365)}defaults={seperator:"alt"};var e=$.extend(defaults,e),i=cookie.readCookie(e.seperator);i&&t(i),$(this).click(function(){var e=$(this).attr("title");return t(e),!1})};var cookie;!function(e){cookie={createCookie:function(e,t,i){if(i){var r=new Date;r.setTime(r.getTime()+24*i*60*60*1e3);var o="; expires="+r.toGMTString()}else var o="";document.cookie=e+"="+t+o+"; path=/"},readCookie:function(e){for(var t=e+"=",i=document.cookie.split(";"),r=0;r<i.length;r++){for(var o=i[r];" "==o.charAt(0);)o=o.substring(1,o.length);if(0==o.indexOf(t))return o.substring(t.length,o.length)}return null}}}(jQuery);