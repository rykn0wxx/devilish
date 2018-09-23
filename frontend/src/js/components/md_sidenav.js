import Utils from './utils';

const MdSidenav = {
	inDuration: 300,
	outDuration: 200,
	trigger: '[data-md-sidenav-toggler]',
	sidebar: null,	//'[data-md-sidenav]';
	sidebarEl: null,
	init: false,
	activate: () => {
		let o = MdSidenav;
		if (!o.init && document.querySelector(o.trigger) !== null) {
			o.sidebar = '[data-md-sidenav="' + document.querySelector(o.trigger).dataset.mdSidenavToggler + '"]';
			o.sidebarEl = document.querySelector(o.sidebar);
			Utils.live(o.trigger, 'click', (event) => {
				let sb = document.querySelector(o.sidebar);
				event.preventDefault();
				event.stopPropagation();
				o.toggleMenu(o);
				$(o.trigger).blur();
			});
		}
	},
	toggleMenu: (o) => {
		if (o.sidebarEl.classList.contains('md-locked-open')) {
			o.closeMenu(o);
		} else {
			o.openMenu(o);
		}
	},
	closeMenu: (o) => {
		$(o.sidebarEl).hide(o.outDuration, () => {
			o.sidebarEl.classList.remove('md-locked-open');
		});
	},
	openMenu: (o) => {
		$(o.sidebarEl).show(o.inDuration, () => {
			o.sidebarEl.classList.add('md-locked-open');
		});
	}
};

export default MdSidenav;
