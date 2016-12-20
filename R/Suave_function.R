#' A Suaveometer Function
#'
#' This function allows you to know how Suave you are on Tinder.
#' Suave_function()


Suave_function <- function(df){
  install.packages("sentiment")
  require(sentiment)
  textdata <- df
  class_emo = classify_emotion(textdata, algorithm="bayes", prior=1.0)
  
  emotion = class_emo[,7]
  emotion[is.na(emotion)] = "unknown"
  class_pol = classify_polarity(textdata, algorithm="bayes")
  polarity = class_pol[,4]
  sent_df = data.frame(text=textdata, emotion=emotion,
                       polarity=polarity, stringsAsFactors=FALSE)
  sent_df = within(sent_df,
                   emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))
  
  colnames(sent_df) = c("ID", "ELO", "text", "timestamp", "emotion", "polarity")
  df <- sent_df
  df$index <- 0:(nrow(df)-1)
  x <- unique(df$ID)
  df$polarity <- ifelse(df$polarity == "positive", 1, ifelse(df$polarity == "negative", -1, 0))
  
  person_one <- subset(df, ID == x[1])
  person_two <- subset(df, ID == x[2])
  
  person_one$avg_polarity <- .5*mean(mean(as.numeric(person_one$polarity))+ mean(as.numeric(person_two$polarity)))
  person_two$avg_polarity <- .5*mean(mean(as.numeric(person_one$polarity))+ mean(as.numeric(person_two$polarity)))
  
  
  person_one$percent_messages <- (nrow(person_one)/(nrow(person_two)+nrow(person_one)))
  person_two$percent_messages <- (nrow(person_two)/(nrow(person_two)+nrow(person_one)))
  lengthPOne <- 0
  lengthPTwo <- 0
  
  for(i in 1:(nrow(person_one))){
    lengthPOne <- lengthPOne + as.numeric(nchar(as.character(person_one$text[i])))
  }
  
  for(i in 1:(nrow(person_one))){
    lengthPTwo <- lengthPTwo + as.numeric(nchar(as.character(person_two$text[i])))
  }
  
  person_one$percent_content <- (lengthPOne/(lengthPTwo + lengthPOne))
  person_two$percent_content <- (lengthPTwo/(lengthPTwo + lengthPOne))
  
  
  person_one$timediff <- 0
  person_two$timediff <- 0
  timediff1 <- 0
  timediff2 <- 0
  y <- 0
  h <- 0
  for(i in 1:(nrow(df)-1)){
    if(as.numeric(df$ID[i]) != as.numeric(df$ID[i+1])){
      if(df$ID[i] == x[1]){
        y <- as.numeric(df$timestamp[i+1]) - as.numeric(df$timestamp[i])
        if(y < 60){
          timediff1 <- union(timediff1, y)
        }
        
      }
      if(df$ID[i] == x[2]){
        h <- as.numeric(df$timestamp[i+1]) - as.numeric(df$timestamp[i])
        if(h < 60) {
          timediff2 <- union(timediff2, h)
        }
      }
    }
  }
  timediff1 <- timediff1[-1]
  timediff2 <- timediff2[-1]
  person_one$avg_timediff <- mean(timediff1)
  person_two$avg_timediff <- mean(timediff2)
  
  person_one$diff_elo <- as.numeric(person_one$ELO[1]) - as.numeric(person_two$ELO[1])
  person_two$diff_elo <- as.numeric(person_two$ELO[1]) - as.numeric(person_one$ELO[1])
  
  person_one <- head(person_one, 1)
  person_one <- person_one[c(1, 8, 9, 10, 12, 13)]
  person_two <- head(person_two, 1)
  person_two <- person_two[c(1, 8, 9, 10, 12, 13)]
  
  total <- rbind(person_two, person_one)
  return(total)
}
