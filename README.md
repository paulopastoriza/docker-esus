# Dockerfiles para execução do e-SUS PEC versão 3.2.28

## Para utilizar os fontes PEC - Treinamento versão 3.2.28:

```bash
git clone https://github.com/paulopastoriza/docker-esus
cd docker-esus
docker build --rm -t esus:treinamento 3.2.28/treinamento
docker run -d -p 8080:8080 esus:treinamento
```

## Para utilizar os fontes PEC - Produção versão 3.2.28:

```bash
git clone https://github.com/paulopastoriza/docker-esus
cd docker-esus
docker build --rm -t esus:producao 3.2.28/producao
docker run -d -p 8080:8080 esus:producao
```

Após iniciar o container, utilizando o navegador, acesse o endereço http://localhost:8080/esus

