# Building a Prod-Ready, Robust Shiny Application.
# 
# Each step is optional. 
# 
# 1 - On init
# 
## 1.1 - Fill the descripion & set options
## 
## Add information about the package that will contain your app

golem::fill_desc(
  pkg_name = "SurvivalCurveExtraction", # The Name of the package containing the App 
  pkg_title = "Exctract Survival Distribution Parameters from Digitized Curves", # The Title of the package containing the App 
  pkg_description = "Digitized curves are used to generate simulated survival curve distributions. Multiple survival curves and distributional parameters are estimated.", # The Description of the package containing the App 
  author_first_name = "Chong", # Your First Name
  author_last_name = "Kim",  # Your Last Name
  author_email = "chong.kim@ucdenver.edu",      # Your Email
  repo_url = "https://github.com/ck2136/SurvivalCurveExtraction" # The (optional) URL of the GitHub Repo
)     

## Use this desc to set {golem} options

golem::set_golem_options()

## 1.2 - Set common Files 
## 
## If you want to use the MIT licence, README, code of conduct, lifecycle badge, and news

usethis::use_mit_license( name = "Chong Kim" )  # You can set another licence here
usethis::use_readme_rmd( open = TRUE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Experimental" )

usethis::use_news_md( open = TRUE )
usethis::use_git()

## 1.3 - Add a data-raw folder
## 
## If you have data in your package
usethis::use_data_raw( name = "df1", open = TRUE ) # Extracted survival curve
usethis::use_data_raw( name = "df2", open = TRUE ) # User created number of risk data

## 1.4 - Init Tests
## 
## Create a template for tests

golem::use_recommended_tests()

## 1.5 : Use Recommended Package

golem::use_recommended_deps()

## 1.6 Add various tools

# If you want to change the favicon (default is golem's one)
golem::remove_favicon()
golem::use_favicon() # path = "path/to/ico". Can be an online file. 

# Add helper functions 
golem::use_utils_ui()
golem::use_utils_server()

# You're now set! 
# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )

