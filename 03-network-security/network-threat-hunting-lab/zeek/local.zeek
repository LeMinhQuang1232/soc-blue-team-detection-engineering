@load policy/tuning/json-logs

redef Site::local_nets += {
	192.168.10.0/24,
	192.168.20.0/24,
	192.168.30.0/24
};
