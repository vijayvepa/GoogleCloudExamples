cd published

echo pscp -r -i ${GOOGLE_PPK_FILE} * ${GOOGLE_USERNAME}@${GOOGLE_IP_ADDRESS}:/home/${GOOGLE_USERNAME}/catalog
pscp -r -i ${GOOGLE_PPK_FILE} * ${GOOGLE_USERNAME}@${GOOGLE_IP_ADDRESS}:/home/${GOOGLE_USERNAME}/catalog