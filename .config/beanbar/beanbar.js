css(THEME_DARK);

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
		),
	),
);
