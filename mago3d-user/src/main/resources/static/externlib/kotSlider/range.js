var KotSlider = function (inputId) {
    if (!document.getElementById(inputId) || !document.getElementById(inputId).tagName == 'INPUT') throw '"' + inputId + '" 라는 id의 input이 없습니다.';

    var defaultOptions = {

        max: 5,
        min: 0,
        step: 1,
        duration: 1000
    };
    this.id = inputId;
    this.min = defaultOptions.min;
    this.max = defaultOptions.max;
    this.step = defaultOptions.step;
    this.duration = defaultOptions.duration;
    this.t = defaultOptions.min;

    this.init();
}

KotSlider.prototype.init = function () {

	var that = this;
    var slider = document.getElementById(this.id);

    var div = document.createElement('div');
    var divChild1 = document.createElement('div');
    var divChild2 = document.createElement('div');
    var divChild3 = document.createElement('div');
    var mother = slider.parentNode;
    div.setAttribute('class', 'rangeWrap');
    divChild1.setAttribute('class', 'rangeWrapChild button');
    divChild2.setAttribute('class', 'rangeWrapChild slide');
    divChild2.append(slider);
    divChild3.setAttribute('class', 'rangeWrapChild legend');
    div.append(divChild1);
    div.append(divChild2);
    div.append(divChild3);
    mother.appendChild(div);

    makeSliderBtn("startBtn", "start", this.id);
    makeSliderBtn("stopBtn", "stop", this.id);
    makeSliderBtn("beforeBtn", "before", this.id);
    makeSliderBtn("afterBtn", "after", this.id);

    this.setSlider(this.id);

    function makeSliderBtn(name, action, id) {
        var name = document.createElement('button');

        name.id = action + id;
        name.setAttribute('class', action);
        name.value = action;
        divChild1.append(name);
    }
    slider.onchange = function(e){
    	that.t = this.value;
    }
    slider.oninput = function(e){
    	that.t = this.value;
    }
    slider.onmousewheel = function(e){
    	var isUp = e.deltaY < 0;
    	var type = isUp ? 'after' : 'before';
    	
    	var btn = document.getElementById(type+this.id);
    	btn.dispatchEvent(new Event('click'));
    }
}

KotSlider.prototype.setMax = function (max) {

    this.max = max;
    this.setSlider(this.id);

}

KotSlider.prototype.setMin = function (min) {

    this.min = min;
    this.setSlider(this.id);

}

KotSlider.prototype.setStep = function (step) {

    this.step = step;
    this.setSlider(this.id);

}

KotSlider.prototype.setDuration = function (duration) {

    this.duration = duration;
    this.setSlider(this.id);

}

KotSlider.prototype.getMax = function () {

    return this.max;

}

KotSlider.prototype.getMin = function () {

    return this.min;

}

KotSlider.prototype.getStep = function () {

    return this.step;

}

KotSlider.prototype.getDuration = function () {

    return this.duration

}

KotSlider.prototype.getValue = function () {

    return this.t

}

KotSlider.prototype._setT = function (value) {

	this.t = value;

}

KotSlider.prototype.setValue = function (value) {
	
	var slider = document.getElementById(this.id);
	var isChange = true;
	if(slider.value == value) {
		isChange = false;
    }
	slider.value = value;
	this._setT(value);
	
	if(isChange) {
		slider.dispatchEvent(new Event('change'));
	}
}

KotSlider.prototype.setSlider = function (id) {
	var that = this;
    var sliderObject = document.getElementById(id);

    var t = that.min;
    var startButton = document.getElementById("start" + id);
    var stopButton = document.getElementById("stop" + id);
    var beforeButton = document.getElementById("before" + id);
    var afterButton = document.getElementById("after" + id);
    var timer;
    var max = that.max;
    var min = that.min;
    var step = that.step;
    var duration = that.duration;

    
    sliderObject.type = 'range';
    //ie에서는 순서가 영향있음..
    sliderObject.value = t;
    sliderObject.max = max;
    sliderObject.min = min;
    sliderObject.step = step;
    sliderObject.className = 'slider';

    startButton.onclick = start;
    beforeButton.onclick = before;
    afterButton.onclick = after;
    sliderObject.onclick = clickValue;

    function clickValue() {
        t = new Number(sliderObject.value);
    }

    function start() {
        startButton.onclick = null;
        stopButton.onclick = stop;
        if(sliderObject.value == t) {
        	t = min;
        	that.setValue(min);
        }
        
        timer = setInterval(function () {
            if (t + step > max) {
                clearInterval(timer);
                startButton.onclick = start;
                return;
            }
            t = t + step;
            that.setValue(t);
        }, duration);
    }
    function stop() {
        clearInterval(timer);
        startButton.onclick = start;
    }
    function before() {
        if (t - min <= max && t - step >= min) {
            t = t - step
        }

        that.setValue(t);
    }
    function after() {

        if (t + step <= max) {

            t = t + step;

        }
        that.setValue(t);
    }
}
