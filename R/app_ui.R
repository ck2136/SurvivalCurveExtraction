#' @import shiny
#' @import shinydashboard
#' @import flexsurv
#' @import DT
#' @import ggplot2
#' @import ggfortify
#' @import plotly
#' @import dplyr
#' @import MASS
#' @import splines
#' @import survival
#' @import formattable
#' @import shinyAce
#' @import survminer
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    
    dashboardPage(
      
      # Header
      dashboardHeader(title = "Survival Curve Extraction Dashboard"),
      
      
      # Sidebar Menus
      dashboardSidebar(
        sidebarMenu(
          menuItem("Introduction", tabName = "dashboard", icon = icon("dashboard")),
          # menuItem("Extraction and Error Check", tabName = "extractData", icon = icon("th")),
          menuItem("Data Input and Summary", tabName = "data1", icon = icon("th"),
                   collapsesible = 
                     menuSubItem('random1', tabName = 'random1'),
                   menuSubItem('Data Input', tabName = 'data'),
                   menuSubItem('Data Check', tabName = 'datacheck'),
                   menuSubItem('KM estimate', tabName = 'datasum')
          ),
          menuItem('Results', tabName = 'results', icon = icon('th'), 
                   collapsible = 
                     menuSubItem('random', tabName = 'random'),
                   menuSubItem('Parameter Estimates', tabName = 'regresult'),
                   menuSubItem('Fit Statistics', tabName = 'diag'),
                   menuSubItem('Plots', tabName = 'plot')
          ),
          menuItem("Software Info", tabName = "softInfo", icon = icon("th"))
          
        )
      ),
      
      # Body of the Dashboard
      dashboardBody(
        tabItems(
          
          # First tab content DashBoard
          tabItem(tabName = "dashboard",
                  
                  h2("Introduction"),
                  fluidRow(
                    box(
                      h4('This is a dashboard for generating survival curve distribution parameters, fit statistic, and figures that are useful and/or necessary for economic simulations. Example of health technology assessment using the R package ', a("heemod", href="https://cran.r-project.org/web/packages/heemod/vignettes/a_introduction.html", style = "color:red"), " is ", a("here", href="https://cran.r-project.org/web/packages/heemod/vignettes/j_survival.html", style = "color:red")),
                      
                      h4("There are several important key points to remember:", style = "color:red"),
                      
                      h4(strong("1."),"User needs to have 2 .csv files to input which is described in ", a("Guyot et al. 2012", href = "https://bmcmedresmethodol.biomedcentral.com/articles/10.1186/1471-2288-12-9", style = "color:red; font-style: italic")),
                      
                      h4("If ",strong("1")," is not satisfied: ","User needs to extract the survival curve data points by using a figure digitizer such as ", a("Webplotdigitizer", href="https://apps.automeris.io/wpd/", style = "color:red"), " and extract the curve data and relevant risk and censoring information as described in ", a("Guyot et al. 2012", href = "https://bmcmedresmethodol.biomedcentral.com/articles/10.1186/1471-2288-12-9", style = "color:red; font-style: italic")),
                      
                      h4(strong("2."),"Before trying to determine a survival distribution that best fits the data, user needs to check that the extracted curve is as accurate as possible. Human error is highly possible to be introduced during the process of survival curve extraction thus this step is crucial in terms of preserving the integrity of the original study's survival information"),
                      
                      h4(strong("3."),"The outputs that are generated in the 'Result' tab (Bottom tab on the left) requires the user to have a basic understanding of the analysis of time to event data. An understanding of parameters for survival distributions and fit statistics will be very helpful. Optionally, understanding of spline functions in fitting a survival distribution to the data may be beneficial"),
                      h4(strong("Everyone should check for data entry errors!"), " regardless of how well the curve was digitized/constructed, anyone who has ever dealt with manual extraction should check the curve visually as well as numerically in terms of the S(t) for each values of t. Please check the 'Extraction and Error Check' tab on the left side an go through the exercise"),
                      
                      h4("A short tutorial of the process of extracting survival curve parameters is illustrated on", a("github", href="https://github.com/ck2136/SurvivalCurveExtraction", style = "color:red")," for those that may need a vignette. If you have any questions regarding how to go about each step please consult", a("Guyot et al. 2012", href = "https://bmcmedresmethodol.biomedcentral.com/articles/10.1186/1471-2288-12-9", style = "color:red; font-style: italic"), " and if still difficult to proceed, e-mail: ", a("chong.kim@ucdenver.edu", href = "mailto:chong.kim@ucdenver.edu"))
                      
                      ,width = 12)
                  )
                  
          ),
          
          # Second Tab content: Information for gathering csv files
          # tabItem(tabName = "extractData",
          #         
          #         fluidRow(
          #           box(
          #             h2("Extraction and Error Checking"),
          #             
          #             h4('If the required survival curve and number at risk csv files are not extracted beforehand, please follow the', a("Tutorial", href="https://github.com/ck2136/SurvivalCurveExtraction/blob/master/SurvivalExtractionforCEA.ipynb"),' so that the user can extract the curve according to Guyot et al. then be able to generate survival distribution parameter estimates')
          #             ,width = 12
          #           )
          #         ),
          #         
          #         fluidRow(
          #           box(
          #             h4(strong("Preview of the tutorial")),
          #             
          #             img(src='www/step1.gif', align = 'center')
          #             , width = 12 , align = 'center'
          #           )
          #         ),
          #         
          #         fluidRow(
          #           column(8,
          #                  box(
          #                    h4(strong("Preview of Number 2")),
          #                    
          #                    img(src='www/step2.gif', align = 'center'),
          #                    
          #                    h4("Currently the most important aspect with regard to checking whether or not the survival curve is appropriate is to determine if it is monotone decreasing (i.e. not increasing). Due to approximation errors in the webplotdigitizer, there may be points that have higher S(t) than the previous time point. The tutorial in the above Tutorial link has python code to remedy non-monotonic S(t) but there are also ways to do this in excel.")
          #                    , width = 8, align = 'center'
          #                  ), offset = 3
          #           )
          #           
          #         )
          # ),
          
          # Second Tab content: Data and SUmmary
          tabItem(tabName = "data",
                  
                  box(
                    
                    h2("Digitized survival curve input"),
                    box(
                      fileInput('datafile1', 'Please input the digitized survival curve csv file',
                                accept=c('text/csv', 'text/comma-separated-values,text/plain')) 
                      ,
                      width = 6
                    ),
                    box(
                      uiOutput("Variables1"),
                      uiOutput("Variables2"),
                      width = 6
                    ),
                    width = 12
                  )
                  ,
                  
                  box(
                    
                    h2("Number at risk input"),
                    box(
                      fileInput('datafile2', 'Please input the number at risk csv file',
                                accept=c('text/csv', 'text/comma-separated-values,text/plain')),
                      width = 6
                    ),
                    box(
                      numericInput('totevent',"Total number of events",value =  NA, min = 0),
                      numericInput('arm.id',"Arm id: control = 0; treatment = 1", 1, min = 0, max = 1),
                      width = 6
                    ),
                    width = 12
                  )
                  
          ),
          
          tabItem(
            tabName = "datacheck",
            fluidRow(
              width = 10,
              box(
                plotOutput("orgplot", width = 700), width = 10
              )
            )
          ),
          
          # Data SUmmary tab content
          
          tabItem(tabName = 'datasum',
                  
                  fluidRow(
                    box(
                      # h3("Individual Patient Data (IPD) View"),
                      # dataTableOutput("IPDtable"),
                      
                      h3("KM Estimate"),
                      verbatimTextOutput("KMsum")
                      , width = 12
                    )
                  )
                  
          ),
          
          # Plots tab: Plot submenu of result
          tabItem(tabName = "plot",
                  
                  fluidRow(
                    box(
                      h3("Plotting Options"),
                      box(
                        radioButtons('confint','Confidence Intervals?',
                                     choices =  c(
                                       "Yes" = 'yes',
                                       "No" = 'no'), selected = 'no'),
                        radioButtons('wpdcurve','Add Digitized Curve?',
                                     choices = c(
                                       "Yes" = 'yes',
                                       "No" = 'no'), selected = 'no'
                        ),
                        width = 4
                      ),
                      box(
                        # Copy the line below to make a text input box
                        textInput("titletxt", label = "Title", value = "Simulated survival distributions"),
                        textInput("xlab", label = "X Label", value = "Time in Months"),
                        width = 4
                      ),
                      box(
                        # Copy the line below to make a text input box
                        textInput("ylab", label = "Y Label", value = "S(t)"),
                        radioButtons('splineyn','Splines?',
                                   choices =  c(
                                     "Yes" = 'yes',
                                     "No" = 'no'), selected = 'no'),
                        conditionalPanel("input.splineyn == 'yes'",
                                   sliderInput('numspline', "Number of splines:",
                                               min = 1, max = 100, value = 1, step = 1)
                  ),
                        width = 4
                      ),
                      width = 12)
                  ),
                  fluidRow(
                    width = 10,
                    box(
                      plotOutput("survplot", width = 700), width = 10
                    )
                  )
          ),
          
          
          # Parameter Estimates tab content
          tabItem(tabName = "regresult",
                  
                  h2("Parameter Estimates"),
                  
                  fluidRow(
                    box(
                      h3("Survival Distribution Parameters"),
                      fluidRow( dataTableOutput("parest"))
                      ,width = 12
                    )
                    
                    
                  )
                  
                  
          ),
          
          # Sixth tab: Fit statistics/Diagnostic
          tabItem(tabName = "diag",
                  h2("Fit Statistics"),
                  
                  fluidRow(
                    box(
                      h3("Fit Statistics"),
                      fluidRow( dataTableOutput("fitstat"))
                      ,width = 12
                    )
                  )
                  
                  
          ),
          tabItem(tabName = "softInfo",
                  h2("Current R Session Information"),
                  
                  fluidRow(
                    box(
                      verbatimTextOutput("info")
                      ,width = 12
                    )
                  )
                  
                  
          )
          
          
          
        )
      )
    )
  )
  
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'SurvivalCurveExtraction')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
