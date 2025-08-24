variable "region" { 
    type = string
    default = "us-east-1" 
}

variable "vpc_cidr" { 
    type = string
    default = "10.0.0.0/16" 
}

variable "subnet1_cidr"{ 
    type = string
    default = "10.0.1.0/24" 
}

variable "subnet2_cidr"{ 
    type = string
    default = "10.0.2.0/24"
}

variable "db_username" { 
    type = string
    default = "admin" 
}

variable "db_password" { 
    type = string
    default = "password"
    sensitive = true 
} 

variable "ingress_cidr"{ 
    type = string
    default = "192.168.0.1/32"  # change this!
} 
