---
date: '2026-01-10T01:53:35+01:00'
draft: false
title: 'Images, conteneurs et Dockerfile : les bases techniques'
---

Le modèle Docker repose principalement sur trois éléments : les images, les conteneurs et les Dockerfiles.

Une image Docker est un artefact immuable servant de modèle. Elle est composée de couches empilées, chacune représentant une instruction exécutée lors de la construction de l’image. Cette architecture en couches permet la mise en cache et la réutilisation, ce qui optimise les temps de build et l’espace disque.

Un conteneur Docker est une instance active d’une image. Il s’agit concrètement d’un processus isolé sur la machine hôte, bénéficiant de mécanismes de virtualisation légère (namespaces, cgroups). Chaque conteneur possède :

- son propre système de fichiers,
- son réseau,
- ses variables d’environnement,
- des limites de ressources configurables.

Le Dockerfile est le fichier central qui décrit comment construire une image. Il suit une syntaxe simple et lisible, permettant de documenter précisément l’environnement d’exécution.

Exemple de Dockerfile commenté :

```dockerfile
FROM node:20-alpine        
WORKDIR /app              
COPY package*.json ./     
RUN npm install 
COPY . .
CMD ["npm", "start"]


```

Cette approche s’inscrit pleinement dans la philosophie Infrastructure as Code, rendant les environnements reproductibles, auditables et facilement automatisables.
