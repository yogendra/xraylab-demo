DROP TABLE IF EXISTS images_uploaded;
DROP TABLE IF EXISTS images_processed;
DROP TABLE IF EXISTS images_anonymized;

CREATE TABLE images_uploaded (time TIMESTAMP, name VARCHAR(255));
CREATE TABLE images_processed (time TIMESTAMP, name VARCHAR(255), model VARCHAR(10), label VARCHAR(20));
CREATE TABLE images_anonymized (time TIMESTAMP, name VARCHAR(255));

INSERT INTO images_uploaded (time,name) SELECT CURRENT_TIMESTAMP, '';
INSERT INTO images_processed (time,name,model,label) SELECT CURRENT_TIMESTAMP, '', '','';
INSERT INTO images_anonymized (time,name) SELECT CURRENT_TIMESTAMP, '';
