!function(t){t.extend(t.inputmask.defaults.definitions,{A:{validator:"[A-Za-z]",cardinality:1,casing:"upper"},"#":{validator:"[A-Za-z\u0410-\u044f\u0401\u04510-9]",cardinality:1,casing:"upper"}}),t.extend(t.inputmask.defaults.aliases,{url:{mask:"ir",placeholder:"",separator:"",defaultPrefix:"http://",regex:{urlpre1:/[fh]/,urlpre2:/(ft|ht)/,urlpre3:/(ftp|htt)/,urlpre4:/(ftp:|http|ftps)/,urlpre5:/(ftp:\/|ftps:|http:|https)/,urlpre6:/(ftp:\/\/|ftps:\/|http:\/|https:)/,urlpre7:/(ftp:\/\/|ftps:\/\/|http:\/\/|https:\/)/,urlpre8:/(ftp:\/\/|ftps:\/\/|http:\/\/|https:\/\/)/},definitions:{i:{validator:function(t,r,i,e,a){return!0},cardinality:8,prevalidator:function(){for(var t=[],r=0;8>r;r++)t[r]=function(){var t=r;return{validator:function(r,i,e,a,n){if(n.regex["urlpre"+(t+1)]){var l=r;if(0<t+1-r.length&&(l=i.join("").substring(0,t+1-r.length)+""+l),r=n.regex["urlpre"+(t+1)].test(l),!a&&!r){for(e-=t,a=0;a<n.defaultPrefix.length;a++)i[e]=n.defaultPrefix[a],e++;for(a=0;a<l.length-1;a++)i[e]=l[a],e++;return{pos:e}}return r}return!1},cardinality:t}}();return t}()},r:{validator:".",cardinality:50}},insertMode:!1,autoUnmask:!1},ip:{mask:["[[x]y]z.[[x]y]z.[[x]y]z.x[yz]","[[x]y]z.[[x]y]z.[[x]y]z.[[x]y][z]"],definitions:{x:{validator:"[012]",cardinality:1,definitionSymbol:"i"},y:{validator:function(t,r,i,e,a){return t=i-1>-1&&"."!=r[i-1]?r[i-1]+t:"0"+t,/2[0-5]|[01][0-9]/.test(t)},cardinality:1,definitionSymbol:"i"},z:{validator:function(t,r,i,e,a){return i-1>-1&&"."!=r[i-1]?(t=r[i-1]+t,t=i-2>-1&&"."!=r[i-2]?r[i-2]+t:"0"+t):t="00"+t,/25[0-5]|2[0-4][0-9]|[01][0-9][0-9]/.test(t)},cardinality:1,definitionSymbol:"i"}}}})}(jQuery);