server {
	listen 443 ssl http2 so_keepalive=on;
	server_name example.com;

	index index.html;
	root /var/www/html;

	ssl_certificate /path/to/example.cer;
	ssl_certificate_key /path/to/example.key;
	ssl_protocols TLSv1.2 TLSv1.3;
	ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
	
	client_header_timeout 1071906480m;
        keepalive_timeout 1071906480m;
	# 在 location 后填写 /你的 ServiceName
	location /你的 ServiceName {
		if ($content_type !~ "application/grpc") {
			return 404;
		}
		client_max_body_size 0;
		grpc_set_header X-Real-IP $proxy_add_x_forwarded_for;
		client_body_timeout 1071906480m;
		grpc_read_timeout 1071906480m;
		grpc_pass grpc://127.0.0.1:2002;
	}
}
