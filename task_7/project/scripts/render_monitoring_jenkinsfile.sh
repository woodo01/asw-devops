#!/bin/bash
set -e

# This script is used to render Jenkins configuration files from Jinja2 templates.

### Environment variables for rendering ###
# Global #
AWS_REGION="eu-central-1"
ROUTE53_DOMAIN="aws.elysium-space.com"
EMAIL_RECIPIENT="ivan.develop@gmail.com"
GIT_REPO="https://github.com/woodo01/asw-devops.git"
GIT_BRANCH="task_7"
GRAFANA_SMTP_USER=""
GRAFANA_SMTP_PASSWORD=""
GRAFANA_ADMIN_USER=""
GRAFANA_ADMIN_PASSWORD=""
JENKINS_EMAIL_USERNAME=""
JENKINS_EMAIL_PASSWORD=""
NAMESPACE="monitoring"
RELEASE_NAME="monitoring"


for arg in "$@"; do
    echo "Processing argument: $arg"
    case $arg in
        --file=*)
            JENKINS_CONFIG="${arg#*=}"
            echo "Jenkins configuration template file set to: $JENKINS_CONFIG"
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: $0 [--file=<manifest_template_file>]"
            echo "Example: $0 --file=multitool_monitoring.jenkinsfile.j2"
            exit 1
            ;;
    esac
done

if [ -z "$JENKINS_CONFIG" ]; then
    echo "Error: JENKINS_CONFIG must be set. Please provide the path to the Jinja2 template file."
    exit 1
fi

NEW_JENKINS_CONFIG="${JENKINS_CONFIG%.j2}"
FILENAME=$(basename "$JENKINS_CONFIG")

echo "Rendering Jenkins configuration from $JENKINS_CONFIG to $NEW_JENKINS_CONFIG"
cd ../jenkins/
jinja2 "$JENKINS_CONFIG" \
    -D EMAIL_RECIPIENT="$EMAIL_RECIPIENT" \
    -D GIT_REPO="$GIT_REPO" \
    -D GIT_BRANCH="$GIT_BRANCH" \
    -D GRAFANA_ADMIN_USER="$GRAFANA_ADMIN_USER" \
    -D GRAFANA_ADMIN_PASSWORD="$GRAFANA_ADMIN_PASSWORD" \
    -D ROUTE53_DOMAIN="$ROUTE53_DOMAIN" \
    -D JENKINS_EMAIL_USERNAME="$JENKINS_EMAIL_USERNAME" \
    -D JENKINS_EMAIL_PASSWORD="$JENKINS_EMAIL_PASSWORD" \
    -D NAMESPACE="$NAMESPACE" \
    -D RELEASE_NAME="$RELEASE_NAME" \
    > "$NEW_JENKINS_CONFIG"
