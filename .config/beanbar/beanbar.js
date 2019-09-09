css(THEME_DARK);
css(`body { width: 50%; }`);

class RotationLock extends ModComponent {
	constructor() {
		super();
		this.setState({ locked: false });
	}

	componentDidMount() {
		this.proc = this.ipcProc(IPC_EXEC_SH, `
			f=~/.rotation-lock
			[ -f $f ] && echo "locked"
			while read -r; do
				if [ -f $f ]; then
					rm -f $f
					echo "unlocked"
				else
					touch $f
					echo "locked"
				fi
			done
			`, msg => { console.log(msg); this.setState({ locked: msg == "locked" }) });
	}

	toggle() {
		this.proc.send();
	}

	render(props, state) {
		console.log("render", state.locked);
		let className = "clickable ";
		className += state.locked ? "locked " : "unlocked ";
		return this.el({ className, onClick: this.toggle.bind(this) }, "Rotation");
	}

	css() {
		return `
		module.RotationLock.locked {
			color: red;
		}
		module.RotationLock.unlocked {
			color: lime;
		}`;
	}
}

css(`
module.I3Workspaces .workspace.focused::after {
	height: 2px;
}`);

init(
	h(I3Workspaces, { scroll: true }),
	h(Group, null,
		h(Disk),
		h(Audio),
		h(Network),
		h(Battery),
		h(Memory),
		h(Processor),
		h(Time),
		h(Drawer, null,
			h(Launcher, { text: "Bluetooth", cmd: "blueman-manager" }),
			h(Launcher, { text: "Audio", cmd: "pavucontrol" }),
			h(Launcher, { text: "OnBoard", cmd: "onboard" }),
			h(RotationLock),
		),
	),
);
