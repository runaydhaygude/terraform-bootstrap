hello there ${name}

%{ for addr in ip_addrs ~}
backend ${addr}:${port}
%{ endfor ~}