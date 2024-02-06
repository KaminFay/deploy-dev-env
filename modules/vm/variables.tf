variable "do_token" {
    type = string
    sensitive = true
}

variable "image" {
    type = string
}

variable "name" {
    type = string
}

variable "region" {
    type = string
}

variable "size" {
    type = string
}

variable "tags" {
    type = list(string)
}

variable "domain_name" {
    type = string
}

// Should probably do some path validation on this
variable "source_zip" {
    type = string
    default = ""
}

variable "provision" {
    type = bool
    default = true
}