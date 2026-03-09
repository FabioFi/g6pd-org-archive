var _____WB$wombat$assign$function_____=function(name){return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name))||self[name];};if(!self.__WB_pmw){self.__WB_pmw=function(obj){this.__WB_source=obj;return this;}}{
let window = _____WB$wombat$assign$function_____("window");
let self = _____WB$wombat$assign$function_____("self");
let document = _____WB$wombat$assign$function_____("document");
let location = _____WB$wombat$assign$function_____("location");
let top = _____WB$wombat$assign$function_____("top");
let parent = _____WB$wombat$assign$function_____("parent");
let frames = _____WB$wombat$assign$function_____("frames");
let opens = _____WB$wombat$assign$function_____("opens");

var min = 8;
var max = 18;
function increaseFontSize() {
    var p = document.getElementsByTagName('div');
    for (i = 0; i < p.length; i++) {
        if (p[i].style.fontSize && p[i].id != 'langTable') {
            var s = parseInt(p[i].style.fontSize.replace("px", ""));
        } else {
            var s = 14;
        }
        if (s != max && p[i].id != 'langTable') {
            s += 1;
        }
        p[i].style.fontSize = s + "px"
    }
}
function decreaseFontSize() {
    var p = document.getElementsByTagName('div');
    for (i = 0; i < p.length; i++) {
        if (p[i].style.fontSize && p[i].id != 'langTable') {
            var s = parseInt(p[i].style.fontSize.replace("px", ""));
        } else {
            var s = 14;
        }
        if (s != min && p[i].id != 'langTable') {
            s -= 1;
        }
        p[i].style.fontSize = s + "px"
    }
}

function removeFontSize() {
    var p = document.getElementsByTagName('div');
    for (i = 0; i < p.length; i++) {
        if (p[i].style.fontSize && p[i].id != 'langTable') {
            var s = parseInt(p[i].style.fontSize.replace("px", ""));
        } else {
            var s = 14;
        }
        
        p[i].style.fontSize = "14px"
    }
}


}

/*
     FILE ARCHIVED ON 23:05:47 May 20, 2020 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 07:49:52 Mar 09, 2026.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  capture_cache.get: 103.226
  load_resource: 196.497 (2)
  PetaboxLoader3.resolve: 192.16 (4)
  PetaboxLoader3.datanode: 265.618 (5)
  captures_list: 1.303
  exclusion.robots: 0.035
  exclusion.robots.policy: 0.015
  esindex: 0.018
  cdx.remote: 19.06
  LoadShardBlock: 300.159 (3)
*/