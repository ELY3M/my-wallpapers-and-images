
/*Source from Public/Confomat/Js/confomat.js*/
// access to confomat from context
function Confomat() {
    this.fns = new Array();
    this.fns['producttypeChange'] = new Array();
    this.fns['applicationLoaded'] = new Array();
    this.fns['designChanged'] = new Array();
    this.fns['userLoggedIn'] = new Array();
}
Confomat.prototype = {
    subscribe : function(event, fn) {
        this.fns[event].push(fn);
    },
    unsubscribe : function(event, fn) {
        this.fns[event] = this.fns[event].filter(
            function(el) {
                if ( el !== fn ) {
                    return el;
                }
            }
        );
    },
    fire : function(event, o, thisObj) {
        var scope = thisObj || window;
        /*
        //using while because
        //this does not work in IE 8:
        this.fns[event].forEach(
            function(el) {
                el.call(scope, o);
            }
        );
        */
        var i = 0;
        while(true){
            if(typeof this.fns[event][i] == 'function'){
                this.fns[event][i].call(scope, o);
                i++;
            }else{
                break;
            }
        }
    },
    call : function(callback, arg){
        var globalCallback = 'document.Confomat.'+callback;
        if(typeof eval(globalCallback) == 'function'){
            return eval(globalCallback+'('+arg+')');
        }
    }
};

// access to context from confomat
function ConfomatContext(){
    this.checkoutUrl = undefined;
    this.shippingDetailsUrl = undefined;
    this.taxDetailsUrl = undefined;
    this.productUrlTemplate = undefined;
    this.popupRef = undefined;
    this.popupLoadingIndicatorUrl = undefined;
}
ConfomatContext.prototype = {
    // configuration
    setCheckoutUrl: function(checkoutUrl){
        this.checkoutUrl = checkoutUrl;
    },
    setShippingDetailsUrl: function(shippingDetailsUrl){
        this.shippingDetailsUrl = shippingDetailsUrl;
    },
    setTaxDetailsUrl: function(taxDetailsUrl){
        this.taxDetailsUrl = taxDetailsUrl;
    },
    setProductUrlTemplate: function(productUrlTemplate){
        this.productUrlTemplate = productUrlTemplate;
    },
    setPopupLoadingIndicatorUrl: function(popupLoadingIndicatorUrl){
        this.popupLoadingIndicatorUrl = popupLoadingIndicatorUrl;
    },

    // actions
    onBasketItemCreated: function (id, shop, productId, appearanceId, sizeId, quantity) {
    },

    onBasketItemUpdated:function(id, shop, oldProductId, productId, appearanceId, sizeId, quantity)  {
    },

    checkout: function(){
        if(this.checkoutUrl != undefined){
            window.location = this.checkoutUrl;
        }
    },

    displayShippingDetails: function(){
        this._openPopupUrl(this.shippingDetailsUrl);
    },

    displayTaxDetails: function(){
        this._openPopupUrl(this.taxDetailsUrl);
    },

    openPopup: function(url, title, width, height){
        if(width === undefined){
            width = 640;
        };
        if(height === undefined){
            height = 320;
        };
        if(url == '' && this.popupLoadingIndicatorUrl){
            url = this.popupLoadingIndicatorUrl;
        }
        this.popupRef = window.open(url, title,'height='+height+',width='+width+'toolbar=no,scrollbar=no');
        if(!this.popupRef){
            return this._false();
        }
        if(window.focus){
            this.popupRef.focus();
        }
        return this._true();
    },

    updatePopup: function(url){
        if(this.popupRef){
            this.popupRef.location = url;
        }else{
            return this.openPopup(url, '');
        }
        return this._true();
    },

    closePopup: function(){
        if(this.popupRef){
            this.popupRef.close();
        }
    },

    getProductUrl: function(productId, viewId){
        if(! this.productUrlTemplate){
            return this._false();
        }
        var url = this.productUrlTemplate.replace(/\[productId\]/, productId).replace(/\[viewId\]/, viewId);
        return url;
    },

    isUserAuthenticated: function(){
        var rtn;
        if(typeof isUserAuthenticated == 'undefined'){
            rtn = 'maybe';
        }else{
            rtn = this._boolReturnValue(isUserAuthenticated);
        }
        return rtn;
    },

    setToken: function(token){
        return createCookie('tok', token, null, 365);
    },

    getToken: function(){
        var tokenValue = getCookieValue('tok');
        if("" != tokenValue){
            // renew token lifetime
            createCookie('tok', tokenValue, null, 365);
        }
        return tokenValue;
    },

    deleteToken: function(){
        return eraseCookie('tok');
    },

    // private
    _openPopupUrl: function(url){
        if(url != undefined){
            Popup.openup({href: url});
        }
    },

    _false: function(){
        return this._boolReturnValue(false);
    },

    _true: function(){
        return this._boolReturnValue(true);
    },

    _boolReturnValue: function(boolean){
        return boolean ? 'true' : 'false';
    }
}

