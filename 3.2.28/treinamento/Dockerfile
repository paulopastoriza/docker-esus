FROM ubuntu:16.04

LABEL maintainer="paulopastoriza@gmail.com"

# Habilita modo não interativo na instalação de pacotes
ENV DEBIAN_FRONTEND noninteractive

# Desabilita o cache do gerenciador de pacote
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Atualiza o repositório de pacotes e instala dependências do SO
RUN apt update && \
  apt-get install -y software-properties-common dialog lzma locales vim wget unzip net-tools

# Instala dependência do JAVA 7
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
  apt-get update && \
  apt-get install -y openjdk-7-jdk

# Regera o locales
RUN locale-gen pt_BR.UTF-8 && \
  echo "locales locales/default_environment_locale select pt_BR.UTF-8" | debconf-set-selections && \
  dpkg-reconfigure --frontend noninteractive locales

# Cria arquivo de dependências para o instalador do e-SUS
RUN echo 'JAVA_HOME=/usr' > /etc/java.conf

# Cria diretório de lock para a instância local do PostgreSQL 9.3
RUN mkdir -p /run/lock/subsys

# Realiza o download, descompacta o pacote de instalação do e-SUS de treinamento
RUN wget -q https://arquivos.esusab.ufsc.br/PEC/lcrlvuSvnXcwbCZk/3.2.28/treinamento/instalador/Instalador-eSUS-AB-PEC-3.2.28-Treinamento-Linux.zip && \
  unzip Instalador-eSUS-AB-PEC-3.2.28-Treinamento-Linux.zip

# Realiza ajustes nos instaladores para compatibilidade com o container (remoção do sudo)
RUN sed -i 's|sudo||g' instalador_linux.sh && \
  sed -i 's|read bd|bd=1|g' instalador_linux.sh && \
  sed -i 's|sudo||g' jboss-as-7.2.0.Final/postgres-complete-install.sh

# Executa o instalador do e-SUS
RUN sh instalador_linux.sh && \
  /etc/init.d/e-SUS-AB-PostgreSQL stop

# Limpa os temporários
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

EXPOSE 8080

WORKDIR /opt/e-SUS

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
