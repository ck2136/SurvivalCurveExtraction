#' Check if S(t) is monotone decreasing
#' 
#' The function checks for monotone decreasing survival probabilities as t increases
#' 
#' @param df1 Data that has been digitized
#' 
#' @return Data that has been checked for monotone decreasing S(t). If the original data frame isn't monotone decreasing then the function imputes the value based on S(t+2) and S(t)'s average value. If the average is still too big S(t+1) is replaced with S(t).
#' 
#' @export

monotone_check <- function(df1) {
  
  # Change 1st S(t) value to 1
  df1$V2[1] <- 1
  
  # compare previous S(t) to S(t+1)
  for(st in 1:(nrow(df1)-1)){
    
    ## If S(t+1) > S(t), S(t+1) value needs to be updated to S(t)
    if(df1$V2[st] < df1$V2[st+1]){
      if(!is.na(df1$V2[st+2])){
        if((df1$V2[st] + df1$V2[st+2])/2 < df1$V2[st]) {
          df1$V2[st+1] <- (df1$V2[st] + df1$V2[st+2])/2
        } else {
          df1$V2[st+1] <- df1$V2[st]
        }
      } else {
        df1$V2[st+1] <- df1$V2[st]
      }
    }
  }
  
  df1$RowNum <- 1:nrow(df1)
  
  colnames(df1) <- c("Time", "S(t)", "Index")
  df1[,c("Index","Time","S(t)")]
  
  df1

}