var confomat = new Confomat();
var confomatContext = new ConfomatContext();

// plain function synonyms for actual method calls
function onProductTypeChange(id){
    confomat.fire('producttypeChange', id);
}

function onApplicationLoaded(time){
    confomat.fire('applicationLoaded', time);
}

function onDesignChanged(id){
    confomat.fire('designChanged', id);
}

function onUserLoggedIn(){
    confomat.fire('userLoggedIn');
}

function addToBasket(shopId, productId, appearanceId, sizeId, quantity, onComplete){
    confomatContext.addToBasket(shopId, productId, appearanceId, sizeId, quantity, onComplete);
}

function updateBasketItem (itemId, shopId, oldProductId, newProductId, appearanceId, sizeId, quantity, onComplete) {
    confomatContext.updateBasketItem(itemId, shopId, oldProductId, newProductId, appearanceId, sizeId, quantity, onComplete);
}

function onBasketItemCreated (id, shop, productId, appearanceId, sizeId, quantity) {
    confomatContext.onBasketItemCreated(id, shop, productId, appearanceId, sizeId, quantity);
}

function onBasketItemUpdated (id, shop, oldProductId, productId, appearanceId, sizeId, quantity) {
    confomatContext.onBasketItemUpdated(id, shop, oldProductId, productId, appearanceId, sizeId, quantity);
}

/*Source from Public/Common/Js/lib/FlashPlayerDetectionKit-1.5/AC_OETags.js*/
// Flash Player Version Detection - Rev 1.6
// Detect Client Browser type
// Copyright(c) 2005-2006 Adobe Macromedia Software, LLC. All rights reserved.
var isIE  = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;
var isWin = (navigator.appVersion.toLowerCase().indexOf("win") != -1) ? true : false;
var isOpera = (navigator.userAgent.indexOf("Opera") != -1) ? true : false;

function ControlVersion()
{
	var version;
	var axo;
	var e;

	// NOTE : new ActiveXObject(strFoo) throws an exception if strFoo isn't in the registry

	try {
		// version will be set for 7.X or greater players
		axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");
		version = axo.GetVariable("$version");
	} catch (e) {
	}

	if (!version)
	{
		try {
			// version will be set for 6.X players only
			axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");
			
			// installed player is some revision of 6.0
			// GetVariable("$version") crashes for versions 6.0.22 through 6.0.29,
			// so we have to be careful. 
			
			// default to the first public version
			version = "WIN 6,0,21,0";

			// throws if AllowScripAccess does not exist (introduced in 6.0r47)		
			axo.AllowScriptAccess = "always";

			// safe to call for 6.0r47 or greater
			version = axo.GetVariable("$version");

		} catch (e) {
		}
	}

	if (!version)
	{
		try {
			// version will be set for 4.X or 5.X player
			axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.3");
			version = axo.GetVariable("$version");
		} catch (e) {
		}
	}

	if (!version)
	{
		try {
			// version will be set for 3.X player
			axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.3");
			version = "WIN 3,0,18,0";
		} catch (e) {
		}
	}

	if (!version)
	{
		try {
			// version will be set for 2.X player
			axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
			version = "WIN 2,0,0,11";
		} catch (e) {
			version = -1;
		}
	}
	
	return version;
}

