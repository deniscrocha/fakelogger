# Fakelogger

Aplicação para gerar logs no STDOUT a cada 1 seg.

para rodar local use o comando: 
`zig run main.zig -lc`

para compilar use o comando:
`zig build-exe -Drelease-fast=true main.zig -lc`

para usar a imagem do docker:
`docker pull rochadenis/fakelogger:latest`
`docker run --rm rochadenis/fakelogger:latest`
