css(THEME_DARK);

class RotationLock extends ModComponent {
	constructor() {
		super();
		this.setState({ locked: false });
	}

	componentDidMount() {
		this.proc = new IPCProc(IPC_EXEC_SH, `
			f=~/.rotation-lock
			while read -r; do
				if [ -f $f ]; then
					rm -f $f
					echo "unlocked"
				else
					touch $f
					echo "locked"
				fi
			done
			`, msg => this.setState({ locked: msg == "locked" }));
		this.proc.send()
	}

	toggle() {
		this.proc.send();
	}

	render(props, state) {
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
			h(RotationLock),
		),
	),
);
