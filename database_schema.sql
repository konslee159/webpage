CREATE DATABASE broadcasting_club;
USE broadcasting_club;

CREATE TABLE admins (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL -- 해시된 비밀번호
);

CREATE TABLE notices (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_id BIGINT,
    FOREIGN KEY (admin_id) REFERENCES admins(id)
);

-- 초기 관리자 계정 (비밀번호: admin123)
INSERT INTO admins (username, password) VALUES ('admin', 'admin123');