// JavaScript helper required to detect Flash Player PlugIn version information
function GetSwfVer(){
	// NS/Opera version >= 3 check for Flash plugin in plugin array
	var flashVer = -1;
	
	if (navigator.plugins != null && navigator.plugins.length > 0) {
		if (navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {
			var swVer2 = navigator.plugins["Shockwave Flash 2.0"] ? " 2.0" : "";
			var flashDescription = navigator.plugins["Shockwave Flash" + swVer2].description;
			var descArray = flashDescription.split(" ");
			var tempArrayMajor = descArray[2].split(".");			
			var versionMajor = tempArrayMajor[0];
			var versionMinor = tempArrayMajor[1];
			var versionRevision = descArray[3];
			if (versionRevision == "") {
				versionRevision = descArray[4];
			}
			if (versionRevision[0] == "d") {
				versionRevision = versionRevision.substring(1);
			} else if (versionRevision[0] == "r") {
				versionRevision = versionRevision.substring(1);
				if (versionRevision.indexOf("d") > 0) {
					versionRevision = versionRevision.substring(0, versionRevision.indexOf("d"));
				}
			}
			var flashVer = versionMajor + "." + versionMinor + "." + versionRevision;
		}
	}
	// MSN/WebTV 2.6 supports Flash 4
	else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.6") != -1) flashVer = 4;
	// WebTV 2.5 supports Flash 3
	else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.5") != -1) flashVer = 3;
	// older WebTV supports Flash 2
	else if (navigator.userAgent.toLowerCase().indexOf("webtv") != -1) flashVer = 2;
	else if ( isIE && isWin && !isOpera ) {
		flashVer = ControlVersion();
	}	
	return flashVer;
}

// When called with reqMajorVer, reqMinorVer, reqRevision returns true if that version or greater is available
function DetectFlashVer(reqMajorVer, reqMinorVer, reqRevision)
{
	versionStr = GetSwfVer();
	if (versionStr == -1 ) {
		return false;
	} else if (versionStr != 0) {
		if(isIE && isWin && !isOpera) {
			// Given "WIN 2,0,0,11"
			tempArray         = versionStr.split(" "); 	// ["WIN", "2,0,0,11"]
			tempString        = tempArray[1];			// "2,0,0,11"
			versionArray      = tempString.split(",");	// ['2', '0', '0', '11']
		} else {
			versionArray      = versionStr.split(".");
		}
		var versionMajor      = versionArray[0];
		var versionMinor      = versionArray[1];
		var versionRevision   = versionArray[2];

        	// is the major.revision >= requested major.revision AND the minor version >= requested minor
		if (versionMajor > parseFloat(reqMajorVer)) {
			return true;
		} else if (versionMajor == parseFloat(reqMajorVer)) {
			if (versionMinor > parseFloat(reqMinorVer))
				return true;
			else if (versionMinor == parseFloat(reqMinorVer)) {
				if (versionRevision >= parseFloat(reqRevision))
					return true;
			}
		}
		return false;
	}
}

function AC_AddExtension(src, ext)
{
  if (src.indexOf('?') != -1)
    return src.replace(/\?/, ext+'?'); 
  else
    return src + ext;
}

function AC_Generateobj(objAttrs, params, embedAttrs) 
{ 
    var str = '';
    if (isIE && isWin && !isOpera)
    {
  		str += '<object ';
  		for (var i in objAttrs)
  			str += i + '="' + objAttrs[i] + '" ';
  		for (var i in params)
  			str += '><param name="' + i + '" value="' + params[i] + '" /> ';
  		str += '></object>';
    } else {
  		str += '<embed ';
  		for (var i in embedAttrs)
  			str += i + '="' + embedAttrs[i] + '" ';
  		str += '> </embed>';
    }

    document.write(str);
}

function AC_FL_RunContent(){
  var ret = 
    AC_GetArgs
    (  arguments, ".swf", "movie", "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
     , "application/x-shockwave-flash"
    );
  AC_Generateobj(ret.objAttrs, ret.params, ret.embedAttrs);
}

function AC_GetArgs(args, ext, srcParamName, classid, mimeType){
  var ret = new Object();
  ret.embedAttrs = new Object();
  ret.params = new Object();
  ret.objAttrs = new Object();
  for (var i=0; i < args.length; i=i+2){
    var currArg = args[i].toLowerCase();    

    switch (currArg){	
      case "classid":
        break;
      case "pluginspage":
        ret.embedAttrs[args[i]] = args[i+1];
        break;
      case "src":
      case "movie":	
        args[i+1] = AC_AddExtension(args[i+1], ext);
        ret.embedAttrs["src"] = args[i+1];
        ret.params[srcParamName] = args[i+1];
        break;
      case "onafterupdate":
      case "onbeforeupdate":
      case "onblur":
      case "oncellchange":
      case "onclick":
      case "ondblClick":
      case "ondrag":
      case "ondragend":
      case "ondragenter":
      case "ondragleave":
      case "ondragover":
      case "ondrop":
      case "onfinish":
      case "onfocus":
      case "onhelp":
      case "onmousedown":
      case "onmouseup":
      case "onmouseover":
      case "onmousemove":
      case "onmouseout":
      case "onkeypress":
      case "onkeydown":
      case "onkeyup":
      case "onload":
      case "onlosecapture":
      case "onpropertychange":
      case "onreadystatechange":
      case "onrowsdelete":
      case "onrowenter":
      case "onrowexit":
      case "onrowsinserted":
      case "onstart":
      case "onscroll":
      case "onbeforeeditfocus":
      case "onactivate":
      case "onbeforedeactivate":
      case "ondeactivate":
      case "type":
      case "codebase":
        ret.objAttrs[args[i]] = args[i+1];
        break;
      case "id":
      case "width":
      case "height":
      case "align":
      case "vspace": 
      case "hspace":
      case "class":
      case "title":
      case "accesskey":
      case "name":
      case "tabindex":
        ret.embedAttrs[args[i]] = ret.objAttrs[args[i]] = args[i+1];
        break;
      default:
        ret.embedAttrs[args[i]] = ret.params[args[i]] = args[i+1];
    }
  }
  ret.objAttrs["classid"] = classid;
  if (mimeType) ret.embedAttrs["type"] = mimeType;
  return ret;
}


