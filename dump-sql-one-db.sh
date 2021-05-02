#!/bin/bash
clear
################################################################
##
##   Script : Dump SQL - One Database
##
##   [Auteur]________: FANGET Nicolas
##   [URL]___________: https://github.com/Fanget-Nicolas/DUMP-SQL-One-Database
##   [Version]_______: 1.1.0 
##   [Créer le]______: 20 Sept. 2020
##   [Mis à jour le]_: 02 Mai 2021
##   [Dépendances]___: Aucune !
##   [Commentaires]__: Script à sécuriser !
##    -v a rajouter pour les logs de mysqldump + Ajout de LOG
##    Ajout : Test suppression de la sauvegarde si correct
##   Info. sur mysqldump : https://mariadb.com/kb/en/mysqldump/
##
################################################################


################################################################
##################### Variables du script  #####################
################################################################

SQL_HOST='' # Adresse IP du serveur MariaDb/MySQL. (localhost / 127.0.0.1 : si BDD sur le même serveur)
SQL_PORT='' # Port du serveur MariaDb/MySQL. (port par défaut : 3306)
SQL_USER='' # Nom d'utilisateur. (avec des droits en lecture sur la bdd)
SQL_PASSWORD='' # Mot de passe.
DATABASE_NAME='' # Base de donnée à sauvegarder.
DB_BACKUP_PATH='' # Chemin du backup. /!\ Ne pas mettre le '/' à la fin.
BACKUP_RETAIN_DAYS=''  # Nombre de jours à conserver.

################################################################
##################### Variables définies  ######################
################################################################

