!function(e){function t(e){var t,a=e.originalEvent.changedTouches,i=a[0],r="";switch(e.type){case"touchmove":r="mousemove";break;case"touchend":r="mouseup";break;default:return}t=document.createEvent("MouseEvent"),t.initMouseEvent(r,!0,!0,window,1,i.screenX,i.screenY,i.clientX,i.clientY,!1,!1,!1,!1,0,null),i.target.dispatchEvent(t),e.preventDefault()}e.rateit={aria:{resetLabel:"reset rating",ratingLabel:"rating"}},e.fn.rateit=function(a,i){var r,n=1,s={},l="init",d=function(e){return e.charAt(0).toUpperCase()+e.substr(1)};if(0===this.length)return this;if(r=e.type(a),"object"==r||void 0===a||null===a)s=e.extend({},e.fn.rateit.defaults,a);else{if("string"==r&&"reset"!==a&&void 0===i)return this.data("rateit"+d(a));"string"==r&&(l="setvalue")}return this.each(function(){var r,h,o,u,v,m,g,c,f,p,b,w=e(this),x=function(e,t){if(null!=t){var a="aria-value"+("value"==e?"now":e),i=w.find(".rateit-range");void 0!=i.attr(a)&&i.attr(a,t)}return arguments[0]="rateit"+d(e),w.data.apply(w,arguments)};if("reset"==a){r=x("init");for(h in r)w.data(h,r[h]);x("backingfld")&&(u=e(x("backingfld")),u.val(x("value")),u.trigger("change"),u[0].min&&(u[0].min=x("min")),u[0].max&&(u[0].max=x("max")),u[0].step&&(u[0].step=x("step"))),w.trigger("reset")}if(w.hasClass("rateit")||w.addClass("rateit"),o="rtl"!=w.css("direction"),"setvalue"==l){if(!x("init"))throw"Can't set value before init";"readonly"!=a||1!=i||x("readonly")||(w.find(".rateit-range").unbind(),x("wired",!1)),"value"==a&&(i=null==i?x("min"):Math.max(x("min"),Math.min(x("max"),i))),x("backingfld")&&(u=e(x("backingfld")),"value"==a&&u.val(i),"min"==a&&u[0].min&&(u[0].min=i),"max"==a&&u[0].max&&(u[0].max=i),"step"==a&&u[0].step&&(u[0].step=i)),x(a,i)}x("init")||(x("min",isNaN(x("min"))?s.min:x("min")),x("max",isNaN(x("max"))?s.max:x("max")),x("step",x("step")||s.step),x("readonly",void 0!==x("readonly")?x("readonly"):s.readonly),x("resetable",void 0!==x("resetable")?x("resetable"):s.resetable),x("backingfld",x("backingfld")||s.backingfld),x("starwidth",x("starwidth")||s.starwidth),x("starheight",x("starheight")||s.starheight),x("value",Math.max(x("min"),Math.min(x("max"),isNaN(x("value"))?isNaN(s.value)?s.min:s.value:x("value")))),x("ispreset",void 0!==x("ispreset")?x("ispreset"):s.ispreset),x("backingfld")&&(u=e(x("backingfld")).hide(),(u.attr("disabled")||u.attr("readonly"))&&x("readonly",!0),"INPUT"==u[0].nodeName&&("range"==u[0].type||"text"==u[0].type)&&(x("min",parseInt(u.attr("min"))||x("min")),x("max",parseInt(u.attr("max"))||x("max")),x("step",parseInt(u.attr("step"))||x("step"))),"SELECT"==u[0].nodeName&&u[0].options.length>1?(x("min",isNaN(x("min"))?Number(u[0].options[0].value):x("min")),x("max",Number(u[0].options[u[0].length-1].value)),x("step",Number(u[0].options[1].value)-Number(u[0].options[0].value)),v=u.find("option[selected]"),1==v.length&&x("value",v.val())):x("value",u.val())),m="DIV"==w[0].nodeName?"div":"span",n++,g='<button id="rateit-reset-{{index}}" data-role="none" class="rateit-reset" aria-label="'+e.rateit.aria.resetLabel+'" aria-controls="rateit-range-{{index}}"></button><{{element}} id="rateit-range-{{index}}" class="rateit-range" tabindex="0" role="slider" aria-label="'+e.rateit.aria.ratingLabel+'" aria-owns="rateit-reset-{{index}}" aria-valuemin="'+x("min")+'" aria-valuemax="'+x("max")+'" aria-valuenow="'+x("value")+'"><{{element}} class="rateit-selected" style="height:'+x("starheight")+'px"></{{element}}><{{element}} class="rateit-hover" style="height:'+x("starheight")+'px"></{{element}}></{{element}}>',w.append(g.replace(/{{index}}/gi,n).replace(/{{element}}/gi,m)),o||(w.find(".rateit-reset").css("float","right"),w.find(".rateit-selected").addClass("rateit-selected-rtl"),w.find(".rateit-hover").addClass("rateit-hover-rtl")),x("init",JSON.parse(JSON.stringify(w.data())))),w.find(".rateit-selected, .rateit-hover").height(x("starheight")),c=w.find(".rateit-range"),c.width(x("starwidth")*(x("max")-x("min"))).height(x("starheight")),f="rateit-preset"+(o?"":"-rtl"),x("ispreset")?w.find(".rateit-selected").addClass(f):w.find(".rateit-selected").removeClass(f),null!=x("value")&&(p=(x("value")-x("min"))*x("starwidth"),w.find(".rateit-selected").width(p)),b=w.find(".rateit-reset"),b.data("wired")!==!0&&b.bind("click",function(t){t.preventDefault(),b.blur();var a=e.Event("beforereset");return w.trigger(a),a.isDefaultPrevented()?!1:(w.rateit("value",null),void w.trigger("reset"))}).data("wired",!0);var y=function(t,a){var i=a.changedTouches?a.changedTouches[0].pageX:a.pageX,r=i-e(t).offset().left;return o||(r=c.width()-r),r>c.width()&&(r=c.width()),0>r&&(r=0),p=Math.ceil(r/x("starwidth")*(1/x("step")))},N=function(e){var t,a=e*x("starwidth")*x("step"),i=c.find(".rateit-hover");i.data("width")!=a&&(c.find(".rateit-selected").hide(),i.width(a).show().data("width",a),t=[e*x("step")+x("min")],w.trigger("hover",t).trigger("over",t))},k=function(t){var a=e.Event("beforerated");return w.trigger(a,[t]),a.isDefaultPrevented()?!1:(x("value",t),x("backingfld")&&e(x("backingfld")).val(t).trigger("change"),x("ispreset")&&(c.find(".rateit-selected").removeClass(f),x("ispreset",!1)),c.find(".rateit-hover").hide(),c.find(".rateit-selected").width(t*x("starwidth")-x("min")*x("starwidth")).show(),w.trigger("hover",[null]).trigger("over",[null]).trigger("rated",[t]),!0)};x("readonly")?b.hide():(x("resetable")||b.hide(),x("wired")||(c.bind("touchmove touchend",t),c.mousemove(function(e){var t=y(this,e);N(t)}),c.mouseleave(function(){c.find(".rateit-hover").hide().width(0).data("width",""),w.trigger("hover",[null]).trigger("over",[null]),c.find(".rateit-selected").show()}),c.mouseup(function(e){var t=y(this,e),a=t*x("step")+x("min");k(a),c.blur()}),c.keyup(function(e){(38==e.which||e.which==(o?39:37))&&k(Math.min(x("value")+x("step"),x("max"))),(40==e.which||e.which==(o?37:39))&&k(Math.max(x("value")-x("step"),x("min")))}),x("wired",!0)),x("resetable")&&b.show()),c.attr("aria-readonly",x("readonly"))})},e.fn.rateit.defaults={min:0,max:5,step:.5,starwidth:16,starheight:16,readonly:!1,resetable:!0,ispreset:!1},e(function(){e("div.rateit, span.rateit").rateit()})}(jQuery);