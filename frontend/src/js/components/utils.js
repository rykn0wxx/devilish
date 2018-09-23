const Utils = {

	addEvent(el, type, handler) {
		if (el.attachEvent) el.attachEvent('on'+type, handler); else el.addEventListener(type, handler);
	},

	live(selector, event, callback, context) {
		var qs = (context || document).querySelectorAll(selector);
		if (qs) {
			this.addEvent(context || document, event, (e) => {
				var el = e.target || e.srcElement, index = -1;
				while (el && ((index = Array.prototype.indexOf.call(qs, el)) === -1)) el = el.parentElement;
				if (index > -1) callback.call(el, e);
			});
		}
	}
};

export default Utils;
