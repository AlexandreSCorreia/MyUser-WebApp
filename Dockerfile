# Use the official Node.js image as the base image
FROM node:latest

# Instalar o Angular CLI globalmente
RUN npm install -g @angular/cli@16.2.7

# Definir o diretório de trabalho para /app
WORKDIR /app

# Copiar o package.json e package-lock.json para o contêiner
COPY package*.json ./

# Instalar as dependências
RUN npm install

# Copiar o código-fonte para o contêiner
COPY . .

# Build do aplicativo
RUN ng build --configuration=production

# Expor a porta 4200
EXPOSE 4200

# Iniciar o aplicativo
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
