Handlebars.registerHelper('ifMatch', function(inputText, matchText, options) {
    if(inputText === matchText) {
        return options.fn(this);
    }
    return options.inverse(this);
});

Handlebars.registerHelper('ifMatchTwo', function(inputText, matchText, inputText2, matchText2, options) {
    if(inputText === matchText && inputText2 === matchText2) {
        return options.fn(this);
    }
    return options.inverse(this);
});

// inputText와 matchValue가 일치하면, inputText를 replaceText로 변경
// 예를들면 default_yn === "Y" ==> "on" 으로 변경
Handlebars.registerHelper('replace', function(inputText, matchValue, replaceText, options) {
    var string = '';
    if(inputText === matchValue) {
        string = replaceText;
    }
    return string;
});

Handlebars.registerHelper('formatNumber', function(value) {
	return value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
});

Handlebars.registerHelper('numberEqual', function(v1, v2, options) {
	if(v1 === v2) {
		return options.fn(this);
	}
	return options.inverse(this);
});

Handlebars.registerHelper('greaterThan', function(inputValue, compareValue, options) {
    if(inputValue > compareValue) {
    	return options.fn(this);
    } else {
    	return options.inverse(this);
    }
});

Handlebars.registerHelper('lessThanEqual', function(inputValue, compareValue, options) {
    if(inputValue <= compareValue) {
    	return options.fn(this);
    } else {
    	return options.inverse(this);
    }
});

Handlebars.registerHelper('indexCompare', function(index, pageNo, options) {
    if(index == pageNo) {
        return true;
    } else {
        return false;
    }
});

Handlebars.registerHelper('getPrefix', function(viewType, layerKey) {
	var string = '';
	switch(viewType) {
		case 'wms': string = 'base_layer'; break;
		case 'wfs':
		case 'data': string = layerKey; break;
		case 'tile':
		case 'canvas': string = viewType + '_' + layerKey;
	}
    return string;
});

// 빼기 helper
Handlebars.registerHelper("subtract", function(value1, value2) {
    return value1 - value2;
});

// foreach start end 1씩 증가
Handlebars.registerHelper('forEachStep', function(from, to, incr, block) {
    var accum = '';
    for(var i = from; i <= to; i += incr)
        accum += block.fn(i);
    return accum;
});
