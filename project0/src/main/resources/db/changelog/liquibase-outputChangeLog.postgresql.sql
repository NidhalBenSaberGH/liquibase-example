--liquibase formatted sql

--changeset nbensaber:1571850706034-1
CREATE TABLE airlines (airline CHAR(2) NOT NULL, airline_full VARCHAR(24), basic_rate FLOAT8, distance_discount FLOAT8, business_level_factor FLOAT8, firstclass_level_factor FLOAT8, economy_seats INTEGER, business_seats INTEGER, firstclass_seats INTEGER, CONSTRAINT airlines_pk PRIMARY KEY (airline));

--changeset nbensaber:1571850706034-2
CREATE TABLE cities (city_id INTEGER NOT NULL, city_name VARCHAR(24) NOT NULL, country VARCHAR(26) NOT NULL, airport VARCHAR(3), language VARCHAR(16), country_iso_code CHAR(2), CONSTRAINT cities_pk PRIMARY KEY (city_id));

--changeset nbensaber:1571850706034-3
CREATE TABLE countries (country VARCHAR(26) NOT NULL, country_iso_code CHAR(2) NOT NULL, region VARCHAR(26), CONSTRAINT countries_pk PRIMARY KEY (country_iso_code));

--changeset nbensaber:1571850706034-4
CREATE TABLE flightavailability (flight_id CHAR(6) NOT NULL, segment_number INTEGER NOT NULL, flight_date date NOT NULL, economy_seats_taken INTEGER DEFAULT 0, business_seats_taken INTEGER DEFAULT 0, firstclass_seats_taken INTEGER DEFAULT 0, CONSTRAINT flightavail_pk PRIMARY KEY (flight_id, segment_number, flight_date));

--changeset nbensaber:1571850706034-5
CREATE TABLE flights (flight_id CHAR(6) NOT NULL, segment_number INTEGER NOT NULL, orig_airport CHAR(3), depart_time TIME WITHOUT TIME ZONE, dest_airport CHAR(3), arrive_time TIME WITHOUT TIME ZONE, meal CHAR(1), flying_time FLOAT8, miles INTEGER, aircraft VARCHAR(6), CONSTRAINT flights_pk PRIMARY KEY (flight_id, segment_number));

--changeset nbensaber:1571850706034-6
CREATE TABLE flights_history (flight_id CHAR(6), segment_number INTEGER, orig_airport CHAR(3), depart_time TIME WITHOUT TIME ZONE, dest_airport CHAR(3), arrive_time TIME WITHOUT TIME ZONE, meal CHAR(1), flying_time FLOAT8, miles INTEGER, aircraft VARCHAR(6), status VARCHAR(20));

--changeset nbensaber:1571850706034-7
CREATE TABLE maps (map_id INTEGER NOT NULL, map_name VARCHAR(24) NOT NULL, region VARCHAR(26), area numeric(8, 4) NOT NULL, photo_format VARCHAR(26) NOT NULL, picture BYTEA, CONSTRAINT maps_pk PRIMARY KEY (map_id));

--changeset nbensaber:1571850706034-8
ALTER TABLE countries ADD CONSTRAINT countries_unq_nm UNIQUE (country);

--changeset nbensaber:1571850706034-9
ALTER TABLE maps ADD CONSTRAINT maps_map_id_map_name_key UNIQUE (map_id, map_name);

--changeset nbensaber:1571850706034-10
CREATE INDEX destindex ON flights(dest_airport);

--changeset nbensaber:1571850706034-11
CREATE INDEX origindex ON flights(orig_airport);

--changeset nbensaber:1571850706034-12
ALTER TABLE cities ADD CONSTRAINT countries_fk FOREIGN KEY (country_iso_code) REFERENCES countries (country_iso_code) ON UPDATE NO ACTION ON DELETE NO ACTION;

--changeset nbensaber:1571850706034-13
ALTER TABLE flightavailability ADD CONSTRAINT flights_fk2 FOREIGN KEY (flight_id, segment_number) REFERENCES flights (flight_id, segment_number) ON UPDATE NO ACTION ON DELETE NO ACTION;
