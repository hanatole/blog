---
date: '2026-01-22T22:55:27+01:00'
draft: false
title: 'Docker Multi-stage : Le secret pour des images 10 fois plus légères'
---


Vous avez enfin réussi à "dockeriser" votre application, mais votre image pèse 1 Go pour un simple site web ? C'est un problème classique. Pour passer en production, vous avez besoin de performance et de sécurité. C'est là qu'intervient le Multi-stage build.

Le problème : Pourquoi vos images sont-elles trop grosses ?
Quand vous construisez une application (en React, Go, ou Java), vous avez besoin d'outils de compilation (Node.js, JDK, Compilateurs). Mais une fois l'application compilée, ces outils ne servent plus à rien. Si vous les laissez dans l'image finale :

1. Le poids : Votre image est inutilement lourde.
2. La sécurité : Plus il y a d'outils, plus il y a de failles de sécurité potentielles.

## La solution : Le Multi-stage Build

Le concept est simple : on utilise plusieurs instructions FROM dans un seul Dockerfile. Chaque instruction FROM commence une nouvelle étape (stage). On compile dans la première, et on ne garde que le résultat dans la deuxième.

## Cas pratique : Une application Web avec Nginx

Imaginons que vous ayez une application (comme une application React ou simplement un site web qui nécessite une étape de construction).

Le Dockerfile optimisé

```dockerfile

# ÉTAPE 1 : La compilation (Le "Builder")

FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build 

# ÉTAPE 2 : L'image finale (La "Production")

FROM nginx:1.27-alpine
# On récupère UNIQUEMENT le dossier build de l'étape précédente
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

```
