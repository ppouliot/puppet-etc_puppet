warning ("You have just installed a R10K git workflow")
case $environment {
  'production':{
    warning ("${fqdn} is in the production environment")
  }
  'staging':{
    warning ("${fqdn} is in the staging environment")
  }
  'testing':{
    warning ("${fqdn} is in the testing environment")
  }
  'development':{
    warning ("${fqdn} is in the development environment")
  }
}
