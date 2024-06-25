pipeline {
    agent any 
    stages {
        stage('Installation of tools') { 
            steps {
                sh '''

                sudo -i

                wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt update && sudo apt install terraform -y
                sudo apt update
                sudo apt install software-properties-common
                sudo add-apt-repository --yes --update ppa:ansible/ansible
                sudo apt install ansible -y
                sudo cd /etc/ansible

                '''
            }
        }
         stage('Terraform init') { 
            steps {
                echo 'welcome to repository'
               
                git 'https://github.com/Yogeshpisal216/Yogi_Project.git'
            }
        }
        stage('Terraform init') { 
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform plan') { 
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform apply') { 
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}