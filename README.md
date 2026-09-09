# Lab B2 - Infrastructure sécurisée pour LINÉOR Joaillerie

> Projet annuel Bachelor 2 (Cybersécurité) : conception, déploiement et supervision d'une infrastructure système et réseau complète, de zéro, pour une startup fictive de joaillerie en ligne.

## 🏢 Contexte

**LINÉOR Joaillerie** est une entreprise fictive (3 salariés + 1 freelance) qui ne dispose d'aucune infrastructure informatique au départ. L'objectif est de construire, sécuriser et superviser un environnement complet répondant à ses besoins métier et aux exigences RGPD (données clients e-commerce).

## 🧱 Architecture

| Machine | Rôle | IP |
|---|---|---|
| Windows Server 2022 | AD DS, DHCP, DNS, partage de fichiers, Apache/MySQL/PHP | 192.168.1.10 |
| Windows 10 | Poste client, joint au domaine `lineor.local` | 192.168.1.20 |
| Kali Linux | Supervision (Zabbix via Docker) + simulation d'attaques | 192.168.1.30 |

Virtualisation : **VirtualBox**. Réseau web isolé sur un second segment (`192.168.2.0/24`) pour cloisonner le trafic applicatif du réseau d'administration.


## 📦 Contenu du repo

```
├── scripts/
│   └── backup-lineor.ps1       # Sauvegarde automatique planifiée (Task Scheduler, 23h00)
├── sql/
│   └── lineor_stock.sql        # Schéma + données de test de la base de stock
├── web/
│   ├── stock.php               # Page web dynamique de gestion du stock
│   └── config.example.php      # Modèle de config (les vrais identifiants ne sont jamais commités)
└── docs/
    └── PROJET_B2.pdf           # Dossier de rendu complet
```

## 🔐 Projet 1 - Infrastructure locale (AD, DHCP, DNS)

- Déploiement d'**Active Directory Domain Services** sur `lineor.local`
- **DHCP** avec plage 192.168.1.20–192.168.1.100
- **4 comptes utilisateurs** créés avec droits différenciés (Admins / Utilisateurs / Utilisateurs_Externes), principe du moindre privilège
- **Partage de fichiers** cloisonné par service (Collections, Logistique, Marketing)
- **Sauvegarde automatique** quotidienne via script PowerShell (`scripts/backup-lineor.ps1`)
- **Politique de mot de passe** : 10 caractères min, complexité obligatoire, expiration 90 jours
- **Windows Firewall** : uniquement les ports nécessaires ouverts

## 🌐 Projet 2 - Services web virtualisés (stack AMP)

- Stack **Apache + MySQL/MariaDB + PHP** installée sur le serveur
- Base **`lineor_stock`** avec table `produits` (`sql/lineor_stock.sql`)
- Page web dynamique de consultation du stock (`web/stock.php`), accessible en interne à `http://192.168.1.10/stock`
- Second réseau virtuel dédié au trafic web (192.168.2.0/24) pour cloisonner des services d'administration
- Compte MySQL dédié en **lecture seule** pour l'application (pas d'usage du compte root)

## 📊 Projet 3 - Supervision, détection d'incident et maintenance

- **Zabbix** déployé via Docker sur Kali Linux (contournement des soucis de compatibilité de Zabbix Server sur Linux natif)
- KPI surveillés : CPU (seuil 80%/95%), RAM (75%/90%), espace disque (<20%), disponibilité des services, latence réseau
- KSI de sécurité : tentatives de connexion échouées, IP inconnues, modifications de comptes AD, accès à la base MySQL

### Scénario d'attaque simulée : bruteforce RDP

Simulation d'une attaque bruteforce depuis Kali Linux (Hydra) ciblant le port RDP du serveur :

```bash
hydra -s 3389 -l Administrateur -P /usr/share/wordlists/rockyou.txt -t 4 192.168.1.10 rdp
```

**Détection** : trigger Zabbix déclenché après 5 échecs de connexion consécutifs → alerte niveau HAUTE. Confirmation via Event Viewer (événements `4625`).

**Réponse à l'incident** : blocage de l'IP source par règle Firewall, renforcement de la politique de verrouillage de compte AD (3 tentatives), plan de mesures correctives (restriction RDP, 2FA envisagée, segmentation réseau renforcée, pentest annuel).

## 🛠️ Stack technique

`VirtualBox` `Windows Server 2022` `Active Directory` `DHCP/DNS` `PowerShell` `Apache` `MySQL/MariaDB` `PHP` `Docker` `Zabbix` `Kali Linux` `Hydra`

---

*Projet réalisé dans le cadre du Bachelor 2 Cybersécurité (alternance Administration Infra & Réseaux Sécurisés).*
