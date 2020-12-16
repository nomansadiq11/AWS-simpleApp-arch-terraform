variable "WebSiteBucketName" {
  type        = string
  description = "string"
  default     = "qmsfrontend"

}

variable "FileBucketName" {
  type        = string
  description = "string"
  default     = "qmsfilesserver"

}

variable "tagEnvironment" {
  type        = string
  description = "string"
  default     = "Production"

}

variable "tagProject" {
  type        = string
  description = "string"
  default     = "QMS"

}
