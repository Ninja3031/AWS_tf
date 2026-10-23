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
