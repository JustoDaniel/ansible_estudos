terraform {
  cloud {
    organization = "JDaniel_Universe" # Verifique se este é o nome exato

    workspaces {
      name = "Ansible-lab1" # Verifique se este é o nome exato
    }
  }
}