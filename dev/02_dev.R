# Building a Prod-Ready, Robust Shiny Application.
# 
# Each step is optional. 
# 

# 2. All along your project

## 2.1 Add modules
## 
golem::add_module( name = "my_first_module" ) # Name of the module
golem::add_module( name = "my_other_module" ) # Name of the module

## 2.2 Add dependencies

usethis::use_package( "shinydashboard" ) # dashboard packge
usethis::use_package( "DT" ) # for viewing tables
usethis::use_package( "shinyAce" ) # For inputting text
usethis::use_package( "formattable" ) # For formatting table
usethis::use_package( "survival" ) # For survival analysis
usethis::use_package( "splines" ) # Addition of spliens to model
usethis::use_package( "MASS" ) # To call each time you need a new package
usethis::use_package( "flexsurv" ) # To call each time you need a new package
usethis::use_package( "dplyr" ) # To call each time you need a new package
usethis::use_package( "plotly" ) # To call each time you need a new package
usethis::use_package( "ggplot2" ) # To call each time you need a new package
usethis::use_package( "ggfortify" ) # To call each time you need a new package
usethis::use_package( "survminer" ) # To call each time you need a new package
usethis::use_package( "openxlsx" ) # To call each time you need a new package

## 2.3 Add tests

usethis::use_test( "app" )

## 2.4 Add a browser button

golem::browser_button()

## 2.5 Add external files

golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "custom" )

# 3. Documentation

## 3.1 Vignette
usethis::use_vignette("SurvivalCurveExtraction")
devtools::build_vignettes()

## 3.2 Code coverage
## You'll need GitHub there
usethis::use_github()
usethis::use_travis()
usethis::use_appveyor()
usethis::browse_github_token()
usethis::edit_r_environ()

# You're now set! 
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
