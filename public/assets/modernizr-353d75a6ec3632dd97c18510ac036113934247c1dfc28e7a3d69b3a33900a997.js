window.Modernizr=function(e,t,n){function r(e){g.cssText=e}function o(e,t){return typeof e===t}function i(e,t){return!!~(""+e).indexOf(t)}function a(e,t){for(var r in e){var o=e[r];if(!i(o,"-")&&g[o]!==n)return"pfx"==t?o:!0}return!1}function c(e,t,r){for(var i in e){var a=t[e[i]];if(a!==n)return r===!1?e[i]:o(a,"function")?a.bind(r||t):a}return!1}function l(e,t,n){var r=e.charAt(0).toUpperCase()+e.slice(1),i=(e+" "+b.join(r+" ")+r).split(" ");return o(t,"string")||o(t,"undefined")?a(i,t):(i=(e+" "+x.join(r+" ")+r).split(" "),c(i,t,n))}var s,u,f,p="2.7.1",d={},m=!0,h=t.documentElement,v="modernizr",y=t.createElement(v),g=y.style,E=({}.toString,"Webkit Moz O ms"),b=E.split(" "),x=E.toLowerCase().split(" "),j={},S=[],N=S.slice,T={}.hasOwnProperty;f=o(T,"undefined")||o(T.call,"undefined")?function(e,t){return t in e&&o(e.constructor.prototype[t],"undefined")}:function(e,t){return T.call(e,t)},Function.prototype.bind||(Function.prototype.bind=function(e){var t=this;if("function"!=typeof t)throw new TypeError;var n=N.call(arguments,1),r=function(){if(this instanceof r){var o=function(){};o.prototype=t.prototype;var i=new o,a=t.apply(i,n.concat(N.call(arguments)));return Object(a)===a?a:i}return t.apply(e,n.concat(N.call(arguments)))};return r}),j.flexbox=function(){return l("flexWrap")},j.flexboxlegacy=function(){return l("boxDirection")};for(var w in j)f(j,w)&&(u=w.toLowerCase(),d[u]=j[w](),S.push((d[u]?"":"no-")+u));return d.addTest=function(e,t){if("object"==typeof e)for(var r in e)f(e,r)&&d.addTest(r,e[r]);else{if(e=e.toLowerCase(),d[e]!==n)return d;t="function"==typeof t?t():t,"undefined"!=typeof m&&m&&(h.className+=" "+(t?"":"no-")+e),d[e]=t}return d},r(""),y=s=null,d._version=p,d._domPrefixes=x,d._cssomPrefixes=b,d.testProp=function(e){return a([e])},d.testAllProps=l,h.className=h.className.replace(/(^|\s)no-js(\s|$)/,"$1$2")+(m?" js "+S.join(" "):""),d}(this,this.document),function(e,t){function n(e,t){var n=e.createElement("p"),r=e.getElementsByTagName("head")[0]||e.documentElement;return n.innerHTML="x<style>"+t+"</style>",r.insertBefore(n.lastChild,r.firstChild)}function r(){var e=S.elements;return"string"==typeof e?e.split(" "):e}function o(e){var t=j[e[b]];return t||(t={},x++,e[b]=x,j[x]=t),t}function i(e,n,r){if(n||(n=t),h)return n.createElement(e);r||(r=o(n));var i;return i=r.cache[e]?r.cache[e].cloneNode():E.test(e)?(r.cache[e]=r.createElem(e)).cloneNode():r.createElem(e),!i.canHaveChildren||g.test(e)||i.tagUrn?i:r.frag.appendChild(i)}function a(e,n){if(e||(e=t),h)return e.createDocumentFragment();n=n||o(e);for(var i=n.frag.cloneNode(),a=0,c=r(),l=c.length;l>a;a++)i.createElement(c[a]);return i}function c(e,t){t.cache||(t.cache={},t.createElem=e.createElement,t.createFrag=e.createDocumentFragment,t.frag=t.createFrag()),e.createElement=function(n){return S.shivMethods?i(n,e,t):t.createElem(n)},e.createDocumentFragment=Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+r().join().replace(/\w+/g,function(e){return t.createElem(e),t.frag.createElement(e),'c("'+e+'")'})+");return n}")(S,t.frag)}function l(e){e||(e=t);var r=o(e);return S.shivCSS&&!m&&!r.hasCSS&&(r.hasCSS=!!n(e,"article,aside,dialog,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}mark{background:#FF0;color:#000}template{display:none}")),h||c(e,r),e}function s(e){for(var t,n=e.getElementsByTagName("*"),o=n.length,i=RegExp("^(?:"+r().join("|")+")$","i"),a=[];o--;)t=n[o],i.test(t.nodeName)&&a.push(t.applyElement(u(t)));return a}function u(e){for(var t,n=e.attributes,r=n.length,o=e.ownerDocument.createElement(T+":"+e.nodeName);r--;)t=n[r],t.specified&&o.setAttribute(t.nodeName,t.nodeValue);return o.style.cssText=e.style.cssText,o}function f(e){for(var t,n=e.split("{"),o=n.length,i=RegExp("(^|[\\s,>+~])("+r().join("|")+")(?=[[\\s,>+~#.:]|$)","gi"),a="$1"+T+"\\:$2";o--;)t=n[o]=n[o].split("}"),t[t.length-1]=t[t.length-1].replace(i,a),n[o]=t.join("}");return n.join("{")}function p(e){for(var t=e.length;t--;)e[t].removeNode()}function d(e){function t(){clearTimeout(a._removeSheetTimer),r&&r.removeNode(!0),r=null}var r,i,a=o(e),c=e.namespaces,l=e.parentWindow;return!w||e.printShived?e:("undefined"==typeof c[T]&&c.add(T),l.attachEvent("onbeforeprint",function(){t();for(var o,a,c,l=e.styleSheets,u=[],p=l.length,d=Array(p);p--;)d[p]=l[p];for(;c=d.pop();)if(!c.disabled&&N.test(c.media)){try{o=c.imports,a=o.length}catch(m){a=0}for(p=0;a>p;p++)d.push(o[p]);try{u.push(c.cssText)}catch(m){}}u=f(u.reverse().join("")),i=s(e),r=n(e,u)}),l.attachEvent("onafterprint",function(){p(i),clearTimeout(a._removeSheetTimer),a._removeSheetTimer=setTimeout(t,500)}),e.printShived=!0,e)}var m,h,v="3.7.0",y=e.html5||{},g=/^<|^(?:button|map|select|textarea|object|iframe|option|optgroup)$/i,E=/^(?:a|b|code|div|fieldset|h1|h2|h3|h4|h5|h6|i|label|li|ol|p|q|span|strong|style|table|tbody|td|th|tr|ul)$/i,b="_html5shiv",x=0,j={};!function(){try{var e=t.createElement("a");e.innerHTML="<xyz></xyz>",m="hidden"in e,h=1==e.childNodes.length||function(){t.createElement("a");var e=t.createDocumentFragment();return"undefined"==typeof e.cloneNode||"undefined"==typeof e.createDocumentFragment||"undefined"==typeof e.createElement}()}catch(n){m=!0,h=!0}}();var S={elements:y.elements||"abbr article aside audio bdi canvas data datalist details dialog figcaption figure footer header hgroup main mark meter nav output progress section summary template time video",version:v,shivCSS:y.shivCSS!==!1,supportsUnknownElements:h,shivMethods:y.shivMethods!==!1,type:"default",shivDocument:l,createElement:i,createDocumentFragment:a};e.html5=S,l(t);var N=/^$|\b(?:all|print)\b/,T="html5shiv",w=!h&&function(){var n=t.documentElement;return"undefined"!=typeof t.namespaces&&"undefined"!=typeof t.parentWindow&&"undefined"!=typeof n.applyElement&&"undefined"!=typeof n.removeNode&&"undefined"!=typeof e.attachEvent}();S.type+=" print",S.shivPrint=d,d(t)}(this,document),function(e,t,n){function r(e){return"[object Function]"==v.call(e)}function o(e){return"string"==typeof e}function i(){}function a(e){return!e||"loaded"==e||"complete"==e||"uninitialized"==e}function c(){var e=y.shift();g=1,e?e.t?m(function(){("c"==e.t?p.injectCss:p.injectJs)(e.s,0,e.a,e.x,e.e,1)},0):(e(),c()):g=0}function l(e,n,r,o,i,l,s){function u(t){if(!d&&a(f.readyState)&&(E.r=d=1,!g&&c(),f.onload=f.onreadystatechange=null,t)){"img"!=e&&m(function(){x.removeChild(f)},50);for(var r in w[n])w[n].hasOwnProperty(r)&&w[n][r].onload()}}var s=s||p.errorTimeout,f=t.createElement(e),d=0,v=0,E={t:r,s:n,e:i,a:l,x:s};1===w[n]&&(v=1,w[n]=[]),"object"==e?f.data=n:(f.src=n,f.type=e),f.width=f.height="0",f.onerror=f.onload=f.onreadystatechange=function(){u.call(this,v)},y.splice(o,0,E),"img"!=e&&(v||2===w[n]?(x.insertBefore(f,b?null:h),m(u,s)):w[n].push(f))}function s(e,t,n,r,i){return g=0,t=t||"j",o(e)?l("c"==t?S:j,e,t,this.i++,n,r,i):(y.splice(this.i++,0,e),1==y.length&&c()),this}function u(){var e=p;return e.loader={load:s,i:0},e}var f,p,d=t.documentElement,m=e.setTimeout,h=t.getElementsByTagName("script")[0],v={}.toString,y=[],g=0,E="MozAppearance"in d.style,b=E&&!!t.createRange().compareNode,x=b?d:h.parentNode,d=e.opera&&"[object Opera]"==v.call(e.opera),d=!!t.attachEvent&&!d,j=E?"object":d?"script":"img",S=d?"script":j,N=Array.isArray||function(e){return"[object Array]"==v.call(e)},T=[],w={},C={timeout:function(e,t){return t.length&&(e.timeout=t[0]),e}};p=function(e){function t(e){var t,n,r,e=e.split("!"),o=T.length,i=e.pop(),a=e.length,i={url:i,origUrl:i,prefixes:e};for(n=0;a>n;n++)r=e[n].split("="),(t=C[r.shift()])&&(i=t(i,r));for(n=0;o>n;n++)i=T[n](i);return i}function a(e,o,i,a,c){var l=t(e),s=l.autoCallback;l.url.split(".").pop().split("?").shift(),l.bypass||(o&&(o=r(o)?o:o[e]||o[a]||o[e.split("/").pop().split("?")[0]]),l.instead?l.instead(e,o,i,a,c):(w[l.url]?l.noexec=!0:w[l.url]=1,i.load(l.url,l.forceCSS||!l.forceJS&&"css"==l.url.split(".").pop().split("?").shift()?"c":n,l.noexec,l.attrs,l.timeout),(r(o)||r(s))&&i.load(function(){u(),o&&o(l.origUrl,c,a),s&&s(l.origUrl,c,a),w[l.url]=2})))}function c(e,t){function n(e,n){if(e){if(o(e))n||(f=function(){var e=[].slice.call(arguments);p.apply(this,e),d()}),a(e,f,t,0,s);else if(Object(e)===e)for(l in c=function(){var t,n=0;for(t in e)e.hasOwnProperty(t)&&n++;return n}(),e)e.hasOwnProperty(l)&&(!n&&!--c&&(r(f)?f=function(){var e=[].slice.call(arguments);p.apply(this,e),d()}:f[l]=function(e){return function(){var t=[].slice.call(arguments);e&&e.apply(this,t),d()}}(p[l])),a(e[l],f,t,l,s))}else!n&&d()}var c,l,s=!!e.test,u=e.load||e.both,f=e.callback||i,p=f,d=e.complete||i;n(s?e.yep:e.nope,!!u),u&&n(u)}var l,s,f=this.yepnope.loader;if(o(e))a(e,0,f,0);else if(N(e))for(l=0;l<e.length;l++)s=e[l],o(s)?a(s,0,f,0):N(s)?p(s):Object(s)===s&&c(s,f);else Object(e)===e&&c(e,f)},p.addPrefix=function(e,t){C[e]=t},p.addFilter=function(e){T.push(e)},p.errorTimeout=1e4,null==t.readyState&&t.addEventListener&&(t.readyState="loading",t.addEventListener("DOMContentLoaded",f=function(){t.removeEventListener("DOMContentLoaded",f,0),t.readyState="complete"},0)),e.yepnope=u(),e.yepnope.executeStack=c,e.yepnope.injectJs=function(e,n,r,o,l,s){var u,f,d=t.createElement("script"),o=o||p.errorTimeout;d.src=e;for(f in r)d.setAttribute(f,r[f]);n=s?c:n||i,d.onreadystatechange=d.onload=function(){!u&&a(d.readyState)&&(u=1,n(),d.onload=d.onreadystatechange=null)},m(function(){u||(u=1,n(1))},o),l?d.onload():h.parentNode.insertBefore(d,h)},e.yepnope.injectCss=function(e,n,r,o,a,l){var s,o=t.createElement("link"),n=l?c:n||i;o.href=e,o.rel="stylesheet",o.type="text/css";for(s in r)o.setAttribute(s,r[s]);a||(h.parentNode.insertBefore(o,h),m(n,0))}}(this,document),Modernizr.load=function(){yepnope.apply(window,[].slice.call(arguments,0))};