output "alb_dns" {
value = module.ecs.alb_dns
}


output "rds_endpoint" {
value = module.rds.endpoint
}


output "frontend_bucket_url" {
value = module.s3_cloudfront.bucket_url
}