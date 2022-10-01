pg-setup:
	docker run --name=go-pg -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=root -p 5432:5432 -d postgres:12-alpine

createdb:
	docker exec -it go-pg createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it go-pg dropdb simple_bank

migrateup:
	migrate --path ./db/migration --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose up

migratedown:
	migrate --path ./db/migration --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose down

.PHONY: pg-setup createdb dropdb migrateup migratedown

