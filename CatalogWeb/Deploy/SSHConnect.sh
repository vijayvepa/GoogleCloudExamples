VM_NAME=${1:-catalog-vm}
ZONE=${2:-us-central1-c}

VM_IP_ADDRESS=$(gcloud compute instances describe ${VM_NAME} --zone ${ZONE} | grep natIP | cut -d: -f2 | xargs)
echo ssh -i ${GOOGLE_SSH_FILE} ${GOOGLE_USERNAME}@${VM_IP_ADDRESS}
ssh -i ${GOOGLE_SSH_FILE} ${GOOGLE_USERNAME}@${VM_IP_ADDRESS}