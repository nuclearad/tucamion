!function(e){if(void 0===e.fn.inputmask){var t=function(e){var t=document.createElement("input");e="on"+e;var i=e in t;return i||(t.setAttribute(e,"return;"),i="function"==typeof t[e]),i},i=function(t,n,a){return(t=a.aliases[t])?(t.alias&&i(t.alias,void 0,a),e.extend(!0,a,t),e.extend(!0,a,n),!0):!1},n=function(t){function i(i){t.numericInput&&(i=i.split("").reverse().join(""));var n=!1,a=0,s=t.greedy,r=t.repeat;"*"==r&&(s=!1),1==i.length&&0==s&&0!=r&&(t.placeholder=""),i=e.map(i.split(""),function(e,i){var s=[];if(e==t.escapeChar)n=!0;else if(e!=t.optionalmarker.start&&e!=t.optionalmarker.end||n){var r=t.definitions[e];if(r&&!n)for(var o=0;o<r.cardinality;o++)s.push(t.placeholder.charAt((a+o)%t.placeholder.length));else s.push(e),n=!1;return a+=s.length,s}});for(var o=i.slice(),u=1;r>u&&s;u++)o=o.concat(i.slice());return{mask:o,repeat:r,greedy:s}}function n(i){t.numericInput&&(i=i.split("").reverse().join(""));var n=!1,a=!1,s=!1;return e.map(i.split(""),function(e,i){var r=[];if(e==t.escapeChar)a=!0;else{if(e!=t.optionalmarker.start||a){if(e!=t.optionalmarker.end||a){var o=t.definitions[e];if(o&&!a){for(var u=o.prevalidator,l=u?u.length:0,c=1;c<o.cardinality;c++){var d=l>=c?u[c-1]:[],f=d.validator,d=d.cardinality;r.push({fn:f?"string"==typeof f?RegExp(f):new function(){this.test=f}:/./,cardinality:d?d:1,optionality:n,newBlockMarker:1==n?s:!1,offset:0,casing:o.casing,def:o.definitionSymbol||e}),1==n&&(s=!1)}r.push({fn:o.validator?"string"==typeof o.validator?RegExp(o.validator):new function(){this.test=o.validator}:/./,cardinality:o.cardinality,optionality:n,newBlockMarker:s,offset:0,casing:o.casing,def:o.definitionSymbol||e})}else r.push({fn:null,cardinality:0,optionality:n,newBlockMarker:s,offset:0,casing:null,def:e}),a=!1;return s=!1,r}n=!1}else n=!0;s=!0}})}function a(e){for(var i=e.length,n=0;i>n&&e.charAt(n)!=t.optionalmarker.start;n++);var a=[e.substring(0,n)];return i>n&&a.push(e.substring(n+1,i)),a}function s(u,l,c){for(var d=0,f=0,p=l.length,v=0;p>v&&(l.charAt(v)==t.optionalmarker.start&&d++,l.charAt(v)==t.optionalmarker.end&&f++,!(d>0&&d==f));v++);d=[l.substring(0,v)],p>v&&d.push(l.substring(v+1,p)),v=a(d[0]),1<v.length?(l=u+v[0]+(t.optionalmarker.start+v[1]+t.optionalmarker.end)+(1<d.length?d[1]:""),-1==e.inArray(l,o)&&""!=l&&(o.push(l),p=i(l),r.push({mask:l,_buffer:p.mask,buffer:p.mask.slice(),tests:n(l),lastValidPosition:-1,greedy:p.greedy,repeat:p.repeat,metadata:c})),l=u+v[0]+(1<d.length?d[1]:""),-1==e.inArray(l,o)&&""!=l&&(o.push(l),p=i(l),r.push({mask:l,_buffer:p.mask,buffer:p.mask.slice(),tests:n(l),lastValidPosition:-1,greedy:p.greedy,repeat:p.repeat,metadata:c})),1<a(v[1]).length&&s(u+v[0],v[1]+d[1],c),1<d.length&&1<a(d[1]).length&&(s(u+v[0]+(t.optionalmarker.start+v[1]+t.optionalmarker.end),d[1],c),s(u+v[0],d[1],c))):(l=u+d,-1==e.inArray(l,o)&&""!=l&&(o.push(l),p=i(l),r.push({mask:l,_buffer:p.mask,buffer:p.mask.slice(),tests:n(l),lastValidPosition:-1,greedy:p.greedy,repeat:p.repeat,metadata:c})))}var r=[],o=[];return e.isFunction(t.mask)&&(t.mask=t.mask.call(this,t)),e.isArray(t.mask)?e.each(t.mask,function(e,t){void 0!=t.mask?s("",t.mask.toString(),t):s("",t.toString())}):s("",t.mask.toString()),t.greedy?r:r.sort(function(e,t){return e.mask.length-t.mask.length})},a="function"==typeof ScriptEngineMajorVersion?ScriptEngineMajorVersion():10<=new Function("/*@cc_on return @_jscript_version; @*/")(),s=navigator.userAgent,r=null!==s.match(/iphone/i),o=null!==s.match(/android.*safari.*/i),u=null!==s.match(/android.*chrome.*/i),l=null!==s.match(/android.*firefox.*/i),c=/Kindle/i.test(s)||/Silk/i.test(s)||/KFTT/i.test(s)||/KFOT/i.test(s)||/KFJWA/i.test(s)||/KFJWI/i.test(s)||/KFSOWI/i.test(s)||/KFTHWA/i.test(s)||/KFTHWI/i.test(s)||/KFAPWA/i.test(s)||/KFAPWI/i.test(s),d=t("paste")?"paste":t("input")?"input":"propertychange",f=function(t,i,n,s){function f(){return t[i]}function p(){return f().tests}function v(){return f()._buffer}function h(){return f().buffer}function k(a,s,r){function o(e,t,i,a){for(var s=_(e),r=i?1:0,o="",u=t.buffer,l=t.tests[s].cardinality;l>r;l--)o+=M(u,s-(l-1));return i&&(o+=i),null!=t.tests[s].fn?t.tests[s].fn.test(o,u,e,a,n):i==M(t._buffer.slice(),e,!0)||i==n.skipOptionalPartCharacter?{refresh:!0,c:M(t._buffer.slice(),e,!0),pos:e}:!1}if(r=!0===r){var u=o(a,f(),s,r);return!0===u&&(u={pos:a}),u}var l=[],u=!1,c=i,d=h().slice(),p=f().lastValidPosition;P(a);var v=[];return e.each(t,function(e,t){if("object"==typeof t){i=e;var n,k=a,m=f().lastValidPosition;if(m==p){if(k-p>1)for(m=-1==m?0:m;k>m&&(n=o(m,f(),d[m],!0),!1!==n);m++)C(h(),m,d[m],!0),!0===n&&(n={pos:m}),n=n.pos||m,f().lastValidPosition<n&&(f().lastValidPosition=n);if(!g(k)&&!o(k,f(),s,r)){for(m=y(k)-k,n=0;m>n&&!1===o(++k,f(),s,r);n++);v.push(i)}}(f().lastValidPosition>=p||i==c)&&k>=0&&k<b()&&(u=o(k,f(),s,r),!1!==u&&(!0===u&&(u={pos:k}),n=u.pos||k,f().lastValidPosition<n&&(f().lastValidPosition=n)),l.push({activeMasksetIndex:e,result:u}))}}),i=c,function(i,n){var r=!1;if(e.each(n,function(t,n){return(r=-1==e.inArray(n.activeMasksetIndex,i)&&!1!==n.result)?!1:void 0}),r)n=e.map(n,function(n,a){return-1==e.inArray(n.activeMasksetIndex,i)?n:void(t[n.activeMasksetIndex].lastValidPosition=p)});else{var u,l=-1,c=-1;e.each(n,function(t,n){-1!=e.inArray(n.activeMasksetIndex,i)&&!1!==n.result&(-1==l||l>n.result.pos)&&(l=n.result.pos,c=n.activeMasksetIndex)}),n=e.map(n,function(n,r){if(-1!=e.inArray(n.activeMasksetIndex,i)){if(n.result.pos==l)return n;if(!1!==n.result){for(var d=a;l>d;d++){if(u=o(d,t[n.activeMasksetIndex],t[c].buffer[d],!0),!1===u){t[n.activeMasksetIndex].lastValidPosition=l-1;break}C(t[n.activeMasksetIndex].buffer,d,t[c].buffer[d],!0),t[n.activeMasksetIndex].lastValidPosition=d}return u=o(l,t[n.activeMasksetIndex],s,!0),!1!==u&&(C(t[n.activeMasksetIndex].buffer,l,s,!0),t[n.activeMasksetIndex].lastValidPosition=l),n}}})}return n}(v,l)}function m(){var n=i,a={activeMasksetIndex:0,lastValidPosition:-1,next:-1};e.each(t,function(e,t){"object"==typeof t&&(i=e,f().lastValidPosition>a.lastValidPosition?(a.activeMasksetIndex=e,a.lastValidPosition=f().lastValidPosition,a.next=y(f().lastValidPosition)):f().lastValidPosition==a.lastValidPosition&&(-1==a.next||a.next>y(f().lastValidPosition))&&(a.activeMasksetIndex=e,a.lastValidPosition=f().lastValidPosition,a.next=y(f().lastValidPosition)))}),i=-1!=a.lastValidPosition&&t[n].lastValidPosition==a.lastValidPosition?n:a.activeMasksetIndex,n!=i&&(E(h(),y(a.lastValidPosition),b()),f().writeOutBuffer=!0),q.data("_inputmask").activeMasksetIndex=i}function g(e){return e=_(e),e=p()[e],void 0!=e?e.fn:!1}function _(e){return e%p().length}function b(){var t=v(),i=f().greedy,a=f().repeat,s=h();if(e.isFunction(n.getMaskLength))return n.getMaskLength(t,i,a,s,n);var r=t.length;return i||("*"==a?r=s.length+1:a>1&&(r+=t.length*(a-1))),r}function y(e){var t=b();if(e>=t)return t;for(;++e<t&&!g(e););return e}function P(e){if(0>=e)return 0;for(;0<--e&&!g(e););return e}function C(e,t,i,n){n&&(t=A(e,t)),n=p()[_(t)];var a=i;if(void 0!=a&&void 0!=n)switch(n.casing){case"upper":a=i.toUpperCase();break;case"lower":a=i.toLowerCase()}e[t]=a}function M(e,t,i){return i&&(t=A(e,t)),e[t]}function A(e,t){for(var i;void 0==e[t]&&e.length<b();)for(i=0;void 0!==v()[i];)e.push(v()[i++]);return t}function x(e,t,i){e._valueSet(t.join("")),void 0!=i&&K(e,i)}function E(e,t,i,n){for(var a=b();i>t&&a>t;t++)!0===n?g(t)||C(e,t,""):C(e,t,M(v().slice(),t,!0))}function I(e,t){var i=_(t);C(e,t,M(v(),i))}function j(e){return n.placeholder.charAt(e%n.placeholder.length)}function V(n,a,s,r,o){r=void 0!=r?r.slice():T(n._valueGet()).split(""),e.each(t,function(e,t){"object"==typeof t&&(t.buffer=t._buffer.slice(),t.lastValidPosition=-1,t.p=-1)}),!0!==s&&(i=0),a&&n._valueSet(""),b(),e.each(r,function(t,i){if(!0===o){var r=f().p,r=-1==r?r:P(r),u=-1==r?t:y(r);-1==e.inArray(i,v().slice(r+1,u))&&U.call(n,void 0,!0,i.charCodeAt(0),a,s,t)}else U.call(n,void 0,!0,i.charCodeAt(0),a,s,t),s=s||t>0&&t>f().p}),!0===s&&-1!=f().p&&(f().lastValidPosition=P(f().p))}function S(t){return e.inputmask.escapeRegex.call(this,t)}function T(e){return e.replace(RegExp("("+S(v().join(""))+")*$"),"")}function O(e){var t,i,n=h(),a=n.slice();for(i=a.length-1;i>=0&&(t=_(i),p()[t].optionality)&&(!g(i)||!k(i,n[i],!0));i--)a.pop();x(e,a)}function G(t,i){if(!p()||!0!==i&&t.hasClass("hasDatepicker"))return t[0]._valueGet();var a=e.map(h(),function(e,t){return g(t)&&k(t,e,!0)?e:null}),a=(Z?a.reverse():a).join("");return e.isFunction(n.onUnMask)?n.onUnMask.call(t,h().join(""),a,n):a}function D(e){return!Z||"number"!=typeof e||n.greedy&&""==n.placeholder||(e=h().length-e),e}function K(t,i,a){var s=t.jquery&&0<t.length?t[0]:t;return"number"!=typeof i?e(t).is(":visible")?(s.setSelectionRange?(i=s.selectionStart,a=s.selectionEnd):document.selection&&document.selection.createRange&&(t=document.selection.createRange(),i=0-t.duplicate().moveStart("character",-1e5),a=i+t.text.length),i=D(i),a=D(a),{begin:i,end:a}):{begin:0,end:0}:(i=D(i),a=D(a),e(s).is(":visible")&&(a="number"==typeof a?a:i,s.scrollLeft=s.scrollWidth,0==n.insertMode&&i==a&&a++,s.setSelectionRange?(s.selectionStart=i,s.selectionEnd=a):s.createTextRange&&(t=s.createTextRange(),t.collapse(!0),t.moveEnd("character",a),t.moveStart("character",i),t.select())),void 0)}function w(a){if(e.isFunction(n.isComplete))return n.isComplete.call(q,a,n);if("*"!=n.repeat){var s=!1,r=0,o=i;return e.each(t,function(e,t){if("object"==typeof t){i=e;var n=P(b());if(t.lastValidPosition>=r&&t.lastValidPosition==n){for(var o=!0,u=0;n>=u;u++){var l=g(u),c=_(u);if(l&&(void 0==a[u]||a[u]==j(u))||!l&&a[u]!=v()[c]){o=!1;break}}if(s=s||o)return!1}r=t.lastValidPosition}}),i=o,s}}function N(t){t=e._data(t).events,e.each(t,function(t,i){e.each(i,function(e,t){if("inputmask"==t.namespace&&"setvalue"!=t.type){var i=t.handler;t.handler=function(e){return this.readOnly||this.disabled?void e.preventDefault:i.apply(this,arguments)}}})})}function L(t){function i(t){if(void 0==e.valHooks[t]||1!=e.valHooks[t].inputmaskpatch){var i=e.valHooks[t]&&e.valHooks[t].get?e.valHooks[t].get:function(e){return e.value},n=e.valHooks[t]&&e.valHooks[t].set?e.valHooks[t].set:function(e,t){return e.value=t,e};e.valHooks[t]={get:function(t){var n=e(t);return n.data("_inputmask")?n.data("_inputmask").opts.autoUnmask?n.inputmask("unmaskedvalue"):(t=i(t),n=n.data("_inputmask"),t!=n.masksets[n.activeMasksetIndex]._buffer.join("")?t:""):i(t)},set:function(t,i){var a=e(t),s=n(t,i);return a.data("_inputmask")&&a.triggerHandler("setvalue.inputmask"),s},inputmaskpatch:!0}}}var n;if(Object.getOwnPropertyDescriptor&&(n=Object.getOwnPropertyDescriptor(t,"value")),n&&n.get){if(!t._valueGet){var a=n.get,s=n.set;t._valueGet=function(){return Z?a.call(this).split("").reverse().join(""):a.call(this)},t._valueSet=function(e){s.call(this,Z?e.split("").reverse().join(""):e)},Object.defineProperty(t,"value",{get:function(){var t=e(this),i=e(this).data("_inputmask"),n=i.masksets,s=i.activeMasksetIndex;return i&&i.opts.autoUnmask?t.inputmask("unmaskedvalue"):a.call(this)!=n[s]._buffer.join("")?a.call(this):""},set:function(t){s.call(this,t),e(this).triggerHandler("setvalue.inputmask")}})}}else document.__lookupGetter__&&t.__lookupGetter__("value")?t._valueGet||(a=t.__lookupGetter__("value"),s=t.__lookupSetter__("value"),t._valueGet=function(){return Z?a.call(this).split("").reverse().join(""):a.call(this)},t._valueSet=function(e){s.call(this,Z?e.split("").reverse().join(""):e)},t.__defineGetter__("value",function(){var t=e(this),i=e(this).data("_inputmask"),n=i.masksets,s=i.activeMasksetIndex;return i&&i.opts.autoUnmask?t.inputmask("unmaskedvalue"):a.call(this)!=n[s]._buffer.join("")?a.call(this):""}),t.__defineSetter__("value",function(t){s.call(this,t),e(this).triggerHandler("setvalue.inputmask")})):(t._valueGet||(t._valueGet=function(){return Z?this.value.split("").reverse().join(""):this.value},t._valueSet=function(e){this.value=Z?e.split("").reverse().join(""):e}),i(t.type))}function R(e,t,i,n){var a=h();if(!1!==n)for(;!g(e)&&e-1>=0;)e--;for(n=e;t>n&&n<b();n++)if(g(n)){I(a,n);var s=y(n),r=M(a,s);if(r!=j(s))if(s<b()&&!1!==k(n,r,!0)&&p()[_(n)].def==p()[_(s)].def)C(a,n,r,!0);else if(g(n))break}else I(a,n);if(void 0!=i&&C(a,P(t),i),0==f().greedy){for(t=T(a.join("")).split(""),a.length=t.length,n=0,i=a.length;i>n;n++)a[n]=t[n];0==a.length&&(f().buffer=v().slice())}return e}function B(e,t,i){var n=h();if(M(n,e,!0)!=j(e))for(var a=P(t);a>e&&a>=0;a--)if(g(a)){var s=P(a),r=M(n,s);r!=j(s)&&!1!==k(a,r,!0)&&p()[_(a)].def==p()[_(s)].def&&(C(n,a,r,!0),I(n,s))}else I(n,a);if(void 0!=i&&M(n,e)==j(e)&&C(n,e,i),e=n.length,0==f().greedy){for(i=T(n.join("")).split(""),n.length=i.length,a=0,s=n.length;s>a;a++)n[a]=i[a];0==n.length&&(f().buffer=v().slice())}return t-(e-n.length)}function F(e,t,i){if(n.numericInput||Z){switch(t){case n.keyCode.BACKSPACE:t=n.keyCode.DELETE;break;case n.keyCode.DELETE:t=n.keyCode.BACKSPACE}if(Z){var a=i.end;i.end=i.begin,i.begin=a}}a=!0,i.begin==i.end?(a=t==n.keyCode.BACKSPACE?i.begin-1:i.begin,n.isNumeric&&""!=n.radixPoint&&h()[a]==n.radixPoint&&(i.begin=h().length-1==a?i.begin:t==n.keyCode.BACKSPACE?a:y(a),i.end=i.begin),a=!1,t==n.keyCode.BACKSPACE?i.begin--:t==n.keyCode.DELETE&&i.end++):1!=i.end-i.begin||n.insertMode||(a=!1,t==n.keyCode.BACKSPACE&&i.begin--),E(h(),i.begin,i.end);var s=b();if(0==n.greedy&&(isNaN(n.repeat)||0<n.repeat))R(i.begin,s,void 0,!Z&&t==n.keyCode.BACKSPACE&&!a);else{for(var r=i.begin,o=i.begin;o<i.end;o++)(g(o)||!a)&&(r=R(i.begin,s,void 0,!Z&&t==n.keyCode.BACKSPACE&&!a));a||(i.begin=r)}t=y(-1),E(h(),i.begin,i.end,!0),V(e,!1,!1,h()),f().lastValidPosition<t?(f().lastValidPosition=-1,f().p=t):f().p=i.begin}function H(t){Y=!1;var i=this,a=e(i),s=t.keyCode,o=K(i);s==n.keyCode.BACKSPACE||s==n.keyCode.DELETE||r&&127==s||t.ctrlKey&&88==s?(t.preventDefault(),88==s&&(Q=h().join("")),F(i,s,o),m(),x(i,h(),f().p),i._valueGet()==v().join("")&&a.trigger("cleared"),n.showTooltip&&a.prop("title",f().mask)):s==n.keyCode.END||s==n.keyCode.PAGE_DOWN?setTimeout(function(){var e=y(f().lastValidPosition);n.insertMode||e!=b()||t.shiftKey||e--,K(i,t.shiftKey?o.begin:e,e)},0):s==n.keyCode.HOME&&!t.shiftKey||s==n.keyCode.PAGE_UP?K(i,0,t.shiftKey?o.begin:0):s==n.keyCode.ESCAPE||90==s&&t.ctrlKey?(V(i,!0,!1,Q.split("")),a.click()):s!=n.keyCode.INSERT||t.shiftKey||t.ctrlKey?0!=n.insertMode||t.shiftKey||(s==n.keyCode.RIGHT?setTimeout(function(){var e=K(i);K(i,e.begin)},0):s==n.keyCode.LEFT&&setTimeout(function(){var e=K(i);K(i,e.begin-1)},0)):(n.insertMode=!n.insertMode,K(i,n.insertMode||o.begin!=b()?o.begin:o.begin-1)),a=K(i),!0===n.onKeyDown.call(this,t,h(),n)&&K(i,a.begin,a.end),ee=-1!=e.inArray(s,n.ignorables)}function U(a,s,r,o,u,l){if(void 0==r&&Y)return!1;Y=!0;var c=e(this);if(a=a||window.event,r=s?r:a.which||a.charCode||a.keyCode,!(!0===s||a.ctrlKey&&a.altKey)&&(a.ctrlKey||a.metaKey||ee))return!0;if(r){!0!==s&&46==r&&0==a.shiftKey&&","==n.radixPoint&&(r=44);var d,p,v=String.fromCharCode(r);s?(r=u?l:f().lastValidPosition+1,d={begin:r,end:r}):d=K(this),l=Z?1<d.begin-d.end||1==d.begin-d.end&&n.insertMode:1<d.end-d.begin||1==d.end-d.begin&&n.insertMode;var g=i;l&&(e.each(t,function(e,t){"object"==typeof t&&(i=e,f().undoBuffer=h().join(""))}),i=g,F(this,n.keyCode.DELETE,d),n.insertMode||e.each(t,function(e,t){"object"==typeof t&&(i=e,B(d.begin,b()),f().lastValidPosition=y(f().lastValidPosition))}),i=g);var _=h().join("").indexOf(n.radixPoint);n.isNumeric&&!0!==s&&-1!=_&&(n.greedy&&d.begin<=_?(d.begin=P(d.begin),d.end=d.begin):v==n.radixPoint&&(d.begin=_,d.end=d.begin));var A=d.begin;r=k(A,v,u),!0===u&&(r=[{activeMasksetIndex:i,result:r}]);var E=-1;if(e.each(r,function(e,t){i=t.activeMasksetIndex,f().writeOutBuffer=!0;var a=t.result;if(!1!==a){var s=!1,r=h();if(!0!==a&&(s=a.refresh,A=void 0!=a.pos?a.pos:A,v=void 0!=a.c?a.c:v),!0!==s){if(1==n.insertMode){for(a=b(),r=r.slice();M(r,a,!0)!=j(a)&&a>=A;)a=0==a?-1:P(a);a>=A?(B(A,b(),v),r=f().lastValidPosition,a=y(r),a!=b()&&r>=A&&M(h().slice(),a,!0)!=j(a)&&(f().lastValidPosition=a)):f().writeOutBuffer=!1}else C(r,A,v,!0);(-1==E||E>y(A))&&(E=y(A))}else!u&&(r=A<b()?A+1:A,-1==E||E>r)&&(E=r);E>f().p&&(f().p=E)}}),!0!==u&&(i=g,m()),!1!==o)if(e.each(r,function(e,t){return t.activeMasksetIndex==i?(p=t,!1):void 0}),void 0!=p){var I=this;if(setTimeout(function(){n.onKeyValidation.call(I,p.result,n)},0),f().writeOutBuffer&&!1!==p.result){var V=h();o=s?void 0:n.numericInput?A>_?P(E):v==n.radixPoint?E-1:P(E-1):E,x(this,V,o),!0!==s&&setTimeout(function(){!0===w(V)&&c.trigger("complete"),X=!0,c.trigger("input")},0)}else l&&(f().buffer=f().undoBuffer.split(""))}else l&&(f().buffer=f().undoBuffer.split(""));n.showTooltip&&c.prop("title",f().mask),a&&(a.preventDefault?a.preventDefault():a.returnValue=!1)}}function W(t){var i=e(this),a=t.keyCode,s=h();n.onKeyUp.call(this,t,s,n),a==n.keyCode.TAB&&n.showMaskOnFocus&&(i.hasClass("focus.inputmask")&&0==this._valueGet().length?(s=v().slice(),x(this,s),K(this,0),Q=h().join("")):(x(this,s),s.join("")==v().join("")&&-1!=e.inArray(n.radixPoint,s)?(K(this,D(0)),i.click()):K(this,D(0),D(b()))))}function $(t){if(!0===X&&"input"==t.type)return X=!1,!0;var i=this,a=e(i);return"propertychange"==t.type&&i._valueGet().length<=b()?!0:void setTimeout(function(){var t=e.isFunction(n.onBeforePaste)?n.onBeforePaste.call(i,i._valueGet(),n):i._valueGet();V(i,!1,!1,t.split(""),!0),x(i,h()),!0===w(h())&&a.trigger("complete"),a.click()},0)}function z(t){var i=e(this),a=K(this),s=this._valueGet(),s=s.replace(RegExp("("+S(v().join(""))+")*"),"");a.begin>s.length&&(K(this,s.length),a=K(this)),1!=h().length-s.length||s.charAt(a.begin)==h()[a.begin]||s.charAt(a.begin+1)==h()[a.begin]||g(a.begin)?(V(this,!1,!1,s.split("")),x(this,h()),!0===w(h())&&i.trigger("complete"),i.click()):(t.keyCode=n.keyCode.BACKSPACE,H.call(this,t)),t.preventDefault()}function J(s){if(q=e(s),q.is(":input")){if(q.data("_inputmask",{masksets:t,activeMasksetIndex:i,opts:n,isRTL:!1}),n.showTooltip&&q.prop("title",f().mask),f().greedy=f().greedy?f().greedy:0==f().repeat,null!=q.attr("maxLength")){var r=q.prop("maxLength");r>-1&&e.each(t,function(e,t){"object"==typeof t&&"*"==t.repeat&&(t.repeat=r)}),b()>=r&&r>-1&&(r<v().length&&(v().length=r),0==f().greedy&&(f().repeat=Math.round(r/v().length)),q.prop("maxLength",2*b()))}if(L(s),n.numericInput&&(n.isNumeric=n.numericInput),("rtl"==s.dir||n.numericInput&&n.rightAlignNumerics||n.isNumeric&&n.rightAlignNumerics)&&q.css("text-align","right"),"rtl"==s.dir||n.numericInput){s.dir="ltr",q.removeAttr("dir");var p=q.data("_inputmask");p.isRTL=!0,q.data("_inputmask",p),Z=!0}q.unbind(".inputmask"),q.removeClass("focus.inputmask"),q.closest("form").bind("submit",function(){Q!=h().join("")&&q.change()}).bind("reset",function(){setTimeout(function(){q.trigger("setvalue")},0)}),q.bind("mouseenter.inputmask",function(){!e(this).hasClass("focus.inputmask")&&n.showMaskOnHover&&this._valueGet()!=h().join("")&&x(this,h())}).bind("blur.inputmask",function(){var a=e(this),s=this._valueGet(),r=h();a.removeClass("focus.inputmask"),Q!=h().join("")&&a.change(),n.clearMaskOnLostFocus&&""!=s&&(s==v().join("")?this._valueSet(""):O(this)),!1===w(r)&&(a.trigger("incomplete"),n.clearIncomplete&&(e.each(t,function(e,t){"object"==typeof t&&(t.buffer=t._buffer.slice(),t.lastValidPosition=-1)}),i=0,n.clearMaskOnLostFocus?this._valueSet(""):(r=v().slice(),x(this,r))))}).bind("focus.inputmask",function(){var t=e(this),i=this._valueGet();n.showMaskOnFocus&&!t.hasClass("focus.inputmask")&&(!n.showMaskOnHover||n.showMaskOnHover&&""==i)&&this._valueGet()!=h().join("")&&x(this,h(),y(f().lastValidPosition)),t.addClass("focus.inputmask"),Q=h().join("")}).bind("mouseleave.inputmask",function(){var t=e(this);n.clearMaskOnLostFocus&&(t.hasClass("focus.inputmask")||this._valueGet()==t.attr("placeholder")||(this._valueGet()==v().join("")||""==this._valueGet()?this._valueSet(""):O(this)))}).bind("click.inputmask",function(){var t=this;setTimeout(function(){var i=K(t),a=h();if(i.begin==i.end){var i=Z?D(i.begin):i.begin,s=f().lastValidPosition,a=n.isNumeric&&!1===n.skipRadixDance&&""!=n.radixPoint&&-1!=e.inArray(n.radixPoint,a)?n.numericInput?y(e.inArray(n.radixPoint,a)):e.inArray(n.radixPoint,a):y(s);a>i?g(i)?K(t,i):K(t,y(i)):K(t,a)}},0)}).bind("dblclick.inputmask",function(){var e=this;setTimeout(function(){K(e,0,y(f().lastValidPosition))},0)}).bind(d+".inputmask dragdrop.inputmask drop.inputmask",$).bind("setvalue.inputmask",function(){V(this,!0),Q=h().join(""),this._valueGet()==v().join("")&&this._valueSet("")}).bind("complete.inputmask",n.oncomplete).bind("incomplete.inputmask",n.onincomplete).bind("cleared.inputmask",n.oncleared),q.bind("keydown.inputmask",H).bind("keypress.inputmask",U).bind("keyup.inputmask",W),(o||l||u||c)&&(q.attr("autocomplete","off").attr("autocorrect","off").attr("autocapitalize","off").attr("spellcheck",!1),(l||c)&&(q.unbind("keydown.inputmask",H).unbind("keypress.inputmask",U).unbind("keyup.inputmask",W),"input"==d&&q.unbind(d+".inputmask"),q.bind("input.inputmask",z))),a&&q.bind("input.inputmask",$),p=e.isFunction(n.onBeforeMask)?n.onBeforeMask.call(s,s._valueGet(),n):s._valueGet(),V(s,!0,!1,p.split("")),Q=h().join("");var k;try{k=document.activeElement}catch(m){}k===s?(q.addClass("focus.inputmask"),K(s,y(f().lastValidPosition))):n.clearMaskOnLostFocus?h().join("")==v().join("")?s._valueSet(""):O(s):x(s,h()),N(s)}}var q,Z=!1,Q=h().join(""),Y=!1,X=!1,ee=!1;if(void 0!=s)switch(s.action){case"isComplete":return w(s.buffer);case"unmaskedvalue":return Z=s.$input.data("_inputmask").isRTL,G(s.$input,s.skipDatepickerCheck);case"mask":J(s.el);break;case"format":return q=e({}),q.data("_inputmask",{masksets:t,activeMasksetIndex:i,opts:n,isRTL:n.numericInput}),n.numericInput&&(n.isNumeric=n.numericInput,Z=!0),V(q,!1,!1,s.value.split(""),!0),h().join("");case"isValid":return q=e({}),q.data("_inputmask",{masksets:t,activeMasksetIndex:i,opts:n,isRTL:n.numericInput}),n.numericInput&&(n.isNumeric=n.numericInput,Z=!0),V(q,!1,!0,s.value.split("")),w(h())}};e.inputmask={defaults:{placeholder:"_",optionalmarker:{start:"[",end:"]"},quantifiermarker:{start:"{",end:"}"},groupmarker:{start:"(",end:")"},escapeChar:"\\",mask:null,oncomplete:e.noop,onincomplete:e.noop,oncleared:e.noop,repeat:0,greedy:!0,autoUnmask:!1,clearMaskOnLostFocus:!0,insertMode:!0,clearIncomplete:!1,aliases:{},onKeyUp:e.noop,onKeyDown:e.noop,onBeforeMask:void 0,onBeforePaste:void 0,onUnMask:void 0,showMaskOnFocus:!0,showMaskOnHover:!0,onKeyValidation:e.noop,skipOptionalPartCharacter:" ",showTooltip:!1,numericInput:!1,isNumeric:!1,radixPoint:"",skipRadixDance:!1,rightAlignNumerics:!0,definitions:{9:{validator:"[0-9]",cardinality:1,definitionSymbol:"*"},a:{validator:"[A-Za-z\u0410-\u044f\u0401\u0451]",cardinality:1,definitionSymbol:"*"},"*":{validator:"[A-Za-z\u0410-\u044f\u0401\u04510-9]",cardinality:1}},keyCode:{ALT:18,BACKSPACE:8,CAPS_LOCK:20,COMMA:188,COMMAND:91,COMMAND_LEFT:91,COMMAND_RIGHT:93,CONTROL:17,DELETE:46,DOWN:40,END:35,ENTER:13,ESCAPE:27,HOME:36,INSERT:45,LEFT:37,MENU:93,NUMPAD_ADD:107,NUMPAD_DECIMAL:110,NUMPAD_DIVIDE:111,NUMPAD_ENTER:108,NUMPAD_MULTIPLY:106,NUMPAD_SUBTRACT:109,PAGE_DOWN:34,PAGE_UP:33,PERIOD:190,RIGHT:39,SHIFT:16,SPACE:32,TAB:9,UP:38,WINDOWS:91},ignorables:[8,9,13,19,27,33,34,35,36,37,38,39,40,45,46,93,112,113,114,115,116,117,118,119,120,121,122,123],getMaskLength:void 0,isComplete:void 0},escapeRegex:function(e){return e.replace(RegExp("(\\/|\\.|\\*|\\+|\\?|\\||\\(|\\)|\\[|\\]|\\{|\\}|\\\\)","gim"),"\\$1")},format:function(t,a){var s=e.extend(!0,{},e.inputmask.defaults,a);return i(s.alias,a,s),f(n(s),0,s,{action:"format",value:t})},isValid:function(t,a){var s=e.extend(!0,{},e.inputmask.defaults,a);return i(s.alias,a,s),f(n(s),0,s,{action:"isValid",value:t})}},e.fn.inputmask=function(t,a){var s,r=e.extend(!0,{},e.inputmask.defaults,a),o=0;if("string"==typeof t)switch(t){case"mask":return i(r.alias,a,r),s=n(r),0==s.length?this:this.each(function(){f(e.extend(!0,{},s),0,r,{action:"mask",el:this})});case"unmaskedvalue":var u=e(this);return u.data("_inputmask")?(s=u.data("_inputmask").masksets,o=u.data("_inputmask").activeMasksetIndex,r=u.data("_inputmask").opts,f(s,o,r,{action:"unmaskedvalue",$input:u})):u.val();case"remove":return this.each(function(){var t=e(this);if(t.data("_inputmask")){s=t.data("_inputmask").masksets,o=t.data("_inputmask").activeMasksetIndex,r=t.data("_inputmask").opts,this._valueSet(f(s,o,r,{action:"unmaskedvalue",$input:t,skipDatepickerCheck:!0})),t.removeData("_inputmask"),t.unbind(".inputmask"),t.removeClass("focus.inputmask");var i;Object.getOwnPropertyDescriptor&&(i=Object.getOwnPropertyDescriptor(this,"value")),i&&i.get?this._valueGet&&Object.defineProperty(this,"value",{get:this._valueGet,set:this._valueSet}):document.__lookupGetter__&&this.__lookupGetter__("value")&&this._valueGet&&(this.__defineGetter__("value",this._valueGet),this.__defineSetter__("value",this._valueSet));try{delete this._valueGet,delete this._valueSet}catch(n){this._valueSet=this._valueGet=void 0}}});case"getemptymask":return this.data("_inputmask")?(s=this.data("_inputmask").masksets,o=this.data("_inputmask").activeMasksetIndex,s[o]._buffer.join("")):"";case"hasMaskedValue":return this.data("_inputmask")?!this.data("_inputmask").opts.autoUnmask:!1;case"isComplete":return s=this.data("_inputmask").masksets,o=this.data("_inputmask").activeMasksetIndex,r=this.data("_inputmask").opts,f(s,o,r,{action:"isComplete",buffer:this[0]._valueGet().split("")});case"getmetadata":if(this.data("_inputmask"))return s=this.data("_inputmask").masksets,o=this.data("_inputmask").activeMasksetIndex,s[o].metadata;break;default:return i(t,a,r)||(r.mask=t),s=n(r),0==s.length?this:this.each(function(){f(e.extend(!0,{},s),o,r,{action:"mask",el:this})})}else{if("object"==typeof t)return r=e.extend(!0,{},e.inputmask.defaults,t),i(r.alias,t,r),s=n(r),0==s.length?this:this.each(function(){f(e.extend(!0,{},s),o,r,{action:"mask",el:this})});if(void 0==t)return this.each(function(){var t=e(this).attr("data-inputmask");if(t&&""!=t)try{var t=t.replace(RegExp("'","g"),'"'),n=e.parseJSON("{"+t+"}");e.extend(!0,n,a),r=e.extend(!0,{},e.inputmask.defaults,n),i(r.alias,n,r),r.alias=void 0,e(this).inputmask(r)}catch(s){}})}}}}(jQuery);