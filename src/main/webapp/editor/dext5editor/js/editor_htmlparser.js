(function(){function f(a){var c={};a=a.split(",");for(var d=0;d<a.length;d++)c[a[d]]=!0;return c}var p=/^<([-A-Za-z0-9_]+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/,v=/^<\/([-A-Za-z0-9_:]+)[^>]*>/,x=/([-A-Za-z0-9_]+)(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?/g,u=/^<([-A-Za-z0-9_:-]+)((?:\s+[a-zA-Z_0-9:-]+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/,y=/([-A-Za-z0-9_:-]+)(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?/g,
z=f("colgroup,col"),A=f("area,base,basefont,br,col,frame,hr,img,input,isindex,link,meta,param,embed");f("area,base,basefont,br,col,frame,img,input,isindex,link,meta,param,embed");var B=f("address,applet,blockquote,button,center,dd,del,dir,div,dl,dt,fieldset,form,frameset,hr,iframe,ins,isindex,li,map,menu,noframes,noscript,object,ol,p,pre,script,table,tbody,td,tfoot,th,thead,tr,ul,h1,h2,h3,h4,h5,h6,figure"),w=f("a,abbr,acronym,applet,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,iframe,img,input,ins,kbd,label,map,object,q,s,samp,script,select,small,span,strike,strong,sub,sup,textarea,tt,u,var"),
C=f("colgroup,dd,dt,li,options,p,td,tfoot,th,thead,tr"),D=f("checked,compact,declare,defer,disabled,ismap,multiple,nohref,noresize,noshade,nowrap,readonly,selected"),E=f("");"undefined"==typeof DEXT5_EDITOR&&(DEXT5_EDITOR={});DEXT5_EDITOR.HTMLParser=function(a,c,d){function t(a,b,m,n){b=b.toLowerCase();if(B[b]){for("table"!=h.last()&&"tbody"!=h.last()||"td"!=b||t("","tr","","");h.last()&&w[h.last()];)l("",h.last());"p"!=h.last()||"table"!=b&&"hr"!=b&&"center"!=b&&"figure"!=b||l("","p")}C[b]&&h.last()==
b&&l("",b);(n=A[b]||!!n)||h.push(b);if(d.start){var c=[];a=p.test(a)?x:y;m.replace(a,function(a,b,m,d,n){m=m?m:d?d:n?n:D[b]?b:"";d="";""!=a&&(a=a.substring(a.indexOf(b)+b.length),a=a.substring(a.indexOf("=")+1),a=a.replace(/^\s+/,""),d=a.substring(0,1),"'"!=d&&'"'!=d&&(d=""));c.push({name:b,value:m,escaped:m.replace(/(^|[^\\])"/g,'$1\\"'),quotationmark:d})});d.start&&d.start(b,c,n)}}function l(a,b){if(b)for(b=b.toLowerCase(),m=h.length-1;0<=m&&h[m]!=b;m--);else var m=0;if(0<=m){for(var n=h.length-
1;n>=m;n--)d.end&&d.end(h[n]);h.length=m}}var b,e,h=[],f=a;for(h.last=function(){return this[this.length-1]};a;){e=!0;if(h.last()&&E[h.last()])a=a.replace(new RegExp("(.*)</"+h.last()+"[^>]*>"),function(a,b){b=b.replace(/\x3c!--(.*?)--\x3e/g,"$1").replace(/<!\[CDATA\[(.*?)]]\x3e/g,"$1");d.chars&&d.chars(b);return""}),l("",h.last());else{var g=a.indexOf("<");b=a.indexOf(">")+1;var q=a.substring(g,b);if(0==a.indexOf("\x3c!--"))b=a.indexOf("--\x3e"),0<=b&&(d.comment&&d.comment(a.substring(4,b)),a=a.substring(b+
3),e=!1);else if(0==a.toLowerCase().indexOf("<?xml"))b=a.indexOf("/>"),0<=b&&(a=a.substring(b+2),e=!1);else if(0!=a.indexOf("<")&&"</"+h.last()+">"==q.replace(/ /ig,""))e=a.substring(0,g),a=a.substring(b),a=e+"</"+h.last()+">"+a,e=!0;else if(0==a.indexOf("</")){if(b=a.match(v))a=a.substring(b[0].length),b[0].replace(v,l),e=!1}else if(0==a.indexOf("<"))if(b=a.match(p))a=a.substring(b[0].length),b[0].replace(p,t),e=!1;else if(b=a.match(u))a=a.substring(b[0].length),b[0].replace(u,t),e=!1;else if("1"==
DEXTTOP.G_CURREDITOR._config.removeIncorrectAttribute&&(b=a.indexOf("<"),q=a.indexOf(">"),0==b&&0<q)){var k=a.substring(0,q+1),r=g=b=0;0<k.indexOf('\ub9d1\uc740=""')?(b=k.indexOf('\ub9d1\uc740=""'),g=5,r=k.split('\ub9d1\uc740=""').length):0<k.indexOf("\ub9d1\uc740=''")&&(b=k.indexOf("\ub9d1\uc740=''"),g=5,r=k.split("\ub9d1\uc740=''").length);if(2==r&&0<b&&(q=a.substring(q+1),r=k.substring(0,b).lastIndexOf(" "),r<b+g))if(a=k.substring(r,b+g),k=k.replace(a,""),a=k+q,b=a.match(p))a=a.substring(b[0].length),
b[0].replace(p,t),e=!1;else if(b=a.match(u))a=a.substring(b[0].length),b[0].replace(u,t),e=!1}e&&(b=a.indexOf("<"),e=0>b?a:a.substring(0,b),a=0>b?"":a.substring(b),d.chars&&(h.last()&&w[h.last()]&&"textarea"!=h.last()&&"script"!=h.last()&&(b=!1,g=RegExp("\\S\\n","g"),g.test(e)&&(b=!0),g=RegExp("\\n\\S","g"),g.test(e)&&(b=!0),g=RegExp("\\S\\n\\S","g"),g.test(e)&&(b=!0),b?e=e.replace(/\n/g," "):(g=RegExp("\\n\\n","g"),g.test(e)&&""==e.trim()?e=e.replace(/\n\n/g,""):e==unescape("%20%20")&&(b=new RegExp(unescape("%20"),
"g"),e=e.replace(b,"&nbsp;")))),"1"==DEXTTOP.G_CURREDITOR._config.replaceSpace&&c&&(b=new RegExp(unescape("%20%20"),"g"),e=e.replace(b,"&nbsp; ")),d.chars(e)))}if(a==f)throw"Parse Error: "+a;f=a}l()};DEXT5_EDITOR.HTMLParser.HTMLtoXML=function(a,c){var d="";DEXT5_EDITOR.HTMLParser(a,c,{start:function(a,c,b){d+="<"+a;for(a=0;a<c.length;a++)d="href"==c[a].name||"src"==c[a].name?d+(" "+c[a].name+"="+c[a].quotationmark+c[a].value+c[a].quotationmark):""!=c[a].quotationmark?d+(" "+c[a].name+"="+c[a].quotationmark+
c[a].value+c[a].quotationmark):d+(" "+c[a].name+'="'+c[a].escaped+'"');d+=(b?"/":"")+">"},end:function(a){z[a]||(d+="</"+a+">")},chars:function(a){d+=a},comment:function(a){d="0"==DEXTTOP.G_CURREDITOR._config.removeComment?d+("\x3c!--"+a+"--\x3e"):d+""}});return d};DEXT5_EDITOR.HTMLParser.RemoveOfficeTag=function(a,c){if(""==a||void 0==a)return"";a=DEXT5_EDITOR.HTMLParser.RemoveOfficeTag2(a);a=DEXTTOP.DEXT5.util.replaceOneSpaceToNbsp(a);c&&(a=a.replace(/(<span[^>]*>)\s<\/span>/gi,"$1&nbsp;</span>"),
a=a.replace(/>\s+</g,"><"));return a};DEXT5_EDITOR.HTMLParser.RemoveOfficeTag2=function(a){var c=RegExp("<o:p></o:p>","gi");a=a.replace(c,"");c=RegExp("<o:p>\\s+</o:p>","gi");a=a.replace(c,"");c=RegExp("<o:p ([^>]+)></o:p>","gi");a=a.replace(c,"");c=RegExp("<o:p ([^>]+)>\\s+</o:p>","gi");a=a.replace(c,"");a=a.replace(/\slang=[\"]?en-us[\"]?/gi,"");"1"==DEXTTOP.G_CURREDITOR._config.removeMsoClass&&(a=a.replace(/\sclass=[\"]?(mso)\w+[\"]?/gi,""));a=a.replace(/&quot;/gi,"&quot_dext;");c=RegExp('(\\s+)?mso-number-format:(\\s+)?"(.+?)"(\\s+)?;',
"gi");a=a.replace(c,"");c=RegExp('(\\s+)?mso-number-format:(\\s+)?"(.+?)"(\\s+)?;?',"gi");a=a.replace(c,"");c=RegExp("\\s?mso-[\\w\uac00-\ud7a3\\-: ?'\"@%\\.\\\\_]+; ?","gi");a=a.replace(c,"");c=RegExp("\\s?mso-[\\w\uac00-\ud7a3\\-: ?]+(['\"])","gi");a=a.replace(c,"$1");a=a.replace(/&quot_dext;/gi,"&quot;");c=RegExp("<v:shapetype ([^>]+)>[\\s\\S]*?</v:shapetype>","gi");a=a.replace(c,"");c=RegExp("<v:shape [^>]+>[\\s\\S]*?(<img [^>]+>)*?</v:shape>","gi");a=a.replace(c,"$1");c=RegExp("<v:shape ([^>]+)>[\\s\\S]*?</v:shape>",
"gi");a=a.replace(c,"");return a=a.replace(/<\!\[if ppt\]>/gi,"")};DEXT5_EDITOR.HTMLParser.CleanNestedHtml=function(a,c,d,f){function l(a,b){for(var d=0,c=a.childNodes.length,e=0;e<c;e++)3!=a.childNodes[e].nodeType&&(b&&(d+=l(a.childNodes[e],b)),d++);return d}function b(a){for(var b="",d=Array(a.childNodes.length),c=0;c<d.length;c++){d[c]=[];d[c].push(a.childNodes[c]);e(a.childNodes[c],d[c]);var h=c,g=d[c],f=[],k=0;a:for(;k<g.length;k++){for(var l=0;l<f.length;l++)if(f[l]==g[k])continue a;f[f.length]=
g[k]}d[h]=f;b+=d[c].join("")}return b}function e(a,b){for(var d=a.childNodes,c=0;c<d.length;c++)b.push(d[c]),d[c].hasChildNodes()&&e(d[c],b);for(var d=0,f;d<b.length;d++){c=b[d];if(1==c.nodeType){f=c.nodeName;if(-1==(" "+q.join(" ").toUpperCase()+" ").search(" "+f.toUpperCase()+" ")){b.splice(d,1);d--;continue}f=c;for(var g="",k=0,l=void 0;k<f.attributes.length;k++)l=f.attributes[k],1==l.specified&&("style"==l.name?(l=h(f),""!=l&&(g+=' style="'+h(f)+'"')):""!=l.value&&(g+=" "+l.name+'="'+l.value+
'"'));f=g;c="<"+c.nodeName.toLowerCase()+f+">"}else 3==c.nodeType&&(c=c.nodeValue.replace(/\n/g,""));b[d]=c}return b}function h(a){for(var b="",c=0,d=g.length,e;c<d;c++)a.currentStyle?e=a.currentStyle[g[c]]:window.getComputedStyle&&(e=document.defaultView.getComputedStyle(a,null).getPropertyValue(g[c])),b+=g[c]+":"+e+";";return b}var p=50,g=[],q="p a abbr acronym applet b basefont bdo big br button cite code del dfn em font i iframe img input ins kbd label map object q s samp script select small strike strong sub sup textarea tt u var".split(" ");
"undefined"!=typeof d&&(p=parseInt(d));d="p";f&&(d=f);var k=a._DOC.getElementsByTagName(d);f=!1;d=0;for(var r=k.length;d<r;d++)if(l(k[d],!0)>p){f=!0;break}f&&(showProcessingBackground(),setTimeout(function(){a._BODY.contentEditable=!1;try{if("2"==c)DEXTTOP.DEXT5.DextCommands("select_all",a.ID),DEXTTOP.DEXT5.DextCommands("remove_css",a.ID),DEXTTOP.DEXT5.DextCommands("remove_format",a.ID),a._FRAMEWIN.setFocusToBody(),setTimeout(function(){a._FRAMEWIN.doSetCaretPosition(a._BODY.firstChild,0)},20);else for(var d=
0,e=k.length,f;d<e;d++)l(k[d],!0)>p&&(f=b(k[d]),f=DEXT5_EDITOR.HTMLParser.HTMLtoXML(f),k[d].innerHTML=f)}catch(g){}hideProcessingBackground();a._BODY.contentEditable=!0},G_Progress_LoadTime))};DEXT5_EDITOR.HTMLParser.makeMap=function(a){return f(a)}})();