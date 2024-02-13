# Cert renew
#
# First install certbot:
# sudo apt-get update
# sudo apt-get install certbot
#
# Create a cert:
# sudo certbot certonly -d infinite-auto.ca -d www.infinite-auto.ca --manual
# sudo certbot certonly -d sandrako.ca -d www.sandrako.ca --manual
# sudo certbot certonly -d wojciklaw.ca -d www.wojciklaw.ca --manual
#
# Schedule renewal job:
# chmod +x renew_certs.sh
# sudo crontab -e
# 0 2 1 */2 * /path/to/your/script/renew_certs.sh

# Specify the base directory where SSL certificates are stored
BASE_CERT_DIR="/etc/letsencrypt/live/"

# List of certificate names
#CERT_NAMES=("infinite-auto.ca" "wojciklaw.ca" "sandrako.ca")
CERT_NAMES=("infinite-auto.ca" )

# Iterate through each certificate and renew
for CERT_NAME in "${CERT_NAMES[@]}"; do
    CERT_DIR="$BASE_CERT_DIR/$CERT_NAME/"

    # Run Certbot to renew the certificates
    certbot renew --quiet --deploy-hook "systemctl reload nginx" --cert-name "$CERT_NAME"

    # Optional: Restart your web server or any other services using the renewed certificates
    service nginx restart
done