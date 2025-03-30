variable "account_id" {
  description = "Identificador unico da conta"
  type        = string
}

variable "display_name" {
  description = "Nome de exibição de conta"
  type        = string
}

variable "project" {
  description = "Nome do Projeto no GCP"
}

variable "airflow_role" {
  description = "Permissões concedidas ao Airflow"
}

variable "private_key_type" {
  description = "Tipo de chave retornada para conexão com GCP"

}

variable "private_key_path" {
  description = "Caminho da chave cadastrada"

}

variable "table_id" {
  description = "Identificador unico de tabela"
}

variable "dataset_id" {
  description = "Identificador unico de Dataset do BQ"
}