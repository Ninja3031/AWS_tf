resource "aws_s3_bucket" "my_bucket" {
  count = length(var.bucket_name)
  bucket = var.bucket_name[count.index]
  #only list have indexes and set does not have indexes so we can use count.index to get the value from set
  #bucket = var.bucket_name_set[count.index]

  tags = var.tags
}

resource "aws_s3_bucket" "bucket2" {
  for_each = var.bucket_name_set
  bucket = each.key
  #each.value will give the value of the set but we can use each.key to get the value from set

  tags = var.tags

  depends_on = [aws_s3_bucket.my_bucket]
  
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  count = length(var.bucket_name)
  bucket = aws_s3_bucket.my_bucket[count.index].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "bucket2_versioning" {
  for_each = var.bucket_name_set
  bucket = aws_s3_bucket.bucket2[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  count = length(var.bucket_name)
  bucket = aws_s3_bucket.my_bucket[count.index].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