export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`
SERVICE='mysqld'
FULL_PATH_BACKUP=${DB_BACKUP_PATH}/${TODAY}
bleuclair='\e[1;34m'

#################################################################
########################## Functions  ###########################
#################################################################

function displaySuccess {

  local passSuccess='\e[32m'
  local passSuccessFin='\e[0m \n'
  local VAR_TEXT="${1}"

  echo -e "${passSuccess}${VAR_TEXT}${passSuccessFin}";

}

function displayError {

  local passError='\e[31m'
  local passErrorFin='\e[0m \n'
  local VAR_TEXT="${1}"

  echo -e "${passError}${VAR_TEXT}${passErrorFin}";

}

function displayInfo {

  local passInfo='\e[96m'
  local passInfoFin='\e[0m'
  local VAR_TEXT="${1}"

  echo -e "${passInfo}${VAR_TEXT}${passInfoFin}";

}

function checkVariable { 

  local VAR_NAME="${1}"
  local VAR_CHECK="${2}"

  if [ -z "${VAR_CHECK}" ]; then
    displayError " => [ERREUR] Variable non définie : $VAR_NAME !"
    exit
  fi

  if [ "BACKUP_RETAIN_DAYS" = "${VAR_NAME}" ]; then
    if [ ! 1 -le $BACKUP_RETAIN_DAYS ]; then
      displayError " => [ERREUR] Variable non définie : $VAR_NAME !"
      exit
    fi
  fi

}

function dir_permission_check_v1 {

  if [ -w "${1}" ]; then
    return 0
  else
    basedir=$(dirname "${1}")
    if [ "${basedir}" != "/" ]; then
      if dir_permission_check_v1 "${basedir}"; then
        echo "Yes"
        return 0
      else
        echo "False"
        return 1
      fi
    elif [ -w "${basedir}" ]; then
      echo "Yes"
      return 0
    else
      echo "False"
      return 1
    fi
  fi

}

function dir_permission_check_v2 {

  if [ -e "${1}" ]; then
    if [ -d "${1}" ] && [ -w "${1}" ] && [ -x "${1}" ]; then
      echo "True"
      return 0
    else
      echo "False"
      return 1
    fi
  else
    dir_permission_check_v2 "$(dirname "${1}")"
    return $?
  fi

}

#checkProcess  "MYSQL"              $SERVICE
# function checkProcess {
#
#  local VAR_NAME="${1}"
#  local VAR_CHECK="${2}"
#
#  displayInfo " => Vérification du processus $VAR_NAME..."
#
#  if pgrep -x ${VAR_CHECK} >/dev/null; then
#    displaySuccess "  -> Le processus est bien démarré."
#  else
#    echo -e "  -> Le processus est arrêté.  \n";
#    exit
#  fi
#
#}

#################################################################
############################ Script  ############################ 
#################################################################

echo -e "${bleuclair}"
echo "======================================="
echo "= Sauvegarde d'une base de donnée SQL ="
echo "======================================="
echo -e "\e[0m"

#~#
#~# Vérifications des variables
#~#
checkVariable "SQL_HOST"           $SQL_HOST
checkVariable "SQL_PORT"           $SQL_PORT
checkVariable "SQL_USER"           $SQL_USER
checkVariable "SQL_PASSWORD"       $SQL_PASSWORD
checkVariable "DATABASE_NAME"      $DATABASE_NAME
checkVariable "DB_BACKUP_PATH"     $DB_BACKUP_PATH
checkVariable "BACKUP_RETAIN_DAYS" $BACKUP_RETAIN_DAYS

#~#
#~# Vérification du service MYSQL est présent et démmaré
#~#
displayInfo " => Vérification du processus « $SERVICE »..."
if pgrep -x ${SERVICE} >/dev/null; then
  displaySuccess "  -> [OK] Le processus est bien démarré."
else
  displayError "  -> [ERREUR] Le processus est arrêté."
  exit
fi

#~#
#~# Vérification du dossier Backup
#~#
displayInfo " => Vérification du dossier Backup..."
if [ ! -d ${FULL_PATH_BACKUP} ]; then
  RESULTFOLDER=$(dir_permission_check_v2 "${FULL_PATH_BACKUP}")
  if [ ${RESULTFOLDER} == "True" ]; then
    displaySuccess "  -> [OK] Création du dossier Backup.\n    -> ${FULL_PATH_BACKUP}"
    mkdir -p -m 740 ${FULL_PATH_BACKUP}
  else
    displayError "  -> [ERREUR] Permission refusée."
    exit
  fi
else
  displaySuccess "  -> [OK] Le dossier Backup est existant.\n    -> ${FULL_PATH_BACKUP}"
fi

#~#
#~# Vérification de la connexion BDD
#~#
displayInfo " => Vérification de la connexion BDD..."
mysql -h ${SQL_HOST} -P ${SQL_PORT} -u ${SQL_USER} -p${SQL_PASSWORD} -e "exit" >/dev/null 2>&1
if [ "$?" -eq 0 ]; then
  displaySuccess "  -> [OK] Connexion disponible."
else
  displayError "  -> [ERREUR] Connexion impossible."
  exit
fi

#~#
#~# Vérification de la BDD
#~#
displayInfo " => Vérification de la base de donnée..."
RESULT=`mysqlshow -h ${SQL_HOST} \
   -P ${SQL_PORT} \
   -u ${SQL_USER} \
   -p${SQL_PASSWORD} | grep -v Wildcard | grep -o ${DATABASE_NAME}`

if [ "$RESULT" == ${DATABASE_NAME} ]; then
  displaySuccess "  -> [OK] La base de donnée existe.\n    -> ${DATABASE_NAME}"
else
  displayError "  -> [ERREUR] La base de donnée n'existe pas !"
  echo "  -> ${DATABASE_NAME} "
  exit
fi

#~#
#~# Lancement de la sauvegarde de la BDD
#~#
displayInfo " => Début de la sauvegarde..."
mysqldump -h ${SQL_HOST} \
   -P ${SQL_PORT} \
   -u ${SQL_USER} \
   -p${SQL_PASSWORD} \
   -B ${DATABASE_NAME} --complete-insert --create-options --routines --single-transaction | gzip > ${FULL_PATH_BACKUP}/${DATABASE_NAME}-${TODAY}.sql.gz

if [ $? -eq 0 ]; then
  displaySuccess "  -> [OK] BDD « ${DATABASE_NAME} » sauvegardée avec succès."
else
  displayError "  -> [ERREUR] Une erreur est survenue lors de la sauvegarde."
  exit 1
fi

#~#
#~# Suppression des anciennes sauvegardes de la BDD
#~#
displayInfo " => Suppression des sauvegardes antérieures à ${BACKUP_RETAIN_DAYS} jours."
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
if [ ! -z ${DB_BACKUP_PATH} ]; then
  cd ${DB_BACKUP_PATH}
  if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
    displaySuccess "  -> [OK] Suppression effectuée."
    rm -rf ${DBDELDATE}
  else
    displaySuccess "  -> [OK] Aucune suppression nécessaire."
  fi
fi

echo -e "\e[0;m"

### Fin du script ####