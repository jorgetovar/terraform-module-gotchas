variable "words" {

  description = "A word pool to use for Mad Libs"
  type        = object({
    nouns      = list(string),
    adjectives = list(string),
    verbs      = list(string),
    adverbs    = list(string),
    numbers    = list(number),
  })
}

variable "num_files" {
  description = "The number of files to create"
  type        = number
}

module "madlibs_localhost" {
  source    = "../modules/madlibs"
  num_files = var.num_files
  words     = var.words

}